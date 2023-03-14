# GraphQL
- GraphQL は、API のためのクエリ言語であり、既存のデータでこれらのクエリを実行するためのランタイム
- GraphQL は、API 内のデータについて完全で理解しやすい説明を提供し、クライアントに必要なものだけを要求する力を与え、時間の経過とともに API を進化させることを容易にし、強力な開発者ツールを可能にする

## 特徴
- Overfetch/Underfetchの解消
- スキーマ駆動開発
  - GraphQL Schemaの定義に従い、静的解析が可能でLinterを作ることができる
- Graph構造を活かした設計にする。複数のQueryが必要な設計にしない
- Front-end側で受け取った型を変換するということは期待しない
### コンポーネント
- Front-end ... Query
- Server-side ... Resolver(Handler)とその裏のLogic
## References
- [Official](https://graphql.org/)
- [Schema-First vs Code-Only GraphQL](https://www.apollographql.com/blog/backend/architecture/schema-first-vs-code-only-graphql/)
- [Awesome-GraphQL](https://github.com/chentsulin/awesome-graphql)
- [Principled GraphQL](https://principledgraphql.com/)
- [GraphQL Best Practices](https://graphql.org/learn/best-practices/)

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

## WIP:Schema設計 (最重要)
- QueryとMutationでSchema設計のポイントが異なる
- Role
- オブジェクト毎のクエリーを用意しないことが一般的で代わりにnodeクエリーを用意する
  - ただし、IDからどのオブジェクトかを判別できる必要がある
  - nodeというフィールドになることを避けるために、`alias`を使う
- `Relay`のGraphQL　Server Specificationとは？
- MutationにおけるCacheの更新？GraphQLキャッシュ
- Scalar？
- directiveの活用
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

## [GraphQL Code Generator](https://the-guild.dev/graphql/codegen)
- [github](https://github.com/dotansimha/graphql-code-generator)
- [GraphQL Code Generatorってどんなコードを生成してくれるの？](https://qiita.com/kyntk/items/624f9b340e813844a292)
- GraphQL schema からコードを生成するためのもので、ReactのHookなどFront-endのコンポーネント生成に役立つ
- Back-endの生成も可能だがGolangには対応していない
