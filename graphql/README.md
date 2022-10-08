# GraphQL
GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data. GraphQL provides a complete and understandable description of the data in your API, gives clients the power to ask for exactly what they need and nothing more, makes it easier to evolve APIs over time, and enables powerful developer tools.

## References
- [Official](https://graphql.org/)
- [Schema-First vs Code-Only GraphQL](https://www.apollographql.com/blog/backend/architecture/schema-first-vs-code-only-graphql/)
- [Awesome-GraphQL](https://github.com/chentsulin/awesome-graphql)
- [Golang: gqlgen](https://github.com/99designs/gqlgen)
- [GraphQL APIの設計 by Shipify](https://github.com/Shopify/graphql-design-tutorial/blob/master/lang/TUTORIAL_JAPANESE.md)

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