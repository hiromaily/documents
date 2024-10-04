# データのインポートとエクスポート

## データのインポート

CSV ファイルからデータをインポートする例です。

```sql
COPY mytable FROM '/path/to/data.csv' WITH CSV HEADER;
```

## データのエクスポート

テーブルのデータを CSV ファイルにエクスポートする例です。

```sql
COPY mytable TO '/path/to/output.csv' WITH CSV HEADER;
```
