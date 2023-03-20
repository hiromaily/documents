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
- `grpc-go` clientは `connect-go` server と問題なく動作し、その逆も問題なく動作する

### gRPC-Web protocol
- [grpc/grpc-web](https://github.com/grpc/grpc-web) で使用される gRPC-Web プロトコル
- Envoyといった仲介proxyを必要とせずに、`connect-go` server が `grpc-web` front-endと相互運用できるようにする

### [Connect protocol](https://connect.build/docs/protocol/)
- HTTP/1.1 または HTTP/2 で動作するシンプルな POST 専用プロトコル
- ストリーミングを含む gRPC と gRPC-Web の最良の部分を取り、それらをブラウザー、モノリス、およびマイクロサービスで同等に機能するプロトコルにパッケージ化したもの
- デフォルトでは、JSON およびバイナリでエンコードされた Protobuf がサポートされている
- 詳細は次節にて
## [Connect Protocol](https://connect.build/docs/protocol/)
- HTTP上でRPCを行うためのプロトコル
- RFC5234の[Augmented BNF for Syntax Specifications: ABNF](https://datatracker.ietf.org/doc/html/rfc5234.html)のルールに従っている

- プロトコルの目的
  - 特に単項のRPCについては、人間が読めるようにし、汎用のHTTPツールでデバッグできるようにすること。
  - gRPCのHTTP/2プロトコルに近い概念で、Connectの実装が両方のプロトコルをサポートできるようにする。
  - 広く実装されているHTTPの機能のみに依存し、高レベルのセマンティクスで動作を指定するため、Connectの実装では、既製のネットワークライブラリを容易に使用することができる。

- Connect プロトコルは、Protobuf または JSON のバイナリペイロードを持つ、`unary`(単体)、`client streamin`、`server streaming`、および`bidirectional streaming`(双方向ストリーミング) RPC をサポートしている
- 双方向ストリーミングはHTTP/2を必要とするが、他のRPCタイプはHTTP/1.1もサポートしている
- このプロトコルはHTTPトレーラを全く使用しないので、どのようなネットワークインフラでも動作する

### unary RPC
- `application/proto`もしくは `application/json` Content-Typesを使用する
- リクエストはすべてPOST
- PathはProtobufスキーマから派生
- RequestとResponseのBodyは有効な`Protobuf`または`JSON`（gRPCスタイルのバイナリ構成なし）
- レスポンスは意味のあるHTTPステータスコードを持つ

### client streaming RPC
- 当然ながら少し複雑で、`application/connect+proto`または`application/connect+json` Content-Types を使用する
- `gRPC-Web` に似た外観をしている
- リクエストはPOST
- PathはProtobufスキーマから派生
- 各リクエストとレスポンスメッセージは数バイトのバイナリフレームデータでラップされている
- レスポンスは常に200 OKのHTTPステータス
- エラーはBodyの最後の部分で送信される






## [Routing](https://connect.build/docs/go/routing)
```
:method post
:path /<Package>.<Service>/<Method>
```
- curlの例
```
curl --header "Content-Type: application/json" --data '{"name": "Jane"}' \
  http://localhost:8080/greet.v1.GreetService/Greet
```
この場合、`greet.v1`の`GreetService`サービスの`Greet`を呼び出すこととなる。
これらは、大文字/小文字を区別し、ハンドラは`POST`のみをサポートする


- これを使うためには、API Gatewayがあったほうがいいかもしれない
  - AWS API Gateway, Azure API Management, Kong, Yyk.IO, 

## Example
[hiromaily/connect-example](https://github.com/hiromaily/connect-example)