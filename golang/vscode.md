# VS Code

## Debugging

- [github:vscode-go](https://github.com/golang/vscode-go)
- [github:vscode-go docs](https://github.com/golang/vscode-go/tree/master/docs)
- [github:vscode-go debuging](https://github.com/golang/vscode-go/blob/master/docs/debugging.md)
- [vscode debuging](https://code.visualstudio.com/docs/editor/debugging)
- [dap: Debug Adapter Protocol](https://github.com/Microsoft/debug-adapter-protocol)

### 3.2. Debugging Using [dlv](https://github.com/go-delve/delve)

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
