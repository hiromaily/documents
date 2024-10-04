# パフォーマンスチューニング

## EXPLAIN コマンドの使用

クエリの実行計画を確認し、パフォーマンスを最適化するための情報を得る例

```sql
EXPLAIN ANALYZE SELECT * FROM mytable WHERE id = 1;
```
