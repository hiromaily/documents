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

func Send() error {
    ...
  res, err := s.client.Send(m)
  if err != nil {
    return fmt.Errorf("%w: %v", errmsg.ErrSendGridBySending, err)
  }
  // check status code
  if slices.Contains(SuccessStatusCodes, res.StatusCode) {
    // true
  } else {
    // false
  }
}
```
