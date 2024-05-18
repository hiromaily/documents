# Glossary 用語集

## [トレイト(trait)](https://doc.rust-jp.rs/book-ja/ch10-02-traits.html)

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
