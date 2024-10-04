# Join操作

## 基本的なテーブルの結合

二つ以上のテーブルを結合するための SQL 文です。以下は内結合の例

```sql
SELECT a.name, b.order_id
FROM customers a
JOIN orders b
ON a.customer_id = b.customer_id;
```

## 結合の種類

SQLにおけるテーブルのJOINは、複数のテーブルからデータを結合して取得する方法

### 1. 内部結合 (INNER JOIN)

内部結合は、`指定した条件に一致する行のみが結合される`方法

```sql
SELECT a.name, b.order_id
FROM customers a
INNER JOIN orders b ON a.customer_id = b.customer_id;
```

### 2. 左外部結合 (LEFT JOIN)

左外部結合は、左側のテーブルの全ての行と、条件に一致する右側のテーブルの行を結合する。`一致しない場合、右側の列の値はNULL`になる。

```sql
SELECT a.name, b.order_id
FROM customers a
LEFT JOIN orders b ON a.customer_id = b.customer_id;
```

### 3. 右外部結合 (RIGHT JOIN)

右外部結合は、右側のテーブルの全ての行と、条件に一致する左側のテーブルの行を結合します。`一致しない場合、左側の列の値はNULL`になる。

```sql
SELECT a.name, b.order_id
FROM customers a
RIGHT JOIN orders b ON a.customer_id = b.customer_id;
```

### 4. 完全外部結合 (FULL JOIN)

完全外部結合は、条件に一致する行をすべて結合し、`不一致の左および右のテーブルのすべての行を取得`する。一致しない場合、欠けている側の列の値はNULLになる。

```sql
SELECT a.name, b.order_id
FROM customers a
FULL JOIN orders b ON a.customer_id = b.customer_id;
```

### 5. 自己結合 (SELF JOIN)

自己結合は、`同じテーブル同士を結合する方法`。これを使用して、テーブル内の関連データを比較できる。

```sql
SELECT a.employee_id, a.name as manager_name, b.name as employee_name
FROM employees a
INNER JOIN employees b ON a.employee_id = b.manager_id;
```

### 6. クロス結合 (CROSS JOIN)

クロス結合は、指定した条件に依存しない全ての行の組み合わせを生成する。すべての行のデカルト積を作成する。

```sql
SELECT a.name, b.order_id
FROM customers a
CROSS JOIN orders b;
```

### 7. ナチュラル結合 (NATURAL JOIN)

ナチュラル結合は、両方のテーブルに共通するすべての列に基づいて結合を行う。一般的には明示的に使用することは少ない。

```sql
SELECT a.name, b.order_id
FROM customers a
NATURAL JOIN orders b;
```

### 8. 半結合 (SEMI JOIN) と反結合 (ANTI JOIN)

SQL標準としては提供されていないが、PostgreSQLなどでは半結合と反結合として、データをフィルターするためにサブクエリを使うことができる。

#### 半結合 (SEMI JOIN)

```sql
SELECT a.name
FROM customers a
WHERE EXISTS (SELECT 1 FROM orders b WHERE a.customer_id = b.customer_id);
```

#### 反結合 (ANTI JOIN)

```sql
SELECT a.name
FROM customers a
WHERE NOT EXISTS (SELECT 1 FROM orders b WHERE a.customer_id = b.customer_id);
```
