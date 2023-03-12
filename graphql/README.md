# GraphQL
GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data. GraphQL provides a complete and understandable description of the data in your API, gives clients the power to ask for exactly what they need and nothing more, makes it easier to evolve APIs over time, and enables powerful developer tools.

## References
- [Official](https://graphql.org/)
- [Schema-First vs Code-Only GraphQL](https://www.apollographql.com/blog/backend/architecture/schema-first-vs-code-only-graphql/)
- [Awesome-GraphQL](https://github.com/chentsulin/awesome-graphql)
- [Principled GraphQL](https://principledgraphql.com/)
### Golang Library
- [GraphQL Go List](https://graphql.org/code/#go)
- [gqlgen](https://github.com/99designs/gqlgen): Star:8.7K
  - Schema-First by GraphQL schema definition language (schema.graphqls)
  - [Example: go-gqlgen-server](https://github.com/hiromaily/go-gqlgen-server)
  - [gqlgen-sqlboile](https://github.com/web-ridge/gqlgen-sqlboiler)
  - [Using GraphQL with Golang from APOLLO BLOG](https://www.apollographql.com/blog/graphql/golang/using-graphql-with-golang/)
- [graphql-go/graphql](https://github.com/graphql-go/graphql): Star:9.1K
  - code-first

### Others
- [GraphQL APIの設計 by Shipify](https://github.com/Shopify/graphql-design-tutorial/blob/master/lang/TUTORIAL_JAPANESE.md)
- [GraphQL実践ノウハウ/graphql-knowhow](https://speakerdeck.com/sonatard/graphql-knowhow)
- [GraphQLを徹底解説する記事](https://zenn.dev/nameless_sn/articles/graphql_tutorial)
- [Goで学ぶGraphQLサーバーサイド入門](https://zenn.dev/hsaki/books/golang-graphql)
- [【GraphQL】開発・学習で必ず確認するべきリポジトリ・ツール・Webサイト等 29](https://zenn.dev/nameless_sn/articles/awesome_gql_resources)

## 開発でやるべきこと
- GraphQLのスキーマを定義
- GraphQLサーバ
  - スキーマとデータソースを結びつける機能を持つリゾルバを実装する
- GraphQLクライアント
  - GraphQLクエリを実行

### [gqlgen](https://github.com/99designs/gqlgen)を使った開発
- これは、`Schema-First` となっている

- GraphQLのスキーマを定義
- スキーマからコード生成する
- GraphQLリゾルバなどを実装する

- [詳細](./gqlgen.md)
### Dataloader
- 複数のデータ取得リクエストを1つにまとめる機能を持つライブラリ
  - リクエストのKeyが重複しているとまとめてくれる
  - レスポンスをキャッシュしてくれる
  - 
- Golang
  - [graph-gophers/dataloader](https://github.com/graph-gophers/dataloader)
  - [vektah/dataloaden](https://github.com/vektah/dataloaden)
- Typescript including React
  - [Apollo Client](https://www.apollographql.com/docs/)
  - [Apollo Client for React](https://www.apollographql.com/docs/react/)
  - [Relay](https://relay.dev/)

## Databaseスキーマ情報から自動的にGraphQLエンドポイントを生成するツール

### [PostGraphile](https://www.graphile.org/postgraphile/)
- [github](https://github.com/graphile/postgraphile)
- [PostgreSQLからGraphQLサーバーを生成するPostgraphileを手元で動かしてみる](https://zenn.dev/adwd/articles/7c081b2f8a977f)
- 対応DB: PostgreSQL
- PostgreSQL サーバーのスキーマ情報を読み取って自動的に GraphQL サーバーを立ち上げる。Node.jsのHTTPサーバーに組み込まれている。
- 制約
  - Node.jsを使う必要がある

- [HASURA](https://hasura.io/)
  - [github](https://github.com/hasura/graphql-engine)
  - 対応DB: PostgreSQL, MS SQL Server,Big Query.
- [Prisma](https://www.prisma.io/)
  - Node.jsとTypescriptのためのORM