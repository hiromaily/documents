# Spec の作成手段について

## OpenAPI spec の作成ができる Tool やサービス

- [openapi-gui](https://github.com/Mermade/openapi-gui)
  - OpenSource
  - OpenAPI 3.1.0 には未対応
  - [Mermade/openapi-gui を使って OpenAPI(Swagger)仕様書を作る](https://zenn.dev/dozo/articles/9a70e5b116f7e6)
- [Stoplight](https://stoplight.io/)

  - OpenAPI 定義ファイルの作成と管理ができる GUI エディタ
    - [Stoplight Studio](https://stoplight.io/studio)
  - [Stoplight と OpenAPI generator で API 開発をより便利にする](https://tech.talentx.co.jp/entry/2024/04/09/133904)
  - 有償

- [Redocly](https://redocly.com/)

  - [redocly-cli](https://github.com/Redocly/redocly-cli)によって spec の lint ができる
  - [Generate code samples automatically with Redocly](https://www.youtube.com/watch?v=zZUR7ih2A5A)
  - vscode の拡張により、コードアシストできる
  - 個人利用は無料

- [SwaggerHub](https://swagger.io/tools/swaggerhub/)
- [Postman](https://www.postman.com/)
- [APIMatic](https://www.apimatic.io/)

### [openapi-gui](https://github.com/Mermade/openapi-gui)

```sh
git clone https://github.com/Mermade/openapi-gui.git
cd openapi-gui
docker build -t mermade/openapi-gui .

# 実行
docker run --name openapi-gui -p 3000:3000 -d mermade/openapi-gui
```

![openapi-gui](../images/openapi-gui.png "openapi-gui")

## DSL 等からの Spec 生成

- [CUE](./cue.md)
  - データの表現やスキーマ定義やバリデーションなどを行うことができる言語

## WIP: Protobuf からの Spec 生成

- WIP:[buf レポジトリ内の検索結果](https://github.com/search?q=org%3Abufbuild%20openapi&type=code)を調べる

- [gRPC Gateway](https://github.com/grpc-ecosystem/grpc-gateway)
  - Protobuf の定義から REST API のプロキシを生成してくれるプラグイン
  - [protoc-gen-openapiv2](https://github.com/grpc-ecosystem/grpc-gateway/tree/main/protoc-gen-openapiv2)
- [gRPC with an OpenAPI v3 API Gateway](https://zostay.com/posts/2024/02/04/grpc-with-an-openapi-v3-api-gateway/)
  - [protoc-gen-apigw](https://github.com/ductone/protoc-gen-apigw)
- [google: protoc-gen-openapi](https://github.com/google/gnostic/tree/main/cmd/protoc-gen-openapi)
  - [WIP: buf.build/community/google-gnostic-openapi](https://github.com/bufbuild/plugins/blob/574b3e9c1d7a4137e6b91e9e4c53584d8503012e/plugins/community/google-gnostic-openapi/v0.7.0/buf.plugin.yaml#L2)の使い方

### buf.gen.yaml

```yaml
version: v1
managed:
  enabled: true
  go_package_prefix:
    default: github.com/org/repo/gen/go
    except:
      - buf.build/googleapis/googleapis
      - buf.build/bufbuild/protovalidate
plugins:
  - plugin: buf.build/protocolbuffers/go
    out: gen/go
    opt:
      - paths=source_relative
  - plugin: buf.build/grpc/go:v1.3.0
    out: gen/go
    opt:
      - paths=source_relative
  - plugin: buf.build/grpc-ecosystem/gateway:v2.18.0
    out: gen/go
    opt:
      - paths=source_relative
  - plugin: buf.build/community/stephenh-ts-proto
    out: gen/ts
    opt:
      - fileSuffix=-pb
      - esModuleInterop=true
      - enumsAsLiterals=true
      - stringEnums=true
      - removeEnumPrefix=true
      - unrecognizedEnum=false
      #- importSuffix=.js
  - plugin: buf.build/grpc-ecosystem/openapiv2
    out: gen/openapi
    opt:
      - logtostderr=true
      - allow_merge=false
      - simple_operation_ids=true
      - json_names_for_fields=true
      - disable_default_errors=true
      - allow_delete_body=true
```
