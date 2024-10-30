# [testing package](https://pkg.go.dev/testing)

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
