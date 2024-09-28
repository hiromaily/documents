# DB 設計

[参考: UML](../uml/README.md)

- Entity Relationship Diagram (ER 図)
- DDL (Data Definition Language)

SQL における`DDL`には、データベースやテーブル、ビューなどの作成を行う`CREATE文`や、これらを削除する`DROP文`、これらの設定や構成に変更を加える`ALTER文`、テーブル中のデータを全削除する`TRUNCATE文`が含まれる

## Design Tool

### 無償

- [pgAdmin](https://www.pgadmin.org/) for PostgreSQL
- [DBeaver](https://dbeaver.io/)
- [Mermaid](https://mermaid.js.org/syntax/entityRelationshipDiagram.html)
  - [Entity Relationship Diagrams](https://mermaid.js.org/syntax/entityRelationshipDiagram.html)
  - [Mermaid with ChatGPT](https://www.mermaidchart.com/landing)
- [PlantUML](https://plantuml.com/ja-dark/ie-diagram)
- [draw.io](https://app.diagrams.net/)
  - DDL や mermaid から生成することができるが、`mermaid記法` から生成したほうがクオリティーが高い
  - メニューの `[配置]-[挿入]-[高度な設定]`
- [SchemaSpy](https://schemaspy.org/)
  - これもよく使われており、良さげ
  - しかし、Java依存はあまりにダサすぎる
- [SQL DDL to ERD diagram](https://www.devtoolsdaily.com/sql/ddl-to-diagram/)

### 有償

- [dbdiagram.io](https://dbdiagram.io/home)
  - Free プランはかなり限定的だが、10 diagrams までは出力できる
- [atlas](https://atlasgo.io/)
  - manage your database schema as code
  - Free プランもある
- [DataGrip](https://www.jetbrains.com/ja-jp/datagrip/) by JetBrains
  - 有償
- [DbVisualizer](https://www.dbvis.com/)
  - 有償

## DDL から ER 図の自動生成ができるとよい

- Mermaid 記法による ER 図
  - DDL 作成後、ChatGPT から Mermaid を自動生成
  - NOT NULL が図に反映できない
- [dbdiagram.io](https://dbdiagram.io/home)
  - table 数が 10 まで
- [drawio with SQL plugin](https://www.drawio.com/doc/faq/sql-plugin)
  - `MySQL` or `SQL Server`
  - drawio の場合、`mermaid から変換`したほうがクオリティーが高い
- [atlas](https://atlasgo.io/)

### [dbdiagram.io](https://dbdiagram.io/home)

- [DBML - Database Markup Language](https://dbml.dbdiagram.io/home/)
- [Crafting an Automatic ERD Generator: A Journey from DDL to Diagram](https://devtoolsdaily.medium.com/crafting-an-automatic-erd-generator-a-journey-from-ddl-to-diagram-83cc5da8cab7) ... MySQL のみ

#### DBML の生成

DDL から DBML に変換する必要がある

- [dbml CLI](https://dbml.dbdiagram.io/cli)
- [ローカルにおける DB 品質管理の向上：dbml/cli、dbdocs、psqldef の活用](https://zenn.dev/coffee_break/articles/25a26cc7622e8c)

Install

```sh
npm install -g @dbml/cli
```

Convert a SQL file to DBML

```sh
sql2dbml sample_pg.sql --postgres
```

## pgAdmin による DDL 作成

[Creating Databases, Schemas, and Tables on pgAdmin](https://www.youtube.com/watch?v=6DzCWzeVFD0)

![pgadmin gui](../images/pgadmin4-create-table.png "pgadmin gui")
