# MySQL

## MySQL 8.0 と 5.7 の違い

### メリット

#### [GTID-based レプリケーションにおける制限の緩和](https://dev.mysql.com/doc/refman/8.0/en/replication-gtids-restrictions.html)

- 5.7 では、`CREATE TEMPORARY TABLE`や`CREATE TABLE ... SELECT`ステートメントを使っている場合、レプリケーション構成では使用できなかった
  - 8.0.21 で、利用可能に

##### GTID (Global Transaction ID)について

- 各トランザクションに与えられた一意識別子
