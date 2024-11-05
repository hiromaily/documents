# Prisma

Typescript のための OSS ORM で、Node.js で DB 操作するときに利用される

## 機能

- data modeling
- migrations
- querying a database.

### Prisma Model

- アプリケーションで使用するモデルを表現するもの
- モデル内でテーブルやカラムの定義を行うことが可能
- Prisma Client でクエリーを発行するために必要となる。

### Prisma schema

- Prisma の設定ファイル
- データベースクライアントやマイグレーションファイルの生成を行う

### Prisma Client

- Node.js および TypeScript 用の自動生成された型安全なクエリビルダー
- Prisma Model での型情報を使用して、クエリーの結果は型安全となる

### Prisma Migrate

- 宣言型データモデリングおよび移行システムで、Prisma Schema の情報をベースにマイグレーション周りの処理が可能になる

### Prisma Studio

- データベース上のデータを閲覧・編集することができる GUI

## 対応する Database

主要な Database 全てに対応している

- [Supported databases](https://www.prisma.io/docs/orm/reference/supported-databases)

## Install から初期化, Migration

### コマンド

```sh
npm install prisma
npm install @prisma/client

# Prismaの初期化
npx prisma init
# -> Prisma directry and .env file will be created
```

### 構成ファイル修正

- `prisma/schema.prisma`の設定 (使用する DB など)
- .env の設定: `DATABASE_URL`

### テーブルの作成と DB への反映 (Migration)

1. `prisma/schema.prisma`にテーブル定義を書く
2. migrate サブコマンドを実行: `npx prisma migrate dev --name init`

これにより、`prisma/migrations/YYYYMMDDHHMMSS_init/migration.sql` といったファイルが作成される

### Prisma による DB の確認

```sh
# GUI上でデータを確認できる
npx prisma studio
```

### DDL から Prisma schema を生成する

schema.prisma の接続情報が正しいことを確認し、以下を実行

```sh
# 最初のみ、既存DBから schema を生成
# or
# 以後のDBの直接的な変更があった場合、DBの変更を schema へ反映
# npx prisma introspect # deprecated
npx prisma db pull
```

### Prisma Client の生成

```sh
npx prisma generate
```

### 環境の`reset`

開発環境においてデータベースをリセットして最新のスキーマに再構築するためのコマンド

```sh
npx prisma migrate reset
```

**内部的な挙動**

  1. データベースのDrop
     - 現在のデータベースの全てのテーブルをドロップ（削除）する
     - つまり、Prisma Migrateによって管理されているマイグレーション履歴もリセットされる
  2. データベースの再作成
  3. マイグレーションの再適用
  4. シードの実行（オプション）

## 実際の手順まとめ

- DDL の作成
- ~~`prisma introspect`~~`prisma db pull`で schema を生成
- schema を修正
- `prisma format`で schema をフォーマット
- `prisma migrate dev` でマイグレーションファイル(sql)を作成し、DB へ反映
- `prisma generate`により client コードの生成

## References

- [Official](https://www.prisma.io/orm)
- [Prisma CLI reference](https://www.prisma.io/docs/orm/reference/prisma-cli-reference)
- [Best practice for instantiating Prisma Client with Next.js](https://www.prisma.io/docs/orm/more/help-and-troubleshooting/help-articles/nextjs-prisma-client-dev-practices)
  - [考察記事](https://scrapbox.io/mkizka/Prisma%E3%82%92Next.js%E3%81%A7%E4%BD%BF%E3%81%86%E3%81%A8%E3%81%8D%E3%81%AE%E3%83%99%E3%82%B9%E3%83%88%E3%83%97%E3%83%A9%E3%82%AF%E3%83%86%E3%82%A3%E3%82%B9)
- [【入門】Prisma を初めて使うときに知りたいことまとめ: 2023](https://rakuraku-engineer.com/posts/prisma-introduction/)
- [Prisma ORM を使いこなす ~歴史と対 RDB 運用の知見を添えて~: 2024](https://zenn.dev/cloudbase/articles/65b9f6e4f9ae05)
- [Prisma を使った効率的なバックエンド開発ワークフロー(2023)](https://zenn.dev/optimisuke/articles/387b30c547ac54)
-
