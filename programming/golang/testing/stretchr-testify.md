# [stretchr/testify](https://github.com/stretchr/testify)

## Assert と Require の違い

```go
"github.com/stretchr/testify/assert"
"github.com/stretchr/testify/require"
```

- assert:
  パッケージはテストが失敗してもテストの実行を続行する。テストで複数のアサーションを行いたい場合に便利。
- require:
  パッケージはテストが失敗した時点でテストの実行を停止する。重大な前提条件を確認する場合や、それ以降のテストが意味を持たない場合に使用する。

## 比較する値の順番

`expected`, `actual`の順番

```go
func Equal(t TestingT, expected interface{}, actual interface{}, msgAndArgs ...interface{}) {
  if h, ok := t.(tHelper); ok {
    h.Helper()
  }
  if assert.Equal(t, expected, actual, msgAndArgs...) {
    return
  }
  t.FailNow()
}
```

## よく使われる Assert メソッド

1. **Equal**

   - **説明**：2 つの値が等しいことを確認する。
   - **シグネチャ**：`func Equal(t TestingT, expected, actual interface{}, msgAndArgs ...interface{}) bool`
   - **例**：

     ```go
     assert.Equal(t, 123, 123, "The values should be equal")
     ```

2. **NotEqual**

   - **説明**：2 つの値が等しくないことを確認する。
   - **シグネチャ**：`func NotEqual(t TestingT, expected, actual interface{}, msgAndArgs ...interface{}) bool`
   - **例**：

     ```go
     assert.NotEqual(t, 123, 456, "The values should not be equal")
     ```

3. **Empty**

   - **説明**：値が空であることを確認する。配列、スライス、マップ、チャンネル、文字列に使用可能。
   - **シグネチャ**：`func Empty(t TestingT, object interface{}, msgAndArgs ...interface{}) bool`
   - **例**：

     ```go
     assert.Empty(t, "", "The string should be empty")
     ```

4. **NotEmpty**

   - **説明**：値が空でないことを確認する。
   - **シグネチャ**：`func NotEmpty(t TestingT, object interface{}, msgAndArgs ...interface{}) bool`
   - **例**：

     ```go
     assert.NotEmpty(t, "hello", "The string should not be empty")
     ```

5. **Nil**

   - **説明**：値が`nil`であることを確認する。
   - **シグネチャ**：`func Nil(t TestingT, object interface{}, msgAndArgs ...interface{}) bool`
   - **例**：

     ```go
     var a *int = nil
     assert.Nil(t, a, "The value should be nil")
     ```

6. **NotNil**

   - **説明**：値が`nil`でないことを確認する。
   - **シグネチャ**：`func NotNil(t TestingT, object interface{}, msgAndArgs ...interface{}) bool`
   - **例**：

     ```go
     var b int = 5
     assert.NotNil(t, &b, "The value should not be nil")
     ```

7. **True**

   - **説明**：値が`true`であることを確認する。
   - **シグネチャ**：`func True(t TestingT, value bool, msgAndArgs ...interface{}) bool`
   - **例**：

     ```go
     assert.True(t, true, "The value should be true")
     ```

8. **False**

   - **説明**：値が`false`であることを確認する。
   - **シグネチャ**：`func False(t TestingT, value bool, msgAndArgs ...interface{}) bool`
   - **例**：

     ```go
     assert.False(t, false, "The value should be false")
     ```

9. **Error**

   - **説明**：指定されたエラーが発生したことを確認する。
   - **シグネチャ**：`func Error(t TestingT, err error, msgAndArgs ...interface{}) bool`
   - **例**：

     ```go
     err := errors.New("an error")
     assert.Error(t, err, "There should be an error")
     ```

10. **NoError**

    - **説明**：指定されたエラーが発生しなかったことを確認する。
    - **シグネチャ**：`func NoError(t TestingT, err error, msgAndArgs ...interface{}) bool`
    - **例**：

      ```go
      var err error = nil
      assert.NoError(t, err, "There should be no error")
      ```

11. **Contains**

    - **説明**：文字列やスライス、マップなどに指定された要素が含まれていることを確認する。
    - **シグネチャ**：`func Contains(t TestingT, s interface{}, contains interface{}, msgAndArgs ...interface{}) bool`
    - **例**：

      ```go
      assert.Contains(t, "Hello World", "World", "The string should contain 'World'")
      ```

