# connect-go

ブラウザと gRPC 互換の HTTP API を構築するためのライブラリ群で、protocol buffer

## References

- [Connect Docs](https://connect.build/docs/introduction)
- [connect-go](https://github.com/bufbuild/connect-go)
- [connect-web](https://www.npmjs.com/package/@bufbuild/connect-web)
  - [connect-es](https://github.com/bufbuild/connect-es)
- [Buf Docs](https://docs.buf.build/installation)
- [buf](https://github.com/bufbuild/buf)
- [grpc/grpc-web](https://github.com/grpc/grpc-web)
- [Blog](https://buf.build/blog)

## protocols in connect-go

### gRPC protocol

- gRPC エコシステム全体で使用されるプロトコルであり、`connect-go` をすぐに他の gRPC 実装と互換性を持たせることができる
- `grpc-go` client は `connect-go` server と問題なく動作し、その逆も問題なく動作する

### gRPC-Web protocol

- [grpc/grpc-web](https://github.com/grpc/grpc-web) で使用される gRPC-Web プロトコル
- Envoy といった仲介 proxy を必要とせずに、`connect-go` server が `grpc-web` front-end と相互運用できるようにする

### [Connect protocol](https://connect.build/docs/protocol/)

- HTTP/1.1 または HTTP/2 で動作するシンプルな POST 専用プロトコル
- ストリーミングを含む gRPC と gRPC-Web の最良の部分を取り、それらをブラウザー、モノリス、およびマイクロサービスで同等に機能するプロトコルにパッケージ化したもの
- デフォルトでは、JSON およびバイナリでエンコードされた Protobuf がサポートされている
- 詳細は次節にて

## [Connect Protocol](https://connect.build/docs/protocol/)

- HTTP 上で RPC を行うためのプロトコル
- RFC5234 の[Augmented BNF for Syntax Specifications: ABNF](https://datatracker.ietf.org/doc/html/rfc5234.html)のルールに従っている

- プロトコルの目的

  - 特に単項の RPC については、人間が読めるようにし、汎用の HTTP ツールでデバッグできるようにすること。
  - gRPC の HTTP/2 プロトコルに近い概念で、Connect の実装が両方のプロトコルをサポートできるようにする。
  - 広く実装されている HTTP の機能のみに依存し、高レベルのセマンティクスで動作を指定するため、Connect の実装では、既製のネットワークライブラリを容易に使用することができる。

- Connect プロトコルは、Protobuf または JSON のバイナリペイロードを持つ、`unary`(単体)、`client streamin`、`server streaming`、および`bidirectional streaming`(双方向ストリーミング) RPC をサポートしている
- 双方向ストリーミングは HTTP/2 を必要とするが、他の RPC タイプは HTTP/1.1 もサポートしている
- このプロトコルは HTTP トレーラを全く使用しないので、どのようなネットワークインフラでも動作する

### unary RPC

- `application/proto`もしくは `application/json` Content-Types を使用する
- リクエストはすべて POST
- Path は Protobuf スキーマから派生
- Request と Response の Body は有効な`Protobuf`または`JSON`（gRPC スタイルのバイナリ構成なし）
- レスポンスは意味のある HTTP ステータスコードを持つ

### client streaming RPC

- 当然ながら少し複雑で、`application/connect+proto`または`application/connect+json` Content-Types を使用する
- `gRPC-Web` に似た外観をしている
- リクエストは POST
- Path は Protobuf スキーマから派生
- 各リクエストとレスポンスメッセージは数バイトのバイナリフレームデータでラップされている
- レスポンスは常に 200 OK の HTTP ステータス
- エラーは Body の最後の部分で送信される

## [Routing](https://connect.build/docs/go/routing)

```txt
:method post
:path /<Package>.<Service>/<Method>
```

- curl の例

```sh
curl --header "Content-Type: application/json" --data '{"name": "Jane"}' \
  http://localhost:8080/greet.v1.GreetService/Greet
```

この場合、`greet.v1`の`GreetService`サービスの`Greet`を呼び出すこととなる。
これらは、大文字/小文字を区別し、ハンドラは`POST`のみをサポートする

- これを使うためには、API Gateway があったほうがいいかもしれない
  - AWS API Gateway, Azure API Management, Kong, Yyk.IO,

## Proto generator

### buf.gen.yaml

```yaml
version: v1
plugins:
  - name: go
    out: pkg/gen
    opt: paths=source_relative
  - name: connect-go
    out: pkg/gen
    opt: paths=source_relative
  - name: es
    out: ./web/src/gen
    opt:
      - target=ts
      - import_extension=none
    path: ./web/node_modules/.bin/protoc-gen-es
  - name: connect-es
    out: ./web/src/gen
    opt:
      - target=ts
      - import_extension=none
    path: ./web/node_modules/.bin/protoc-gen-connect-es
```

- name: go
  - Go 向け protoc の plugin によって定義ファイルから Go の型情報が生成される
  - `go install google.golang.org/protobuf/cmd/protoc-gen-go` が必要
- name: connect-go
  - connect-go 用の plugin によって定義ファイルから connect-go の Handler や Client 向けのコードが生成される
  - `go install github.com/bufbuild/connect-go/cmd/protoc-gen-connect-go@latest` が必要
- name: es
  - Typescript(ES)向け protoc の plugin によって定義ファイルから Typescript の型情報が生成される
  - target によって出力ファイル(ts or js)の切り替えが可能
  - [@bufbuild/protoc-gen-es](https://www.npmjs.com/package/@bufbuild/protoc-gen-es)の install が必要
- name: es
  - connect-es
  - connect-es 用の plugin によって、client のための Interface が生成される
  - [protoc-gen-connect-es](https://github.com/bufbuild/connect-es/tree/main/packages/protoc-gen-connect-es)の install が必要
  - 尚、[protoc-gen-connect-web](https://github.com/bufbuild/connect-es/tree/main/packages/protoc-gen-connect-web)は deprecated されている

## Example

[hiromaily/connect-example](https://github.com/hiromaily/connect-example)
