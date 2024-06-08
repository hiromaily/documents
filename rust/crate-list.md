# Crate List

- [std](https://doc.rust-lang.org/stable/std/)

## CLI

### [clap](https://crates.io/crates/clap)

Command Line Argument Parser

[Docs](https://docs.rs/clap/latest/clap/)

```sh
cargo add clap --features derive
```

```toml
[dependencies]
clap = { version = "4.5.0", features = ["derive"] }
```

## Logging

### [log](https://crates.io/crates/log)

A lightweight logging facade

- [Docs](https://docs.rs/log/latest/log/)
- [github](https://github.com/rust-lang/log/tree/master)

こちらには実装が含まれていないため、別途実装のための crate を使うが独自実装を用意する必要がある

#### 実装 [eng_logger](https://crates.io/crates/env_logger)

実行時に`RUST_LOG` 環境変数の設定が必要

```rs
RUST_LOG=info ./main
```

## データのシリアライゼーションとデシリアライゼーション (JSON など)

### [serde](https://crates.io/crates/serde)

- [Docs](https://serde.rs/)
- [github](https://github.com/serde-rs/serde): Star: 8.7k

## 非同期 Runtime

### [tokio](https://crates.io/crates/tokio)

A runtime for writing reliable asynchronous applications with Rust. Provides I/O, networking, scheduling, timers ...

- [Docs](https://tokio.rs/)
- [github](https://github.com/tokio-rs/tokio): Star: 25.1k

### [async-trait](https://crates.io/crates/async-trait)

trait 内で async fn を定義するのに利用される

```rs
#[async_trait::async_trait]
trait Foo {
   async fn foo(&self) -> u32;
}
```

しかし、Rust の 1.75 から`async fn in trait`が実装されため、こちらは不要となる

[参照: trait に async fn を含める方法](https://zenn.dev/uzabase/articles/c6a581e44effe0)

## Test Utility

### [assert_cmd](https://crates.io/crates/assert_cmd)

簡単なコマンドの初期化とアサーションが可能で、CLI の統合テストを実行するプロセスを簡素化することを目的としている

- テストするクレート バイナリの検索
- プログラムの実行結果のアサート

[Docs](https://docs.rs/assert_cmd/latest/assert_cmd/)

```sh
cargo add assert_cmd --dev
```

```toml
[dev-dependencies]
assert_cmd = "2.0.13"
```

```rs
use assert_cmd::Command;

let mut cmd = Command::cargo_bin("bin_fixture").unwrap();
cmd.assert().success();
```

### [pretty_assertions](https://crates.io/crates/pretty_assertions)

`assert_eq!` and `assert_ne!` を overwrite したもので、console に colorful diffs を表示できる

```sh
cargo pretty_assertions --dev
```

```rust
#[cfg(test)]
use pretty_assertions::{assert_eq, assert_ne};
```

### [predicates](https://crates.io/crates/predicates)

Rust でのブール値の述語関数の実装。
このライブラリは、`述語` (引数が 1 つのブール値関数) へのインターフェイスを実装する。これにより、実行時に組み合わせロジックを作成して組み立て、値の評価に 1 回以上使用できるようになる。この種のオブジェクトは、実行時にユーザー操作で変更できるフィルターやチェックを作成するときに非常に便利。これにより、構成コードを使用して述語を構築し、その述語を実際のフィルタリングを行うコードに渡すことができるため、関心を明確に分離できる。フィルタリング コードはユーザー構成について何も知らない。

[Docs](https://docs.rs/predicates/3.1.0/predicates/)

```sh
cargo predicates --dev
```

```toml
[dev-dependencies]
predicates = "3.0.4"
```

```rs
use predicates::prelude::*;

let less_than_ten = predicate::lt(10);
assert_eq!(true, less_than_ten.eval(&9));
assert_eq!(false, less_than_ten.eval(&11));
```

## Error Handling

### [anyhow](https://crates.io/crates/anyhow)

Rust アプリケーションで簡単に慣用的なエラー処理を実行するための特性オブジェクト ベースのエラー型である `anyhow::Error` を提供する。
失敗のある関数の戻り値の型として、`Result<T, anyhow::Error>`、または同等の `anyhow::Result<T>` を使用する。

```sh
cargo anyhow --dev
```

```toml
[dev-dependencies]
anyhow = "1.0.79"
```

```rs
use anyhow::Result;

fn get_cluster_info() -> Result<ClusterMap> {
    let config = std::fs::read_to_string("cluster.json")?;
    let map: ClusterMap = serde_json::from_str(&config)?;
    Ok(map)
}
```

- [エラーハンドリング: anyhow](./error-handling.md#anyhowによるエラー処理)
- [ライブラリ辞典: Rust の複数のエラー型のエラーハンドリングを楽にする anyhow の使い方](https://libdict.com/rust/anyhow/introduction)

### [thiserror](https://crates.io/crates/thiserror)

Rust で独自のエラータイプを実装する必要がある場合、簡単にカスタムエラータイプを実装できる

```toml
[dependencies]
thiserror = "1.0"
```

```rs
use thiserror::Error;

#[derive(Error, Debug)]
pub enum DataStoreError {
    #[error("data store disconnected")]
    Disconnect(#[from] io::Error),
    #[error("the data for key `{0}` is not available")]
    Redaction(String),
    #[error("invalid header (expected {expected:?}, found {found:?})")]
    InvalidHeader {
        expected: String,
        found: String,
    },
    #[error("unknown data store error")]
    Unknown,
}
```

- [ライブラリ辞典: Rust で独自のエラータイプの実装を楽にする thiserror の使い方](https://libdict.com/rust/thiserror/introduction)
