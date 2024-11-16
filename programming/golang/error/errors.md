# 標準ライブラリの `errors` パッケージの機能

`errors` パッケージは、Go の標準ライブラリの一部であり、エラーハンドリングをサポートするために便利な機能を提供している。
以下は、`errors` パッケージの有益な機能とその使い方についての説明。

[errors](https://pkg.go.dev/errors)

## 定義されているfunction

- `New(text)`
- `As(err, target)`
- `Is(err, target)`
- `Join(errs)`
- `Unwrap(err)`

## **`errors.New`**: エラーメッセージの作成

`errors.New` は、新しいエラーメッセージを生成するための関数。エラーメッセージは単なる文字列であるため、コードの中で簡単に比較や出力ができる。

```go
import (
    "errors"
    "fmt"
)

func main() {
    err := errors.New("something went wrong")
    if err != nil {
        fmt.Println(err)
    }
}
```

## **`errors.Is`**: エラーチェックと比較

標準的なエラー型は独自のエラーと比較できるので、簡単なエラーハンドリングが可能

```go
import (
    "errors"
    "fmt"
)

// カスタムエラーの定義
var ErrNotFound = errors.New("not found")

func find(id int) error {
    if id == 0 {
        return ErrNotFound
    }
    return nil
}

func main() {
    err := find(0)
    // エラーが特定のエラーかどうか判別
    if errors.Is(err, ErrNotFound) {
        fmt.Println("error:", err)
    }
}
```

## **`errors.As`**: 特定のエラーを検索する

エラーチェインの中から特定の型のエラーを見つけ出したい場合に使用する

```go

import (
    "errors"
    "fmt"
    "io/fs"
    "os"
)

func main() {
    if _, err := os.Open("non-existing"); err != nil {
        var pathError *fs.PathError
        if errors.As(err, &pathError) {
            fmt.Println("Failed at path:", pathError.Path)
        } else {
            fmt.Println(err)
        }
    }
}
```

```go
package main

import (
    "errors"
    "fmt"
)

// カスタムエラー型の定義
type MyError struct {
    Msg string
    Code int
}

func (e *MyError) Error() string {
    return fmt.Sprintf("MyError: %s (Code: %d)", e.Msg, e.Code)
}

// エラーを返す関数
func someFunc() error {
    return &MyError{
        Msg: "something went wrong",
        Code: 404,
    }
}

func main() {
    err := someFunc()

    var myErr *MyError
    // errors.As を使用して特定のエラー型を検出
    if errors.As(err, &myErr) {
        // MyError 型にキャスト成功時の処理
        fmt.Printf("Caught MyError: %s\n", myErr)
        fmt.Printf("Error Code: %d\n", myErr.Code)
    } else {
        // MyError 以外のエラー処理
        fmt.Println("An unexpected error occurred:", err)
    }
}
```

## **`errors.Join`**: 渡された複数のエラーをWrapする

```go
func Join(errs ...error) error
```

```go
import (
    "errors"
    "fmt"
)

func main() {
    err1 := errors.New("err1")
    err2 := errors.New("err2")
    err := errors.Join(err1, err2)
    fmt.Println(err)
    if errors.Is(err, err1) {
        fmt.Println("err is err1")
    }
    if errors.Is(err, err2) {
        fmt.Println("err is err2")
    }
}
```
