# Generics

ジェネリックスを使用すると、呼び出しコードによって提供される一連の型のいずれかで動作するように記述された関数または型を宣言して使用することができる  
ジェネリックスは`type parameters`とも言われる

## Prerequisites

- Go 1.18

## References

- [An Introduction To Generics](https://go.dev/blog/intro-generics)
- [Tutorial](https://go.dev/doc/tutorial/generics)

  - [Type parameters](https://go.dev/tour/generics/1)
  - [Generic types](https://go.dev/tour/generics/2)

- [Go 言語のジェネリクス入門](https://zenn.dev/nobishii/articles/type_param_intro)
- [Go 言語のジェネリクス入門(2) インスタンス化と型推論](https://zenn.dev/nobishii/articles/type_param_intro_2)

## Type Parameters

### 呼び出し方法

- 関数や型に`型パラメータ`を持たせることができるようになった
- 型パラメータリストは，括弧の代わりに角括弧を使う以外は，普通のパラメータリストと同じように見える

```go
// 通常のfunction
func Min(x, y float64) float64 {
    if x < y {
        return x
    }
    return y
}

// Generic: unions
type Ordered interface {
	Integer | Float | ~string
}

// func Func Name[T Interface type](args1, args2 T) T {}
func GMin[T Ordered](x, y T) T {
    if x < y {
        return x
    }
    return y
}

func main() {
  // 呼び出し
  x := GMin[int](2, 3)
  // instantiation後、呼び出し
  fmin := GMin[float64]
  m := fmin(2.71, 3.14)
}
```

- GMin に `type argument`（ここでは`[int]`）を与えることを`instantiation`:インスタンス化と呼ぶ
- インスタンス化は 2 つのステップで行われる
  - まず、コンパイラはすべての型引数を Generics 関数や型全体のそれぞれの型引数に置き換える
  - 次に、コンパイラはそれぞれの型引数がそれぞれの制約を満たすことを検証する。第 2 ステップが失敗するとインスタンス化に失敗してプログラムは無効となる。
- インスタンス化に成功すると、他の関数と同じように呼び出すことができる非属性関数が作成される。

```go
fmin := GMin[float64]
m := fmin(2.71, 3.14)
```

### 型と`Type parameters`を同時に使う

- `Type parameters`は型と一緒に使うこともできる

```go
type Tree[T interface{}] struct {
    left, right *Tree[T]
    value       T
}

func (t *Tree[T]) Lookup(x T) *Tree[T] { ... }

var stringTree Tree[string]
```

- Generics 型 Tree は、この例の Lookup のようにメソッドを持つことができる。
- Generics 型を使用するには、インスタンス化する必要がある。
- Tree[string]は、型引数 string を持つ Tree をインスタンス化した例

## Type sets

### `Type parameters`をインスタンス化するために使用できる型引数について

- 例えば、上記の非 generic 関数`Min`のように float64 型を持つ場合、引数の値の許容範囲は float64 型で表現可能な浮動小数点値の集合となる
- 同様に、`type parameter`リストも`type parameter`ごとに型を持つ。`type parameter`はそれ自体が型であるため、`type parameter`の型は`型の集合`を定義する。この`meta-type`を`type constraint`:型制約と呼ぶ
- generic `GMin`では、[constraints package:制約パッケージ](https://pkg.go.dev/golang.org/x/exp/constraints)から`type constraint`:型制約 がインポートされている。Ordered constraint は、順序付け可能な、言い換えれば`<`演算子（または`<=` , `>`など）で比較できる値を持つすべての型の集合を記述する。 この制約は、順序付けできる値を持つ型だけが GMin に渡されることを保証する。それはまた、GMin 関数本体でその`Type parameters`の値が`<` 演算子と比較で使用できることを意味する。
- Go では、`type constraint`:型制約は`interface`でなければならない。つまり、`interface`型は値型として使用でき、メタ型としても使用できる。`interface`はメソッドを定義するので、特定のメソッドが存在することを要求する`type constraint`:型制約を表現できることは明らか

- 明示的に型を追加することで、新たな方法で`Type sets`を制御することができる。例えば，`interface{ int|string|bool }` は，int 型，string 型，bool 型を含む型集合を定義している

```go
type Ordered interface {
    Integer|Float|~string
}
```

- この宣言は、Ordered interface がすべての整数型、浮動小数点型、文字列型の集合であることを示している。
- 縦棒は型の和（この場合は型の集合）を表している。
- Integer と Float は、同様に constraints パッケージで定義されているインタフェース型
- 注意すべきポイントは、Ordered interface で定義されたメソッドはない
- `type constraint`:型制約では、通常、`string`のような特定の型には関心がなく、すべての string 型に関心がある。 そのために、`~`トークンがある
- `~string`という表現は、文字列を基本型とするすべての型の集合を意味する。
- Go 1.18 では、interface は従来通りメソッドと埋め込みインターフェイスを含むことができるが、非インターフェイス型、unions、基本型の集合を埋め込むことができる。
- 型制約として使用される場合、インタフェースによって定義された型集合は、それぞれの型パラメータの型引数として許可される型を正確に指定する
- Generics 関数本体内で、オペランドの`type constraint`:型制約 `C`の`type parameter` `P`である場合、`C`の型集合のすべての型によって許可されていれば操作は許可される
  - （現在ここでいくつかの実装制限があるが、通常のコードはそれに出会うことはほとんどないと思われる）
- 制約として使用される interface は、名前（Ordered など）が与えられている場合もあれば、型パラメータリストにインライン化されたリテラルインターフェースである場合もある

```go
[S interface{~[]E}, E interface{}]
// or
[S ~[]E, E interface{}]
// or using any
[S ~[]E, E any]
```

- Go 1.18 では空のインターフェイス型の別名として新しい事前定義識別子 `any` を導入

## Type inference 型推論

Generic 関数を呼び出すコードを書く際に自然なスタイルで書くための方法

### Function argument type inference: 関数の引数型推論

- `Type parameters`を使うと、型引数を渡す必要があり、コードが冗長になる

```go
func GMin[T constraints.Ordered](x, y T) T { ... }
```

- 型パラメータ`T`は，通常の non-type 引数 x,y の型を指定するために使われる

```go
var a, b, m float64
m = GMin[float64](a, b) // explicit type argument
```

- 多くの場合、コンパイラは通常の引数から T の型引数を推測することができ、 これにより明確さを保ちながらコードを短くすることができる

```go
var a, b, m float64
m = GMin(a, b) // no type argument
```

- このように、関数の引数の型から型引数を推論することを、`function argument type inference`: `関数引数型推論`という
- `Function argument type inference`は、関数のパラメータで使用される`Type parameters`に対してのみ機能し、関数の結果でのみ使用される型パラメータや関数本体でのみ使用される型パラメータに対しては機能しない。 例えば、`MakeT[T any]() T` のように結果に T のみを使用する関数に対しては適用されない

### Constraint type inference: 制約型推論

他にも、`Constraint type inference`:制約型推論という別の種類の型推論をサポートしている。これを説明するために、整数のスライスを例に挙げる

```go
// Scale returns a copy of s with each element multiplied by c.
// This implementation has a problem, as we will see.
func Scale[E constraints.Integer](s []E, c E) []E {
    r := make([]E, len(s))
    for i, v := range s {
        r[i] = v * c
    }
    return r
}
```

- 任意の整数型のスライスに対して動作する Generic 関数
- ここで、多次元の Point 型があり、各 Point は点の座標を示す整数のリストであるとする。 当然、この型にはいくつかのメソッドがある

```go
type Point []int32

func (p Point) String() string {
    // Details not important.
}
```

- Point は単なる整数のスライスなので、先に書いた Scale 関数を使うことができる

```go
// ScaleAndPrint doubles a Point and prints it.
func ScaleAndPrint(p Point) {
    r := Scale(p, 2)
    fmt.Println(r.String()) // DOES NOT COMPILE
}
```

- 残念ながらこれはコンパイルできず、`r.String undefined (type []int32 has no field or method String)`といったエラーで失敗する
- 問題は、Scale 関数が`[]E`型（E は引数 slice の要素型）の値を返すこと。 基礎型が`[]int32`である Point 型の値で Scale を呼ぶと、Point 型ではなく`[]int32型`の値を返す。 これは Generics コードの書き方からすれば当然ですが、我々が望むものとは異なっている。
- これを解決するためには、Scale 関数を変更して、Slice 型に`Type parameters`を使用するようにする必要がある。

```go
// Scale returns a copy of s with each element multiplied by c.
func Scale[S ~[]E, E constraints.Integer](s S, c E) S {
    r := make(S, len(s))
    for i, v := range s {
        r[i] = v * c
    }
    return r
}
```

- Slice 引数の型である新しい`Type parameters` `S`を導入した。 基礎となる型が`[]E`ではなく `S`であり、結果の型が`S`になるように制約した。`E`は整数であると制約されているので、効果は前と同じで、最初の引数はある整数型の Slice でなければならない。 関数の本体に対する唯一の変更は、make を呼ぶときに[]E ではなく、S を渡すようにしたこと。
- 新しい関数は、普通のスライスで呼び出すと以前と同じように動作するが、Point 型で呼び出すと、望んだ通り Point 型の値が返ってくる。このバージョンの Scale では、以前の ScaleAndPrint 関数も期待通りにコンパイルして動作する。
- つまり、`Scale[Point, int32](p, 2)`と書かなければならないところを、なぜ型引数のない`Scale(p, 2)`と書けるのか？新しい Scale 関数には`S`と `E` という二つの`type parameters`がある。`type parameters`を渡さない Scale 呼び出しでは、前述の関数引数の型推論により、コンパイラが`S`に対する`type parameters`は Point だと推測している。しかし、この関数には乗算係数 c の型である`type parameters` `E`もある。対応する関数引数は 2 だが、2 は 型付けされていない定数なので、`Function argument type inference`は E の正しい型を推論できない。代わりに、コンパイラが`E`の`type parameters`は Slice の要素型だと推論する処理を制約型推論と呼んでいる。
- 制約型推論は、型パラメータの制約から`type parameters`を推論するもので、ある`type parameters`に別の`type parameters`を条件とする制約が定義されている場合に使用される。 一方の`type parameters`の`type argument`がわかっている場合、その制約から他方の`type parameters`が推論される。
- これが適用される通常のケースは、ある制約がある型に対して`~type`という形式を使い、その型が他の`type parameters`を使って書かれている場合。Scale の例でこれを見ると、S は `~[]E`で、これは`~`に続いて他の`type parameters`を使って書かれた型`[]E`。 もし S の`type parameters`を知っていれば E の`type parameters`を推測できる。S は Slice 型、E はその Slice 型の要素の型。

### 型推論 in practice

- 型推論が成功すれば型引数を省略でき、generic 関数の呼び出しも普通の関数と変わらない。 型推論が失敗すればコンパイラがエラーメッセージを出すが、その場合は必要な型引数を与えればよい
- コンパイラが型推論を行う際、その型が決して驚くようなものではないことを保証したいが、まだ完全に機能するわけではない。明示的な型引数はあったほうがいい。

## Type `T comparable`

- 型パラメータ `T comparable`は`==`や`!=`で比較可能な値のみ引数に受け取ることができる
- map の key にも使うことができる

```go
package main

import "fmt"

// Index returns the index of x in s, or -1 if not found.
func Index[T comparable](s []T, x T) int {
	for i, v := range s {
		// v and x are type T, which has the comparable
		// constraint, so we can use == here.
		if v == x {
			return i
		}
	}
	return -1
}

func main() {
	// Index works on a slice of ints
	si := []int{10, 20, 15, -10}
	fmt.Println(Index(si, 15))

	// Index also works on a slice of strings
	ss := []string{"foo", "bar", "baz"}
	fmt.Println(Index(ss, "hello"))
}
```

## 型の満たす性質

- あるメソッドを持っているという性質
  - 従来のインタフェース型
- `==`, `!=`で比較できるという性質
  - comparable インタフェース
- `<`, `>`, `>=`, `<=`で順序づけられるという性質
  - unions を利用した新しいインタフェース
- for ~ range 文でループを回すことができるという性質
  - for range ループができる型を使って、その 1 つの型だけからなる unions による型制約 (型が 1 つだけであれば無意味...)
- ある名前のフィールドを持っているという性質
  - フィールドを持つという性質を型制約で表して、型パラメータ型の値のフィールドを参照することはできない。

## [go.1.20 の変更点による Generics への影響](https://go.dev/doc/go1.20#language)

- Comparable types:（通常のインターフェースなど）は、型引数が厳密に比較可能でない場合でも、比較可能な制約を満たすことができるようになった（比較は実行時にパニックになる可能性がある）
- これにより、Interface 型や Interface 型を含む複合型など、厳密に比較できない型引数で、Comparable 制約を受けた型パラメータ（例えば、ユーザー定義の Generics map key の型パラメータ）をインスタンス化することが可能になった。

- [All your comparable types](https://go.dev/blog/comparable)

## Example

- [Go by Example: Generics](https://gobyexample.com/generics)
