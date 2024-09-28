# OpenAPI

OpenAPIとは、RESTful APIを記述するための標準化された定義フォーマット。以前はSwagger（スワッガー）という名前で知られていたが、2020年1月にOpenAPI Initiativeに移管され、その後現在の名称になった。
OpenAPIの主な目的は、APIの仕様を機械可読な形式で記述することで、その仕様に基づくドキュメント、テスト、自動生成コードなどのツールを容易に作成・利用できるようにすること。

## OpenAPI仕様の主な特徴

1. **フォーマット**: OpenAPI仕様はYAMLまたはJSON形式で記述される。
2. **スキーマ定義**: リクエストやレスポンスの形式、クエリパラメータ、ヘッダー、ボディの内容などを詳細に定義できる。
3. **自動生成**: OpenAPI仕様からクライアントコード、サーバーコード、ドキュメント、テストケースなどを自動生成するツールが数多く存在する。
4. **互換性**: 多くのプラットフォームやフレームワークでサポートされているため、異なる技術スタックでも共通のAPI仕様を利用できる。

## OpenAPIの構造

- **info**: APIのバージョン、タイトル、作者情報などの基本情報。
- **servers**: APIが提供されるサーバーの情報。
- **paths**: 各エンドポイントのパスと、そのパスに対するHTTPメソッド（GET、POSTなど）ごとの操作内容。
- **components**: スキーマ、レスポンス、パラメータ、リクエストボディ、セキュリティ方式などの再利用可能な部品の定義。
- **security**: APIの認証や認可の設定。
- **tags**: エンドポイントをグループ化するためのタグ。

## Latest Version

- 3.1 (As of Oct 2022)

## コードが先か、Spec が先か

### Specを先に用意する場合

OpenAPI の spec は不変であり、Spec を[Stoplight](https://stoplight.io/)などで作成して、[openapi-generator](https://github.com/OpenAPITools/openapi-generator)に対応した framework のコードを生成する。しかし、Specの生成は簡単ではない。

## [OpenAPI.Tools](https://openapi.tools/)

OpenAPI.ToolsはOpenAPI Initiativeが提供する、OpenAPI仕様に関連するさまざまなツールやリソースを一覧提供しているウェブサイトで、APIの設計、開発、テスト、ドキュメント生成などに役立つツールやライブラリを見つけやすくするためのリポジトリとなっている。

### カテゴリーに分かれたツール

1. **APIドキュメント生成**: API仕様から自動的にドキュメントを生成するツール。
2. **サーバ生成**: OpenAPI仕様からサーバーサイドのコードを自動生成するためのツール。
3. **クライアント生成**: OpenAPI仕様からクライアントサイドのコードを自動生成するためのツール。
4. **テストツール**: APIをテストするためのツールやフレームワーク。
5. **デザインツール**: API設計やモデリングを支援するツール。
6. **検証ツール**: OpenAPI仕様の検証やLintingのためのツール。
7. **セキュリティツール**: APIのセキュリティ検証やスキャンに役立つツール。
8. **コンバータ**: 他のAPIフォーマット（RAML、Swagger 1.2など）との相互変換を行うツール。

## References

- [Official](https://www.openapis.org/)
- [OpenAPI-Specification](https://github.com/OAI/OpenAPI-Specification)
- [Swagger](https://swagger.io/)
- [github.com/google/gnostic](https://github.com/google/gnostic)
  - A compiler for APIs described by the OpenAPI Specification with plugins for code generation and other API support tasks
  - [protoc-gen-openapi](https://github.com/google/gnostic/tree/main/cmd/protoc-gen-openapi)
