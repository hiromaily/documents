# RUST

RUST は式指向言語

## 式と文

- `文`はなんらかの動作をして値を返さない命令
  - 値を返さない
  - 関数定義
- `式`は結果値に評価される
  - 値を返す
  - 関数呼び出し
  - スコープを作る際に仕様するブロック{}
  - 式は終端にセミコロンを含めない

## References

- [Rust を学ぶ](https://www.rust-lang.org/ja/learn)
- [github: rust-learning](https://github.com/ctjhoa/rust-learning?tab=readme-ov-file)
- [The Rust Programming Language 日本語版](https://doc.rust-jp.rs/book-ja/)
- [Rust by Example 日本語版](https://doc.rust-jp.rs/rust-by-example-ja/)
- [Rust 裏本 (The Rustonomicon)](https://doc.rust-jp.rs/rust-nomicon-ja/index.html)
- [The Rust Reference](https://doc.rust-lang.org/reference/introduction.html)
- [Rust Design Patterns](https://rust-unofficial.github.io/patterns/intro.html)
- [Effective Rust](https://effective-rust.com/preface.html)
- [Asynchronous Programming in Rust 日本語](https://async-book-ja.netlify.app/01_getting_started/01_chapter)
- [Practice Rust](https://www.rustfinity.com/practice/rust/challenges)
- [Microsft: Rust の最初のステップ](https://learn.microsoft.com/ja-jp/training/paths/rust-first-steps/)
- [Zenn: Rust 入門](https://zenn.dev/mebiusbox/books/22d4c1ed9b0003)
  - 言葉の定義が独特でわかりにくい
- [ライブラリ辞典(α): Rust](https://libdict.com/rust)
- [とほほの Rust 入門](https://www.tohoho-web.com/ex/rust.html)
- [Gopher が Rust 入門したので違いをまとめてみた](https://zenn.dev/skanehira/articles/2024-08-12-go-rust-pros-cons)

## [Rust 初心者が実務レベルになるまでの学習ステップ](https://ai-techblog.hatenablog.com/entry/2023/03/26/082349)

- 1.Rust の基本を学ぶ
  - [The Rust Programming Language 日本語版](https://doc.rust-jp.rs/book-ja/)
- 2.Rust の基本構文を理解する
  - 変数、データ型、関数、制御構造（if、else、for、while)
    - [The Rust Programming Language 日本語版: 一般的なプログラミングの概念](https://doc.rust-jp.rs/book-ja/ch03-00-common-programming-concepts.html)
  - エラーハンドリング（Result 型、Option 型、パニック、エラー処理）
    - [The Rust Programming Language 日本語版: 数当てゲームのプログラミング](https://doc.rust-jp.rs/book-ja/ch02-00-guessing-game-tutorial.html)
    - [Rust のエラーハンドリングガイド！Option 型や Result 型を使いこなす](https://libdict.com/rust/lang-error-handling)
- 3.所有権、借用を理解する
  - 所有権、ムーブセマンティクス、参照、借用のルール
  - [The Rust Programming Language 日本語版: 所有権を理解する](https://doc.rust-jp.rs/book-ja/ch04-00-understanding-ownership.html)
- 4.構造体、列挙型、パターンマッチングを学ぶ
- 5.モジュール、パッケージ、クレートを理解する
- 6.トレイトとジェネリクスを学ぶ
- 7.非同期プログラミングとコンカレンシーを学ぶ
- 8.テストを書く
- 9.ドキュメントを書く
- 10.Rust のエコシステムに慣れる
- 11.実践的なプロジェクトを手がける
- 12.高度な Rust の機能を学ぶ

## Install on MacOS

```sh
brew install rustup-init
rustup-init
exec $SHELL -l

rustup --version # Rust環境管理: コンパイラ更新,コンポーネント管理など
rustc --version  # コンパイラ
cargo --version  # ビルドツール兼パッケージマネージャ
```

### `rustup component add`と`cargo install`の違い

- `rustup component add`
  - rustup を使って install する場合は source ではなく binary を取得することになる
- `cargo install`
  - crates.io から情報を取得し、source をダウンロードして、端末側で build する

### rustup

Rust のインストールやアップグレード、管理を簡単にできる

- update: `rustup update`
- read document: `rustup doc`
- see version: `rustup --version`

```sh
# update all
rustup update
```

### cargo

プログラムのビルドやパッケージ管理、テストの実行ができる

```sh
❯ cargo help
Rust's package manager

Usage: cargo [+toolchain] [OPTIONS] [COMMAND]
       cargo [+toolchain] [OPTIONS] -Zscript <MANIFEST_RS> [ARGS]...

Options:
  -V, --version             Print version info and exit
      --list                List installed commands
      --explain <CODE>      Provide a detailed explanation of a rustc error message
  -v, --verbose...          Use verbose output (-vv very verbose/build.rs output)
  -q, --quiet               Do not print cargo log messages
      --color <WHEN>        Coloring: auto, always, never
  -C <DIRECTORY>            Change to DIRECTORY before doing anything (nightly-only)
      --frozen              Require Cargo.lock and cache are up to date
      --locked              Require Cargo.lock is up to date
      --offline             Run without accessing the network
      --config <KEY=VALUE>  Override a configuration value
  -Z <FLAG>                 Unstable (nightly-only) flags to Cargo, see 'cargo -Z help' for details
  -h, --help                Print help

Commands:
    build, b    Compile the current package
    check, c    Analyze the current package and report errors, but don't build object files
    clean       Remove the target directory
    doc, d      Build this package's and its dependencies' documentation
    new         Create a new cargo package
    init        Create a new cargo package in an existing directory
    add         Add dependencies to a manifest file
    remove      Remove dependencies from a manifest file
    run, r      Run a binary or example of the local package
    test, t     Run the tests
    bench       Run the benchmarks
    update      Update dependencies listed in Cargo.lock
    search      Search registry for crates
    publish     Package and upload this package to the registry
    install     Install a Rust binary
    uninstall   Uninstall a Rust binary
    ...         See all commands with --list

See 'cargo help <command>' for more information on a specific command.
```

```sh
# create project
cargo new foo_bar

cargo init # in current directory
```

## 便利なクレートの install

- [crates.io](https://crates.io/)

### formatter

```sh
# これにより、cargoにsubコマンドとして、`fmt`が追加される
rustup component add rustfmt

# Format
cargo fmt
```

### linter

```sh
# これにより、cargoにsubコマンドとして、`clippy`が追加される
rustup component add clippy

# Lint
cargo clippy
```

### [cargo-edit](https://crates.io/crates/cargo-edit)

依存関係を解決し、Cargo.toml ファイルを更新する

```sh
# これにより、cargoにsubコマンドとして、`add`,`rm`,`upgrade`が追加される
cargo install cargo-edit
```

```sh
# add package (依存packageの追加)
cargo add <package-name>
cargo add <package-name>@<version>

# add package for development
cargo add <package-name> --dev

# upgrade all packages
cargo upgrade
# upgrade package
cargo upgrade <package-name>

#
cargo update <package-name>

# remove package
cargo rm <package-name>
```

### コンパイラの警告 (warning) の自動修正

Rust の install 時に`rustfix`は一緒にインストールされる

```sh
cargo fix
```

## ソースコードのコンパイル

`rustc`が Rust のコンパイラとなる

```sh
rustc src/main.rs

rustc ./src/main.rs -o ./bin/main
```

`cargo build` もしくは、`cargo run`でもビルドできる
これらは、target ディレクトリを作成し、ビルドによる成果物を格納する

```sh
cargo build
cargo build -r # releaseモード

cargo run
cargo run -r　# releaseモードの場合

cargo run --bin hello

# targetディレクトリの削除
cargo clean
```

## Test の実行

```sh
cargo test

# Test functionの名前に`something`が含まれるものを実行する
cargo test something
```
