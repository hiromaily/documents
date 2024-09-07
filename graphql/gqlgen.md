# gqlgen

- [Github](https://github.com/99designs/gqlgen)
- [Docs](https://gqlgen.com/)

- gqlgen は `schema-first`となっている。

## 開発の流れ

- GraphQL のスキーマを定義
- スキーマからコード生成する
- GraphQL リゾルバなどを実装する

## 初期設定

- `go run github.com/99designs/gqlgen init` コマンドでスケルトンが出力される
- `go install github.com/99designs/gqlgen@latest` コマンドで`gqlgen`を install したほうがいいかも

```sh
❯ gqlgen -help
NAME:
   gqlgen - generate a graphql server based on schema

USAGE:
   gqlgen [global options] command [command options] [arguments...]

DESCRIPTION:
   This is a library for quickly creating strictly typed graphql servers in golang. See https://gqlgen.com/ for a getting started guide.

COMMANDS:
   generate  generate a graphql server based on schema
   init      create a new gqlgen project
   version   print the version string
   help, h   Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --config value  the config filename
   --help, -h      show help (default: false)
   --verbose       show logs (default: false)
```

## schema について

- スキーマは、GraphQL の [Schema Definition Language](https://graphql.org/learn/schema/)を使う。
- デフォルトでは、 `schema.graphqls`　が対象となるファイルになる

## コードの生成

- schema 修正後、`gqlgen generate` コマンドで生成できる

## resolvers の実装

- `graph/schema.resolvers.go`ファイル
  - `gqlgen generate`コマンドによって再生成される
  - こちらのファイルにエンドポイント毎の実装が含まれるため、こちらのファイルを修正していく必要がある
- `graph/resolvers.go`ファイル
  - 空の`Resolver`構造体が定義されているのみ
  - こちらに、Database, logging といったアプリケーションの依存関係を追加する
  - 初期化処理は、`server.go`の`main()`内に記述がある

## サーバーの起動

- `go run server.go`を実行

### `gqlgen.yml` ファイルについて

- これにより構成を変更することができる
- [Configuration](https://gqlgen.com/config/)
