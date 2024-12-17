# testing package

[testing](https://pkg.go.dev/testing)

## Benchmarks

```sh
go test -benchmem -bench BenchmarkEncryptIDs github.com/org/repo/pkg/entity
```

```go
func BenchmarkRandInt(b *testing.B) {
    for range b.N {
        rand.Int()
    }
}
```

## Examples

```go
func ExampleHello() {
    fmt.Println("hello")
    // Output: hello
}
```

## Fuzzing

## Skipping

```sh
go test -short
```

```go
func TestTimeConsuming(t *testing.T) {
    if testing.Short() {
        t.Skip("skipping test in short mode.")
    }
    ...
}
```

## Subtests and Sub-benchmarks

## Main
