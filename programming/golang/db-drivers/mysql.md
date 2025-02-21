# [go-sql-driver/mysql](https://github.com/go-sql-driver/mysql)

## 接続例

```go
   dsn := "user:password@tcp(127.0.0.1:3306)/dbname?charset=utf8&parseTime=True&loc=Local"
    
    db, err := sql.Open("mysql", dsn)
    if err != nil {
        log.Fatal(err)
    }
    defer db.Close()

    // 接続プールの設定
    db.SetMaxOpenConns(10) // 最大オープン接続数
    db.SetMaxIdleConns(5)  // 最大アイドル（待機）接続数
    db.SetConnMaxLifetime(0) // 接続の再利用制限時間（0は無制限）

    // テスト用に1つクエリを実行してみる
    err = db.Ping()
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Successfully connected to the database!")

    // ここで実際のデータベース操作を行う
    // 例えば、クエリを実行する
    rows, err := db.Query("SELECT id, name FROM your_table")
```

- **db.SetMaxOpenConns(n int)**:
  最大のオープン接続数を設定する。この数を超えると、新しい接続試行はブロックされるか、エラーが発生する
- **db.SetMaxIdleConns(n int)**:
  アイドル（待機状態）にできる最大接続数を設定します。この数を超えた余分な接続はクローズされる

## [mysql: DNS のパラメータについて](https://github.com/go-sql-driver/mysql/blob/00dc21a6243c02c1a84fc82d08a821c08fde4053/dsn.go#L61-L72)

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

### `useAffectedRows=true`の設定はできない？これはJDBC専用？

通常のMySQLの `UPDATE` 文では、影響を受けた行数を取得することができる。ただし、取得できる情報は、データベースのURL設定によって異なる。

1. **データベースURLに `useAffectedRows=true` が含まれない場合**:
   - 返される情報は **_適合行数** (Rows matched)、条件に合致する行数

2. **データベースURLに `useAffectedRows=true` が含まれる場合**:
   - 返される情報は **_影響行数** (Changed) 、影響を受けた行数

DNS例: `mysql://localhost:3306/dbname?useAffectedRows=true`