12. **NotContains**

    - **説明**：文字列、配列、スライス、マップが特定の要素を含まないことを確認する。
    - **シグネチャ**：`func NotContains(t TestingT, s, contains interface{}, msgAndArgs ...interface{}) bool`
    - **例**：

      ```go
      assert.NotContains(t, []int{1, 2, 3}, 4, "The slice should not contain 4")
      ```

13. **Len**

    - **説明**：スライス、マップ、チャネルの長さが指定された値と等しいことを確認する。
    - **シグネチャ**：`func Len(t TestingT, object interface{}, length int, msgAndArgs ...interface{}) bool`
    - **例**：

      ```go
      assert.Len(t, []int{1, 2, 3}, 3, "The length should be 3")
      ```

14. **Less**

    - **説明**：最初の値が 2 番目の値より小さいことを確認する。
    - **シグネチャ**：`func Less(t TestingT, e1, e2 interface{}, msgAndArgs ...interface{}) bool`
    - **例**：

      ```go
      assert.Less(t, 3, 5, "3 should be less than 5")
      ```

15. **Greater**

    - **説明**：最初の値が 2 番目の値より大きいことを確認する。
    - **シグネチャ**：`func Greater(t TestingT, e1, e2 interface{}, msgAndArgs ...interface{}) bool`
    - **例**：

      ```go
      assert.Greater(t, 5, 3, "5 should be greater than 3")
      ```

16. **LessOrEqual**

    - **説明**：最初の値が 2 番目の値以下であることを確認する。
    - **シグネチャ**：`func LessOrEqual(t TestingT, e1, e2 interface{}, msgAndArgs ...interface{}) bool`
    - **例**：

      ```go
      assert.LessOrEqual(t, 3, 5, "3 should be less or equal to 5")
      ```

17. **GreaterOrEqual**

    - **説明**：最初の値が 2 番目の値以上であることを確認する。
    - **シグネチャ**：`func GreaterOrEqual(t TestingT, e1, e2 interface{}, msgAndArgs ...interface{}) bool`
    - **例**：

      ```go
      assert.GreaterOrEqual(t, 5, 5, "5 should be greater or equal to 5")
      ```

18. **InDelta**

    - **説明**：2 つの値が特定のデルタ値（許容差）以内であることを確認する。浮動小数点数の計算結果の比較に便利。
    - **シグネチャ**：`func InDelta(t TestingT, expected, actual interface{}, delta float64, msgAndArgs ...interface{}) bool`
    - **例**：

      ```go
      assert.InDelta(t, 123.0, 123.1, 0.2, "The values should be within the delta")
      ```

19. **InEpsilon**

    - **説明**：2 つの値の割合（相対誤差）が特定のイプシロン（許容値）以内であることを確認する。これも浮動小数点数の計算結果の比較に便利。
    - **シグネチャ**：`func InEpsilon(t TestingT, expected, actual interface{}, epsilon float64, msgAndArgs ...interface{}) bool`
    - **例**：

      ```go
      assert.InEpsilon(t, 100.0, 100.1, 0.001, "The values should be within the epsilon")
      ```

### assert のコード例

```go
import (
    "errors"
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestAssertions(t *testing.T) {
    // Equal
    assert.Equal(t, 123, 123, "The values should be equal")

    // NotEqual
    assert.NotEqual(t, 123, 456, "The values should not be equal")

    // Nil and NotNil
    var a *int = nil
    var b int = 5
    assert.Nil(t, a, "The value should be nil")
    assert.NotNil(t, &b, "The value should not be nil")

    // True and False
    assert.True(t, true, "The value should be true")
    assert.False(t, false, "The value should be false")

    // Error and NoError
    err := errors.New("an error")
    assert.Error(t, err, "There should be an error")
    assert.NoError(t, nil, "There should be no error")

    // Contains
    assert.Contains(t, "Hello World", "World", "The string should contain 'World'")

    // Len
    assert.Len(t, []int{1, 2, 3}, 3, "The length should be 3")
}
```
