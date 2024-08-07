# DB設計

- Entity Relationship Diagram (ER図)
- DDL (Data Definition Language)

SQLにおける`DDL`には、データベースやテーブル、ビューなどの作成を行う`CREATE文`や、これらを削除する`DROP文`、これらの設定や構成に変更を加える`ALTER文`、テーブル中のデータを全削除する`TRUNCATE文`が含まれる

## Design Tool

### 無償
- [pgAdmin](https://www.pgadmin.org/) for PostgreSQL
- [DBeaver](https://dbeaver.io/)
- [Mermaid](https://mermaid.js.org/syntax/entityRelationshipDiagram.html)
  - [Entity Relationship Diagrams](https://mermaid.js.org/syntax/entityRelationshipDiagram.html)
  - [Mermaid with ChatGPT](https://www.mermaidchart.com/landing)
- [PlantUML](https://plantuml.com/ja-dark/ie-diagram)
- [draw.io](https://app.diagrams.net/)
  - クラス図
  - フローチャート
  - 組織図
  - スイムレーン
  - ER図
  - シーケンス図
- [SchemaSpy](https://schemaspy.org/)

### 有償
- [atlas](https://atlasgo.io/)
  - manage your database schema as code
  - Freeプランもある
- [DataGrip](https://www.jetbrains.com/ja-jp/datagrip/) by JetBrains
  - 有償
- [dbdiagram.io](https://dbdiagram.io/home)
  - Freeプランはかなり限定的
- [DbVisualizer](https://www.dbvis.com/)
  - 有償

## pgAdminによるDDL作成

[Creating Databases, Schemas, and Tables on pgAdmin](https://www.youtube.com/watch?v=6DzCWzeVFD0)

![pgadmin gui](../images/pgadmin4-create-table.png "pgadmin gui")




## [atlas](https://atlasgo.io/)

マイグレーションツール

- [Docs](https://atlasgo.io/getting-started)
- [ent. バージョン管理型マイグレーション](https://entgo.io/ja/docs/versioned-migrations/)
- [Explorer](https://gh.atlasgo.cloud/explore)

Atlas は、最新の DevOps 原則を使用してデータベース スキーマを管理および移行するための言語に依存しないツールであり、次の 2 つのワークフローが用意されている。

宣言型
Terraform と同様に、Atlas はデータベースの現在の状態を、HCL、SQL、または ORM スキーマで定義された目的の状態と比較し、移行計画を生成して実行し、データベースを目的の状態に移行する

バージョン管理
他のツールとは異なり、Atlas はスキーマ移行を自動的に計画する。ユーザーは、目的のデータベース スキーマを HCL、SQL、または選択した ORM で記述でき、Atlas を利用することで、データベースに必要な移行を計画、リンティング、適用できる

### atlas references

- [Go製モダンマイグレーションツールのAtlasを使用してみた](https://zenn.dev/jy8752/articles/f9fda2379b57f5)
- [GoのAtlasとBunを使ったマイグレーション環境を構築する](https://techblog.enechain.com/entry/bun-atlas-migration-setup-guide)

