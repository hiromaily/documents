# ビューの作成

複雑なクエリを簡略化するためにビューを作成する例

```sql
CREATE VIEW department_avg_salary AS
SELECT department, AVG(salary) as avg_salary
FROM employees
GROUP BY department;
```
