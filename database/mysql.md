# MySQL

## 行更新時に自動でupdated_atに現在時刻を設定する関数を定義する

- [TIMESTAMP および DATETIME の自動初期化および更新機能](https://dev.mysql.com/doc/refman/8.0/ja/timestamp-initialization.html)

## MySQL 8.0 と 5.7 の違い

### メリット

#### [GTID-based レプリケーションにおける制限の緩和](https://dev.mysql.com/doc/refman/8.0/en/replication-gtids-restrictions.html)

- `5.7` では、`CREATE TEMPORARY TABLE`や`CREATE TABLE ... SELECT`ステートメントを使っている場合、レプリケーション構成では使用できなかったが、`8.0.21` で、利用可能に

##### GTID (Global Transaction ID)について

- 各トランザクションに与えられた一意識別子

## GUI for MacOS

### [MySQL Workbench](https://www.mysql.com/products/workbench/)

Officially provided by MySQL, it offers a comprehensive set of tools for database design, development, and administration. It's feature-rich and widely used.

### [Sequel Pro](https://sequelpro.com/)

A lightweight, fast, and easy-to-use MySQL database management tool for macOS. It’s especially popular for its simplicity and ease of use, although it's no longer actively maintained.

- not maintained

### [TablePlus](https://tableplus.com/)

A modern, native application with a clean interface that supports multiple databases including MySQL. It offers a range of features like query editing, data management, and database structure visualization.

- 有償
- multiple databases

### [DBeaver](https://dbeaver.io/)

An open-source database tool that supports many databases including MySQL. It provides a powerful SQL editor, data visualization tools, and a user-friendly interface.

- open-source
- multiple databases

### [Navicat for MySQL](https://www.navicat.com/en/products/navicat-for-mysql)

A premium database development tool with a wide range of features for database management, development, and maintenance.

- 有償

### [HeidiSQL](https://www.heidisql.com/)

While originally for Windows, it can run on macOS using Wine or a similar compatibility layer. It’s a lightweight and feature-rich tool.

- free
- multiple databases
- windows only

## PostgreSQLから乗り換えたときに注意すべきこと

### 配列型は存在しないので注意が必要

これは不可能
```sql
expected_date_list TIMESTAMP[] NULL COMMENT '予約希望日リスト',
```

JSON型を利用する場合

```sql
expected_date_list JSON NULL COMMENT '予約希望日リスト',
```

### UUID型

- [MySQLでUUIDv4をプライマリキーにするとパフォーマンス問題が起きるのはなぜ？](https://zenn.dev/reiwatravel/articles/9ce1050bf8509b)
- [The Problem with Using a UUID Primary Key in MySQL](https://planetscale.com/blog/the-problem-with-using-a-uuid-primary-key-in-mysql)

## Problems

### MySQL接続時 `Public Key Retrieval is not allowed` エラー

ドライバの設定で、以下を修正する
```
allowPublicKeyRetrieval=true
```

