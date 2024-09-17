# Framework

- [Hono](https://hono.dev/)
- [NestJS](https://nestjs.com/)
- [Fastify](https://fastify.dev/)
- [Express](https://expressjs.com/ja/)
- [LoopBack](https://loopback.io/)
- [Koa](https://koajs.com/)

## [NestJS](https://nestjs.com/)

### NestJS としてのアーキテクチャ

- 開発手法としてDDDを使ったレイヤードアーキテクチャ
  - [NestJS architecture step by step guide](https://kodaschool.com/blog/the-architecture-of-nestjs)
  - [Nest.js — Architectural Pattern, Controllers, Providers, and Modules.](https://medium.com/geekculture/nest-js-architectural-pattern-controllers-providers-and-modules-406d9b192a3a)

- ディレクトリ例(参考用)
  - [nestjs-project-structure](https://github.com/CatsMiaow/nestjs-project-structure)

#### 特徴

- NestJs は、開発者に API を直接公開する一方で、ある程度の抽象化を提供する
- NestJs のアーキテクチャは、AngularJS から大きなインスピレーションを得ている
  - AngularJS はただの MVC アーキテクチャ

- 3 Layer
  - Controllers (Routes)
  - Service Layer (Business Logic)
  - Data Access Layer (ODM)

#### デメリット

- [技術選定の失敗 2年間を振り返る TypeScript,Hono,Nest.js,React,GraphQL](https://zenn.dev/nem/articles/ade7b83cae2fa5)
  - 全身技術負債みたいなフレームワーク
  - 無駄に分厚い
  - 直観的ではなく学習コストが高い
  - esmoduleの対応予定無し
  - レガシーデコレーター依存
  - ビルド遅い。立ち上がり遅い。パフォーマンスが悪い
  - monorepoと相性が悪い(なんか独自のmonorepoの仕組みがある)
  - 他のライブラリとの統合にプラグインが必要になる
  - ボイラープレートが多い
