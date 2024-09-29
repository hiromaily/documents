# ORM ent

Entは、Facebookによって開発されたGo言語用のEntity Framework（ORM）で、スキーマ駆動型のデータベースインターフェースを提供する。エンティティの定義から自動的にコードを生成し、型安全なAPIを提供することが特徴。

## Entの基本的な特徴

1. **スキーマの定義**
   - スキーマはGoの構造体で定義され、専用のDSL（Domain Specific Language）を用いて属性やリレーションを記述する。

   ```go
   type User struct {
       ent.Schema
   }

   func (User) Fields() []ent.Field {
       return []ent.Field{
           field.String("name").
               NotEmpty().
               Unique(),
           field.String("email").
               NotEmpty().
               Unique(),
       }
   }

   func (User) Edges() []ent.Edge {
       return nil
   }
   ```

2. **コードの自動生成**
   - 定義したスキーマに基づいて、型安全なクエリビルダーやクライアントコードを自動生成する。

   ```sh
   entc generate ./schema
   ```

3. **クエリの作成**
   - 自動生成されたクエリビルダーを用いてクエリを作成する。

   ```go
   client.User.
       Query().
       Where(user.Name("john")).
       Only(ctx)
   ```

## DDLからスキーマ定義を逆生成

おそらく、[entimport](https://github.com/ariga/entimport)を利用する

## entコマンド

```sh
go install entgo.io/ent/cmd/ent@latest

ent --help
```

```sh
> ent --help
Usage:
  ent [command]

Available Commands:
  completion  Generate the autocompletion script for the specified shell
  describe    print a description of the graph schema
  generate    generate go code for the schema directory
  help        Help about any command
  new         initialize a new environment with zero or more schemas
```

```sh
> ent generate --help
generate go code for the schema directory

Usage:
  ent generate [flags] path

Examples:
  ent generate ./ent/schema
  ent generate github.com/a8m/x

Flags:
      --feature strings    extend codegen with additional features
      --header string      override codegen header
  -h, --help               help for generate
      --storage string     storage driver to support in codegen (default "sql")
      --target string      target directory for codegen
      --template strings   external templates to execute
```

## References

[Official](https://entgo.io/ja/)
