# Generator from DB Schema

Database スキーマ情報から自動的に GraphQL エンドポイントを生成するツールやサービスを利用することで、データベーススキーマから自動的にGraphQLエンドポイントを生成できる。プロジェクトの要件に応じて、適切なツールを選定すると良い。例えば、`PostgreSQL`を使っていれば`Hasura`や`PostGraphile`が非常に便利だし、異種混合のデータソースを統合したい場合は`GraphQL Mesh`や`StepZen`が有力な選択肢となる。Prismaは特にTypeScriptおよびNode.jsとの親和性が高く、広範なサポートを提供している。

## [Hasura](https://hasura.io/)

**Hasura**は、PostgreSQLデータベースからリアルタイムGraphQLエンドポイントを自動生成するオープンソースのGraphQLエンジン。

* **特徴**:
  * 自動生成されたGraphQLスキーマ。
  * リアルタイムのデータ同期機能（サブスクリプション）。
  * 強力な認証とアクセスコントロール。
  * Web UIでデータベースの管理やGraphQLクエリのテストが可能。

## [Prisma](https://www.prisma.io/)

**Prisma**は、モダンなデータベースORMで、GraphQLサーバーとの統合が非常にスムーズ。

* **特徴**:
  * TypeScriptおよびGraphQLエコシステムとの深い統合。
  * データベーススキーマから自動的にTypeScript型を生成。
  * ミューテーションやクエリを簡単に作成可能なPrisma Clientを提供。

## [GraphQL Mesh](https://www.graphql-mesh.com/)

**GraphQL Mesh**は、異なるデータソース（REST API, SOAP, gRPC, DBなど）をGraphQLエンドポイントに統合するツール。

* **特徴**:
  * 異種混合のデータソースをGraphQLとして統合可能。
  * 各種データベース（PostgreSQL, MySQL, SQLite, MongoDBなど）からスキーマを生成。
  * プラグインシステムで柔軟なカスタマイズが可能。

## [PostGraphile](https://www.graphile.org/postgraphile/)

**PostGraphile**は、PostgreSQLスキーマから自動的にGraphQL APIを生成するツール。

* **特徴**:
  * PostgreSQLデータベースから即座にGraphQLスキーマを生成。
  * 高度なフィルタリングやページネーションサポート。
  * カスタムリゾルバーやカスタムスキーマの拡張が可能。

## [Graphback](https://graphback.dev/)

**Graphback**は、ビジネスアプリケーション向けにCRUD操作を簡単にするためのフレームワーク。

* **特徴**:
  * GraphQLスキーマから自動的にCRUDリゾルバーやデータベーススキーマを生成。
  * オフラインファーストのデータ同期機能。
  * 並べ替えやフィルタリング機能がデフォルトで組み込まれている。

## [StepZen](https://stepzen.com/)

**StepZen**は、REST API、データベース、GraphQLサーバーなどのさまざまなデータソースを統合するためのGraphQLエンドポイントを簡単に作成するサービス。

* **特徴**:
  * 多様なデータソースからGraphQLスキーマを自動生成。
  * カスタムロジックを簡単に追加可能。
  * インタラクティブなWeb UIで設定管理。
