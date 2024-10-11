# Format

ファイル保存時に自動的にフォーマットされる際に使用されるツール（フォーマッター）は、ファイルの種類や拡張子によって異なる。

1. **JavaScript/TypeScript**: `Prettier`や`ESLint`などが一般的。

   - Prettier: コード全体のフォーマットを行うためによく使われる。
   - ESLint: コードスタイルとリントを兼ね備えたツールです。VSCode の設定で`eslint --fix`を保存時に実行することも可能。

2. **HTML/CSS**: ツールとして`Prettier`が使われることが多い。

   - Prettier: HTML や CSS のフォーマットにも対応している。

3. **Python**: `Pylint`や`Black`などのツールが利用されることが多い。

   - Black: コードフォーマッターとして非常に人気がある。
   - autopep8: PEP 8 に準拠するようにコードを整えるツール。

4. **Go**: `gofmt`が標準ツール。

   - gofmt: Go プログラムのフォーマットを自動的に行う。

5. **Rust**: `rustfmt`が使われる。
   - rustfmt: Rust コードのフォーマットを自動的に行うツール。

これらのツールは、VSCode の拡張機能としてインストールされることが多い。また、拡張は特定の言語ファイルを保存する際に対応するフォーマッターを自動的に実行することができる。

## 設定ファイル

VSCode の設定ファイル（`settings.json`）において、ファイル保存時に特定のフォーマッタを適用する設定も可能。
(`User Settings`が望ましい)

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode", // 全体のデフォルト
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[python]": {
    "editor.defaultFormatter": "ms-python.python"
  }
}
```

## 設定としてデフォルトのフォーマッターを指定する [重要]

1. **コマンドパレットを表示**: `Cmd + Shift + P`（Mac）を押してコマンドパレットを表示

2. **コマンドを検索**: `Configure Default Formatter…`を選択

これらの操作により、`settings.json`ファイルが自動的に更新される。

```json
{
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

## 特定のフォーマッターを使ってフォーマットする手順

複数のフォーマッターが有効になっている場合、どのフォーマッターを使用するかを指定することができる

1. **コマンドパレットを表示**: `Cmd + Shift + P`（Mac）を押してコマンドパレットを表示

2. **コマンドを検索**: `Format Document With…`と入力

3. **フォーマッターを選択**: 任意のフォーマッターを選択して実行する

## コマンドパレットからコードフォーマットを実行する手順

1. **コマンドパレットを表示**: キーボードショートカット `Cmd + Shift + P`（Mac）を押してコマンドパレットを表示

2. **コマンドを検索**: コマンドパレットの入力欄に`format`と入力。

3. **フォーマットコマンドを選択**: 表示されたコマンド一覧から`Format Document`または`Format Selection`を選択する。

   - **Format Document**: 現在開いている全てのドキュメントをフォーマットする。
   - **Format Selection**: 選択している範囲のみをフォーマットする。
