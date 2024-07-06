# VS Code

- [docs: vscode](../ide/vscode/README.md)

## Snippets

Extension にあるのは、あまり使い勝手がよくなさそうなので install しなくてもよさそう

- [Golang Snippets](https://marketplace.visualstudio.com/items?itemName=honnamkuan.golang-snippets)
  - 48k installed

[Go extension](https://github.com/golang/vscode-go/wiki/features#code-editing)に snippet も含まれる。

### Useful

- `for`

```go
for i := 0; i < count; i++ {

}
```

- `forr`

```go
for _, v := range v {

}
```

- `df`

```go
defer func()
```

- `if`

```go
if condition {

}
```

- `iferr`

```go
if err != nil {
  return nil, err
}
```

- `el`

```go
else {

}
```

- `go`

```go
go func() {

}()
```

- `helloweb`

```go
package main

import (
  "fmt"
  "net/http"
  "time"
)

func greet(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, "Hello World! %s", time.Now())
}

func main() {
  http.HandleFunc("/", greet)
  http.ListenAndServe(":8080", nil)
}
```

### For test

- `bf`

```go
func Benchmark(b *testing.B) {
  for i := 0; i < b.N; i++ {

  }
}
```

### 追加したほうがいい snippet

- `ifel`

```go
if cond {
} else {
}
```

- `elif`

```go
else if cond {
}
```

- `pri`

```go
fmt.Println()
```

## Debugging Using [dlv](https://github.com/go-delve/delve)

- [コンテナで動く Go アプリをデバッグする方法](https://zenn.dev/skanehira/articles/2021-11-26-go-remote-debug)

1. install `dlv`

```
go install github.com/go-delve/delve/cmd/dlv@latest
```

2. create `launch.json` in a .vscode folder in your workspace (project root folder)

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug Compose Container",
      "type": "go",
      "debugAdapter": "dlv-dap",
      "request": "launch",
      "port": 40000,
      "host": "localhost",
      "mode": "exec",
      "program": "/usr/bin/chaincode",
      "substitutePath": [
        {
          "from": "${workspaceFolder}/demo/chains/fabric/chaincode/fabibc",
          "to": "/root"
        }
      ]
    }
  ]
}
```

- port: デバッガのポート
- program: コンテナ側にある実行ファイルのフルパス
- exec: 事前ビルドされた program を実行する
- substitutePath: VSCode 側のパスをコンテナ側のパスに置換

3. Dockerfile

```Dockerfile
FROM golang:1.17-alpine3.13
RUN apk add --no-cache gcc libc-dev

WORKDIR /root
COPY ./ ./

# build with gcflags
RUN go build -v -mod=vendor -gcflags "all=-N -l" -o /usr/bin/app .
# Install dlv
RUN GOBIN=/usr/bin go install github.com/go-delve/delve/cmd/dlv@latest

ENTRYPOINT dlv dap
CMD -l 0.0.0.0:40000 --log --check-go-version=false
```

4. docker-compose.yml

```yml
ports:
  - "40000:40000"
```

## References

- [github:vscode-go](https://github.com/golang/vscode-go)
- [github:vscode-go docs](https://github.com/golang/vscode-go/tree/master/docs)
- [github:vscode-go debuging](https://github.com/golang/vscode-go/blob/master/docs/debugging.md)
- [vscode debuging](https://code.visualstudio.com/docs/editor/debugging)
- [dap: Debug Adapter Protocol](https://github.com/Microsoft/debug-adapter-protocol)
