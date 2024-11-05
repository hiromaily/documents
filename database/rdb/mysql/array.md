# MySQLの配列型

PostgreSQL から乗り換えたときに注意すべきこととして、配列型は存在しないので注意が必要

以下は不可能

```sql
expected_date_list TIMESTAMP[] NULL COMMENT '予約希望日リスト',
```

JSON 型を利用する場合

```sql
expected_date_list JSON NULL COMMENT '予約希望日リスト',
```
