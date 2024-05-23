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

## 型パラメータ

ジェネリックに使われる`<T>`というシンボル
パラメータの型は推論可能

## Option<T>列挙体

失敗の可能性がある関数は多く、その戻り値によく使用される

```rs
enum Option<T>
    Some(T),
    None,
```

これは、T 型のオプション値で、T 型のどれかであるケースと、どれでもないの二者択一となる

## Result ＜ T， E ＞列挙型

Option 型が`結果がない場合`を`None`で表現するのに対して、Result 型ではエラーの条件や理由を記述した値を追加する

```rs
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

### unwrap 関数

Ok バリアントに適用されたらその値を返すが、そうでなければ Panic を起こす
