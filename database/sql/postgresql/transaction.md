# トランザクション

トランザクション制御文を使用して、複数の操作を一つの単位として実行する例

```sql
BEGIN;

INSERT INTO accounts (user_id, balance) VALUES (1, 1000);
UPDATE accounts SET balance = balance - 100 WHERE user_id = 1;

COMMIT;
```
