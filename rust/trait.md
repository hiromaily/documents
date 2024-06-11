# トレイト Trait

## トレイト制約(トレイト境界): ジェネリック関数に使う型パラメータが、特定のメソッドを実装していることを保証する

以下は、`HasSquareRoot`トレイトを f32 型と f64 型に、指定のコードで実装するという意味があり、`quartic_root`ジェネリック関数の、`where Number: HasSquareRoot` は`トレイト制約`と呼ばれ、このジェネリック関数のジェネリック型 Number は、`HasSquareRoot`を実装している必要がある、ということを意味する。

また、これを`パラメータ制約`というが、パラメータ制約のないジェネリック関数はわずかなことしかできないことが多いため、ほとんどのジェネリック関数の型パラメータには常にトレイト制約が必要になる。

```rs
// HasSquareRootトレイト
trait HasSquareRoot {
    fn sq_root(self) -> Self;
}
// f32にHasSquareRootを実装
impl HasSquareRoot for f32 {
    fn sq_root(self) -> Self {
        self.sqrt()
    }
}
// f64にHasSquareRootを実装
impl HasSquareRoot for f64 {
    fn sq_root(self) -> Self {
        self.sqrt()
    }
}

// ジェネリクス関数
// ジェネリクスのNumber型はHasSquareRootトレイトが実装されている必要がある
fn quartic_root<Number>(x: Number) -> Number
where Number: HasSquareRoot {
    x.sq_root().sq_root()
}

// 呼び出し
print!("{} {}",
    quartic_root(100f64),
    quartic_root(100f32),
)
```

複数の制約を持つジェネリックパラメータは以下の通り

```rs
// HasSquareRootトレイト
trait HasSquareRoot {
    fn sqrt(self) -> Self;
}
// f32にHasSquareRootを実装
impl HasSquareRoot for f32 {
    fn sqrt(self) -> Self {
        self.sqrt()
    }
}
// f64にHasSquareRootを実装
impl HasSquareRoot for f64 {
    fn sqrt(self) -> Self {
        self.sqrt()
    }
}

// HasAbsoluteValueトレイト
trait HasAbsoluteValue {
    fn abs(self) -> Self;
}
// f32にHasAbsoluteValueを実装
impl HasAbsoluteValue for f32 {
    fn abs(self) -> Self {
        self.abs()
    }
}
// f64にHasAbsoluteValueを実装
impl HasAbsoluteValue for f64 {
    fn abs(self) -> Self {
        self.abs()
    }
}

// ジェネリクス関数
// ジェネリクスのNumber型はHasSquareRootトレイト及びHasAbsoluteValueトレイトが実装されている必要がある
fn abs_quartic_root<Number>(x: Number) -> Number
where Number: HasSquareRoot + HasAbsoluteValue {
    x.abs().x.sqrt().sqrt()
}

// 呼び出し
print!("{} {}",
    abs_quartic_root(100f64),
    abs_quartic_root(100f32),
)
```

## トレイト継承

これにより複数のトレイトを 1 つの新しいトレイトにまとめる

```rs
// HasSquareRootトレイト
trait HasSquareRoot {
    fn sqrt(self) -> Self;
}
impl HasSquareRoot for f32 {
    fn sqrt(self) -> Self {
        self.sqrt()
    }
}
impl HasSquareRoot for f64 {
    fn sqrt(self) -> Self {
        self.sqrt()
    }
}

// HasAbsoluteValueトレイト
trait HasAbsoluteValue {
    fn abs(self) -> Self;
}
impl HasAbsoluteValue for f32 {
    fn abs(self) -> Self {
        self.abs()
    }
}
impl HasAbsoluteValue for f64 {
    fn abs(self) -> Self {
        self.abs()
    }
}

// トレイト継承
trait HasSqrtAndAbs: HasSquareRoot + HasAbsoluteValue { }
// implも必要
impl HasSqrtAndAbs for f32 {} // 空ブロックでOK
impl HasSqrtAndAbs for f64 {} // 空ブロックでOK


// ジェネリクス関数
// ジェネリクスのNumber型はHasSqrtAndAbsトレイトが実装されている必要がある
fn abs_quartic_root<Number>(x: Number) -> Number
where Number: HasSqrtAndAbs {
    x.abs().x.sqrt().sqrt()
}

// 呼び出し
print!("{} {}",
    abs_quartic_root(100f64),
    abs_quartic_root(100f32),
)
```

