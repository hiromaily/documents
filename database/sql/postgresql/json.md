# JSON の操作

## JSON データの操作

PostgreSQL は JSON データ型をサポートしており、JSON データの保存や操作が可能

```sql
-- テーブルにJSONデータを挿入
CREATE TABLE myjson (
    data JSONB
);

INSERT INTO myjson (data) VALUES ('{"name": "John", "age": 30}');
```

## JSON データのクエリ

JSON データの特定のフィールドを取得する例

```sql
SELECT data->>'name' as name, data->>'age' as age FROM myjson;
```
