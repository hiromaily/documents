# IDE / Visual Studio Code

## よく使うショートカット

- [MacOS ShortCuts](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-macos.pdf)

- `Command Palette` => `Shift + Command + P` or `F1`
  - `設定ファイル` => `settings.json` で検索
- `ファイル検索` => `Command + P`
  - `Quick Open, Go to file` => `Command + P`
- `User Settings` => `Command + ,`

## プログラミング固有

- `今までの修正箇所へ移動` => `⌘ + Shift + ] / ⌘ + Shift + [` => 実際は開いている Tab を移動しているだけだった
- `コメントアウト: Toggle line comment` => `⌘/`
- `カーソル行にある全ての行を上下に移動する` => `Option + ⇅`
- `定義箇所にジャンプ` => `Command + クリック`
  - `Ctrl + -` でも戻るが、進めない。。。 => `Go Back`
- メニューの[Go]に、`Next Change`と`Previous Change`がある
  - `Option + F3` or `Option + Shift + F3` => 押しても反応しない
- `Command Palette` => `Shift + Command + P` or `F1`
  - Go Back in Edit Locations / Go to Last Edit Location
    - これはファイルをまたいで移動ができるが、最後の変更を起点にしか back 方面にしか移動できない
  - Go to Next Change / Go to Previous Change
    - 同一ファイル内でしか移動できない
  - Go Forward in Edit Locations / Go Previous in Edit Locations
    - 思っているような挙動とは違う
  - Go Back => `Ctrl + -` / Go Forward => `Ctrl + Shift + -`

## Window 内

- 左下に`TIMELINE`があり、Local の修正履歴が一覧で閲覧できる

## 検索/置換

- `検索` => `⌘F`
- `置換` => `⌥⌘F`

## Command Palette

- `Command Palette` => `Shift + Command + P` or `F1`

## WIP: Code の Bookmark 機能

## Formatter の指定 (Configure Default Formatter)

- `Shift + Command + P` => `Format Selection`

## Indent の変更

`Indent`と入力すると、関連コマンドが表示される

## Emmet スニペット

- Emmet とは、Web 制作において非常に便利な機能がそろったツールキットで、HTML・CSS の記述を楽にするもの
- VSCode にはデフォルトで Emmet がインストールされている

- HTML ファイルの雛形を作成する

## マルチカーソル

- 同一の文字列をマウスでドラッグして選択
- `Ctrl + Shitf + L`

## プロジェクト固有の設定ファイル

```sh
mkdir .vscode
touch .vscode/extensions.json # ワークスペースで推奨したい拡張機能を記載
touch .vscode/settings.json   # vscodeそのものの設定を記載
```
