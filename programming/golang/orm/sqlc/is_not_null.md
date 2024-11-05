# IS NOT NULL

- [sql.NullString is used when field is filtered with is not null](https://github.com/sqlc-dev/sqlc/issues/2723)

例えば、以下のようなSQLを用意し、Where句に`IS NOT NULL`を条件に追加したカラムをSelectする

```sql
SELECT sa.id as sms_auth_id, sa.sid 
FROM sms_auth sa 
WHERE sa.status = 'sending'
  AND sa.sid IS NOT NULL
ORDER BY sa.id ASC
```

`IS NOT NULL`は考慮されず、出力されるModelは`sql.NullString`を含むことになる

```go
type GetSMSStatusSendingRow struct {
  SmsAuthID string
  Sid       sql.NullString
}
```

本来期待するModelは以下のような構造となる

```go
type SMSAuth struct {
  SMSAuthID string
  SID       string
}
```
