# IDE / Visual Studio Code

## よく使うショートカット

- [MacOS ShortCuts](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-macos.pdf)

- `ファイル検索` => `Command + P`
- `Command Palette` => `F1` or `Shift + Command + P`
- `Quick Open, Go to file` => `Command + P`
- `User Settings` => `Command + ,`

- `TextのLineを移動する` => `Option + ⇅`
- `Indent/outdent line` => `⌘] / ⌘[`
- `Toggle line comment` => `⌘/`

## 検索/置換

- `検索` => `⌘F`
- `置換` => `⌥⌘F`

## Command Palette

- `Command Palette` => `F1` or `Shift + Command + P`

## Indent の変更

`Indent`と入力すると、関連コマンドが表示される

## Emmet スニペット

- Emmet とは、Web 制作において非常に便利な機能がそろったツールキットで、HTML・CSS の記述を楽にするもの
- VSCode にはデフォルトで Emmet がインストールされている

- HTML ファイルの雛形を作成する

## マルチカーソル

- 同一の文字列をマウスでドラッグして選択
- `Ctrl + Shitf + L`

## プロジェクトの設定ファイル

```sh
mkdir .vscode
touch .vscode/extensions.json # ワークスペースで推奨したい拡張機能を記載
touch .vscode/settings.json   # vscodeそのものの設定を記載
```

- `settings.json`内にて、以下の設定によって、エクスプローラの表示対象からの除外するファイルとフォルダを設定する

```json
{
  "files.exclude": {
    "**/.git": true,
    "**/.vendor": true,
    "**/.DS_Store": true
  }
}
```

- `settings.json`内にて、検索の対象からの除外するファイルとフォルダーを設定する

```json
{
  "search.exclude": {
    "**/node_modules": true,
    "**/vendor": true
  }
}
```

- `.gitignore` と `.ignore` の設定を検索時に有効化する

```json
{
  "search.useIgnoreFiles": true
}
```

## shell の default setting

- 必要かどうかは、要検証
- ~/Library/Application\ Support/Code/User/settings.json

```json
{
  "terminal.integrated.defaultProfile.osx": "zsh",
  ...
}
```
