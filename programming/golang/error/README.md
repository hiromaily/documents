# Go Error

## エラーパッケージ

- [errors](https://pkg.go.dev/errors)
  - 標準ライブラリで、ほぼこれ一択と言える状況
- [github.com/pkg/errors](https://github.com/pkg/errors)
  - 2020年頃まではよく利用されていたが、現在は `public archive`状態
- [golang.org/x/xerrors](https://pkg.go.dev/golang.org/x/xerrors)
  - こちらでの実装のいくつかが、標準パッケージに取り込まれている

## エラーの作成方法

```go
import (
    "errors"
    "fmt"
)

// errorsパッケージによるエラー
var ErrNegativeNumber = errors.New("negative number is not allowed")

// fmt.Errorfによるエラー
err := fmt.Errorf("user %s not found", name)
```

## TODO: エラーの構造化について

- HTTP のようにコードとメッセージを管理するパターン
