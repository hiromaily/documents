# testing package

[testing](https://pkg.go.dev/testing)

## Testのセットアップとティアダウン

TestMain関数によって、通常のTestXxx関数を実行する前後に特定の処理を追加できる。
TestMain関数は、1 packageに1つしか利用できない。

```go
func TestMain(m *testing.M) {
    // setup code here
    code := m.Run()
    // teardown code here
    os.Exit(code)
}
```

## Cleanup関数

T.Cleanupを使うと、テストが終了した後に実行するクリーンアップ処理を登録できる。

```go
func TestExample(t *testing.T) {
    t.Cleanup(func() {
        t.Log("Running cleanup after test")
    })
    // テストのコード
}
```

## T.TempDirで一時ディレクトリの作成

t.TempDirを使うと、一時ディレクトリを作成し、テスト終了後に自動でクリーンアップすることができる。

```go
func TestExample(t *testing.T) {
    tmpDir := t.TempDir()
    // Use tmpDir for temporary file operations
}
```

## Parallelテスト

複数のテストを並列に実行したい場合、t.Parallelを使用します。並列実行することで、テストの実行時間を短縮できる。

```go
func TestExample(t *testing.T) {
    t.Parallel()
    // テストのコード
}
```

## ビルトインのカバレッジ測定

```sh
# テストカバレッジを出力
go test -cover ./...

# 詳細なカバレッジレポートを生成する
go test -coverprofile=cover.out ./...
go tool cover -html=cover.out -o cover.html
```

## Fatal系とError系の使い分け

- t.Error系 (t.Error, t.Errorf) はエラーを報告し、テストを続行する。
- t.Fatal系 (t.Fatal, t.Fatalf) はエラーを報告し、テストを終了する。

## T.Helperでテストヘルパーを明示する

複数のテストケースで共通のエラーハンドリングを行う場合、ヘルパー関数を定義する。T.Helperを使用すると、エラーが発生した場所がテスト関数内であるかのようにレポートされる。

```go
func assertEqual(t *testing.T, got, want string) {
    t.Helper()
    if got != want {
        t.Errorf("got %s, want %s", got, want)
    }
}

func TestSomething(t *testing.T) {
    got := "foo"
    want := "bar"
    assertEqual(t, got, want)
}
```

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
