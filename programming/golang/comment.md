# Golang Comment

## GoDoc

- [Go Doc Comments](https://go.dev/doc/commentg)
- [tolang.org/x/tools/cmd/godoc](https://pkg.go.dev/golang.org/x/tools/cmd/godoc)

## [Deprecated](https://go.dev/wiki/Deprecated)

```go
type ResponseRecorder struct {
    // HeaderMap contains the headers explicitly set by the Handler.
    // It is an internal detail.
    //
    // Deprecated: HeaderMap exists for historical compatibility
    // and should not be used. To access the headers returned by a handler,
    // use the Response.Header map as returned by the Result method.
    HeaderMap http.Header
```
