# fmt.Error

[source](https://go.dev/src/fmt/errors.go)

## `wrapError` struct

```go
type wrapError struct {
  msg string
  err error
}

func (e *wrapError) Error() string {
  return e.msg
}

func (e *wrapError) Unwrap() error {
  return e.err
}
```

## `wrapErrors` struct

```go
type wrapErrors struct {
  msg  string
  errs []error
}

func (e *wrapErrors) Error() string {
  return e.msg
}

func (e *wrapErrors) Unwrap() []error {
  return e.errs
}
```
