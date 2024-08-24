# ライフタイム

Rust はすべての`参照`に`ライフタイム`を持つ。明示的にライフタイムを指定する場合は`'a`のような、ライフタイムパラメータを使用する必要があるのだが、すべての参照にライフタイムパラメータを書くのは手間がかかるので、一定のルールに沿ってライフタイムを推論しルール外のものはコンパイルエラーという仕様になっている。

## ライフタイムポジション

ライフタイムパラメータを書ける場所のことで、「入力」または「出力」という形で現れる。`fn` 定義では、入力とは仮引数の型のことで、出力とは結果の型のこと。

```rs
// &'a T
// &'a mut T
// T<'a>

// 変数の束縛
let a = &'a b;
let a = &'a mut b;

// 引数と戻り値
fn foo<'a>(arg: &'a str) -> &'a str
```

## References

- [書籍: Rust プログラミング完全ガイド (第 23 章)](https://book.impress.co.jp/books/1121101129)
  - こちらが一番理解しやすい
- [The Rust Programming Language 日本語版: ライフタイムで参照を検証する](https://doc.rust-jp.rs/book-ja/ch10-03-lifetime-syntax.html)
- [Rust 裏本: ライフタイム](https://doc.rust-jp.rs/rust-nomicon-ja/lifetimes.html)
