# Slices

[slices](https://pkg.go.dev/slices)

## Note

`"golang.org/x/exp/slices"`を使っているサイトもあるが、この記述は古いので注意

## コード例

```go
import (
  "slices"
)

var SuccessStatusCodes []int = []int{200, 202}
// check status code
if slices.Contains(SuccessStatusCodes, res.StatusCode) {
  // true
} else {
  // false
}
```
