# Tips

## `build constraints exclude all Go files in`

ビルド制約は、以下のGoファイルすべてを除外します

- [cmd/go: don't make "build constraints exclude all Go files" a fatal error for go test](https://github.com/golang/go/issues/43424)

ビルド制約コメントが付いているファイルと付いていないファイルが混在している場合、特定のビルド制約コメントがないファイルだけを実行することは、残念ながら標準のgo testコマンドでは直接的にはサポートされていないらしい（ChatGPT談)

## `make`によるSliceの初期化

- [内部Docs: makeについて](./reference-types.md#makeについて)

```go
package main

import (
  "fmt"
)

func main() {
  sliceData := make([]int, 0, 3)

  sliceData = append(sliceData, 1)
  fmt.Printf("len=%d cap=%d %v\n", len(sliceData), cap(sliceData), sliceData)
  //len=1 cap=3 [1]

  sliceData = append(sliceData, 2)
  fmt.Printf("len=%d cap=%d %v\n", len(sliceData), cap(sliceData), sliceData)
  //len=2 cap=3 [1 2]

  sliceData = append(sliceData, 3)
  fmt.Printf("len=%d cap=%d %v\n", len(sliceData), cap(sliceData), sliceData)
  //len=3 cap=3 [1 2 3]

  sliceData = append(sliceData, 4)
  fmt.Printf("len=%d cap=%d %v\n", len(sliceData), cap(sliceData), sliceData)
  //len=4 cap=8 [1 2 3 4]

  sliceData = append(sliceData, 5)
  fmt.Printf("len=%d cap=%d %v\n", len(sliceData), cap(sliceData), sliceData)
  //len=5 cap=8 [1 2 3 4 5]
}
```

## How to use pointer without definition as variable

struct

```go
(*SomethingStruct)(&SomethingStruct{}).SomethingFunc(param)
```

string

```go
(*string)(&s.SomethingType)
```

## `for range`のアドレスについて

以前は同じアドレスが使われていたが、現在は毎回異なるアドレスが使われる

```go
package main

import "fmt"

func main() {
    numbers := []int{1, 2, 3, 4, 5}

    for i, n := range numbers {
        // nのアドレスは毎回異なる
        fmt.Printf("i: %d, n: %d, addr of n: %p\n", i, n, &n)
    }

    for n := range numbers {
        // nのアドレスは毎回異なる
        fmt.Printf("n: %d, addr of n: %p\n", n, &n)
    }
}
```

## 循環参照 `import cycle not allowed` エラー

[godepgraph](https://github.com/kisielk/godepgraph)

```sh
# Install
go install github.com/kisielk/godepgraph@latest
# Install dot
brew install graphviz

# グラフ生成
godepgraph package-name | dot -Tpng -o import-cycle-graph.png
```
