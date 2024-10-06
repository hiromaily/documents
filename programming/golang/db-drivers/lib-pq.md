# [lib/pq](https://github.com/lib/pq)

## postgresql: DNS のパラメータについて

```go
dsn := "user=username password=password dbname=mydb host=127.0.0.1 port=5432 sslmode=disable"
db, err := sql.Open("postgres", dsn)
```

1. **dbname**

   - 接続するデータベース名

2. **user**

   - データベースに接続するユーザー名

3. **password**

   - データベースに接続するユーザーのパスワード

4. **host**

   - 接続先のホスト名。デフォルトは`localhost`

5. **port**

   - 接続先のポート番号。デフォルトは`5432`

6. **sslmode**

   - SSL 接続のモード。以下のいずれか：
     - `disable`：SSL を使用しない。
     - `require`：SSL を必須とするが不正な証明書も許可。
     - `verify-ca`：SSL を必須とし、CA 証明書を検証。
     - `verify-full`：SSL を必須とし、CA 証明書およびホスト名を検証。

7. **connect_timeout**

   - 接続のタイムアウト時間（秒）

8. **fallback_application_name**

   - プライマリの`application_name`を提供できない場合のフォールバックアプリケーション名

9. **application_name**

   - Application Name を指定。PostgreSQL のログなどで識別される

10. **sslcert**

    - クライアント証明書のファイル名

11. **sslkey**

    - クライアントの秘密鍵のファイル名

12. **sslrootcert**
    - 信頼する CA 証明書のファイル名（`verify-ca` または `verify-full` モードで必要）
