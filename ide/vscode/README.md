# IDE / Visual Studio Code

## よく使うショートカット

- [MacOS ShortCuts](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-macos.pdf)

- `Command Palette` => `Shift + Command + P` or `F1`
  - ` 設定ファイル`` =>  `settings.json` で検索
- `ファイル検索` => `Command + P`
  - `Quick Open, Go to file` => `Command + P`
- `User Settings` => `Command + ,`

## プログラミング固有

- `今までの修正箇所へ移動??` => `⌘ + Shift + ] / ⌘ + Shift + [`
- `コメントアウト: Toggle line comment` => `⌘/`
- `カーソル行にある全ての行を上下に移動する` => `Option + ⇅`
- `定義箇所にジャンプ` => `Command + クリック`

## 検索/置換

- `検索` => `⌘F`
- `置換` => `⌥⌘F`

## Command Palette

- `Command Palette` => `Shift + Command + P` or `F1`

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
