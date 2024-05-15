# Rust Tips

## References

- [Rust を学ぶ](https://www.rust-lang.org/ja/learn)
- [The Rust Programming Language 日本語版](https://doc.rust-jp.rs/book-ja/)
- [Rust by Example 日本語版](https://doc.rust-jp.rs/rust-by-example-ja/)
- [Zenn: Rust 入門](https://zenn.dev/mebiusbox/books/22d4c1ed9b0003)
- [Microsft: Rust の最初のステップ](https://learn.microsoft.com/ja-jp/training/paths/rust-first-steps/)
- [とほほの Rust 入門](https://www.tohoho-web.com/ex/rust.html)

## [Rust 初心者が実務レベルになるまでの学習ステップ](https://ai-techblog.hatenablog.com/entry/2023/03/26/082349)

## Install on MacOS

```sh
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

```sh
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
  - 構造体が実装すべきメソッドを定義する、Interface のようなもの

```rs
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

- [マクロ](https://doc.rust-jp.rs/book-ja/ch19-06-macros.html)
  - 例えば`println!`は関数ではなくマクロであり、マクロの引数を展開して関数の呼び出しに置き換える処理をしている
    - 内部的には、`std::io::println()`の関数呼び出しに置き換えられる。`std::io`モジュールの`println`関数
    - 尚、`std::io`モジュールは default で import されるため、明示的な import は不要となる
  - `!`を末尾につけることでマクロを表す
- [属性](https://zenn.dev/mebiusbox/books/22d4c1ed9b0003/viewer/a3d2c9#%F0%9F%93%8C-%E5%B1%9E%E6%80%A7)
  - 属性とは追加情報（メタデータ）のことで，宣言やコンテキストに対して付与することができる

## 基本型

- i8
- i16
- i32 -> 通常の int と同義
- i64
- u8
- u16
- u32
- u64
- isize: 環境によって変化する符号付き整数
- usize: 環境によって変化する符号無し整数
- f32: 32 ビット浮動小数点数
- f64: 64 ビット浮動小数点数

## 文字列型

- char: Unizode のスカラ値 (4bytes)
- str: Unicode の文字列型
  - 内部的には u8 型の配列が使用される
  - u8: 8 ビット符号なし整数を表す型だが、1byte のデータを扱うことができるが、文字を表すことができるわけではない

## 特徴

- 型推論ができるため、`let 変数名 = 値;`のみで型まで設定できる。もちろん`let 変数名: 型 = 値;`
