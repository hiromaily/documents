# Protobuf からの Spec 生成

## [Google/gnostic](https://github.com/google/gnostic)

Gnosticは、OpenAPIやその他のAPI仕様を解析し、操作するためのツールキットで、API仕様を読み取り、変換、検証、生成するために使用される。
Gnosticは非常に柔軟で、API仕様に基づく様々なツールやプロセスを簡単に統合することができる。これにより、APIの開発と運用がさらに効率化され、標準化された方法で管理できるようになる。

### Gnosticの主な特徴は以下の通り

1. **多言語サポート**: GnosticはGoを主な実装言語としているが、その他の言語でも利用可能なライブラリやツールが存在する。
2. **仕様の解析**: OpenAPI、Swagger、Protocol BuffersなどのAPI仕様を読み込み、内部のデータ構造に変換する。
3. **バリデーション**: API仕様が正しいかどうかを検証し、エラーや警告を報告する。
4. **変換**: 異なるAPI仕様フォーマット間の相互変換を行うことができる。
5. **コード生成**: API仕様からGoのクライアントやサーバーコードを自動生成するツールも含まれている。

### 具体的な使用例

- OpenAPI仕様を読み込む
- 仕様のバリデーションを行う
- 仕様を別のフォーマット（例：Protocol Buffers）に変換する
- 仕様からコードを生成する

## `buf.gen.yaml`の例

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

## References

- [buf レポジトリ内の検索結果](https://github.com/search?q=org%3Abufbuild%20openapi&type=code)を調べる
- [gRPC Gateway](https://github.com/grpc-ecosystem/grpc-gateway)
  - Protobuf の定義から REST API のプロキシを生成してくれるプラグイン
  - [protoc-gen-openapiv2](https://github.com/grpc-ecosystem/grpc-gateway/tree/main/protoc-gen-openapiv2)
- [gRPC with an OpenAPI v3 API Gateway](https://zostay.com/posts/2024/02/04/grpc-with-an-openapi-v3-api-gateway/)
  - [protoc-gen-apigw](https://github.com/ductone/protoc-gen-apigw)
- [google: protoc-gen-openapi](https://github.com/google/gnostic/tree/main/cmd/protoc-gen-openapi)
  - [buf.build/community/google-gnostic-openapi](https://github.com/bufbuild/plugins/blob/574b3e9c1d7a4137e6b91e9e4c53584d8503012e/plugins/community/google-gnostic-openapi/v0.7.0/buf.plugin.yaml#L2)の使い方
