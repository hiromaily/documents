# Sqlc Useful Features

## インメモリ構造体でテスト

生成されたコードを利用して容易にユニットテストを書ける点もsqlcの特徴。例えば、sqlcの生成コードを使って、モックデータベースを使ったテストを行うことで、業務ロジックのテストを簡潔に行うことができる。

```go
package db_test

import (
  "context"
  "testing"
  "github.com/stretchr/testify/require"
  "example.com/myapp/db"
)

func TestCreateUser(t *testing.T) {
  testDB := db.NewTestDB(t)  // テスト専用のデータベースを提供する関数
  defer testDB.Close()

  q := db.New(testDB)
  ctx := context.TODO()

  createUserParams := db.CreateUserParams{
    Name:  "testuser",
    Email: "testuser@example.com",
  }
  user, err := q.CreateUser(ctx, createUserParams)
  require.NoError(t, err)
  require.Equal(t, "testuser", user.Name)
  require.Equal(t, "testuser@example.com", user.Email)
}
```

## シャーディングや複数データベースのサポート

sqlcは複数のデータベースやシャーディングをサポートするプロジェクト設定も可能。プロジェクト内で異なるデータベースに対して異なるクエリを実行する必要がある場合にも対応できる。

```yml
version: "2"
sql:
  - engine: "postgresql"
    schema: "schema1.sql"
    queries: "queries1.sql"
    gen:
      go: 
        package: "db1"
        out: "db1"
  
  - engine: "mysql"
    schema: "schema2.sql"
    queries: "queries2.sql"
    gen:
      go: 
        package: "db2"
        out: "db2"
```

## ~~外部のSQLファイルをインポート~~

~~sqlcは外部のSQLファイルをインポートする機能をサポートしている。大規模なプロジェクトでSQLクエリをモジュール化し、再利用性を高めることができる。~~

```sql
-- file: users.sql

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);

-- file: queries.sql
@include 'users.sql'

-- name: CreateUser :one
INSERT INTO users (name, email) 
VALUES ($1, $2)
RETURNING id, name, email;
```

## config内での環境変数の利用

sqlcは設定ファイルの中で環境変数を使用することができる。

```yml
version: "2"
sql:
  - engine: "postgresql"
    schema: "schema.sql"
    queries: "queries.sql"
    gen:
      go:
        package: "db"
        out: "db"
conn:
  url: ${DATABASE_URL}  # 環境変数を使用
```

## 部分的なSQLファイルから生成

特定のSQLファイルから部分的にクエリやスキーマを生成することも可能。これにより、大規模なスキーマ定義やクエリファイルを管理しやすくなる。
具体的には、メインのスキーマファイルに他のSQLファイルをインクルードする。

```sql
-- schema.sql: メインスキーマファイル

@include 'users.sql'
@include 'products.sql'
```

詳細は[こちら](./use-partial-sql.md)

## クエリのドキュメント生成

sqlcはSQLクエリに関する自動生成されたドキュメントを提供する。
クエリにコメントを付けることで、sqlcが生成するGoコードにドキュメントとして組み込まれる。

```sql
-- name: GetUserByEmail :one
-- @desc: このクエリは、指定されたメールアドレスでユーザーを検索する。
SELECT id, name, email
FROM users
WHERE email = $1;
```

## カスタムビルドフラグ

sqlcはカスタムビルドフラグをサポートしており、生成されるコードのコンパイル条件を指定できる。これにより、特定のクエリやスキーマを条件付きで含めたり無効にしたりすることが可能。
以下の設定により、`-tags=prod` ビルドタグが指定された場合のみ、生成されるGoコードがコンパイルされる。

```yml
gen:
  go:
    build_flags: "-tags=prod"
```

詳細は[こちら](./custom-build-flag.md)

## エクスポートされた構造体の再利用

sqlcが生成するデータベースのスキーマに基づいた構造体を、他のGoコードで再利用することができる。これにより、一貫性のあるデータモデルをプロジェクト全体で確保することができる。

```go
type CreateUserParams = db.CreateUserParams

func CreateUserWrapper(ctx context.Context, q *db.Queries, params CreateUserParams) (db.User, error) {
    return q.CreateUser(ctx, params)
}
```

## クエリメタデータ

sqlcはクエリに関するメタデータも管理している。このメタデータを使って、クエリのパフォーマンスや使用量を監視することができる。
以下のようにメタデータを追加することで、クエリに関する詳細な情報を保持できる。

```sql
-- name: GetUserStats :one
-- @desc: このクエリは、ユーザーの統計情報を取得する。
SELECT COUNT(*)
FROM users;
```

詳細は[こちら](./query-metadata.md)

## パッケージの分割

sqlcは生成されるコードを複数のパッケージに分割することもでき、依存関係をより明確に管理できる。これにより、大規模なプロジェクトでもコードの管理がしやすくなる。

```yml
sql:
  - engine: "postgresql"
    schema: "users/schema.sql"
    queries: "users/queries.sql"
    gen:
      go:
        package: "db/users"
        out: "db/users"

  - engine: "postgresql"
    schema: "products/schema.sql"
    queries: "products/queries.sql"
    gen:
      go:
        package: "db/products"
        out: "db/products"
```
