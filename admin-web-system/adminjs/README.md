# AdminJS

Node.js エコシステムに特化したオープンソースの管理ダッシュボードフレームワーク。プロジェクトの特性や要件に応じて、柔軟にカスタマイズすることができる。

## 主な特徴

1. **自動生成された UI**:

   - AdminJS は、データベースモデルからすぐに管理画面を生成する。これにより、CRUD（Create, Read, Update, Delete）操作を簡単に行うことができる。

2. **モダンなデザイン**:

   - 洗練された直感的なユーザーインターフェースを提供している。管理者や開発者が使いやすいデザイン。

3. **柔軟なカスタマイズ性**:

   - さまざまなカスタマイズオプションが用意されており、画面のレイアウトやフィールドの表示方法、アクションの追加などが簡単に行える。

4. **多言語対応**:
   - 多言語サポートが組み込まれており、ユーザーインターフェースを複数の言語で表示することができる。

## サポートされている ORM/ODM

- **Mongoose**: MongoDB 用のオブジェクトデータモデリングツール。
- **Sequelize**: PostgreSQL, MySQL, SQLite, and MSSQL 用の ORM。
- **TypeORM**: TypeScript と JavaScript の両方に対応した ORM。
- **Prisma**: 次世代 ORM ツール。

## 基本的な使用方法

### インストール

まず、AdminJS と各種プラグインのインストールを行う。

```bash
npm install @adminjs/adminjs @adminjs/express adminjs-expressjs
```

### 基本的な設定

1. **Express アプリケーションの作成**:

```js
const express = require("express");
const { default: AdminJS } = require("@adminjs/adminjs");
const AdminJSExpress = require("@adminjs/express");
const app = express();

// スキーマ定義やデータベース接続の前提として必要な設定
AdminJS.registerAdapter(require("@adminjs/sequelize")); // Sequelizeの場合

const adminJs = new AdminJS({
  databases: [], // ここにデータベースコネクションを追加
  rootPath: "/admin",
});

const router = AdminJSExpress.buildRouter(adminJs);

app.use(adminJs.options.rootPath, router);

app.listen(3000, () =>
  console.log("AdminJS is under http://localhost:3000/admin")
);
```

### モデルの追加とカスタマイズ

例えば、Sequelize を使用している場合、モデルを次のように追加する

```js
const { Sequelize, DataTypes } = require("sequelize");
const sequelize = new Sequelize("sqlite::memory:");

const User = sequelize.define("User", {
  username: DataTypes.STRING,
  email: DataTypes.STRING,
});

const adminJs = new AdminJS({
  databases: [sequelize],
  rootPath: "/admin",
  resources: [
    {
      resource: User,
      options: {
        properties: {
          password: { isVisible: false }, // パスワードフィールドを非表示にする例
        },
      },
    },
  ],
});
```

## その他の機能

- **認証と認可**: AdminJS は認証と認可の機能を追加するための API を提供している。これにより、特定のユーザーにのみ管理画面へのアクセスを許可したり、特定のアクションに制限を設けたりできる。
- **カスタムアクション**: 特定のビジネスロジックに基づいたカスタムアクションを追加することも可能。ボタン 1 つで特定のスクリプトを実行するような設定ができる。
- **拡張プラグイン**: ファイル管理、ダッシュボードウィジェット、テーマの変更など、追加のプラグインが多数用意されている。

## 利用可能なフレームワーク

- Express
- Koa
- Hapi
- NestJS
