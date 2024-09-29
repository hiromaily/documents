# Sqlc カスタムビルドフラグ

`ビルドフラグ`とは、Goのビルドプロセスにおいて特定の条件でコードをコンパイルするための指示であり、ビルドフラグを使うことで実行環境や開発環境に応じて異なるコードをビルドすることができる。これにはデバッグ用コードの有効化や、異なる設定値（例：開発用や本番用のデータベース接続情報）を使用するなどの用途がある。

sqlcを使って生成されるGoコードにもカスタムビルドフラグを適用することが可能で、これにより生成されるコードが特定のビルド条件に基づいて異なる内容を持つことができる。

## sqlcでの使用方法と手順

1. **ビルドタグの付与**: Goのソースコードファイルや、sqlcによって生成されるコードにビルドタグ（ビルドフラグ）を付与する。ビルドタグはソースファイルの最初にコメントとして記述する。

2. **sqlc.yamlの設定**: sqlcの設定ファイルで、生成されるコードに適用するビルドタグを指定する。

### 具体例

以下の例では、開発環境と本番環境で異なる設定を使用するためにビルドタグを利用する。

#### 1. スキーマとクエリファイル

スキーマとクエリは通常通りに記述する。

**schema.sql**

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);
```

**queries.sql**

```sql
-- name: CreateUser :one
INSERT INTO users (name, email) 
VALUES ($1, $2)
RETURNING id, name, email;

-- name: GetUser :one
SELECT id, name, email
FROM users
WHERE id = $1;
```

#### 2. sqlc.yamlの設定

sqlcの設定ファイルにビルドタグを指定する。

**sqlc.yamlを修正**

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
        build_flags: "-tags=dev"　# ここにビルドタグを追加
```

ここで、`build_flags: "-tags=dev"` と指定することで、生成されるコードに `dev` ビルドタグを適用する。

#### 3. 生成されたコードにビルドタグを追加

`生成されたGoコードにビルドタグを追加する`。sqlcは直接ビルドタグを追加しないため、生成後に手動で追加するか、カスタムテンプレートを使用して自動でビルドタグを挿入することが可能。

例えば、`db/queries.sql.go` というファイルが生成された場合、以下の通り

**db/queries.sql.goにビルドタグを追加**

```go
// +build dev

package db

import (
    "context"
    "database/sql"
)
```

#### 4. Goのビルド時にタグを指定

コマンドラインでビルド時に `dev` タグを指定することで、特定のコードのみがビルドされます。

**ビルドコマンド**

```sh
go build -tags=dev
```

このコマンドにより、`+build dev` タグが付いているソースコードがビルド対象に含まれます。

## 実際のビルドタグの応用例

開発用と本番用で異なるデータベース接続設定を使用する例

**db/config_dev.go**

```go
// +build dev

package db

import "fmt"

func GetDBConfig() string {
    return "host=localhost port=5432 user=devuser password=devpass dbname=devdb sslmode=disable"
}

func main() {
    fmt.Println(GetDBConfig())  // 開発用の設定出力
}
```

**db/config_prod.go**

```go
// +build prod

package db

import "fmt"

func GetDBConfig() string {
    return "host=prod.db.server port=5432 user=produser password=prodpass dbname=proddb sslmode=require"
}

func main() {
    fmt.Println(GetDBConfig())  // 本番用の設定出力
}
```

**メインプログラム**

```go
package main

import (
    "database/sql"
    "fmt"
    "log"

    _ "github.com/lib/pq"
    "example.com/myapp/db"
)

func main() {
    connStr := db.GetDBConfig()
    dbConn, err := sql.Open("postgres", connStr)
    if err != nil {
        log.Fatal(err)
    }
    defer dbConn.Close()

    fmt.Println("Database connected.")
}
```

このように、`dev` タグを使って開発環境の設定をビルドし、`prod` タグを使って本番環境の設定をビルドすることで、簡単に環境ごとの設定の切り替えが可能。
カスタムビルドフラグを利用することで、異なる環境や状況に応じた柔軟なコード管理が可能となる。
