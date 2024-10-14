# Framework

Node.js で使われる主なフレームワーク

1. **[Hono](https://hono.dev/)**

   - **特徴**: Hono は`Ultrafast Web Framework`として知られ、**非常に高速**である点が特長。シンプルかつ軽量でありながら、優れたパフォーマンスを発揮するため、リソース効率の良いアプリケーションが構築可能。TypeScript で書かれているため、型安全性に優れており、コードの信頼性を高めることができる。また、モジュールベースの設計を採用しているため、小さなコードベースでも強力な機能を簡単に取り込むことができる。
   - [github](https://github.com/honojs/hono)
     - Star: 19.3k

2. **[Koa.js](https://koajs.com/)**

   - **特徴**: `Express.jsの主要開発者によって作られたフレームワーク`で、よりシンプルでモダンな設計を持っている。非同期関数（async/await）を使用しているため、ミドルウェアの構成が非常にクリーンで分かりやすくなっている。
   - [github](https://github.com/koajs/koa)
     - Star: 35.2k

3. **[Express.js](https://expressjs.com/)**

   - **特徴**: 軽量で柔軟なフレームワークで、Node.js のアプリケーションと API 開発において最も人気がある。シンプルなルーティングとミドルウェアシステムを提供し、多くの開発者によって広く使用されている。

4. **[Fastify](https://www.fastify.io/)**

   - **特徴**: `高速かつ低オーバーヘッドなHTTPフレームワーク`で、特にパフォーマンスに重きを置いて設計されている。非同期かつフレンドリーな API が特徴で、プラグインシステムも豊富。スキーマベースのリクエスト・レスポンスのバリデーションが可能で、TypeScript とも親和性が高い。
   - [github](https://github.com/fastify/fastify)
     - Star: 32.1k

5. **[LoopBack](https://loopback.io/)**

   - **特徴**: `APIファーストのフレームワーク`であり、`特にエンタープライズ用途での使用が多い`。モデルベースのアプローチを採用しており、データソースへの接続や API の定義が比較的簡単に行える。また、多数のコネクターが用意されており、データベースやその他のサービスへの接続が容易。TypeScript による開発にも対応している。
   - [github](https://github.com/strongloop/loopback)
     - Star: 13.2k

6. **[Encore.ts](https://encore.dev/)**

   - **特徴**: 比較的新しいフレームワークで、TypeScript で書かれている。`マイクロサービスアーキテクチャやクラウドネイティブなアプリケーションの開発に特化`しており、インフラの管理やデプロイメントを簡単に行うためのツールチェインが含まれている。開発者エクスペリエンスを向上させるための機能が豊富。
   - Goで書かれている
   - [github](https://github.com/encoredev/encore)
     - Star: 7.1k

7. **[Hapi.js](https://hapi.dev/)**

   - **特徴**: 高度な構成が可能で、`セキュリティやパフォーマンスに優れたアプリケーション`を作成できるように設計されている。プラグインシステムが強力で、大規模なプロジェクトにも適している。
   - [github](https://github.com/hapijs/hapi)
     - Star: 14.6k

8. **[Meteor.js](https://www.meteor.com/)**

   - **特徴**: `フルスタックプラットフォーム`で、`リアルタイムWebアプリケーションの開発に特化`している。クライアントとサーバが同じコードベースで書かれるため、一貫した開発体験を提供する。また、デフォルトで MongoDB を使用し、リアルタイムデータ同期を簡単に実現できる。

9. **[Sails.js](https://sailsjs.com/)**

   - **特徴**: `MVC（Model-View-Controller）アーキテクチャ`に基づいて設計されているため、従来の Web 開発スタイルに馴染みのある開発者にとって理解しやすい。データ駆動アプリケーションの開発を容易にし、RESTful API やリアルタイム機能もサポートしている。

10. **[Nest.js](https://nestjs.com/)**

    - **特徴**: TypeScript で書かれており、モジュール化された構造を持つフルスタックフレームワーク。`Angularに似た構文`を使用しているため、フロントエンド開発経験のある開発者には親和性が高い。マイクロサービスアーキテクチャや GraphQL などのモダンな技術にも対応している。

## [Admin.js](../../../admin-web-system/adminjs.md)に対応しているFramework

- Fastify (via @adminjs/fastify)
- Koa (via @adminjs/koa)
- Express.js (via @adminjs/express)
- Hapi (via @adminjs/hapi)
- Nest.js (via @adminjs/nestjs)
