# トレイト Trait

## トレイト制約(トレイト境界): ジェネリック関数に使う型パラメータが、特定のメソッドを実装していることを保証する

以下は、`HasSquareRoot`トレイトを f32 型と f64 型に、指定のコードで実装するという意味があり、`quartic_root`ジェネリック関数の、`where Number: HasSquareRoot` は`トレイト制約`と呼ばれ、このジェネリック関数のジェネリック型 Number は、`HasSquareRoot`を実装している必要がある、ということを意味する。

また、これを`パラメータ制約`というが、パラメータ制約のないジェネリック関数はわずかなことしかできないことが多いため、ほとんどのジェネリック関数の型パラメータには常にトレイト制約が必要になる。

```rs
// HasSquareRootトレイト
trait HasSquareRoot {
    fn sq_root(self) -> Self;
}
impl HasSquareRoot for f32 {
    fn sq_root(self) -> Self {
        self.sqrt()
    }
}
impl HasSquareRoot for f64 {
    fn sq_root(self) -> Self {
        self.sqrt()
    }
}

// ジェネリクス関数
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

// ジェネリクス関数
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
// メソッドが1つしかない場合、そのメソッド名をトレイト名にするのが慣例なので、`Length`が正しい
trait HasLength {
    fn length(&self) -> usize;
}
impl HasLength for str {
    fn length(&self) -> usize { self.chars().count() }
}

// 呼び出し
let s = "$ee";
print!("{} {}", s.len(), s.length());
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
// Infoは標準ライブラリのジェネリックトレイトで、info関数は精度を失わずに型変換を行う
// ここでは、Self型に型変換を行う
impl<Rhs> HasMultiply<Rhs> for f64 where Rhs: Info<Self> {
    fn multiply(self, rhs: Rhs) -> Self { self * rhs.info() }
}
impl<Rhs> HasMultiply<Rhs> for f32 where Rhs: Info<Self> {
    fn multiply(self, rhs: Rhs) -> Self { self * rhs.info() }
}

// ジェネリクス関数
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

## 構造体が実装すべきメソッドを定義する、Interface のようなもの

```rs
struct Rect { width: u32, height: u32 }

trait Printable { fn print(&self); }
impl Printable for Rect {
    fn print(&self) {
        println!("width:{}, height:{}", self.width, self.height)
    }
}
```

## References

- [The Rust Programming Language 日本語版: トレイト(trait)](https://doc.rust-jp.rs/book-ja/ch10-02-traits.html)
- [Rust By Example 日本語版](https://doc.rust-jp.rs/rust-by-example-ja/trait.html)
- [Rust での 抽象化 3 パターンについて](https://zenn.dev/j5ik2o/articles/045737392958a3)

```

```
