# Package Layout

- [Package Layout](https://doc.rust-lang.org/cargo/guide/project-layout.html)

## ディレクトリ

`benches`, `bin`, `examples`, `tests`という 4 種のフォルダ名には、暗黙的に役割が与えられている

```sh
# examplesフォルダ
cargo run --example [ファイル名]

# binフォルダ
cargo run --bin     [ファイル名]

# testsフォルダ内のテスト実行
cargo test

# benchesフォルダ内のベンチマーク実行
cargo bench
```
