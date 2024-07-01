# OpenAPI

The OpenAPI Specification (OAS) defines a standard, programming language-agnostic interface description for HTTP APIs, which allows both humans and computers to discover and understand the capabilities of a service without requiring access to source code, additional documentation, or inspection of network traffic.

- OpenAPI は RESTful API の記述を仕様化したもの
- yaml, json などでスキーマ定義を先に行い、スキーマ駆動開発に向いている
- tool などでスキーマからコードを生成するのが一般的

## コードが先か、Spec が先か

OpenAPI の spec は不変であり、Spec を[Stoplight](https://stoplight.io/)などで作成して、[openapi-generator](https://github.com/OpenAPITools/openapi-generator)に対応した framework のコードを生成するのがよさそう

## Latest Version

- 3.1 (As of Oct 2022)

## References

- [Official](https://www.openapis.org/)
- [OpenAPI-Specification](https://github.com/OAI/OpenAPI-Specification)
- [Swagger](https://swagger.io/)
  - Simplify API development for users, teams, and enterprises with the Swagger open source and professional toolset.
- [Stoplight Studio](https://stoplight.io/studio)

  - OpenAPI 定義ファイルの作成と管理ができる GUI エディタ

- [OpenAPI（API ドキュメント）を用いた Go の API サーバー開発](https://note.com/shift_tech/n/n2d0265731777)
- [最近の Go の OpenAPI Generator の推しは ogen](https://blog.p1ass.com/posts/ogen/)
- [Stoplight と OpenAPI generator で API 開発をより便利にする](https://tech.talentx.co.jp/entry/2024/04/09/133904)

## OpenAPI spec の作成

- [Redocly](https://redocly.com/)
- [Stoplight](https://stoplight.io/)
- [SwaggerHub](https://swagger.io/tools/swaggerhub/)
- [Postman](https://www.postman.com/)
- [APIMatic](https://www.apimatic.io/)

## spec からコードを生成する

- [openapi-generator](https://github.com/OpenAPITools/openapi-generator)
  - [official](https://openapi-generator.tech/)
  - 様々な言語に対応した型定義を作成する

### Golang (WIP: 情報が古い)

- [oapi-codegen](https://github.com/deepmap/oapi-codegen)
  - Generate Go client and server boilerplate from OpenAPI 3 specifications
- [goa](https://github.com/goadesign/goa)
  - Design-based APIs and microservices in Go
- [kin-openapi](https://github.com/getkin/kin-openapi)
  - OpenAPI 3.0 (and Swagger v2) implementation for Go (parsing, converting, validation, and more)
- [gin-swagger](https://github.com/swaggo/gin-swagger)
  - gin middleware to automatically generate RESTful API documentation with Swagger 2.0
- [go-swagger](https://github.com/go-swagger/go-swagger)
  - Swagger 2.0 implementation for go

### Typescript/Javascript/Node.js

- [zod](https://github.com/colinhacks/zod)
  - Zod is a TypeScript-first schema declaration and validation library.
- [aspida](https://github.com/aspida/aspida)
  - TypeScript friendly HTTP client wrapper for the browser and node.js
- [tsoa](https://github.com/lukeautry/tsoa)
  - OpenAPI-compliant REST APIs using TypeScript and Node
  - A valid OpenAPI spec (2.0 or 3.0) is generated from your controllers and models

### Python

#### [FastAPI](https://fastapi.tiangolo.com/)

- [Github](https://github.com/tiangolo/fastapi)

FastAPI is a modern, fast (high-performance), web framework for building APIs with Python 3.7+ based on standard Python type hints.
コードファースト

## [CUE](https://cuelang.org/)

データの表現やスキーマ定義やバリデーションなどを行うことができる言語

- [cue 言語を利用して OpenAPI ファイルを生成する](https://zenn.dev/kawahara/articles/bc7c0851bea7d4)

## [OpenAPI Generator](https://openapi-generator.tech/)の使い方
