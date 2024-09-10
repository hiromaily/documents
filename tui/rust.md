# Rust による実装

以下に、`tui`, `crossterm`, `git`を使って、`git branch`によって表示された branch 一覧から選択したbranchに切り替えるアプリケーション例を示す

## 必要な依存関係を追加

Cargo.tomlに`tui`、`crossterm`、`git2`の依存関係を追加

`tui`はメンテナンスされていないため、Forkedバージョンの[ratatui](https://github.com/ratatui/ratatui)を使う

```toml
[dependencies]
tui = "0.16"             # TUIライブラリ
crossterm = "0.20"       # ターミナル用クロスプラットフォームライブラリ
git2 = "0.13"            # Gitリポジトリ操作用ライブラリ
```

## Rustのコード

```rs
use crossterm::{
    event::{self, DisableMouseCapture, EnableMouseCapture, Event as CEvent, KeyCode},
    execute,
    terminal::{disable_raw_mode, enable_raw_mode, EnterAlternateScreen, LeaveAlternateScreen}
};
use git2::Repository;
use std::{error::Error, io, time::{Duration, Instant}};
use tui::{
    backend::CrosstermBackend,
    layout::{Constraint, Direction, Layout},
    style::{Color, Modifier, Style},
    text::Span,
    widgets::{Block, Borders, List, ListItem, Paragraph},
    Terminal,
};

enum Event<I> {
    Input(I),
    Tick,
}

fn main() -> Result<(), Box<dyn Error>> {
    // ターミナルをrawモードに設定
    enable_raw_mode()?;
    let mut stdout = io::stdout();
    execute!(stdout, EnterAlternateScreen, EnableMouseCapture)?;

    let backend = CrosstermBackend::new(stdout);
    let mut terminal = Terminal::new(backend)?;

    let tick_rate = Duration::from_millis(200);
    let rx = start_event_loop(tick_rate);

    let repo = Repository::open(".")?; // カレントディレクトリでリポジトリを開く
    let mut app = App::new(repo);

    // メインループ
    loop {
        terminal.draw(|f| ui(f, &app))?;

        match rx.recv()? {
            Event::Input(event) => match event {
                KeyCode::Char('q') => break,
                KeyCode::Down => app.next(),
                KeyCode::Up => app.previous(),
                KeyCode::Enter => app.checkout_selected()?,
                _ => {}
            },
            Event::Tick => {}
        }
    }

    // 終了処理
    disable_raw_mode()?;
    execute!(
        terminal.backend_mut(),
        LeaveAlternateScreen,
        DisableMouseCapture
    )?;
    terminal.show_cursor()?;

    Ok(())
}

struct App<'a> {
    branches: Vec<String>,
    selected: usize,
    repo: Repository,
    message: Option<Span<'a>>,
}

impl<'a> App<'a> {
    fn new(repo: Repository) -> Self {
        let branches = get_branches(&repo).unwrap_or_else(|_| vec![]);
        Self {
            branches,
            selected: 0,
            repo,
            message: None,
        }
    }

    fn next(&mut self) {
        if self.selected < self.branches.len() - 1 {
            self.selected += 1;
        }
    }

    fn previous(&mut self) {
        if self.selected > 0 {
            self.selected -= 1;
        }
    }

    fn checkout_selected(&mut self) -> Result<(), git2::Error> {
        if let Some(branch) = self.branches.get(self.selected) {
            let (object, reference) = self.repo.revparse_ext(branch)?;
            self.repo.checkout_tree(&object, None)?;
            if let Some(ref_name) = reference.and_then(|r| r.name()) {
                self.repo.set_head(ref_name)?;
                self.message = Some(Span::styled(
                    format!("Switched to branch '{}'", branch),
                    Style::default().fg(Color::Green).add_modifier(Modifier::BOLD),
                ));
            }
        }
        Ok(())
    }
}

fn get_branches(repo: &Repository) -> Result<Vec<String>, git2::Error> {
    let mut branches = Vec::new();
    let branches_iter = repo.branches(Some(git2::BranchType::Local))?;
    for branch in branches_iter {
        let (branch, _) = branch?;
        if let Some(name) = branch.name()? {
            branches.push(name.to_string());
        }
    }
    Ok(branches)
}

fn start_event_loop(tick_rate: Duration) -> std::sync::mpsc::Receiver<Event<KeyCode>> {
    use std::sync::mpsc;
    use std::thread;

    let (tx, rx) = mpsc::channel();
    thread::spawn(move || {
        let mut last_tick = Instant::now();
        loop {
            let timeout = tick_rate
                .checked_sub(last_tick.elapsed())
                .unwrap_or_else(|| Duration::from_secs(0));
            if event::poll(timeout).expect("Polling failed") {
                if let CEvent::Key(key) = event::read().expect("Reading event failed") {
                    tx.send(Event::Input(key.code)).expect("Sending input event failed");
                }
            }
            if last_tick.elapsed() >= tick_rate {
                tx.send(Event::Tick).expect("Sending tick event failed");
                last_tick = Instant::now();
            }
        }
    });
    rx
}

fn ui<B: tui::backend::Backend>(f: &mut tui::Frame<B>, app: &App) {
    let size = f.size();

    let chunks = Layout::default()
        .direction(Direction::Vertical)
        .margin(2)
        .constraints(
            [
                Constraint::Percentage(80),
                Constraint::Percentage(10),
                Constraint::Percentage(10),
            ]
            .as_ref(),
        )
        .split(size);

    let branch_list: Vec<ListItem> = app
        .branches
        .iter()
        .map(|b| ListItem::new(b.clone()))
        .collect();

    let branches = List::new(branch_list)
        .block(Block::default().borders(Borders::ALL).title("Branches"))
        .highlight_style(Style::default().bg(Color::Blue));

    let message = if let Some(msg) = &app.message {
        Paragraph::new(msg.clone()).block(Block::default().borders(Borders::ALL).title("Message"))
    } else {
        Paragraph::new("").block(Block::default().borders(Borders::ALL).title("Message"))
    };

    f.render_widget(branches, chunks[0]);
    f.render_widget(
        Paragraph::new(format!("Selected Branch: {}", app.branches[app.selected]))
            .block(Block::default().borders(Borders::ALL).title("Info")),
        chunks[1],
    );
    f.render_widget(message, chunks[2]);
}
```

## Rustコードの説明

1. **依存関係の設定**:
   - `tui` と `crossterm` は TUI の構築とターミナル操作のために使用。
   - `git2` は、Gitリポジトリの操作のために使用。

2. **ターミナルの初期化**:
   - ターミナルを "raw モード" に設定し、"alternative screen" に切り替える。
   - `CrosstermBackend` を使用してターミナルのフレームを初期化。

3. **イベントループ**:
   - メインループ内でターミナルの描画とイベントの処理を行う。
   - `キーが押されると`, 'q', 矢印キー、Enterキーが検出され、それに応じて適切な動作が行われる。

4. **ブランチの取得と表示**:
   - Gitリポジトリからブランチの一覧を取得し、リストとして表示。

5. **ブランチのチェックアウト**:
   - 選択されたブランチに切り替える処理を行う。
   - `app.checkout_selected` は選択されたブランチをチェックアウトし、成功したかどうかのメッセージを表示する。

このコードを実行すると、ターミナルに現在のGitリポジトリのブランチ一覧が表示され、矢印キーで選択し、Enterキーでブランチを切り替え、'q' キーで終了できる。
