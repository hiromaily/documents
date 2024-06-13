# Trait for standard implementations

## `Debug` トレイトの実装

Debug トレイトは、デバッグ情報を表示、つまりフォーマット文字列でのデバッグ整形が可能するためのトレイトで、`Debug` を実装すると、Debug トレイトの fmt 関数が自動的に実装されているので、`:?`フォーマット文字列をつかうことができる。

Debug トレイトは、例えば、`assert_eq!`マクロを使用する際などに必要になる

```rs
#[derive(Debug)]
struct Point{ x: i32, y: i32, z: i32 }

fn main(){
    let some_point = Point {x: 10, y: 20, z: 0};
    println!("Debug: {:?}", some_point);
}
```

## `PartialEq` トレイトの実装

PartialEq トレイトは、値の比較を行うためのトレイトで、`==`と`!=`演算子をサポートする。PartialEq を導出すると、`eq`メソッドを実装する。

```rs
// deriveを使用し、Point構造体にPartialEqトレイトを自動的に実装
#[derive(PartialEq)]
struct Point {
    x: i32,
    y: i32,
}

fn main() {
    let p1 = Point { x: 3, y: 4 };
    let p2 = Point { x: 3, y: 4 };
    let p3 = Point { x: 5, y: 6 };

    // == と != 演算子を利用できるようになる
    assert!(p1 == p2);
    assert!(p1 != p3);
}
```

## `Eq` トレイトの実装

Eq トレイトにはメソッドはない。その目的は、注釈された型の全値に対して、値が自身と等しいことを通知すること。 Eq トレイトは、PartialEq を実装する全ての型が Eq を実装できるわけではないものの、 PartialEq も実装する型に対してのみ適用できる。これの一例は、浮動小数点数型で、浮動小数点数の実装により、非数字(NaN)値の 2 つのインスタンスはお互いに等価ではないことが宣言される。

Eq が必要になる一例が、HashMap<K, V>のキーで、HashMap<K, V>が、2 つのキーが同じであると判定できる。

## `Clone` トレイトの実装

Clone トレイトは、オブジェクトの複製を作成するためのトレイトで、値のディープコピーを明示的に行う

```rs
// deriveを使用し、Point構造体にCloneトレイトとDebugトレイトを自動的に実装
#[derive(Clone, Debug)]
struct Point {
    x: i32,
    y: i32,
}

fn main() {
    let p1 = Point { x: 3, y: 4 };
    let p2 = p1.clone(); // clone()が利用できるになる

    println!("p1: {:?}", p1); // p1: Point { x: 3, y: 4 }
    println!("p2: {:?}", p2); // p2: Point { x: 3, y: 4 }
}
```

## [`Copy` トレイト](https://doc.rust-lang.org/std/marker/trait.Copy.html)

スタックに格納されたビットをコピーするだけで値を複製できる。
Copy トレイトは稀にしか必要にならない。Copy で可能なこと全てが Clone でも達成可能だが、コードがより遅い可能性や、 clone を使用しなければならない箇所があったりする。

束縛したオブジェクトが Copy トレイトを実装したデータ型の変数から別の変数に束縛するときは，所有権は移動せず，値をコピーして新しいオブジェクト（そして所有権）を作成する。Rust のプリミティブ型はコピートレイトを実装している。
しかし、`&`による不変参照は Copy トレイトを実装しているが、`&mut`による可変参照は Copy トレイトを実装していない。

Copy トレイトの性質として、所有権の`move`が起こらない（らしい）

## `PartialOrd` トレイト と `Ord` トレイト

`PartialOrd`トレイトにより、ソートする目的で型のインスタンスを比較できる。PartialOrd を実装する型は、 `<、>、<=、>=` 演算子を使用することができる。`PartialEq`も実装する型に対してのみ、 PartialOrd トレイトを適用できる。

`PartialOrd`を導出すると、`partial_cmp`メソッドを実装し、これは、与えられた値が順序付けられない時に None になる`Option<Ordering>`を返す。 その型のほとんどの値は比較できるものの、順序付けできない値の例として、非数字(NaN)浮動小数点値が挙げられる。 partial_cmp をあらゆる浮動小数点数と NaN 浮動小数点数で呼び出すと、None が返る。

構造体に導出すると、フィールドが構造体定義で現れる順番で各フィールドの値を比較することで 2 つのインスタンスを比較する。  
enum に導出すると、enum 定義で先に定義された列挙子が、後に列挙された列挙子よりも小さいと考えられる。

PartialOrd トレイトが必要になる例には、低い値と高い値で指定される範囲の乱数を生成する rand クレートの gen_range メソッドが挙げられる。

## `Hash` トレイト

`Hash`トレイトにより、任意のサイズの型のインスタンスを取り、そのインスタンスをハッシュ関数で固定サイズの値にマップできる。 Hash を導出すると、`hash`メソッドを実装する。hash の導出された実装は、 型の各部品に対して呼び出した hash の結果を組み合わせる。つまり、Hash を導出するには、 全フィールドと値も Hash を実装しなければならないということ。

Hash が必要になる例は、`HashMap<K, V>`にキーを格納し、データを効率的に格納すること。

## `Default` トレイト

`Default`トレイトにより、型に対して既定値を生成できる。Default を導出すると、`default`関数を実装する。 default 関数の導出された実装は、型の各部品に対して default 関数を呼び出す。つまり、 Default を導出するには、型の全フィールドと値も Default を実装しなければならないということ。

構造体のいくつかのフィールドをカスタマイズし、それから`Default::default()`を使用して、 残りのフィールドに対して既定値をセットし使用することができる。

例えば、Default トレイトは、`Option<T>`インスタンスに対してメソッド`unwrap_or_default`を使用する時に必要になる。 `Option<T>`が None ならば、メソッド unwrap_or_default は、`Option<T>`に格納された型 T に対して `Default::default` の結果を返す。

## [Send トレイト](https://doc.rust-lang.org/std/marker/trait.Send.html)

- [The Rust Reference: Special types and traits -> Send](https://doc.rust-lang.org/reference/special-types-and-traits.html#send)

この型の値をあるスレッドから別のスレッドに送信しても安全であることを示す

## [Sync トレイト](https://doc.rust-lang.org/std/marker/trait.Sync.html)

- [The Rust Reference: Special types and traits -> Sync](https://doc.rust-lang.org/reference/special-types-and-traits.html#sync)

この型の値が複数のスレッド間で安全に共有できることを示す。この trait は、不変の静的項目で使用されるすべての型に対して実装する必要がある。

## [Unpin トレイト]

## [UnwindSafe トレイト]

## [RefUnwindSafe トレイト]

## [Sized トレイト](https://doc.rust-lang.org/std/marker/trait.Sized.html)

## その他,有用な 3rd party crates

### `Error` トレイト

[thiserror](https://crates.io/crates/thiserror) は、標準ライブラリの std::error::Error トレイトの便利な derive マクロを提供しており、独自のエラータイプを実装する必要がある場合、簡単にカスタムエラータイプを実装できる

- [ライブラリ辞典: Rust で独自のエラータイプの実装を楽にする thiserror の使い方](https://libdict.com/rust/thiserror/introduction)

## References

- [The Rust Programming Language 日本語版: 導出可能なトレイト](https://doc.rust-jp.rs/book-ja/appendix-03-derivable-traits.html)
- [The Rust Reference: Special types and traits](https://doc.rust-lang.org/reference/special-types-and-traits.html)
- [Attribute 属性](./attribute.md)
