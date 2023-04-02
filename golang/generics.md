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

- [Go言語のジェネリクス入門](https://zenn.dev/nobishii/articles/type_param_intro)
- [Go言語のジェネリクス入門(2) インスタンス化と型推論](https://zenn.dev/nobishii/articles/type_param_intro_2)

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
- GMinに `type argument`（ここでは`[int]`）を与えることを`instantiation`:インスタンス化と呼ぶ
- インスタンス化は2つのステップで行われる
  - まず、コンパイラはすべての型引数をGenerics関数や型全体のそれぞれの型引数に置き換える
  - 次に、コンパイラはそれぞれの型引数がそれぞれの制約を満たすことを検証する。第2ステップが失敗するとインスタンス化に失敗してプログラムは無効となる。
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
- Generics型Treeは、この例のLookupのようにメソッドを持つことができる。
- Generics型を使用するには、インスタンス化する必要がある。
- Tree[string]は、型引数stringを持つTreeをインスタンス化した例


## Type sets
### `Type parameters`をインスタンス化するために使用できる型引数について
- 例えば、上記の非generic関数`Min`のようにfloat64型を持つ場合、引数の値の許容範囲はfloat64型で表現可能な浮動小数点値の集合となる
- 同様に、`type parameter`リストも`type parameter`ごとに型を持つ。`type parameter`はそれ自体が型であるため、`type parameter`の型は`型の集合`を定義する。この`meta-type`を`type constraint`:型制約と呼ぶ
- generic `GMin`では、[constraints package:制約パッケージ](https://pkg.go.dev/golang.org/x/exp/constraints)から`type constraint`:型制約 がインポートされている。Ordered constraint は、順序付け可能な、言い換えれば`<`演算子（または`<=` , `>`など）で比較できる値を持つすべての型の集合を記述する。 この制約は、順序付けできる値を持つ型だけがGMinに渡されることを保証する。それはまた、GMin関数本体でその`Type parameters`の値が`<` 演算子と比較で使用できることを意味する。
- Goでは、`type constraint`:型制約は`interface`でなければならない。つまり、`interface`型は値型として使用でき、メタ型としても使用できる。`interface`はメソッドを定義するので、特定のメソッドが存在することを要求する`type constraint`:型制約を表現できることは明らか

- 明示的に型を追加することで、新たな方法で`Type sets`を制御することができる。例えば，`interface{ int|string|bool }` は，int型，string型，bool型を含む型集合を定義している

```go
type Ordered interface {
    Integer|Float|~string
}
```
- この宣言は、Ordered interfaceがすべての整数型、浮動小数点型、文字列型の集合であることを示している。 
- 縦棒は型の和（この場合は型の集合）を表している。
- Integerと Floatは、同様にconstraintsパッケージで定義されているインタフェース型
- 注意すべきポイントは、Ordered interfaceで定義されたメソッドはない
- `type constraint`:型制約では、通常、`string`のような特定の型には関心がなく、すべてのstring型に関心がある。 そのために、`~`トークンがある
- `~string`という表現は、文字列を基本型とするすべての型の集合を意味する。
- Go 1.18では、interfaceは従来通りメソッドと埋め込みインターフェイスを含むことができるが、非インターフェイス型、unions、基本型の集合を埋め込むことができる。
- 型制約として使用される場合、インタフェースによって定義された型集合は、それぞれの型パラメータの型引数として許可される型を正確に指定する
- Generics関数本体内で、オペランドの`type constraint`:型制約 `C`の`type parameter` `P`である場合、`C`の型集合のすべての型によって許可されていれば操作は許可される
  - （現在ここでいくつかの実装制限があるが、通常のコードはそれに出会うことはほとんどないと思われる） 
- 制約として使用されるinterfaceは、名前（Orderedなど）が与えられている場合もあれば、型パラメータリストにインライン化されたリテラルインターフェースである場合もある
```go
[S interface{~[]E}, E interface{}]
// or
[S ~[]E, E interface{}]
// or using any
[S ~[]E, E any]
```
- Go 1.18では空のインターフェイス型の別名として新しい事前定義識別子 `any` を導入

## Type inference 型推論
Generic関数を呼び出すコードを書く際に自然なスタイルで書くための方法

### Function argument type inference: 関数の引数型推論
- `Type parameters`を使うと、型引数を渡す必要があり、コードが冗長になる
```go
func GMin[T constraints.Ordered](x, y T) T { ... }
```
- 型パラメータ`T`は，通常のnon-type引数x,yの型を指定するために使われる
```go
var a, b, m float64
m = GMin[float64](a, b) // explicit type argument
```
- 多くの場合、コンパイラは通常の引数からTの型引数を推測することができ、 これにより明確さを保ちながらコードを短くすることができる
```go
var a, b, m float64
m = GMin(a, b) // no type argument
```
- このように、関数の引数の型から型引数を推論することを、`function argument type inference`: `関数引数型推論`という
- `Function argument type inference`は、関数のパラメータで使用される`Type parameters`に対してのみ機能し、関数の結果でのみ使用される型パラメータや関数本体でのみ使用される型パラメータに対しては機能しない。 例えば、`MakeT[T any]() T` のように結果にTのみを使用する関数に対しては適用されない

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
- 任意の整数型のスライスに対して動作するGeneric関数
- ここで、多次元のPoint型があり、各Pointは点の座標を示す整数のリストであるとする。 当然、この型にはいくつかのメソッドがある
```go
type Point []int32

func (p Point) String() string {
    // Details not important.
}
```
- Pointは単なる整数のスライスなので、先に書いたScale関数を使うことができる
```go
// ScaleAndPrint doubles a Point and prints it.
func ScaleAndPrint(p Point) {
    r := Scale(p, 2)
    fmt.Println(r.String()) // DOES NOT COMPILE
}
```
- 残念ながらこれはコンパイルできず、`r.String undefined (type []int32 has no field or method String)`といったエラーで失敗する
- 問題は、Scale関数が`[]E`型（Eは引数sliceの要素型）の値を返すこと。 基礎型が`[]int32`であるPoint型の値でScaleを呼ぶと、Point型ではなく`[]int32型`の値を返す。 これはGenericsコードの書き方からすれば当然ですが、我々が望むものとは異なっている。
- これを解決するためには、Scale関数を変更して、Slice型に`Type parameters`を使用するようにする必要がある。
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
- Slice引数の型である新しい`Type parameters` `S`を導入した。 基礎となる型が`[]E`ではなく `S`であり、結果の型が`S`になるように制約した。`E`は整数であると制約されているので、効果は前と同じで、最初の引数はある整数型のSliceでなければならない。 関数の本体に対する唯一の変更は、makeを呼ぶときに[]Eではなく、Sを渡すようにしたこと。 
- 新しい関数は、普通のスライスで呼び出すと以前と同じように動作するが、Point型で呼び出すと、望んだ通りPoint型の値が返ってくる。このバージョンのScaleでは、以前のScaleAndPrint関数も期待通りにコンパイルして動作する。 
- つまり、`Scale[Point, int32](p, 2)`と書かなければならないところを、なぜ型引数のない`Scale(p, 2)`と書けるのか？新しいScale関数には`S`と `E` という二つの`type parameters`がある。`type parameters`を渡さないScale呼び出しでは、前述の関数引数の型推論により、コンパイラが`S`に対する`type parameters`はPointだと推測している。しかし、この関数には乗算係数cの型である`type parameters` `E`もある。対応する関数引数は2だが、2は 型付けされていない定数なので、`Function argument type inference`はEの正しい型を推論できない。代わりに、コンパイラが`E`の`type parameters`はSliceの要素型だと推論する処理を制約型推論と呼んでいる。 
- 制約型推論は、型パラメータの制約から`type parameters`を推論するもので、ある`type parameters`に別の`type parameters`を条件とする制約が定義されている場合に使用される。 一方の`type parameters`の`type argument`がわかっている場合、その制約から他方の`type parameters`が推論される。 
- これが適用される通常のケースは、ある制約がある型に対して`~type`という形式を使い、その型が他の`type parameters`を使って書かれている場合。Scaleの例でこれを見ると、Sは `~[]E`で、これは`~`に続いて他の`type parameters`を使って書かれた型`[]E`。 もしSの`type parameters`を知っていればEの`type parameters`を推測できる。SはSlice型、EはそのSlice型の要素の型。

### 型推論 in practice
- 型推論が成功すれば型引数を省略でき、generic 関数の呼び出しも普通の関数と変わらない。 型推論が失敗すればコンパイラがエラーメッセージを出すが、その場合は必要な型引数を与えればよい 
- コンパイラが型推論を行う際、その型が決して驚くようなものではないことを保証したいが、まだ完全に機能するわけではない。明示的な型引数はあったほうがいい。

## Type `T comparable` 
- 型パラメータ `T comparable`は`==`や`!=`で比較可能な値のみ引数に受け取ることができる
- mapのkeyにも使うことができる

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
  - comparableインタフェース
- `<`, `>`, `>=`, `<=`で順序づけられるという性質
  - unionsを利用した新しいインタフェース
- for ~ range文でループを回すことができるという性質
  - for rangeループができる型を使って、その1つの型だけからなるunionsによる型制約 (型が1つだけであれば無意味...)
- ある名前のフィールドを持っているという性質
  - フィールドを持つという性質を型制約で表して、型パラメータ型の値のフィールドを参照することはできない。


## [go.1.20の変更点によるGenericsへの影響](https://go.dev/doc/go1.20#language)
- Comparable types:（通常のインターフェースなど）は、型引数が厳密に比較可能でない場合でも、比較可能な制約を満たすことができるようになった（比較は実行時にパニックになる可能性がある）
- これにより、Interface型やInterface型を含む複合型など、厳密に比較できない型引数で、Comparable制約を受けた型パラメータ（例えば、ユーザー定義のGenerics map keyの型パラメータ）をインスタンス化することが可能になった。

- [All your comparable types](https://go.dev/blog/comparable)
## Example
- [Go by Example: Generics](https://gobyexample.com/generics)

