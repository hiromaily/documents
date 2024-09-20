# Overriding types `go_type`

[go_type](https://docs.sqlc.dev/en/stable/howto/overrides.html#the-go-type-map)

データベースのカラムの型をカスタムのGoタイプにマッピングすることができる。これにより、特定のカラムを独自の型として扱うことができる。

## `go_type`の使用方法

`go_type`を指定するには、sqlcの設定ファイル（通常は`sqlc.yaml`または`sqlc.json`）の中で、以下のように記述する

```yaml
version: "2"
sql:
  - schema: "path/to/schema.sql"
    queries: "path/to/queries.sql"
    engine: "postgresql" # または他のデータベースのエンジン
    package: "db"
overrides:
  - db_type: "text"
    go_type: "github.com/yourname/yourpackage.CustomString"
  - db_type: "uuid"
    go_type: "github.com/google/uuid.UUID"
  - db_type: "jsonb"
    go_import:
      - "encoding/json"
    go_type: "json.RawMessage"
```

## 設定ファイルの詳細

- `version`: 構成ファイルのバージョン。ここでは`"2"`。
- `sql`: スキーマとクエリのパス、使用するデータベースエンジン、生成されるパッケージ名を指定。
  - `schema`: データベーススキーマのファイルパス。
  - `queries`: SQLクエリファイルのパス。
  - `engine`: 使用するデータベースエンジン（例：`postgresql`）。
  - `package`: 自動生成されるGoコードのパッケージ名。
- `overrides`: 型のオーバーライドを定義。
  - `db_type`: データベースのカラムタイプ。ここでは例として`text`、`uuid`、`jsonb`を指定しています。
  - `go_import`: カスタムタイプをインポートする際に必要なGoパッケージを指定（オプション）。
  - `go_type`: オーバーライドするカスタムのGoタイプ。パッケージパスも含めて指定します。

例えば、PostgreSQLの`uuid`タイプのカラムを`google/uuid.UUID`型にマッピングしたい場合、設定ファイルに次のように記述できる

```yaml
overrides:
  - db_type: "uuid"
    go_type: "github.com/google/uuid.UUID"
```

この設定を行うことで、SQLクエリ中のuuidカラムはsqlcによって生成されるGoコード内で`uuid.UUID`型として扱われるようになる

## カスタム型の利用例

また、自分のプロジェクト内で特殊なビジネスロジックを持つカスタム型を作りたい場合もあります。例えば、`UserEmail`というカスタム型を定義して、それをデータベースの`text`カラムにマッピングする場合

```go
// custom_types.go
package customtypes

type UserEmail string
```

そして、設定ファイルで以下のように定義します：

```yaml
overrides:
  - db_type: "text"
    go_type: "your/package/customtypes.UserEmail"
```

このようにすることで、textカラムを持つ部分において、sqlcは自動生成されるコード内でそのカラムを`UserEmail`型として扱う。
