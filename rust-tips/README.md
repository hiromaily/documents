# Rust Tips

## References

- [Rust by Example 日本語版](https://doc.rust-jp.rs/rust-by-example-ja/)
- [Rust 入門](https://zenn.dev/mebiusbox/books/22d4c1ed9b0003)
- [とほほの Rust 入門](https://www.tohoho-web.com/ex/rust.html)

## Install on MacOS

```
brew install rustup-init
rustup-init
exec $SHELL -l

rustup --version
rustc --version
cargo --version

# install cargo-edit (https://crates.io/crates/cargo-edit)
cargo install cargo-edit

# install rust-analyzer
rustup component add rls rust-src rust-analysis

# update all
rustup update

# create project
cargo new foo_bar
```

## cargo-edit

- [cargo-edit](https://crates.io/crates/cargo-edit)

```
# add package
cargo add <package-name>
cargo add <package-name>@<version>

# add package for development
cargo add <package-name> --dev

# upgrade package
cargo upgrade <package-name>

# remove package
cargo rm <package-name>
```

## 用語集
- [トレイト(trait)](https://doc.rust-jp.rs/book-ja/ch10-02-traits.html)
  - 構造体が実装すべきメソッドを定義する、Interfaceのようなもの
```
struct Rect { width: u32, height: u32 }

trait Printable { fn print(&self); }
impl Printable for Rect {
    fn print(&self) {
        println!("width:{}, height:{}", self.width, self.height)
    }
}
```

- [クレート(crate)](https://doc.rust-jp.rs/book-ja/ch07-01-packages-and-crates.html)
  - パッケージ、モジュール、ライブラリを意味する
```
# rand crate
use rand::Rng;

fn main() {
    let mut rng = rand::thread_rng();
    for _i in 1..10 {
        println!("{}", rng.gen_range(1, 101));
    }
}
```

- [マクロ](https://doc.rust-jp.rs/book-ja/ch19-06-macros.html)

- [属性](https://zenn.dev/mebiusbox/books/22d4c1ed9b0003/viewer/a3d2c9#%F0%9F%93%8C-%E5%B1%9E%E6%80%A7)
  - 属性とは追加情報（メタデータ）のことで，宣言やコンテキストに対して付与することができる