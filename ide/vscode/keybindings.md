# Key Bindings

## keybindings.json

```json
// 既定値を上書きするには、このファイル内にキー バインドを挿入します
[
  // 新規ファイル
  {
    "key": "cmd+n",
    "command": "-workbench.action.files.newUntitledFile"
  },
  {
    "key": "cmd+n",
    "command": "explorer.newFile"
  },
  // 新規フォルダ
  {
    "key": "shift+cmd+n",
    "command": "explorer.newFolder"
  },
  // Git の tab に移動
  {
    "key": "shift+cmd+g",
    "command": "workbench.view.scm",
    "when": "workbench.scm.active && !gitlens:disabled && config.gitlens.keymap == 'chorded'"
  },
  // ターミナルの画面をトグルで表示する
  {
    "key": "cmd+j",
    "command": "-workbench.action.togglePanel"
  },
  {
    "key": "cmd+j",
    "command": "workbench.action.terminal.toggleTerminal",
    "when": "terminal.active"
  },
  // JSDocの生成を無効化 と 生成
  {
    "key": "cmd+j",
    "command": "-jsdoc-generator.generateJSDoc"
  },
  {
    "key": "ctrl+cmd+j",
    "command": "jsdoc-generator.generateJSDoc"
  },
  // リンク, 定義元を開く
  {
    "key": "ctrl+cmd+enter",
    "command": "editor.action.openLink"
  },
  {
    "key": "ctrl+cmd+enter",
    "command": "editor.action.goToTypeDefinition"
  },
  {
    "key": "ctrl+cmd+enter",
    "command": "editor.action.revealDefinition"
  },
  // parameterHints を開いたり閉じたりする
  {
    "key": "cmd+space",
    "command": "editor.action.triggerParameterHints",
    "when": "editorHasSignatureHelpProvider && editorTextFocus"
  },
  {
    "key": "cmd+space",
    "command": "closeParameterHints",
    "when": "editorFocus && parameterHintsVisible"
  },
  // 予測変換を tab で選択する
  {
    "key": "tab",
    "command": "selectNextSuggestion",
    "when": "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus"
  },
  {
    "key": "shift+tab",
    "command": "selectPrevSuggestion",
    "when": "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus"
  }
]
```
