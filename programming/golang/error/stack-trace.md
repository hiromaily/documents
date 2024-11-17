# Errorの Stack Trace

## [cockroachdb/errors](https://github.com/cockroachdb/errors)を使ったやり方がシンプル

```go
fmt.Printf("error: %+v\n", err)  // %+v でスタックトレースを含むエラーメッセージを表示
```

## カスタムコードの場合

```go
func customError(err error, msg string) error {
    pc, file, line, _ := runtime.Caller(1)
    fn := runtime.FuncForPC(pc)
    return fmt.Errorf("%s: %s [%s:%d] %w", msg, fn.Name(), file, line, err)
}

func topFunction() error {
    err := middleFunction()
    if err != nil {
        return customError(err, "topFunction encountered an error")
    }
    return nil
}

func main() {
    logger := SetupLogger()
    err := topFunction()
    if err != nil {
        // Topレベルでエラーロギングを行う
        logger.Error("top level error", slog.String("error", err.Error()))
    }
}

// top level error: topFunction encountered an error [main.topFunction ./main.go:21]
```
