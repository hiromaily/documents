# Prismaの便利な 3rd package

## 1. schema の DB 側の naming の mapping について

以下のように命名規則が schema ファイルと、Datbase で異なるので、mapping が必要となる。
そこで、[prisma-case-format](https://github.com/iiian/prisma-case-format)によって一括変換すると便利。

```prisma
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

### prisma-case-formatコマンドの 実行例

- e.g. model 名が camel ケースで、DB を snake にしたい場合

```sh
prisma-case-format --file ./prisma/schema.prisma --map-table-case=snake,singular
# or
prisma-case-format --file ./prisma/schema.prisma --map-table-case=snake,plural
```

- e.g. カラム名が camel ケースで、DB を snake にしたい場合

```sh
prisma-case-format --file ./prisma/schema.prisma --map-field-case=snake
```

### コマンド実行時に、`"punycode" module is deprecated`エラーが出る場合

yarn と nodev21 によるものらしいので、node のバージョンを v20 に下げることで解消する

## 2. schema のコメントを DDL に反映させる

- [prisma-db-comments-generator](https://github.com/onozaty/prisma-db-comments-generator)を install し、`prisma generate`で出力
