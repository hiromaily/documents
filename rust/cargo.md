# Cargo

Rust のパッケージマネージャであり、Rust のパッケージの依存関係をダウンロードし、パッケージをコンパイルして配布可能なパッケージを作成し、Rust コミュニティのパッケージ・レジストリである`crates.io`にアップロードする (実体は github が多い)。

## Cargo commands

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

## Cargo.toml (manifest)

[The Manifest Format](https://doc.rust-lang.org/cargo/reference/manifest.html)

## Cargo.toml: Dependencies 依存関係

git repositories もしくは local 環境のサブディレクトリにある依存ファイルを指定する。これは Test のために一時的にロケーションを切り替えることも可能。

```toml
[package]
name = "hello_world"
version = "0.1.0"
edition = "2021"

[dependencies]
time = "0.1.12"
regex = "0.1.41"
```

`cargo build`を実行すると、Cargo が新しい依存関係とその依存関係をすべて取得し、それらをすべてコンパイルして、`Cargo.lock`を更新する

### git から直接参照する場合

```toml
[dependencies]
regex = { git = "https://github.com/rust-lang/regex.git", rev = "9f9f693" }
```

### version の指定方法

- 例えば `cargo update time` を実行すると、minor version までの範囲で update される。
- `log = "^1.2.3"` と `log = "1.2.3"` は同じ意味を持つ
- `~1.2.3 := >=1.2.3, <1.3.0`
- `1.2.* := >=1.2.0, <1.3.0`

### feature flag

コンパイル時にクレートの特定の機能の有効/無効を切り替えることのできる `フィーチャーフラグ (feature flag)` と呼ばれる機能がある

```toml
[dependencies]
clap = { version = "4.5.0", features = ["derive"] }
```

上記は、clap クレートを `derive` フラグを立てた状態で使用することを意味する

- [[Rust] フィーチャーフラグの使い方](https://qiita.com/osanshouo/items/43271813b5d62e89d598)

## References

- [The Cargo Book](https://doc.rust-lang.org/cargo/index.html)
