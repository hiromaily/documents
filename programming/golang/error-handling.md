# Go Errorハンドリング

## 様々なハンドリングの方法

### エラーチェックのカスケード (連続して起こっている状態)

エラーが発生した場合、その都度チェックと処理を行う。これは、エラーが上位に伝播せず、ローカルで処理が完結する場合に適している。

```go
file, err := os.Open("test.txt")
if err != nil {
    // ここでpanicを起こし終了する
    log.Fatal(err)
}
defer file.Close()

content, err := ioutil.ReadAll(file)
if err != nil {
    // ここでpanicを起こし終了する
    log.Fatal(err)
}
fmt.Println(string(content))
```

### `errors` パッケージによる`カスタムエラー`

標準ライブラリの `errors` パッケージを使ってカスタムエラーを作成できる。

```go
import (
    "errors"
    "fmt"
)

// カスタムエラーの定義
var ErrNegativeNumber = errors.New("negative number is not allowed")

func factorial(n int) (int, error) {
    if n < 0 {
        // カスタムエラーを返す
        return 0, ErrNegativeNumber
    }
    if n == 0 {
        return 1, nil
    }
    result, err := factorial(n - 1)
    if err != nil {
        return 0, err
    }
    return n * result, nil
}

func main() {
    result, err := factorial(-5)
    if err != nil {
        fmt.Println("Error:", err)
    } else {
        fmt.Println("Factorial:", result)
    }
}
```

### `fmt`パッケージの `Errorf` 関数

`fmt.Errorf` は、フォーマットされたエラーメッセージを生成するための関数であり、エラーメッセージに動的な情報を含めることができる。

```go
import (
    "fmt"
)

func main() {
    name := "John"
    err := fmt.Errorf("user %s not found", name)
    if err != nil {
        fmt.Println(err)
    }
}
```

###  `pkg/errors` パッケージの `Wrap` 関数

`pkg/errors`を使用してエラーのラッピングとスタックトレースの追加が可能

```go
import (
    "github.com/pkg/errors"
)

func readFile(filename string) ([]byte, error) {
    data, err := ioutil.ReadFile(filename)
    if err != nil {
        // errorをwrapする
        return nil, errors.Wrap(err, "failed to read file")
    }
    return data, nil
}

func main() {
    data, err := readFile("test.txt")
    if err != nil {
        fmt.Printf("Error: %+v\n", err)
    } else {
        fmt.Println(string(data))
    }
}
```

## 標準ライブラリの `errors` パッケージの機能

`errors` パッケージは、Goの標準ライブラリの一部であり、エラーハンドリングをサポートするために便利な機能を提供しています。以下は、`errors` パッケージの有益な機能とその使い方についての説明です。

### **`errors.New`**

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

### **エラーチェックと比較**

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

### errorのWrap方法

```go
func someOtherFunc() error {
    return fmt.Errorf("failed to process request: %w", &MyError{
        Msg: "unable to connect to database",
        Code: 500,
    })
}
```

### **`errors.Unwrap`**

`errors.Unwrap` は、ネストされたエラーを取り出すための関数で、エラーチェーンの処理で使用する

```go
import (
    "errors"
    "fmt"
)

var ErrNotFound = errors.New("not found")

func find(id int) error {
    if id == 0 {
        return fmt.Errorf("user %d: %w", id, ErrNotFound)
    }
    return nil
}

func main() {
    err := find(0)
    if err != nil {
        originalErr := errors.Unwrap(err)
        fmt.Println("original error:", originalErr)
    }
}
```

### **`errors.As`**

エラーチェインの中から特定の型のエラーを見つけ出したい場合に使用する

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
