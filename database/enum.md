# ENUM 列挙型 

データ型として利用できるが、[サーティーワンフレーバー](./anti-patterns.md)にある通りアンチパターンであり、ENUMは変更が入らない確証が得られる場合のみの利用に留めたほうがよい。しかし、変更が発生すると、どのようになるのか？


## PostgreSQL

### Enumの作成 (PostgreSQLを想定)

```sql
CREATE TYPE fruit AS ENUM ('apple', 'orange', 'strawberry');
```

### 削除

```sql
DROP TYPE fruit;
```

`利用されている場合は、削除できない`

### 列挙値の確認

```sql
SELECT
  pg_namespace.nspname
  , pg_type.typname
  , pg_enum.enumsortorder
  , pg_enum.enumlabel
FROM
  pg_type
  INNER JOIN pg_enum
    ON (pg_type.oid = pg_enum.enumtypid)
  INNER JOIN pg_namespace
    ON (pg_type.typnamespace = pg_namespace.oid)
WHERE
  pg_type.typtype = 'e'
ORDER BY
  pg_namespace.nspname
  , pg_type.typname
  , pg_enum.enumsortorder
  , pg_enum.enumlabel;
```

非常に複雑なqueryが必要になる

### 値の追加

```sql
ALTER TYPE fruit ADD VALUE 'grape';

ALTER TYPE fruit ADD VALUE 'grape' BEFORE 'orange';
```

### 値の名前変更

```sql
ALTER TYPE job_status RENAME VALUE 'pending' TO 'suspended';
```

`気をつけるべきは、既存の入力の全てに影響を与えることになる`

### 値の削除

`値を削除する方法はなく、列挙型自体の作り直しが必要になる`

### 列挙型作り直す方法

1. 古い列挙型の名前を変更
2. 同じ名前で新しい列挙型を作成
3. 古い列挙型を利用していたテーブルのカラムのデータ型を新しい列挙型に変更
4. 古い列挙型を削除

上記のようにクエリが複雑になる

## MySQL

- 内部的には整数として保持される
- ENUM型を独立して定義できず、テーブルに紐づけられる

```sql
CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  price ENUM('cheap', 'reasonable', 'expensive')
);
```