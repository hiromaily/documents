# 型

## [基本型](https://doc.rust-jp.rs/rust-by-example-ja/primitives.html)

- i8
- i16
- i32 -> 通常の int と同義 (RUST のデフォルト)
- i64
- u8
- u16
- u32
- u64
- isize: 環境によって変化する符号付き整数
- usize: 環境によって変化する符号無し整数
- f32: 32 ビット浮動小数点数
- f64: 64 ビット浮動小数点数

## [The Rust Reference: 10.Type system](https://doc.rust-lang.org/reference/types/pointer.html)

- [Boolean type](https://doc.rust-lang.org/reference/types/boolean.html)
- [Numeric types](https://doc.rust-lang.org/reference/types/numeric.html)
- [Textual types](https://doc.rust-lang.org/reference/types/textual.html)
- [Never type](https://doc.rust-lang.org/reference/types/never.html#never-type)
- [Tuple types](https://doc.rust-lang.org/reference/types/tuple.html)
- [Array types](https://doc.rust-lang.org/reference/types/array.html)
- [Slice types](https://doc.rust-lang.org/reference/types/slice.html)
- [Struct types](https://doc.rust-lang.org/reference/types/struct.html)
- [Enumerated types](https://doc.rust-lang.org/reference/types/enum.html)
- [Union types](https://doc.rust-lang.org/reference/types/union.html)
- [Function item types](https://doc.rust-lang.org/reference/types/function-item.html)
- [Closure types](https://doc.rust-lang.org/reference/types/closure.html)
- [Pointer types](https://doc.rust-lang.org/reference/types/pointer.html)
- [Function pointer types](https://doc.rust-lang.org/reference/types/function-pointer.html)
- [Trait objects](https://doc.rust-lang.org/reference/types/trait-object.html)
- [Impl trait](https://doc.rust-lang.org/reference/types/impl-trait.html)
- [Type parameters](https://doc.rust-lang.org/reference/types/parameters.html)
- [Inferred type](https://doc.rust-lang.org/reference/types/inferred.html)

## 型推論

- `型推論`ができるため、`let 変数名 = 値;`のみで型まで設定できる。もちろん`let 変数名: 型 = 値;`

## [標準ライブラリの型](https://doc.rust-jp.rs/rust-by-example-ja/std.html)

### [Box: スタックとヒープ](https://doc.rust-jp.rs/rust-by-example-ja/std/box.html)

すべての値はデフォルトでスタックに割り当てられる。`Box<T>`を作成することで、値を ボックス化 、すなわちヒープ上に割り当てることができる。`Box`とは正確にはヒープ上におかれた T の値へのスマートポインタ。Box がスコープを抜けると、デストラクタが呼ばれて内包するオブジェクトが破棄され、ヒープメモリが解放される。

```rs
#[allow(dead_code)]
struct Rectangle {
    top_left: Point,
    bottom_right: Point,
}

fn origin() -> Point {
    Point { x: 0.0, y: 0.0 }
}

fn boxed_origin() -> Box<Point> {
    // Allocate this point on the heap, and return a pointer to it
    // このPointをヒープ上に割り当て、ポインタを返す。
    Box::new(Point { x: 0.0, y: 0.0 })
}

fn main() {
    // Heap allocated rectangle
    // ヒープ上に割り当てられたRectangle
    let boxed_rectangle: Box<Rectangle> = Box::new(Rectangle {
        top_left: origin(),
        bottom_right: Point { x: 3.0, y: -4.0 },
    });

    // The output of functions can be boxed
    // 関数の返り値をボックス化
    let boxed_point: Box<Point> = Box::new(origin());
}
```

### [ベクタ型](https://doc.rust-jp.rs/rust-by-example-ja/std/vec.html):

`ベクタ: vec`はサイズを変更可能な配列。スライスと同様、そのサイズはコンパイル時には不定ですが、いつでも要素を追加したり削除したりすることができる。ベクタは 3 つの要素で、その特徴が完全に決まる。

- データへのポインタ
- 長さ
- 容量 ... あらかじめメモリ上にベクタのために確保された領域

ベクタはその容量を超えない限りにおいて長くしていくことができる。超えた場合には、より大きな容量を持つように再割り当てされる。

```rs
fn main() {
    // Iterators can be collected into vectors
    // イテレータは要素を収集してベクタにすることができる。
    let collected_iterator: Vec<i32> = (0..10).collect();
    println!("Collected (0..10) into: {:?}", collected_iterator);

    // The `vec!` macro can be used to initialize a vector
    // ベクタの初期化には`vec!`マクロが使用できる。
    let mut xs = vec![1i32, 2, 3];
    println!("Initial vector: {:?}", xs);

    // Insert new element at the end of the vector
    // 新しい要素をベクタの最後に挿入することができる。
    println!("Push 4 into the vector");
    xs.push(4);
    println!("Vector: {:?}", xs);
```

### [スライス型](https://doc.rust-jp.rs/book-ja/ch04-03-slices.html):

- 配列やベクタへの参照で、型は&[要素の型] (可変は&mut [要素の型])となる。
- スライス自体は要素のデータ領域を持っておらず、実行時にサイズが決まる。
- 以下のデータを保持する
  - 配列(またはベクタ)の要素へのポインタ (ptr)
  - 要素数 (len)

```rs
let slice = &[3, 4, 5];

let arr = [23, 17, 12, 16, 15, 2];
let slice2 = &arr[2..5];
```

### [文字列](https://doc.rust-jp.rs/rust-by-example-ja/std/str.html)

#### char

Unicode のスカラ値 (4bytes)

#### str

Unicode の文字列型で、内部的には u8 型の配列が使用される。
`u8`: これは 8 ビット符号なし整数を表す型だが、1byte のデータを扱うことができるが、文字を表すことができるわけではない。
`&str`は有効な UTF-8 の配列のスライス `&[u8]` で、いつでも String に変換することができる。`&[T]`がいつでも`Vec<T>`に変換できるのと同様。
`String`はヒープに保存されるが`str`はスタックに保存される

#### String

String は有効な UTF-8 の配列であることを保証されたバイトのベクタ `Vec<u8>` として保持される。ヒープ上に保持され、伸長可能で、末端に null 文字を含まない。

##### parse メソッド

- 文字列をパースして数値に変換する
- Result 型を返す

### [Option](https://doc.rust-jp.rs/rust-by-example-ja/std/option.html)

プログラムの一部が失敗した際、`panic!`するよりも、エラーを捕捉する方が望ましい場合がある。これは`Option` という列挙型を用いることで可能になる。

列挙型 `Option<T>`には 2 つの値がある。

- None: これは実行の失敗か値の欠如を示す
- Some(value): 型 T の value をラップするタプル

```rs
fn checked_division(dividend: i32, divisor: i32) -> Option<i32> {
    if divisor == 0 {
        // Failure is represented as the `None` variant
        // 失敗は`None`としてあらわされる。
        None
    } else {
        // Result is wrapped in a `Some` variant
        // 結果は`Some`にラップされる。
        Some(dividend / divisor)
    }
}
```

### [Result](https://doc.rust-jp.rs/rust-by-example-ja/std/result.html)

これまでの例で、失敗する可能性のある関数の返り値として、列挙型`Option`が使用でき、失敗時の返り値には None を用いるが、なぜ そのオペレーションが失敗したのかを明示したい場合は`Result`列挙型を使用する。

列挙型`Result<T, E>`は 2 つの値をとりえる。

- Ok(value): これはオペレーションが成功したことを意味し、返り値の型 T である value をラップする。
- Err(why): これはオペレーションの失敗を意味する。型 E である why をラップしており、ここには失敗した理由が（必ずではありませんが）セットされる。

```rs
pub type MathResult = Result<f64, MathError>;

pub fn div(x: f64, y: f64) -> MathResult {
    if y == 0.0 {
        // This operation would `fail`, instead let's return the reason of
        // the failure wrapped in `Err`
        // 分母が0なので、このオペレーションは普通に行えば失敗する。
        // 代わりに`Err`でラップされた失敗の理由を返そう。
        Err(MathError::DivisionByZero)
    } else {
        // This operation is valid, return the result wrapped in `Ok`
        // このオペレーションは問題がないので、結果を`Ok`でラップして返そう。
        Ok(x / y)
    }
}
```

### [HashMap](https://doc.rust-jp.rs/rust-by-example-ja/std/hash.html)

ベクタ型が値を整数のインデックスで保持するのに対し、`HashMap`ではキーで保持する。HashMap のキーはブーリアン、整数、文字列等の Eq と Hash トレイトを保持する型なら何でもよい。

ベクタ型と同様、伸長可能だが、HashMap の場合さらに、スペースが余っているときには小さくすることも可能。HashMap を一定の容量のエリアに作成するときは`HashMap::with_capacity(uint)`を、デフォルトの容量で作成するときは`HashMap::new()`を用い、後者が推奨されている。

```rs
use std::collections::HashMap;

fn call(number: &str) -> &str {
    match number {
        "798-1364" => "We're sorry, the call cannot be completed as dialed.
            Please hang up and try again.",
        "645-7689" => "Hello, this is Mr. Awesome's Pizza. My name is Fred.
            What can I get for you today?",
        _ => "Hi! Who is this again?"
    }
}

fn main() {
    let mut contacts = HashMap::new();

    contacts.insert("Daniel", "798-1364");
    contacts.insert("Ashley", "645-7689");
    contacts.insert("Katie", "435-8291");
    contacts.insert("Robert", "956-1745");
}
```

## References

- [The Rust Reference: 10.Type system](https://doc.rust-lang.org/reference/types/pointer.html)
