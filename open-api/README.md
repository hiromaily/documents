# OpenAPI

The OpenAPI Specification (OAS) defines a standard, programming language-agnostic interface description for HTTP APIs, which allows both humans and computers to discover and understand the capabilities of a service without requiring access to source code, additional documentation, or inspection of network traffic.

- OpenAPIはRESTful APIの記述を仕様化したもの
- yaml, jsonなどでスキーマ定義を先に行い、スキーマ駆動開発に向いている
- toolなどでスキーマからコードを生成するのが一般的


## Latest Version
- 3.1 (As of Oct 2022)


## References
- [Official](https://www.openapis.org/)
- [OpenAPI-Specification](https://github.com/OAI/OpenAPI-Specification)
- [Swagger](https://swagger.io/)
  - Simplify API development for users, teams, and enterprises with the Swagger open source and professional toolset.
- [Stoplight Studio](https://stoplight.io/studio)
  - OpenAPI 定義ファイルの作成と管理ができる GUI エディタ

### Others
- [OpenAPI（APIドキュメント）を用いたGoのAPIサーバー開発](https://note.com/shift_tech/n/n2d0265731777)


## Languages
- [openapi-generator](https://github.com/OpenAPITools/openapi-generator)
  - [official](https://openapi-generator.tech/)
  - 様々な言語に対応した型定義を作成する

### Golang
- [kin-openapi](https://github.com/getkin/kin-openapi)
  - OpenAPI 3.0 (and Swagger v2) implementation for Go (parsing, converting, validation, and more)
- [gin-swagger](https://github.com/swaggo/gin-swagger)
  - gin middleware to automatically generate RESTful API documentation with Swagger 2.0
- [goa](https://github.com/goadesign/goa)
  - Design-based APIs and microservices in Go

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
FastAPI is a modern, fast (high-performance), web framework for building APIs with Python 3.7+ based on standard Python type hints.

- [Github](https://github.com/tiangolo/fastapi)


## [CUE](https://cuelang.org/)
データの表現やスキーマ定義やバリデーションなどを行うことができる言語

- [cue言語を利用してOpenAPIファイルを生成する](https://zenn.dev/kawahara/articles/bc7c0851bea7d4)


## [OpenAPI Generator](https://openapi-generator.tech/)の使い方