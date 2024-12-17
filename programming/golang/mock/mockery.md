# Golang mock tools

[mockery](https://github.com/vektra/mockery)

```sh
go install github.com/vektra/mockery/v2@latest

# 生成
mockery --dir=pkg/repository --name=UserRepositorier --output=pkg/repository/mocks --outpkg=mocks
```

mockeryのパラメータ

- `--dir`: インタフェースが定義されているディレクトリ
- `--name`: モックを生成するインタフェースの名前
- `--output`: モックファイルの生成先ディレクトリ
- `--outpkg`: 生成されるモックのパッケージ名

## テストコード

```go
import (
  "testing"

  "github.com/stretchr/testify/assert"

  "github.com/org/repo/pkg/repository/mocks"
)

// context用のMock
// Interface型は特殊のため注意
func AnyCtx() any {
    return mock.MatchedBy(func(ctx context.Context) bool {
        return ctx != nil
    })
}

func TestHealthCheck(t *testing.T) {
  mockAllRepo := mocks.NewAllRepositorier(t)
  mockAllRepo.IsWeekend()

  // この例では、IsWeekend()はmock環境で"1"が返ってくる
  mockAllRepo.On("IsWeekend", 100).Return("1", nil)

  // いずれの型も許容したい場合は、`mock.Anything`
  // その型であればどのような値も許容する場合は、`mock.AnythingOfType("string")`
  // mockS3 := s3Mocks.NewS3Caller(t)
  // mockS3.On("UploadStream", AnyCtx(), s3BucketName, mock.AnythingOfType("string"), mock.Anything, mock.AnythingOfType("*int64")).
  //     Return(nil)

  // mockをパラメータとして、usecaseインスタンスを生成
  healthUsecase = usecase.NewHealthUsecase(logger, mockAllRepo)

  // テストしたい関数を呼び出す
  resp, err := healthUsecase.HealthCheck()

  // アサーション
  assert.NoError(t, err)
  assert.Equal(t, "expected data", resp)

  // 期待通りのメソッドが呼ばれたかを確認
  mockAllRepo.AssertExpectations(t)
}
```
