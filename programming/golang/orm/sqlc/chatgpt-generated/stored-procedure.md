# Sqlc ストアドの呼び出し方法

- `v1.27.0`現在、ストアドのコード生成は、Syntaxエラーが発生して利用することが難しい
- そのためストアド結果に紐づく戻り値の型がblankのstructになってしまう
- 呼び出し側は実行できる

## 1. ストアドプロシージャの作成

以下は`PostgreSQL`の例でストアドプロシージャを作成

```sql
CREATE OR REPLACE PROCEDURE update_user_email(user_id INT, new_email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE users
    SET email = new_email
    WHERE id = user_id;
END;
$$;
```

## 2. sqlcの設定ファイル

これは通常と変わらない

**sqlc.yaml**

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
```

## 3. schema.sqlにストアドプロシージャの定義を書く

**schema.sql**

```sql
CREATE OR REPLACE PROCEDURE update_user_email(user_id INT, new_email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE users
    SET email = new_email
    WHERE id = user_id;
END;
$$;
```

## 4. クエリファイル

queries.sqlにストアドプロシージャを呼び出すクエリを記述

**queries.sql**

```sql
-- name: UpdateUserEmail :exec
CALL update_user_email($1, $2);
```

## 5. コード生成

これは通常と変わらない

```sh
sqlc generate
```

## 生成されたコード例

**db/queries.sql.go**

```go
// Code generated by sqlc. DO NOT EDIT.
// source: queries.sql

package db

import (
    "context"
    "database/sql"
)

type UpdateUserEmailParams struct {
    UserID    int32
    NewEmail  string
}

func (q *Queries) UpdateUserEmail(ctx context.Context, arg UpdateUserEmailParams) error {
    _, err := q.db.ExecContext(ctx, "CALL update_user_email($1, $2);", arg.UserID, arg.NewEmail)
    return err
}
```

## ストアドプロシージャの呼び出し例

**main.go**

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

    // ユーザーのメールアドレスを更新するためにストアドプロシージャを呼び出します。
    updateParams := db.UpdateUserEmailParams{
        UserID:   1,
        NewEmail: "new.email@example.com",
    }
    err = q.UpdateUserEmail(ctx, updateParams)
    if err != nil {
        log.Fatal(err)
    }
    
    log.Println("User email updated successfully")
}
```