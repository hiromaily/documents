# Prisma

TypescriptのためのOSS ORMで、Node.jsでDB操作するときに利用される

## 機能  

- data modeling
- migrations
- querying a database.

### Prisma Model

- アプリケーションで使用するモデルを表現するもの
- モデル内でテーブルやカラムの定義を行うことが可能
- Prisma Clientでクエリーを発行するために必要となる。

### Prisma schema

- Prismaの設定ファイル
- データベースクライアントやマイグレーションファイルの生成を行う

### Prisma Client

- Node.js および TypeScript用の自動生成された型安全なクエリビルダー
- Prisma Modelでの型情報を使用して、クエリーの結果は型安全となる

### Prisma Migrate

- 宣言型データモデリングおよび移行システムで、Prisma Schemaの情報をベースにマイグレーション周りの処理が可能になる

### Prisma Studio

- データベース上のデータを閲覧・編集することができるGUI


## 対応するDatabase

主要なDatabase全てに対応している

- [Supported databases](https://www.prisma.io/docs/orm/reference/supported-databases)


## Installから初期化, Migration

### コマンド
```sh
npm install prisma
npm install @prisma/client

# Prismaの初期化
npx prisma init
# -> Prisma directry and .env file will be created
```

### 構成ファイル修正

- `prisma/schema.prisma`の設定 (使用するDBなど)
- .envの設定: `DATABASE_URL`

### テーブルの作成とDBへの反映 (Migration)

1. `prisma/schema.prisma`にテーブル定義を書く
2. migrateサブコマンドを実行: `npx prisma migrate dev --name init`

これにより、`prisma/migrations/YYYYMMDDHHMMSS_init/migration.sql` といったファイルが作成される

### PrismaによるDBの確認

```sh
# GUI上でデータを確認できる
npx prisma studio
```

### DDLからPrisma schemaを生成する

schema.prismaの接続情報が正しいことを確認し、以下を実行

```sh
# 最初のみ、既存DBから schema を生成
npx prisma introspect

# 以後のDBの直接的な変更があった場合、DBの変更を schema へ反映
npx prisma db pull
```

### Prisma Clientの生成

```sh
npx prisma generate
```

## Clientによる操作方法

### レコード作成

```ts
await prisma.users.create({
    data: {
        name: name,
        email: email,
    },
});
```

### レコード全件取得

```ts
// テーブルのレコードを全件取得
await prisma.users.findMany();

// 特定の条件に該当するレコードを全件取得
await prisma.user.findMany({
  where: {
    email: email,
  },
})
```

### レコード1件取得

```ts
// ユニークなレコードを取得
await prisma.users.findUnique({
    where: {
        id: Number(req.params.id),
    },
});

// 最初に一致したレコードを取得
await prisma.users.findFirst({
    where: {
        name: name,
    },
});
```

### レコード更新

```ts
await prisma.users.update({
    where: {
        id: Number(req.params.id),
    },
    data: {
        name: updatedName,
        email: updatedEmail,
    },
});
```

### レコード削除

```ts
await prisma.users.delete({
    where: {
        id: Number(req.params.id),
    },
});
```

## prismaコマンド

- ローカルでschemaをDBへ反映させる (prisma schema first)

```sh
npx prisma migrate dev
```

- 本番/StagingでschemaをDBへ反映させる 

```sh
npx prisma migrate deploy
```

- schemaをformatする

```sh
npx prisma format
```

- マスタデータの流し込み

```sh
npx prisma db seed
```

- 既存DBから schema を生成 (おそらく最初のみ)

```sh
npx prisma introspect
```

- DBの変更を schema へ反映

```sh
npx prisma db pull
```

- GUI上でデータを確認

```sh
npx prisma studio
```

- schemaでのerrorを確認

```sh
npx prisma validate
```

## 実際の手順

- DDLの作成
- `prisma introspect`でschemaを生成
- schemaを修正
- `prisma format`でschemaをフォーマット
- `prisma migrate dev` でマイグレーションファイル(sql)を作成し、DBへ反映
- `prisma generate`によりclientコードの生成

## schemaについて

以下のように命名規則がschemaファイルと、Datbaseで異なるので、mappingが必要となる。
そこで、[prisma-case-format](https://github.com/iiian/prisma-case-format)によって一括変換すると便利。

```
model Users {
  id             String         @id @default(uuid())
  name           String
  email          String
  createdAt      DateTime       @default(now()) @map("created_at")
  updatedAt      DateTime       @updatedAt @map("updated_at")

  @@map("users")
}
```

### [prisma-case-format](https://github.com/iiian/prisma-case-format)

[help]

```sh
Usage: prisma-case-format [options]

Give your schema.prisma sane naming conventions

Options:
  -f, --file <file>                cwd-relative path to `schema.prisma` file (default: "schema.prisma")
  -c, --config-file <cfgFile>      cwd-relative path to `.prisma-case-format` config file (default:
                                   ".prisma-case-format")
  -D, --dry-run                    print changes to console, rather than back to file (default: false)
  --table-case <tableCase>         case convention for table names (SEE BOTTOM) (default: "pascal")
  --field-case <fieldCase>         case convention for field names (default: "camel")
  --enum-case <enumCase>           case convention for enum names. In case of not declared, uses value of
                                   “--table-case”. (default: "pascal")
  --map-table-case <mapTableCase>  case convention for @@map() annotations (SEE BOTTOM)
  --map-field-case <mapFieldCase>  case convention for @map() annotations
  --map-enum-case <mapEnumCase>    case convention for @map() annotations of enums.  In case of not declared,
                                   uses value of “--map-table-case”.
  -p, --pluralize                  optionally pluralize array type fields (default: false)
  --uses-next-auth                 guarantee next-auth models (Account, User, Session, etc) uphold their
                                   data-contracts
  -V, --version                    hint: you have v2.2.1
  -h, --help                       display help for command
-------------------------
Supported case conventions: ["pascal", "camel", "snake"].
Additionally, append ',plural' after any case-convention selection to mark case convention as pluralized.
For instance:
  --map-table-case=snake,plural

will append `@@map("users")` to `model User`.
Append ',singular' after any case-convention selection to mark case convention as singularized.
For instance,
  --map-table-case=snake,singular
```

- e.g. model名がcamelケースで、DBをsnakeにしたい場合

```sh
prisma-case-format --file ./prisma/schema.prisma --map-table-case=snake,singular
# or
prisma-case-format --file ./prisma/schema.prisma --map-table-case=snake,plural
```

- e.g. カラム名がcamelケースで、DBをsnakeにしたい場合

```sh
prisma-case-format --file ./prisma/schema.prisma --map-field-case=snake
```

#### `"punycode" module is deprecated`エラーが出る場合

yarnとnodev21によるものらしいので、nodeのバージョンをv20に下げることで解消する



## References

- [Official](https://www.prisma.io/orm)
- [Prisma CLI reference](https://www.prisma.io/docs/orm/reference/prisma-cli-reference)
- [Best practice for instantiating Prisma Client with Next.js](https://www.prisma.io/docs/orm/more/help-and-troubleshooting/help-articles/nextjs-prisma-client-dev-practices)
  - [考察記事](https://scrapbox.io/mkizka/Prisma%E3%82%92Next.js%E3%81%A7%E4%BD%BF%E3%81%86%E3%81%A8%E3%81%8D%E3%81%AE%E3%83%99%E3%82%B9%E3%83%88%E3%83%97%E3%83%A9%E3%82%AF%E3%83%86%E3%82%A3%E3%82%B9)
- [【入門】Prismaを初めて使うときに知りたいことまとめ: 2023](https://rakuraku-engineer.com/posts/prisma-introduction/)
- [Prisma ORMを使いこなす ~歴史と対RDB運用の知見を添えて~: 2024](https://zenn.dev/cloudbase/articles/65b9f6e4f9ae05)
- [Prisma を使った効率的なバックエンド開発ワークフロー(2023)](https://zenn.dev/optimisuke/articles/387b30c547ac54)
- 