# Errorの Wrap 方法

## 標準ライブラリの `errors`

### `errors.Join`を利用する

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

### error の Wrap 方法: `%w`書式指定子を使う

```go
err := errors.New("file is not found")
newErr := fmt.Errorf("failed to open files, %w", err) // errをラップ

fmt.Println(newErr) // failed to open files, file is not found

// `errors.Unwrap`によるアンラップ
fmt.Println(errors.Unwrap(newErr)) // file is not found
```

- `%w`はformat文字列の最後に置くこと
- 複数のエラーのwrapが可能

## [参考] `pkg/errors` パッケージの `Wrap` 関数

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
