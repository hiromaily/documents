# Sqlc 部分的なSQLファイルから生成

sqlcは基本的に一つのスキーマファイルやクエリファイルからGoコードを生成することが一般的だが、大規模なプロジェクトではスキーマやクエリが巨大になり、管理が難しくなることがある。そのため、スキーマやクエリを複数のファイルに分割し、管理しやすくすることが必要。

sqlcは`@include`ディレクティブを使って、別のSQLファイルをインポートすることができる。これを使うことで、複数のSQLファイルを一つのプロジェクトとしてまとめて管理し、コード生成時にそれらを結合して処理することができる。

スキーマやクエリを部分的に分割してインクルードすることで、プロジェクト構造が整理され、保守性が向上する。

## 具体的な手順

1. **SQLスキーマとクエリファイルの分割**: スキーマやクエリを複数のファイルに分割する。

```sql
-- users.sql: ユーザーに関するテーブル定義

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);
```

```sql
-- products.sql: 商品に関するテーブル定義

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC NOT NULL
);
```

2. **メインのスキーマファイルにインクルード**: スキーマファイルに他のSQLファイルをインクルードする。

```sql
-- schema.sql: メインスキーマファイル

@include 'users.sql'
@include 'products.sql'
```

3. **クエリファイルの分割とインクルード**: クエリも同様に分割し、メインのクエリファイルでインクルードする。

```sql
-- user_queries.sql: ユーザーに関するクエリ

-- name: CreateUser :one
INSERT INTO users (name, email) VALUES ($1, $2)
RETURNING id, name, email;

-- name: GetUser :one
SELECT id, name, email FROM users WHERE id = $1;
```

```sql
-- product_queries.sql: 商品に関するクエリ

-- name: CreateProduct :one
INSERT INTO products (name, price) VALUES ($1, $2)
RETURNING id, name, price;

-- name: GetProduct :one
SELECT id, name, price FROM products WHERE id = $1;
```

```sql
-- queries.sql: メインのクエリファイル

@include 'user_queries.sql'
@include 'product_queries.sql'
```

4. **sqlc.yaml設定ファイル**: sqlcの設定ファイルで、メインのスキーマファイルとクエリファイルを指定する。

```yaml
version: "2"
sql:
  - engine: "postgresql"
    schema: "schema.sql"
    queries: "queries.sql"
    gen:
      go: 
        package: "db"
        out: "db"

5. **生成コマンドの実行**: `sqlc generate`を実行
```

## 生成された使い方の例

生成されたコードを使ってクエリを呼び出す例としては以下のようになる。

```go
package main

import (
    "context"
    "database/sql"
    "log"

    _ "github.com/lib/pq"
    "example.com/myapp/db"
)

func main() {
    connStr := "user=username dbname=mydb sslmode=disable"
    dbConn, err := sql.Open("postgres", connStr)
    if err != nil {
        log.Fatal(err)
    }
    defer dbConn.Close()

    q := db.New(dbConn)
    ctx := context.TODO()

    // Create a new user
    newUser, err := q.CreateUser(ctx, db.CreateUserParams{
        Name:  "John Doe",
        Email: "john.doe@example.com",
    })
    if err != nil {
        log.Fatal(err)
    }
    log.Println("New User ID:", newUser.ID)

    // Create a new product
    newProduct, err := q.CreateProduct(ctx, db.CreateProductParams{
        Name:  "Gadget",
        Price: 1999,
    })
    if err != nil {
        log.Fatal(err)
    }
    log.Println("New Product ID:", newProduct.ID)
}
```
