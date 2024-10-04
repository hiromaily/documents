# データのインポートとエクスポート

## データのインポート

CSV ファイルからデータをインポートする例

```sql
COPY mytable FROM '/path/to/data.csv' WITH CSV HEADER;
```

## データのエクスポート

テーブルのデータを CSV ファイルにエクスポートする例

```sql
COPY mytable TO '/path/to/output.csv' WITH CSV HEADER;
```
