# 高階関数 higher-order function

高階関数:Higher-Order Functions は、他の関数を引数として受け取ったり、戻り値として関数を返すことができる関数のこと。
プログラムを柔軟にし、再利用性を高める重要な概念。これによって、コードの汎用性と抽象度を向上させることができる。
高階関数は関数型プログラミングの基本概念の一つで、多くのプログラミング言語でサポートされている。Go言語（Golang）でも高階関数を利用することができる。

## 1. 関数を引数として受け取る

関数を引数として受け取る高階関数の例。この例では、整数のスライスを受け取り、各要素に指定された関数を適用する`applyFunc`関数を定義する。

```go
package main

import (
    "fmt"
)

// 関数型の定義
type IntFunc func(int) int

// 高階関数: 関数を引数に取る
func applyFunc(nums []int, f IntFunc) []int {
    var result []int
    for _, num := range nums {
        result = append(result, f(num))
    }
    return result
}

// サンプル関数: 各要素を2倍にする
func double(n int) int {
    return n * 2
}

func main() {
    nums := []int{1, 2, 3, 4, 5}
    // double関数を適用
    doubled := applyFunc(nums, double)
    fmt.Println(doubled) // [2, 4, 6, 8, 10]
}
```

## 2. 関数を戻り値として返す

関数を戻り値として返す高階関数の例。この例では、加算用、乗算用の関数を生成する`makeAdder`、`makeMultiplier`関数を定義する。

```go
package main

import (
    "fmt"
)

// 高階関数: 関数を戻り値として返す
func makeAdder(x int) func(int) int {
    return func(y int) int {
        return x + y
    }
}

func makeMultiplier(x int) func(int) int {
    return func(y int) int {
        return x * y
    }
}

func main() {
    add5 := makeAdder(5)      // 5を加える関数を生成
    fmt.Println(add5(3))      // 8

    multiply3 := makeMultiplier(3) // 3倍する関数を生成
    fmt.Println(multiply3(4))      // 12
}
```

## 3. 無名関数（匿名関数）を使った高階関数

Go言語では無名関数（匿名関数、anonymous function）も簡単に定義できる。これを利用して、高階関数で無名関数を使った例を示す。

```go
package main

import (
    "fmt"
)

func main() {
    nums := []int{1, 2, 3, 4, 5}

    // 無名関数を使って各要素を3倍にする
    tripled := applyFunc(nums, func(n int) int {
        return n * 3
    })
    fmt.Println(tripled) // [3, 6, 9, 12, 15]
}

// applyFunc 関数の再定義（前述の例と同じ）
type IntFunc func(int) int

func applyFunc(nums []int, f IntFunc) []int {
    var result []int
    for _, num := range nums {
        result = append(result, f(num))
    }
    return result
}
```

## References

- [map / filter などの高階関数よりも古典的な for文の方が読みやすいと感じるあなたへ](https://gakuzzzz.github.io/slides/for_loop_to_higher_order_functions/#1)
