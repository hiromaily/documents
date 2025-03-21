# Cursor カーサー

Cursor は、Anysphere 社が開発した AI エージェント。Visual Studio Code（VS Code）をベースに、AI による開発支援機能が充実しているコードエディタ。
AI を活用してコードの自動生成からデバッグ、プロジェクト管理まで幅広いタスクをサポートする多機能なツールであり、自動デバッグ機能やターミナルコマンドの自動化など、開発の効率化に役立つ様々な機能を提供している。特に「Composer Agent」の導入により、プロジェクトの自動化がさらに進化し、開発効率が向上しているのが特徴。

## 主な特徴

- **コードの自動生成と編集**: 自然言語で指示を出すだけで、Cursor が適切なコードを生成または編集する。これにより、基本的なコーディングや繰り返し作業を大幅に効率化できる。
- **チャットでの質疑応答**: Cursor には、プログラミングに関する質問に答える AI チャット機能が組み込まれている。コードに関する疑問を即座に解決できるため、開発の効率が向上する。
- **自動デバッグとエラー修正**: Cursor はコード内のエラーを検出し、修正案を提示する。これにより、デバッグ作業が効率化され、開発プロセスが加速する。
- **ターミナルコマンドの自動化**: 依存関係のインストールやアプリケーションの実行がエディター内で完結し、作業時間を大幅に削減する。
- **柔軟性の高いワークフロー**: プロジェクトを段階的に構築できるため、初心者からプロフェッショナルまで幅広く活用可能。

## 機能

- **Command K**: AI にコードの生成や編集を指示するためのプロンプト入力欄を表示するショートカット機能。
- **@Symbols**: プロジェクト内の特定のファイルやコードシンボルを参照する機能で、プロジェクト全体の文脈を考慮した回答を得ることが可能。
- **Codebase Answers**: プロジェクト全体を分析し、適切な提案やインサイトを提供する。
- **Composer Agent**: 最新のアップデートで導入された機能で、プロジェクトの自動化に特化している。コードベースの自動解析やタスクの一括実行が可能で、開発効率を大幅に向上させる。

## 利点と活用シーン

- **開発の効率化**: Cursor は、プログラミング作業の多くの部分を自動化することで、開発者の生産性を飛躍的に向上させる。
- **初心者向け**: 自然言語での指示や自動デバッグ機能は、初心者エンジニアにとても役立つ。

## 利用方法

### 1. インストールと初期設定

- **Cursor のダウンロード**:
   Cursor の公式ウェブサイトにアクセスし、[インストーラをダウンロード](https://www.cursor.com/ja)
- **インストールと初期設定**:
  - ダウンロードしたインストーラを起動し、初期設定を行う。
  - 特にこだわりなければ、「Default (VS Code)」のままで、Language for AI には「日本語」を選択
  - VSCode の拡張機能を使用する場合は、その設定も行う

### 2. 基本操作

- **新規プロジェクトの作成**:
  - メニューバーの「ファイル」から「New AI Project」を選択する
  - プロジェクトの内容を入力し、「Next」をクリックし、フォルダを選択してプロジェクト名を入力する.
- **コードの編集**:
  - メニューバーの「ファイル」から「新しいテキストファイル（Ctrl+N）」を選択し、コードを書く画面を表示する.
  - コードを書いた後は、「名前をつけて保存（Ctrl+Shift+S）」で保存する

### 3. AI 機能の利用

- **コードの自動生成・編集**:
  - `Command + K`を押してチャット画面を表示し、プロンプトを入力する。
  - 例えば、「ユーザーの入力を受け取るフォームのコードを作成して」といった指示で、適切なコードを自動生成する.
- **チャット機能の使用**:
  - 画面右側の CHAT メニューから利用し、プログラミングに関する質問や Cursor の使い方を問い合わせる.
- **自動デバッグ・エラー修正**:
  - 例えば、赤いエラーが表示された部分にカーソルを合わせて「AI Fix In Chat」を押すと、チャット機能でエラーを解決するためのプロンプトが入力される.

### 4. 追加の設定

- **言語設定**:
  - メニューバーの「View」から「Command Palette」を表示し、「Configure Display Language」を選択して「日本語」を選択する。
  - 再起動後、メニューバーが日本語に切り替わる.

## 料金

Cursor の料金体系は以下の通り

- **Basic**: 無料
- **Pro**: 月額 20 ドル
- **Business**: 月額 40 ドル

## [cursor.directory](https://cursor.directory/)

Cursor Directoryは、Cursor AIユーザーのためのリソースサイトで、主な目的は、Cursor AIの効果的な利用をサポートすること。
Cursor Directoryを利用することで、開発者はCursor AIの機能をより効果的に活用し、高品質なコードを効率的に生成することができる。

### Cursor Directoryの特徴

1. 最適化されたプロンプトとルールの提供: 各種フレームワークや言語に合わせた、最適化されたプロンプトやルールのテンプレートを提供する。

2. プロジェクト品質の向上: 適切なルールを使用することで、Cursor AIの回答品質を飛躍的に向上させることができる。

3. 開発効率の改善: 言語やフレームワーク固有の最適な設定を簡単に適用できるため、開発効率が向上する。

4. カスタマイズの促進: 既存のルールを参考に、プロジェクトに合わせたカスタムルールを作成することができる。

5. プロジェクト方針の統一: チーム開発において、コーディング規約や選定技術などのプロジェクト全体のルールを設定し、一貫性を保つことができる。

## References

- [最強神器「Cursor」の本当に使い方を徹底解説【知らないとヤバいレベルです】](https://zenn.dev/aimasaou/articles/f9b19ca901a0cd)
- [私のシンプルCursor活用方法](https://note.com/nike_cha_n/n/nd0f7566019ae)
- [AIコーディングアシスタント「Cursor」が4カ月の短期間で1億ドル調達　加熱するコーディングAI開発競争](https://ampmedia.jp/2025/02/23/cursor/)
- [Cursor 次期バージョン(v0.46)の 5 つのアップデートが超便利なので紹介したい](https://zenn.dev/kikagaku/articles/b074d9fbf01479)
- [いま文章を書くのに「CURSOR」を使わないのは損だ](https://ascii.jp/elem/000/004/253/4253872/)
- [Cursor活用で開発生産性を最大化するTips](https://zenn.dev/rikika/articles/d65e6e676e890d)
- [Cursorを3週間使った所感・Clineとの違いまとめ](https://zenn.dev/robustonian/articles/cursor_vs_cline)
- [Cursor Agentベストプラクティス](https://note.com/suthio/n/n6a7663311d50)
- [Cursorとかいうやつを使ってみたらUnity効率上がりすぎた話](https://note.com/gigabit_million/n/nc793ceff3bf7)
- [ノンエンジニアでもOKなCursorエージェント超入門](https://note.com/miyatad/n/nae304a0024af)
- [【超実践】CursorでPM業務を圧倒的効率化](https://note.com/tttocklll/n/n3840b000ec51)
- [あなたの仕事に“AI秘書”を。ノンエンジニアでもOKなCursorエージェント超入門](https://note.com/miyatad/n/nae304a0024af)
- [Cursorの知るべき10個のTips](https://zenn.dev/superstudio/articles/28ecc293bd2437)
