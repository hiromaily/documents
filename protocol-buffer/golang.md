# proto for Golang

## Install plugin for Golang

- [protoc-gen-go](https://pkg.go.dev/github.com/golang/protobuf/protoc-gen-go)
  - protoc-gen-go is a plugin for the Google protocol buffer compiler to generate Go code
- [protoc-gen-go-grpc](https://pkg.go.dev/google.golang.org/grpc/cmd/protoc-gen-go-grpc)
  - This tool generates Go language bindings of services in protobuf definition files for gRPC.

```
# go plugin to generate go code
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest

# grpc plugin to generate grpc go code
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

## Proto files の build 方法

```
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
