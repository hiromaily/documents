# カスタムエラー

Goのランタイムに組み込まれているInterfaceを満たすことができればよい

```go
type error interface {
  Error() string
}
```

## カスタムエラー型の定義

```go
// カスタムエラー型の定義
type MyError struct {
    Msg string
    Code int
}

func (e *MyError) Error() string {
    return fmt.Sprintf("MyError: %s (Code: %d)", e.Msg, e.Code)
}
```
