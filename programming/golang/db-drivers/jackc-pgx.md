# [jackc/pgx](https://github.com/jackc/pgx)）

`github.com/jackc/pgx` は、Go 言語用の高性能な PostgreSQL ドライバおよびデータベース接続プール。このパッケージは、純粋な Go で書かれており、標準ライブラリの `database/sql` インターフェースを拡張した機能を提供する。

## 特長

1. **高性能**:

   - `jackc/pgx` は低レベルの PostgreSQL プロトコルを直接操作することで、高速なデータベース操作を実現している。

2. **カスタマイズ可能な接続プーリング**:

   - 接続プーリングの機能をネイティブにサポートしている。`pgx.ConnPool` を使うことで、効率的な接続管理が可能。

3. **トランザクション管理**:

   - トランザクションの開始、コミット、ロールバックがシンプルにできる。

4. **高度な PostgreSQL 機能**:

   - サーバーサイドカーソル、ユーザー定義型、トランザクション間隔ロギングなど、PostgreSQL 特有の機能をサポートしている。

5. **Bulkインサート**:

   - 大量のデータを効率的に一括挿入するためのヘルパー関数を提供している。

6. **シンプルな API 設計**:
   - 非常にシンプルかつ直感的な API 設計により、初学者から上級者まで使いやすい。

## インストール

```sh
go get github.com/jackc/pgx/v5
```

## 基本的な使い方

基本的な接続、クエリの実行方法のサンプル

```go
package main

import (
    "context"
    "fmt"
    "log"

    "github.com/jackc/pgx/v4"
)

func main() {
    conn, err := pgx.Connect(context.Background(), "postgres://username:password@localhost:5432/mydb")
    if err != nil {
        log.Fatalf("Unable to connect to database: %v\n", err)
    }
    defer conn.Close(context.Background())

    var greeting string
    err = conn.QueryRow(context.Background(), "SELECT 'Hello, world!'").Scan(&greeting)
    if err != nil {
        log.Fatalf("QueryRow failed: %v\n", err)
    }

    fmt.Println(greeting)
}
```

トランザクションの管理

```go
func transactionExample(conn *pgx.Conn) error {
    tx, err := conn.Begin(context.Background())
    if err != nil {
        return err
    }
    defer tx.Rollback(context.Background())

    _, err = tx.Exec(context.Background(), "INSERT INTO users(name) VALUES('john')")
    if err != nil {
        return err
    }

    return tx.Commit(context.Background())
}
```

接続プールを使う場合

```go
package main

import (
    "context"
    "log"
    "github.com/jackc/pgx/v4/pgxpool"
)

func main() {
    config, err := pgxpool.ParseConfig("postgres://username:password@localhost:5432/mydb")
    if err != nil {
        log.Fatalf("Unable to parse DATABASE_URL: %v\n", err)
    }

    pool, err := pgxpool.ConnectConfig(context.Background(), config)
    if err != nil {
        log.Fatalf("Unable to connect to database: %v\n", err)
    }
    defer pool.Close()

    var greeting string
    err = pool.QueryRow(context.Background(), "SELECT 'Hello, world!'").Scan(&greeting)
    if err != nil {
        log.Fatalf("QueryRow failed: %v\n", err)
    }

    log.Println(greeting)
}
```

## pgx: DNS のパラメータについて

- **sslmode**: SSL（セキュア・ソケット・レイヤ）接続を使用するかどうかを指定する。
  - 例: `sslmode=disable`（SSLを使用しない）, `sslmode=require`（SSLを必須とする）
- **connect_timeout**: サーバーとの接続を確立するためのタイムアウト（秒単位）。
  - 例: `connect_timeout=10`（10秒）
- **application_name**: この接続を識別するためのアプリケーション名。
  - 例: `application_name=myapp`
- **search_path**: 初期設定のスキーマ検索パス。
  - 例: `search_path=myschema`
- **pool_max_conns**: 接続プールの最大接続数（pgxpoolで特に有用）。
  - 例: `pool_max_conns=20`
