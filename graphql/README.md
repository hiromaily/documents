# GraphQL

- GraphQL は、API のためのクエリ言語であり、既存のデータでこれらのクエリを実行するためのランタイム
- GraphQL は、API 内のデータについて完全で理解しやすい説明を提供し、クライアントに必要なものだけを要求する力を与え、時間の経過とともに API を進化させることを容易にし、強力な開発者ツールを可能にする

## 特徴

- Overfetch/Underfetch の解消
- スキーマ駆動開発
  - GraphQL Schema の定義に従い、静的解析が可能で Linter を作ることができる
- Graph 構造を活かした設計にする。複数の Query が必要な設計にしない
- Front-end 側で受け取った型を変換するということは期待しない

## コンポーネント

- Front-end ... Query
- Server-side ... Resolver(Handler)とその裏の Logic

## 開発でやるべきこと

- GraphQL のスキーマを定義
- GraphQL サーバ
  - スキーマとデータソースを結びつける機能を持つリゾルバを実装する
- GraphQL クライアント
  - GraphQL クエリを実行

## WIP:Schema 設計 (最重要)

- Query と Mutation で Schema 設計のポイントが異なる
- Role
- オブジェクト毎のクエリーを用意しないことが一般的で代わりに node クエリーを用意する
  - ただし、ID からどのオブジェクトかを判別できる必要がある
  - node というフィールドになることを避けるために、`alias`を使う
- `Relay`の GraphQL 　 Server Specification とは？
- Mutation における Cache の更新？GraphQL キャッシュ
- Scalar？
- directive の活用

## [GraphQL Code Generator](https://the-guild.dev/graphql/codegen)

- [github](https://github.com/dotansimha/graphql-code-generator)
- [GraphQL Code Generator ってどんなコードを生成してくれるの？](https://qiita.com/kyntk/items/624f9b340e813844a292)
- GraphQL schema からコードを生成するためのもので、React の Hook など Front-end のコンポーネント生成に役立つ
- Back-end の生成も可能だが Golang には対応していない

## References

- [Official](https://graphql.org/)
- [Schema-First vs Code-Only GraphQL](https://www.apollographql.com/blog/backend/architecture/schema-first-vs-code-only-graphql/)
- [Awesome-GraphQL](https://github.com/chentsulin/awesome-graphql)
- [Principled GraphQL](https://principledgraphql.com/)
- [GraphQL Best Practices](https://graphql.org/learn/best-practices/)
