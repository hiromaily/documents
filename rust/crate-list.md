# Crate List

- [std](https://doc.rust-lang.org/stable/std/)

## [clap](https://crates.io/crates/clap)

Command Line Argument Parser

[Docs](https://docs.rs/clap/latest/clap/)

```sh
cargo add clap --features derive
```

```toml
[dependencies]
clap = { version = "4.5.0", features = ["derive"] }
```

## [assert_cmd](https://crates.io/crates/assert_cmd)

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

## [pretty_assertions](https://crates.io/crates/pretty_assertions)

`assert_eq!` and `assert_ne!` を overwrite したもので、console に colorful diffs を表示できる

```sh
cargo pretty_assertions --dev
```

```rust
#[cfg(test)]
use pretty_assertions::{assert_eq, assert_ne};
```

## [predicates](https://crates.io/crates/predicates)

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

## [anyhow](https://crates.io/crates/anyhow)

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
