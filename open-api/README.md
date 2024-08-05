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

## spec からコードを生成する

[generator.md](./generator.md)

- [openapi-generator](https://github.com/OpenAPITools/openapi-generator)
  - [official](https://openapi-generator.tech/)
  - 様々な言語に対応した型定義を作成する
