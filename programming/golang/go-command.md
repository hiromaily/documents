# Go Command

## 依存関係のupgrade

```sh
go get -u ./...

# パッチアップデートのみ
go get -u=patch ./...

# update後に実行
go mod tidy
```

## ビルド時

```sh
# 通常のビルド
go build -v -o ${GOPATH}/bin/cmd-a ./cmd/cmd-a/

# ビルド時にmain.goの変数に外部から値を設定する
go build -v -ldflags "-X main.CommitID=${COMMIT_ID}" -o ${GOPATH}/bin/cmd-a ./cmd/cmd-a/

# Release用
go build -v -trimpath -ldflags="-s -w" -o ${GOPATH}/bin/cmd-a ./cmd/cmd-a/
```

### `-trimpath` option

これはビルド情報からファイルパス情報を削除するためのフラグで、生成されたバイナリからソースコードの絶対パスを取り除くために使われる。このフラグを使用することで、セキュリティの向上やバイナリサイズの削減が期待できる。

### `-ldflags="-s -w"` option

リンカ (linker) フラグを指定するオプション

`-s`: シンボルテーブル情報を削除。これによりデバッグ情報が取り除かれ、バイナリサイズが小さくなる
`-w`: デバッグ情報を削除。これもバイナリサイズを減少させる。

この二つのフラグを組み合わせることで、ビルドされるバイナリのサイズが最小限に抑えられる。

### build時に使われる環境変数

```sh
GOOS=linux GOARCH=${ARCH} CGO_ENABLED=0 go build -o myapp
```

1. **GOOS**: 実行バイナリのターゲットとなるオペレーティングシステムを指定。例えば、`GOOS=linux`と設定すると、Linux用のバイナリが生成される。他の選択肢としては、`windows`, `darwin`（macOS）など。

    ```bash
    export GOOS=linux
    ```

2. **GOARCH**: 実行バイナリのターゲットとなるアーキテクチャを指定。`${ARCH}`は一般的に環境変数に設定されているアーキテクチャ値。例えば、`amd64`, `arm`, `arm64`など。

    ```bash
    export GOARCH=amd64
    ```

3. **CGO_ENABLED**: CGO（C言語のコードをGoコードから利用するためのインターフェース）の有効/無効を設定。`CGO_ENABLED=0`と設定すると、CGOを無効にし、純Go（Pure Go）でビルドされる。これによりクロスコンパイルが容易になる。

    ```bash
    export CGO_ENABLED=0
    ```

4. **GOARM**: ARMアーキテクチャのバージョンを指定。例えば、ARMv6の場合は`GOARM=6`と設定。

    ```bash
    export GOARM=6
    ```