## `str`といったスタンダードライブラリなどの外部型に Trait によってメソッドを追加する

```rs
// HasLengthトレイト
// メソッドが1つしかない場合、そのメソッド名をトレイト名にするのが慣例なので、`Length`が正しい
trait HasLength {
    fn length(&self) -> usize;
}
// strにHasLengthを実装
impl HasLength for str {
    fn length(&self) -> usize { self.chars().count() }
}

// 呼び出し
let s = "$ee";
print!("{} {}", s.len(), s.length());
```

## 構造体に Trait によってメソッドを追加する(一番使われやすいはず)

```rs
struct Rect { width: u32, height: u32 }

// Printableトレイト
trait Printable {
    fn print(&self);
}
// Rect構造体にPrintableを実装
impl Printable for Rect {
    fn print(&self) {
        println!("width:{}, height:{}", self.width, self.height)
    }
}

// 呼び出し
let rect = Rect{ width: 20, height: 15};
rect.print();
```

## ジェネリックトレイト

トレイトも 1 つ以上の型によるパラメータ化が可能で、2 つの引数に違う型を使いたい場合などに有効

```rs
// HasLnExpトレイト
trait HasLnExp {
    fn ln(self) -> Self;
    fn exp(self) -> Self;
}
impl HasLnExp for f64 {
    fn ln(self) -> Self { self.ln() }
    fn exp(self) -> Self { self.exp() }
}
impl HasLnExp for f32 {
    fn ln(self) -> Self { self.ln() }
    fn exp(self) -> Self { self.exp() }
}

// HasMultiply<Rhs>ジェネリックトレイト
trait HasMultiply<Rhs> { // Rhs stands for right-hand side
    fn multiply(self, rhs: Rhs) -> Self;
}
// ジェネリックトレイトの実装
// - Infoは標準ライブラリのジェネリックトレイトで、info関数は精度を失わずに型変換を行う
// - ここでは、Self型に型変換を行う
impl<Rhs> HasMultiply<Rhs> for f64 where Rhs: Info<Self> {
    fn multiply(self, rhs: Rhs) -> Self { self * rhs.info() }
}
impl<Rhs> HasMultiply<Rhs> for f32 where Rhs: Info<Self> {
    fn multiply(self, rhs: Rhs) -> Self { self * rhs.info() }
}

// ジェネリクス関数
// ジェネリクスのBase型はHasLnExpトレイト及びHasMultiply<Exponent>トレイトが実装されている必要がある
fn exponentiate<Base, Exponent>(
    base: Base, exponent: Exponent) -> Base
where Base: HasLnExp + HasMultiply<Exponent>
{
    (base.ln().multiply(exponent)).exp()
}

// 呼び出し
println!("{}", exponentiate(2.5f32, 3i16)); // 2.5^3
println!("{}", exponentiate(2.5f64, 3f32)); // 2.5^3
```

## 関連型: Associated types

`関連型`を使用すると、inner types を output types としての trait にローカルに移動することで、コード全体の可読性が向上する。ジェネリックトレイトの別の書き方とも言える。

```rs
// `A` and `B` are defined in the trait via the `type` keyword.
// (Note: `type` in this context is different from `type` when used for
// aliases).
trait Contains {
    type A;
    type B;

    // Updated syntax to refer to these new types generically.
    fn contains(&self, _: &Self::A, _: &Self::B) -> bool;
}
```

```rs
// Dictionaryトレイト
trait Dictionary {
    type key;
    type Count;
    fn get(&self, key: Self::Key) -> Option<String>;
    fn count(&self, key: Self::Key) -> Self::Count;
}
struct Record {
    id: u32,
    name: String,
}
struct  RecordSet {
    data: Vec<Record>,
}
// RecordSetにDictionaryを実装
impl Dictionary for RecordSet {
    fn get(&self, key: Self::Key) -> Option<String> {
        for record in self.data.iter() {
            if record.id == key {
                return Some(String::from(&record.name));
            }
        }
        None
    }
    fn count(&self, key: Self::Key) -> Self::Count {
        let mut c = 0;
        for record in self.data.iter() {
            if record.id == key {
                c += 1;
            }
        }
        c
    }
}

// ジェネリクス関数
// ジェネリクスのD型はDictionaryトレイトが実装されている必要がある
fn get_name<D>(
    dict: &D, // Dictionaryトレイトの実装のアドレス
    id: <D as Dictionary>::Key, // DictionaryトレイトのType Key
) -> Option<String>
where D: Dictionary {
    dict.get(id)
}

// 呼び出し側
let names = RecordSet {
    data: vec![
        Record { id: 34, name: "John".to_string() },
        Record { id: 49, name: "Jane".to_string() },
    ]
}
print!(
    "{}, {}: {:?}, {:?}",
    names.count(48),
    names.count(49),
    get_name(&names, 48),
    get_name(&names, 49));
```

