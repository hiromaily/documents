# SQL

## データ操作

### データの挿入

新しいレコードをテーブルに挿入するための SQL 文です。

```sql
INSERT INTO mytable (name, age, email) VALUES ('John Doe', 30, 'john.doe@example.com');
```

### データの更新

既存のレコードを更新するための SQL 文です。

```sql
UPDATE mytable SET age = 31 WHERE name = 'John Doe';
```

### データの削除

既存のレコードを削除するための SQL 文です。

```sql
DELETE FROM mytable WHERE name = 'John Doe';
```

## データのクエリ

### データの選択

テーブルからデータを選択するための SQL 文です。

```sql
SELECT * FROM mytable;
```

特定の列を選択する場合は、以下のように指定します。

```sql
SELECT name, age FROM mytable;
```

### フィルター付きデータの選択

特定の条件を満たすレコードを選択するための SQL 文です。

```sql
SELECT * FROM mytable WHERE age > 25;
```

### データの整列

特定の列を基準にデータを並び替えるための SQL 文です。

```sql
SELECT * FROM mytable ORDER BY age DESC;
```

### データの集計

データを集計するための SQL 文です。

```sql
SELECT COUNT(*), AVG(age) FROM mytable;
```

### グループ化

特定の列に基づいてデータをグループ化し、集計関数と一緒に使用する例です。

```sql
SELECT department, COUNT(*), AVG(salary)
FROM employees
GROUP BY department;
```

### 条件付きグループ化

HAVING 句を使用して、グループ化されたデータに対して条件を追加する例です。

```sql
SELECT department, COUNT(*), AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;
```

### サブクエリ

サブクエリを使用して、別のクエリの結果セットに基づいてデータを取得する例です。

```sql
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

## 特定機能の使用

### ウィンドウ関数

ウィンドウ関数を使用して、クエリ内の行ごとの集計を取得する例です。

```sql
SELECT name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) as rank
FROM employees;
```

### 変更データの取得 (ヒストリカルデータ)

#### システムカラムを用いて変更データを取得

PostgreSQL には特定のシステムカラムがあり、レコードの挿入や更新の履歴を追跡するために使用できます。

```sql
-- xminカラムを使用
SELECT xmin, * FROM mytable;

-- ctidカラムを使用
SELECT ctid, * FROM mytable;

-- xminとctidの差を比較
SELECT xmin::text::bigint - ctid::text::bigint, * FROM mytable;
```
