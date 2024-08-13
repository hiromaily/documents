# Migration Tools

## SQL-based

- Flyway (Java)
- Liquibase (Java)
- Alembic (Python)
- Diesel (Rust)

## ORM-based Migration Tools

- Django Migrations (Python)
- Sequelize (JavaScript/TypeScript (Node.js))

## Cloud-based

- AWS Database Migration Service (DMS)
- Google Cloud Database Migration Service
- Azure Database Migration Service

## Golang based

- [migrate](https://github.com/golang-migrate/migrate)
- [atlas](https://atlasgo.io/)
- [goose](https://github.com/pressly/goose)
- [sql-migrate](https://github.com/rubenv/sql-migrate)

### [atlas](https://atlasgo.io/)

- [Docs](https://atlasgo.io/getting-started)
- [ent. バージョン管理型マイグレーション](https://entgo.io/ja/docs/versioned-migrations/)
- [Explorer](https://gh.atlasgo.cloud/explore)

Atlas は、最新の DevOps 原則を使用してデータベース スキーマを管理および移行するための言語に依存しないツールであり、次の 2 つのワークフローが用意されている。

宣言型
Terraform と同様に、Atlas はデータベースの現在の状態を、HCL、SQL、または ORM スキーマで定義された目的の状態と比較し、移行計画を生成して実行し、データベースを目的の状態に移行する

バージョン管理
他のツールとは異なり、Atlas はスキーマ移行を自動的に計画する。ユーザーは、目的のデータベース スキーマを HCL、SQL、または選択した ORM で記述でき、Atlas を利用することで、データベースに必要な移行を計画、リンティング、適用できる

#### atlas references

- [Go製モダンマイグレーションツールのAtlasを使用してみた](https://zenn.dev/jy8752/articles/f9fda2379b57f5)
- [GoのAtlasとBunを使ったマイグレーション環境を構築する](https://techblog.enechain.com/entry/bun-atlas-migration-setup-guide)

## Javascript/Typescript based

[ORM](../nodejs/orm/README.md)

- [Sequelize](https://www.npmjs.com/package/sequelize)
- [typeorm](https://www.npmjs.com/package/typeorm)
- [Prisma](https://www.prisma.io/)
- [knex](https://www.npmjs.com/package/knex)
- [Umzug](https://www.npmjs.com/package/umzug)
