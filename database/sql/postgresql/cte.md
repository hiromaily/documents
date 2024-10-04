# 共通テーブル式 (CTE: Common Table Expressions)

CTE (Common Table Expressions)は、複雑なクエリを簡潔に書くためのSQL機能。CTEを使うことで、再利用可能なサブクエリ（仮想表）を名前付きで定義し、メインのクエリで利用できる。これにより、可読性と理解しやすさが向上し、また自己参照や再帰的な操作を簡単に実装することができる。
CTEは、複雑なデータ操作や階層構造を扱う場合にとても有用な機能であり、PostgreSQL含む多くのRDBMSでサポートされている。

以下は、PostgreSQLを例に取って、CTEの使用方法や具体例

## 基本的なCTEの構文

CTEは`WITH`キーワードを使って定義する

```sql
WITH cte_name AS (
    -- サブクエリ
    SELECT ...
)
SELECT ...
FROM cte_name;
```

## 単純なサブクエリ

以下の例では、`employees`テーブルから年収が高い社員を一時的なテーブルとして取得し、最終クエリで使用する

```sql
WITH HighSalaryEmployees AS (
    SELECT id, name, salary
    FROM employees
    WHERE salary > 50000
)
SELECT *
FROM HighSalaryEmployees;
```

部署毎に平均のサラリーを抽出したテーブルを利用するケース

```sql
WITH DepartmentSalary AS (
    SELECT department, AVG(salary) as avg_salary
    FROM employees
    GROUP BY department
)
SELECT e.name, e.department, e.salary, ds.avg_salary
FROM employees e
JOIN DepartmentSalary ds ON e.department = ds.department;
```

## 再帰的CTE

再帰的CTEは、`自己参照`や`階層的なデータ操作を行う際`に使用する。再帰的CTEは、`アンカークエリ部分`と`再帰部分`で構成される

### 組織ツリーの再帰的CTEの例

以下の例では、`employees`テーブルを使用して、あるマネージャーの下にある全ての部下を再帰的に取得する

```sql
WITH RECURSIVE EmployeeHierarchy AS (
    -- アンカークエリ（ベースクエリ）
    SELECT id, name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- 再帰パート
    SELECT e.id, e.name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN EmployeeHierarchy eh ON e.manager_id = eh.id
)
SELECT *
FROM EmployeeHierarchy;
```

## 複数のCTE

複数のCTEを同時に定義することも可能。CTEをカンマで区切って複数定義し、それぞれのCTEを後続のCTEまたはメインクエリで使用できる

### 複数のCTEの使用の例

以下の例では、二つのCTEを定義し、それらを結合して最終的なクエリを実行する

```sql
WITH SalesCTE AS (
    SELECT salesperson_id, SUM(amount) AS total_sales
    FROM sales
    GROUP BY salesperson_id
),
RewardsCTE AS (
    SELECT salesperson_id, reward_points
    FROM rewards
)
SELECT s.salesperson_id, s.total_sales, r.reward_points
FROM SalesCTE s
JOIN RewardsCTE r ON s.salesperson_id = r.salesperson_id;
```

## CTEを利用したデータの更新

CTEを使って一時的な結果セットを作成した後、その結果を用いてデータを更新することも可能

### 複雑な条件でデータを更新する例

```sql
WITH BonusEligible AS (
    SELECT id
    FROM employees
    WHERE performance_rating > 8
)
UPDATE employees
SET bonus = 1000
WHERE id IN (SELECT id FROM BonusEligible);
```

## 特徴と利点

1. **可読性の向上**:
   複雑なクエリを読みやすい部分に分けることで、SQLの可読性が向上する

2. **再利用性**:
   同じサブクエリを複数回使用する場合に、CTEを使って再利用することでクエリが簡潔になる

3. **再帰的クエリ**:
   再帰的CTEを使うことで、階層的なデータ（例: 組織構造やフォルダツリー）のクエリが簡単になる

4. **一時的な中間結果**:
   一時的な中間結果を作成し、それを元に更に複雑なクエリを組み立てる際に便利

5. **トランザクションのサポート**:
   CTEはトランザクション内でも使用できるため、複数のステップを含む操作を一回のクエリで実行することが容易
