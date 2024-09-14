# EditorConfig

異なるエディタ間でのコードフォーマットを統一するための構成ファイル。特にチームプロジェクトにおいて、一貫したコーディングスタイルを保つことに役立つ。

エディタやIDEに設定を提供し、ファイルごとの書式設定（タブ幅、文字セット、改行形式など）を統一するためのツールで、異なる開発者が異なる環境で作業しても、コードのスタイルが一貫して保たれるようになる。

## 1. `.editorconfig`ファイルをプロジェクトのルートに作成

まず、プロジェクトのルートディレクトリに`.editorconfig`というファイルを作成する。このファイルには、デフォルトの設定や特定のファイルタイプに対する設定を記述する。

```ini
# EditorConfigのルートファイルであることを指定
root = true

# すべてのファイルに適用される設定
[*]
charset = utf-8
indent_style = space
indent_size = 2
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

# Markdownファイルに特化した設定
[*.md]
indent_style = tab
trim_trailing_whitespace = false
```

## 2. Visual Studio Codeの設定

`EditorConfig for VS Code` 拡張機能をインストールする

## よく使われる設定項目

- `root`: これはオプションで、設定を検索する際のルートディレクトリを指定。
- `indent_style`: インデントスタイルを指定（`space`または`tab`）。
- `indent_size`: インデントの幅を指定。
- `charset`: 文字エンコーディングを指定します（例：`utf-8`）。
- `end_of_line`: 改行コードを指定します（`lf`、`cr`、`crlf`）。
- `insert_final_newline`: ファイルの最後に必ず改行を挿入するかどうかを指定。
- `trim_trailing_whitespace`: 行末の空白を自動的に削除するかどうかを指定。

## よく利用する言語の設定例

```ini
# EditorConfigのルートファイルであることを指定
root = true

# Go (golang) 設定
[*.go]
indent_style = space
indent_size = 2

# TypeScript 設定
[*.ts]
indent_style = space
indent_size = 2

# Makefile 設定
[Makefile]
indent_style = tab

# Rust 設定
[*.rs]
indent_style = space
indent_size = 2

# Dockerfile 設定
[Dockerfile]
charset = utf-8
indent_style = space
indent_size = 4

# YAML 設定
[*.yaml]
[*.yml]
indent_style = space
indent_size = 2
```
