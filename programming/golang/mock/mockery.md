# Golang mock tools

[mockery](https://github.com/vektra/mockery)

```sh
go install github.com/vektra/mockery/v2@latest

# 生成
mockery --dir=pkg/repository --name=AllRepositorier --output=pkg/repository/mocks --outpkg=mocks
```

## mockeryのパラメータ

- `--dir`: インタフェースが定義されているディレクトリ
- `--name`: モックを生成するインタフェースの名前
- `--output`: モックファイルの生成先ディレクトリ
- `--outpkg`: 生成されるモックのパッケージ名

```go
import (
  "testing"

  "github.com/stretchr/testify/assert"

  "github.com/org/repo/pkg/repository/mocks"
)

func TestHealthCheck(t *testing.T) {
  mockAllRepo := mocks.NewAllRepositorier(t)
  mockAllRepo.IsWeekend()

  // この例では、IsWeekend()はmock環境で"1"が返ってくる
  mockAllRepo.On("IsWeekend").Return("1", nil)

  // mockをパラメータとして、usecaseインスタンスを生成
  healthUsecase = usecase.NewHealthUsecase(logger, mockAllRepo)

  // テストしたい関数を呼び出す
  res, err := healthUsecase.HealthCheck()

  // アサーション
  assert.NoError(t, err)
  assert.Equal(t, "expected data", res)

  // 期待通りのメソッドが呼ばれたかを確認
  mockAllRepo.AssertExpectations(t)
}
```
