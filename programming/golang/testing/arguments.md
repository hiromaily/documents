# Test実行時にパラメータを利用して、test内で参照する場合

`go test`の`-args`オプションを利用する

```sh
go test -race -v ./pkg/something -args -foo=bar
```
