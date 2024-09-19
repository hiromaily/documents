# Go sqlc

SQLをコンパイルしてGoのコードを生成する

- [Official](https://sqlc.dev/)
- [github: sqlc](https://github.com/sqlc-dev/sqlc)

## [Install](https://docs.sqlc.dev/en/latest/overview/install.html)

```sh
go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
```

## How to use

- [Getting started with MySQL](https://docs.sqlc.dev/en/latest/tutorials/getting-started-mysql.html)
- [Getting started with PostgreSQL](https://docs.sqlc.dev/en/latest/tutorials/getting-started-postgresql.html)

### sqlの用意

```sh
cd [project]
mkdir sqlfiles
```

利用するsqlファイルを用意するが、プリペアードステートメント形式となる。(外部から参照するのでもOK)

```sql
-- name: CreateUser :one
INSERT INTO users (
    user_name, email, phone_number, password
) VALUES (
    $1, $2, $3, $4
) RETURNING *;

-- name: GetUserByEmail :one
SELECT
    *
FROM
    users
WHERE
    email = $1;

```

- Create
- Select
- Insert
- Update
- Delete

### Configurationファイル `sqlc.yaml`の用意

- mysqlの場合

```yaml
version: "2"
sql:
  - engine: "mysql"
    queries: "./sqlfiles/query.sql"
    schema: "./sqlfiles/schema.sql"
    gen:
      go:
        package: "tutorial"
        out: "pkg/tutorial"
```

### 生成

```sh
sqlc generate
```

### `main.go` 例

```go
package main

import (
    "database/sql"
    "fmt"
    "log"
    "sqlc_example/sqlc"

    _ "github.com/go-sql-driver/mysql"
)

func main() {
    db, err := sql.Open("mysql", "user:password@tcp(127.0.0.1:3306)/dbname")
    if err != nil {
        log.Fatal(err)
    }
    defer db.Close()

    queries := sqlc.New(db)

    // Create a user
    newUser, err := queries.CreateUser(ctx, sqlc.CreateUserParams{
        Username: "testuser",
        Email:    "testuser@example.com",
    })
    if err != nil {
        log.Fatal(err)
    }
    fmt.Printf("Created User: %+v\n", newUser)

    // Get a user by ID
    user, err := queries.GetUser(ctx, newUser.ID)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Printf("User: %+v\n", user)

    // List all users
    users, err := queries.ListUsers(ctx)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Printf("All Users: %+v\n", users)
}
```
