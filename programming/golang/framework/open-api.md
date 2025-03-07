# Golang の OpenAPI に対応した Framework

- [open-api](../../../api/open-api/README.md)

## Generator (Specから生成するもの)

### [openapi-generator](https://github.com/OpenAPITools/openapi-generator)

- spec first
- [generator/go docs](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/go.md)
- 対応している framework

  - [gin](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/go-gin-server.md)
  - [echo](https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/go-echo-server.md)
  - 使いやすいコードを生成するわけではない

### [ogen](https://github.com/ogen-go/ogen)

- ジェネレーター
- Star: 1.3 K
- OpenAPI v3
- 2024 時点では伸びてきている
- [最近の Go の OpenAPI Generator の推しは ogen](https://blog.p1ass.com/posts/ogen/)

## GoのコードからOpenAPIのSpecを生成する

### [huma](https://github.com/danielgtaylor/huma)

- Star: 2.7 K
- OpenAPI v3.1
  - Goのコードから直接OpenAPI 3.1形式のドキュメントを生成できる
- 2024/11 時点で Star は急上昇中

### [go-swagger](https://github.com/go-swagger/go-swagger)

- Star: 9.4 K
- OpenAPI v2
- `v2`にしか対応していないのが辛い

spec からコードを generate するか、コードから spec を generate するか、調整できる

### [swag](https://github.com/swaggo/swag)

- Star: 10.1 K
- OpenAPI v2

コードから spec を generate する

### [gin-swagger](https://github.com/swaggo/gin-swagger)

- Star: 3.7 K
- OpenAPI v2

### [kin-openapi](https://github.com/getkin/kin-openapi)

- Star: 2.5 K
- OpenAPI v3

### [oapi-codegen](https://github.com/deepmap/oapi-codegen)

- Star: 5.6 K
- OpenAPI v3

### [goa](https://github.com/goadesign/goa)
