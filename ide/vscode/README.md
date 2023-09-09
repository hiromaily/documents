# IDE / Visual Studio Code

## よく使うショートカット

- [MacOS ShortCuts](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-macos.pdf)

- `ファイル検索` => `Command+P`
- `Command Palette` => `F1` or `Shift+Command+P`
- `Quick Open, Go to file` => `Command+P`
- `User Settings` => `Command+,`

- `TextのLineを移動する` => `Option+⇅`
- `Indent/outdent line` => `⌘] / ⌘[`
- `Toggle line comment` => `⌘/`

## 検索/置換

- `検索` => `⌘F`
- `置換` => `⌥⌘F`

## Extensions

1. Gitlens ... コミット履歴を確認できる
2. Live Server ... local dev server を立ち上げる
3. Import Cost ... npm で import したときのファイルサイズを表示する
4. Prettier ... save 時に prettier で format をかける
5. ESLint ... eslint の結果が code 上ですぐに確認できる
6. Markdown All in One ... Markdown に便利な機能が含まれるが、default でも十分かも
7. Better Comments ... better comments が提案される
8. Snippets

- ES7+ React/Redux/React-Native snippets
- Javascript (ES6) Code Snippets

8. Path Intellisense ... パス入力を補完する
9. Auto Rename Tag
10. Auto Close Tag
11. Live Server

## 便利機能

### Emmet スニペット

- HTML ファイルの雛形を作成する

### マルチカーソル

- 同一の文字列をマウスでドラッグして選択
- `Ctrl+Shitf+L`

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

- スニペットを有効にする
  - [Snippets in Visual Studio Code](https://code.visualstudio.com/docs/editor/userdefinedsnippets)
  - Create your own snippets

```sh
cd  ~/Library/Application Support/Code/User
mkdir snippets
touch snippets/javascript.json # for javascript
touch snippets/typescript.json # for typescript
```

## Command Palette

- `Command Palette` => `F1` or `Shift+Command+P`

### Indent の変更

`Indent`と入力すると、関連コマンドが表示される

## shell の default setting

- 必要かどうかは、要検証
- ~/Library/Application\ Support/Code/User/settings.json

```json
{
  "terminal.integrated.defaultProfile.osx": "zsh",
  ...
}
```
