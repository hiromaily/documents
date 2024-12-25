# [testing package](https://pkg.go.dev/testing)

## vscodeで、unit testを生成する

vscode上で、functionにカーソルを合わせて右クリックし、`Go:Generate Unit Tests For Function`を選択する

## パッケージ名に`_test`をつける場合

- **ブラックボックステストを行いたい場合**:
  - パッケージの内部実装には依存せず、公開されたAPI（エクスポートされた関数や型）のみをテストしたい場合には`_test`をつける。これにより、テストはパッケージの外部からそのパッケージを使うユーザーと同じ視点でアプローチする。
  - 例えば、パッケージ名が`mypkg`であれば、テスト用のパッケージ名は`mypkg_test`とする。

例:

```go
package mypkg_test

import (
    "mypkg"
    "testing"
)

func TestSomeFunction(t *testing.T) {
    result := mypkg.SomeFunction()
    if result != expected {
        t.Errorf("Expected %v, but got %v", expected, result)
    }
}
```

## パッケージ名に`_test`をつけない場合

- **ホワイトボックステストを行いたい場合**:
  - パッケージの内部構造や非公開関数、変数もテストしたい場合には、パッケージ名に`_test`をつけずに通常のパッケージ名のままにする。これにより、テストコード内から非公開メンバへもアクセスできる。
  - 例えば、パッケージ名が`mypkg`であれば、テストファイルのパッケージ名も`mypkg`とする。

例:

```go
package mypkg

import (
    "testing"
)

func TestInternalFunction(t *testing.T) {
    result := internalFunction()
    if result != expected {
        t.Errorf("Expected %v, but got %v", expected, result)
    }
}
```

## Testのcacheのクリア

```sh
go clean -testcache
```

## Testの実行方法

```sh
# 全てのTestを実行する（ただしbuild tagが付いているものは除く)
go test -v ./...

# 特定のfunctionを実行する
go test -race -v -run TestSomething github.com/hiromaily/my-project/pkg/something

# cacheを無効化する
go test -race -v -run TestSomething github.com/hiromaily/my-project/pkg/something -count=1
```

### 特定のtagが付いているTestのみを実行する

2024年現在、go testに`tags`フラグは存在しない

```sh
# これでは、tagがついていないファイルまで実行されてしまう
#go test -v -tags=integration ./...

# そのため、ファイルまで実行せねばならないが、その場合tagをつける必要はない
#go test -v --tags=integration ./tests/integration_test.go
go test -v ./tests/integration_test.go
```

## benchmarkの実行

- `-bench regexp`
- `-benchmem`: Print memory allocation statistics for benchmarks

```sh
go test -benchmem -bench BenchmarkEncryptIDs github.com/org/repo/pkg/entity
```

## UnittestとIntegrationTestを分ける方法

- [Separating unit tests and integration tests in Go](https://stackoverflow.com/questions/25965584/separating-unit-tests-and-integration-tests-in-go)
