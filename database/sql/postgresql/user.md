# ユーザーと権限管理

## 新しいユーザーの作成

新しいデータベースユーザーを作成する例です。

```sql
CREATE USER newuser WITH PASSWORD 'password';
```

## 権限の付与

特定のテーブルに対してアクセス権を付与する例です。

```sql
GRANT SELECT, INSERT ON mytable TO newuser;
```

## 権限の取り消し

特定のテーブルに対してアクセス権を取り消す例です。

```sql
REVOKE INSERT ON mytable FROM newuser;
```
