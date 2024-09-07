# proto for Golang

- goでは、[buf](https://buf.build/docs/introduction)を使うほうが楽
- [内部Docs](./connect/buf.md)

## [protoc-gen-go](https://pkg.go.dev/github.com/golang/protobuf/protoc-gen-go) プラグイン

Googleが公式にサポートするGoのコード生成プラグイン

### 関連ライブラリ

- [protoc-gen-go-grpc](https://pkg.go.dev/google.golang.org/grpc/cmd/protoc-gen-go-grpc)
  - gRPCのGo用プラグインで、RPCサービスを実装するためのコードを生成する
- [protoc-gen-validate](https://github.com/bufbuild/protoc-gen-validate)
  - Protobufメッセージのフィールドバリデーションをサポートするプラグイン
  - 現在は`bufbuild`に統合されている
- [grpc-gateway/protoc-gen-openapiv2](https://github.com/grpc-ecosystem/grpc-gateway/tree/main/protoc-gen-openapiv2)
  - grpc-gatewayのプラグインで、gRPCサービスをRESTful APIに変換するためのSwagger/OpenAPI仕様の生成をサポート
- [grpc-gateway/protoc-gen-grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway/tree/main/protoc-gen-grpc-gateway)
  - grpc-gatewayプロジェクトの一部で、HTTP/JSON APIとgRPCプロトコルの間で変換を行うコードを生成する

```sh
# go plugin to generate go code
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest

# grpc plugin to generate grpc go code
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

## Proto files の build 方法

```sh
protoc \
--go_out=./pb/go/rippleapi/ --go_opt=paths=source_relative \
--go-grpc_out=./pb/go/rippleapi/ --go-grpc_opt=paths=source_relative  \
--proto_path=./proto/rippleapi \
--proto_path=./proto/third_party \
proto/**/*.proto

# old way
protoc --go_out=plugins=grpc:. --go_opt=paths=source_relative \
  xxxx.proto
```
