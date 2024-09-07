# Generator from DB Schema

## Database スキーマ情報から自動的に GraphQL エンドポイントを生成するツール

### [PostGraphile](https://www.graphile.org/postgraphile/)

- [github](https://github.com/graphile/postgraphile)
- [PostgreSQL から GraphQL サーバーを生成する Postgraphile を手元で動かしてみる](https://zenn.dev/adwd/articles/7c081b2f8a977f)
- 対応 DB: PostgreSQL
- PostgreSQL サーバーのスキーマ情報を読み取って自動的に GraphQL サーバーを立ち上げる。Node.js の HTTP サーバーに組み込まれている。
- 制約

  - Node.js を使う必要がある

- [HASURA](https://hasura.io/)
  - [github](https://github.com/hasura/graphql-engine)
  - 対応 DB: PostgreSQL, MS SQL Server,Big Query.
- [Prisma](https://www.prisma.io/)
  - Node.js と Typescript のための ORM
