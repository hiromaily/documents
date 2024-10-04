# DB Drivers

## [go-sql-driver/mysql](https://github.com/go-sql-driver/mysql)

### [mysql: DNS のパラメータについて](https://github.com/go-sql-driver/mysql/blob/00dc21a6243c02c1a84fc82d08a821c08fde4053/dsn.go#L61-L72)

```go
  AllowAllFiles            bool // Allow all files to be used with LOAD DATA LOCAL INFILE
  AllowCleartextPasswords  bool // Allows the cleartext client side plugin
  AllowFallbackToPlaintext bool // Allows fallback to unencrypted connection if server does not support TLS
  AllowNativePasswords     bool // Allows the native password authentication method
  AllowOldPasswords        bool // Allows the old insecure password method
  CheckConnLiveness        bool // Check connections for liveness before using them
  ClientFoundRows          bool // Return number of matching rows instead of rows changed
  ColumnsWithAlias         bool // Prepend table alias to column names
  InterpolateParams        bool // Interpolate placeholders into query string
  MultiStatements          bool // Allow multiple statements in one query
  ParseTime                bool // Parse time values to time.Time
  RejectReadOnly           bool // Reject read-only connections
```

```go
dsn := "username:password@tcp(127.0.0.1:3306)/mydb?allowAllFiles=true&parseTime=true"
```

1. **AllowAllFiles**

   - `LOAD DATA LOCAL INFILE` を使用して、どのファイルでもデータベースサーバにアップロードすることを許可する
   - **デフォルト:** `false`

2. **AllowCleartextPasswords**

   - クリアテキスト（平文）のパスワードをクライアント側プラグインで使用することを許可する
   - **デフォルト:** `false`

3. **AllowFallbackToPlaintext**

   - サーバが TLS をサポートしていない場合に、暗号化されていない接続にフォールバックすることを許可する
   - **デフォルト:** `false`

4. **AllowNativePasswords**

   - ネイティブパスワード認証方法を許可します。MySQL のデフォルトのパスワード認証方式を使用する
   - **デフォルト:** `true`

5. **AllowOldPasswords**

   - 古い、安全性が低いパスワード認証方法（MySQL 4.1 以前で使用されたもの）を許可する
   - **デフォルト:** `false`

6. **CheckConnLiveness**

   - 接続を使用する前に、その接続が生きているかどうかを確認する。これにより、使われる前に接続が有効かどうかをチェックする
   - **デフォルト:** `false`

7. **ClientFoundRows**

   - 変更された行数ではなく、一致した行数を返す。通常、行が変更された場合のみカウントされるが、このオプションを有効にすると、検索された全ての行をカウントする。
   - **デフォルト:** `false`

8. **ColumnsWithAlias**

   - カラム名にテーブルエイリアスを前置する。クエリ結果のカラム名にエイリアスを含めるかどうかを指定する。
   - **デフォルト:** `false`

9. **InterpolateParams**

   - プレースホルダをクエリ文字列に挿入する。SQL 文のプレースホルダ（例えば `?` や `:param`）を SQL 文字列内に直接挿入する。
   - **デフォルト:** `false`

10. **MultiStatements**

    - 一つのクエリに複数のステートメントを含めることを許可する。これにより、セミコロン（;）で区切られた複数のステートメントを一度に実行できる。
    - **デフォルト:** `false`

11. **ParseTime**

    - 時間の値を `time.Time` 型に解析する。これにより、データベースから取得した日時情報を `time.Time` 形式に変換する。
    - **デフォルト:** `false`

12. **RejectReadOnly**
    - 読み取り専用接続を拒否する。読み取り専用の接続をエラーとして処理する。
    - **デフォルト:** `false`

## [lib/pq](https://github.com/lib/pq)

### postgresql: DNS のパラメータについて

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

## [jackc/pgx](https://github.com/jackc/pgx)）

`pgx`は特に高性能な操作や追加のカスタマイズが必要な場合にお勧め

適切なドライバとパラメータ設定を選ぶことは、アプリケーションのニーズとセキュリティ要件に基づいて行うべき
