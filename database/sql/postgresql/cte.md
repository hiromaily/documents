# 共通テーブル式 (CTE: Common Table Expressions)

再利用可能なサブクエリの結果を定義するための WITH 句を使用した例です。

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
