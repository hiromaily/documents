# 拡張 (Extensions)

PostgreSQL は様々な拡張機能が提供されており、それらを使用して標準機能を拡張することができます。

## 拡張のインストール

PostgreSQL に拡張をインストールする例です。

```sql
-- 例: PostGIS (地理空間データベース)
CREATE EXTENSION postgis;
```

## 使用可能な拡張の一覧表示

```sql
-- 使用可能な拡張のリストを表示
SELECT * FROM pg_available_extensions;
```
