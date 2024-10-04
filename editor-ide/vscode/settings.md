# Settings

- `Shift + Command + P` => `settings.json`

## 種類

- Default: `defaultSettings.json` ... すべての設定が含まれる。修正すべきではないかと。
  - `default`と入力すると出てくる
- User: `settings.json` ... ユーザーによってカスタマイズする設定ファイル
  - `user`と入力すると出てくる
- Workspace: `settings.json` ... その環境下(ディレクトリ下)に`.vscode`が作成され、その中に`settings.json`ができる

## 便利な設定

### デフォルト表示

- 右側のミニマップを削除
  - `"editor.minimap.enabled": false,`
- タブサイズの変更
  - `"editor.tabSize": 2`
- code コマンドでファイルを開いたとき、既に開いているウインドウがあればそこに表示する
  - `"window.openFilesInNewWindow": "off"`
- 開始と終了のブラケットをセットで同じカラーにする
  - `"editor.bracketPairColorization.enabled": true,`
- 開始と終了のブラケットにガイドを表示する
  - `"editor.guides.bracketPairs": true,`
- テキストコピー時に書式設定を含めない
  - `"editor.copyWithSyntaxHighlighting": false`
- function 呼び出し時のコードに、引数の名前が表示されるようにする
  - `"javascript.inlayHints.parameterNames.enabled": "all",`
  - `"typescript.inlayHints.parameterNames.enabled": "all"`
- ファイルツリーにインデントのガイド線を表示する / インデントのサイズを変更する
  - `"workbench.tree.renderIndentGuides": "always",`
  - `"workbench.tree.indent": 16,`
- ターミナルで選択するとコピー、右クリックで貼り付け出来るようにする
  - `ターミナルで選択するとコピー、右クリックで貼り付け出来るようにする`
  - `"terminal.integrated.rightClickBehavior": "paste"`
- shell の default setting (おそらく不要)
  - `"terminal.integrated.defaultProfile.osx": "zsh",`

### 自動保存

- タブやウィンドウがフォーカスを失うと自動保存する
  - `"files.autoSave": "onFocusChange"`

### フォーマット

- 保存時にコードが整形される
  - `"editor.formatOnSave": true,`
- 無駄なホワイトスペースを削除
  - `"files.trimTrailingWhitespace": true`

### ファイル検索

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
  - `"search.useIgnoreFiles": true`

## settings.json 個々の説明

```json{
  // アイコンテーマ
  "workbench.iconTheme": "material-icon-theme",
  // focus外したら保存
  "files.autoSave": "onFocusChange",
  // タブサイズ
  "editor.tabSize": 2,
  // defaultのformatter
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  // 保存時にフォーマッターが走る
  "editor.formatOnSave": true,
  // prettier:シングルクォートをdefaultにする
  "prettier.singleQuote": true,
  // ファイル保存時にESLintでフォーマット
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  // fonts
  "scm.inputFontFamily": "'MyricaM M'",
  "editor.fontFamily": "'MyricaM M'",
  "editor.inlayHints.fontFamily": "'MyricaM M'",
  "markdown.preview.fontFamily": "'MyricaM M'",
  "debug.console.fontFamily": "'MyricaM M'",
  "rest-client.fontFamily": "'MyricaM M'",
  "editor.codeLensFontFamily": "'MyricaM M'",
  // codic:API_TOKEN
  "codic.ACCESS_TOKEN": "hoge",
  // codic:camelcase を default
  "codic.case": "camelCase",
  // 入力中に候補を自動的に表示するかどうかを制御する
  "editor.quickSuggestions": true,
  // 無駄なホワイトスペースを削除
  "files.trimTrailingWhitespace": true,
  // ブレイクポイントのスペースを削除
  "editor.glyphMargin": false,
  // ミニマップを削除
  "editor.minimap.enabled": false,
  // 大きすぎるUIを小さくする。
  "window.zoomLevel": -1,
  // font-sizeをあげてる。
  "editor.fontSize": 24,
  "terminal.integrated.fontSize": 20,
  "debug.console.fontSize": 20,
  // codeコマンドでファイルを開いたとき、既に開いているウインドウがあればそこに表示する
  "window.openFilesInNewWindow": "off",
  // タブの名前の長さに応じてタブの幅が変更される
  "workbench.editor.tabSizing": "shrink",
  // 文字の間隔を狭める
  "editor.letterSpacing": -0.3,
  "editor.lineHeight": 32,
  // プレビューモードで開かれるのを阻止する
  "workbench.editor.enablePreview": false,
  "workbench.editor.enablePreviewFromQuickOpen": false,
  // 開始と終了のブラケットをセットで同じカラーにする
  "editor.bracketPairColorization.enabled": true,
  // 開始と終了のブラケットが強調表示される。
  "editor.guides.bracketPairs": true,
  // タブステップ中も入力補完を有効にする
  "editor.suggest.snippetsPreventQuickSuggestions": false,
  // 入力候補の1番目を最初に選択しておく
  "editor.suggestSelection": "first",
  // vsintellicode:AIによる予測変換の結果を上にくるようにする。
  "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
  // vscodeを立ち上げた時に表示される画面を変更する
  "workbench.startupEditor": "none",
  // テキストコピー時に書式設定を含める
  "editor.copyWithSyntaxHighlighting": false,
  // importが入力補完される
  "javascript.suggest.autoImports": true,
  "typescript.suggest.autoImports": true,
  // ファイルを移動した時にimportのパスが変わっても自動で更新される
  "javascript.updateImportsOnFileMove.enabled": "always",
  "typescript.updateImportsOnFileMove.enabled": "always",
  // コンソールなどの画面を右側に配置する
  "workbench.panel.defaultLocation": "right",
  // 引数の名前が表示されます。
  "javascript.inlayHints.parameterNames.enabled": "all",
  "typescript.inlayHints.parameterNames.enabled": "all",
  // vscode の window 上部の名前を変更する
  "window.title": "${activeEditorMedium}${separator}${rootName}",
  // ファイルツリーにインデントのガイド線を表示する
  "workbench.tree.renderIndentGuides": "always",
  // ファイルツリーにインデントのサイズを変更する
  "workbench.tree.indent": 16,
  // vscode のテーマを変更する
  "workbench.colorTheme": "Monokai",
  // ターミナルで選択するとコピー、右クリックで貼り付け出来るようにする
  "terminal.integrated.copyOnSelection": true,
  "terminal.integrated.rightClickBehavior": "paste",
  // git リポジトリを同期する前に確認しないようにする
  "git.confirmSync": false,
  // vscodeのカーソルを変更する
  "editor.cursorStyle": "block",
  "workbench.colorCustomizations": {
    "editorCursor.foreground": "#f858f07f",
    "terminalCursor.foreground": "#f858f07f"
  },
  "editor.cursorBlinking": "expand",
  // カーソルがにゅるっと移動する
  "editor.cursorSmoothCaretAnimation": true
}
```
