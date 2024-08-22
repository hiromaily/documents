# 配列

## PostgreSQL

- [PostgreSQL 16.3: 配列関数と演算子](https://www.postgresql.jp/document/16/html/functions-array.html)
- [PostgreSQL 16.3: 行と配列の比較](https://www.postgresql.jp/document/16/html/functions-comparisons.html)

### ANY/SOME

意味は同じでANYとSOMEのどちらを使ってもいいらしい

### ANY
```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT,
    categories TEXT[]
);

INSERT INTO products (name, categories)
VALUES
  ('Laptop', ARRAY['electronics', 'computers']),
  ('Tablet', ARRAY['electronics', 'mobile']),
  ('Desk', ARRAY['furniture', 'office']);

-- categoriesに、'electronics'が含まれるレコードを抽出
SELECT name, categories
  FROM products
  WHERE 'electronics' = ANY(categories);
```

#### SubQueryとしてArrayを使う場合

```sql
-- idの条件の範囲をArrayで指定
SELECT name
  FROM products
  WHERE id = ANY(ARRAY[1, 3, 5]);
```

### SOME

```sql
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title TEXT,
    genres TEXT[]
);

INSERT INTO books (title, genres)
VALUES
  ('The Great Gatsby', ARRAY['fiction', 'classic', 'novel']),
  ('To Kill a Mockingbird', ARRAY['fiction', 'classic', 'drama']),
  ('The Pragmatic Programmer', ARRAY['non-fiction', 'technology']),
  ('Clean Code', ARRAY['non-fiction', 'technology', 'programming']);

-- Arrayに`classic`が含まれているレコードが対象となる
SELECT title
  FROM books
  WHERE 'classic' = SOME(genres);
```
