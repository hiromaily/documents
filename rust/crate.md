# Crate

パッケージ、モジュール、ライブラリを意味する。

```rs
# rand crate
use rand::Rng;

fn main() {
    let mut rng = rand::thread_rng();
    for _i in 1..10 {
        println!("{}", rng.gen_range(1, 101));
    }
}
```

## クレートルート (crate root)

Rust コンパイラの開始点となり、クレートのルートモジュールを作るソースファイルのことで、Cargo は `src/main.rs` が、パッケージと同じ名前を持つ`バイナリクレート`の`クレートルート`であると判断する。

## バイナリクレートとライブラリクレート

### 実行バイナリクレート

エントリポイント (main 関数) を持つクレートで、`cargo new --bin` (bin は省略可)で作成される

```txt
modules/
├── Cargo.toml
└── src
    └── main.rs <--- クレートルート
```

### ライブラリクレート

エントリポイントを持たないクレートで、`cargo new --lib`で作成される。

```txt
libraries/
├── Cargo.toml
└── src
    └── lib.rs <--- クレートルート
```

## References

- [The Rust community’s crate registry](https://crates.io/)
  - crate のバージョン情報を調べるために便利
- [The Rust Programming Language 日本語版: パッケージとクレート](https://doc.rust-jp.rs/book-ja/ch07-01-packages-and-crates.html)
- [100 日後に Rust をちょっと知ってる人になる: [Day 43]モジュールシステム](https://zenn.dev/shinyay/articles/hello-rust-day043)