- [Rust By Example 日本語版: 関連型](https://doc.rust-jp.rs/rust-by-example-ja/generics/assoc_items.html)
- [Rust By Example: Associated types](https://doc.rust-lang.org/rust-by-example/generics/assoc_items/types.html)

## 標準トレイト: Iterator

```rs
trait Iterator {
    type Item;
    fn next(&mut self) -> Option<Self::Item>;
}
```

実装すべきもの

- 生成される項目の型を表現する Item の型
- もし可能ならば次の項目を返し、次の項目を生成できなければ None を返す next 関数の本体

```rs
// ジェネリクス関数
// ジェネリクスのIter型はIteratorトレイトが実装されている必要がある
fn get_third<Iter>(mut iterator: Iter) -> Option<Iter::Item>
where
    Iter: Iterator, // Iteratorトレイトの実装
{
    iterator.next();
    iterator.next();
    iterator.next()
}

// 呼び出し
print!(
    "{:?}, {:?}, {:?}, {:?}",
    get_third(10..12),
    get_third(20..29),
    get_third([3.1, 3.2].iter()),
    get_third([4.1, 4.2, 4.3, 4.4].iter()));
```

実際には、上記のジェネリクス関数は不要で、標準ライブラリに n 番目の項目を返すイテレータコンシューマ`nth`がある

```rs
// 呼び出し
print!(
    "{:?}, {:?}, {:?}, {:?}",
    (10..12).nth(2),
    (20..29).nth(2),
    [3.1, 3.2].iter().nth(2),
    [4.1, 4.2, 4.3, 4.4].iter().nth(2));

```

## 静的ディスパッチ

コンパイラによってコンパイル時にジェネリクス関数の単相化が行われるもの

```rs
// Drawトレイト
trait Draw {
    fn draw(&self);
}

struct Text { characters: String }
impl Text {
    fn from(text: &str) -> Text {
        Text { characters: text.to_string() }
    }
}
// DrawトレイトのText型のための実装
impl Draw for Text {
    fn draw(&self) {
        print!("{}", self.characters);
    }
}

struct BoxedText {
    text: Text,
    first: char,
    last: char,
}
impl BoxedText {
    fn from(
        text: &str, first: char, last: char) -> BoxedText
    {
        BoxedText {
            text: Text::from(text),
            first: first,
            last: last,
        }
    }
}
// DrawトレイトのBoxedText型のための実装
impl Draw for BoxedText {
    fn draw(&self) {
        print!("{}", self.first);
        self.text.draw();
        print!("{}", self.last);
    }
}

// トレイトを引数に取るジェネリクス関数
fn draw_text<T>(txt: T) where T: Draw {
    txt.draw();
}
// 以下のようにtxtを参照にしてもよい
// fn draw_text<T>(txt: &T) where T: Draw {
//     txt.draw();
// }

// 呼び出し
let greeting = Text::from("Hello");
let boxed_greeting = BoxedText::from("Hi", '[', ']');

draw_text(greeting);
//draw_text(&greeting);
print!(", ");
draw_text(boxed_greeting);
//draw_text(&boxed_greeting);
```

## 動的ディスパッチ

```rs
// トレイトを引数に取るジェネリクス関数
fn draw_text(txt: &dyn Draw) {
    txt.draw();
}
draw_text(&greeting);
print!(", ");
draw_text(&boxed_greeting);
```

## References

- [The Rust Programming Language 日本語版: トレイト(trait)](https://doc.rust-jp.rs/book-ja/ch10-02-traits.html)
- [Rust By Example 日本語版](https://doc.rust-jp.rs/rust-by-example-ja/trait.html)
- [Rust での 抽象化 3 パターンについて](https://zenn.dev/j5ik2o/articles/045737392958a3)
- [The Rust Programming Language 日本語版: 引数としてのトレイト](https://doc.rust-jp.rs/book-ja/ch10-02-traits.html#%E5%BC%95%E6%95%B0%E3%81%A8%E3%81%97%E3%81%A6%E3%81%AE%E3%83%88%E3%83%AC%E3%82%A4%E3%83%88)
