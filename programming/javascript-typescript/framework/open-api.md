# TypescriptのOpenAPIに対応したFramework

## [zod](https://github.com/colinhacks/zod)

[zod-to-openapi](https://github.com/asteasolutions/zod-to-openapi)によって、ZodスキーマをOpenAPI Specificationに変換することができる。これにより、TypeScriptコードベースで型安全なバリデーションを保ちながら、同時にAPIドキュメントも管理することができる。

```ts
import { z } from 'zod';
import { OpenAPIGenerator, generateSchema } from 'zod-to-openapi';

// Zodスキーマの定義
const UserSchema = z.object({
  id: z.string().uuid(),
  name: z.string(),
  email: z.string().email(),
  roles: z.array(z.string())
});

// OpenAPIの定義を生成
const OpenAPISchema = generateSchema(UserSchema);

// Swagger/OpenAPIの設定
const generator = new OpenAPIGenerator(
  {
    openapi: '3.0.0',
    info: {
      title: 'Zod to OpenAPI Example',
      version: '1.0.0'
    },
    paths: {},
    components: {
      schemas: {
        User: OpenAPISchema
      }
    }
  },
  '3.0.0'
);

// OpenAPI Specificationの生成
const openAPIDocument = generator.generateDocument();

// OpenAPIドキュメントの表示
console.log(JSON.stringify(openAPIDocument, null, 2));
```

## [Ts.ED Swagger](https://tsed.io/tutorials/swagger.html)

Ts.ED（TypeScript Framework for Node.js、Express、Socket.IO）は、型注釈とデコレーターを使って高い生産性を実現するためのフレームワーク。`@tsed/swagger`は、このTs.EDフレームワークに組み込まれたSwagger（OpenAPI）統合ツールで、`TypeScriptコードから自動的にOpenAPI Specificationを生成する`。

ただし、他の`Hono`といったフレームワークでは利用できない

```ts
import { Configuration, Inject } from "@tsed/di";
import { PlatformExpress } from "@tsed/platform-express";
import "@tsed/swagger"; // Swaggerモジュールのインポート
import * as bodyParser from "body-parser";
import { HelloWorldController } from "./controllers/HelloWorldController";

@Configuration({
  rootDir: __dirname,
  port: 8080,
  acceptMimes: ["application/json"],
  mount: {
    "/rest": [
      HelloWorldController
    ]
  },
  swagger: [
    {
      path: "/docs",
      specVersion: "3.0.1"
    }
  ],
  middlewares: [
    bodyParser.json(),
    bodyParser.urlencoded({ extended: true })
  ]
})
export class Server {
  public static initialize(): Promise<void> {
    const platform = PlatformExpress.bootstrap(this);
    return platform.listen();
  }
}
```

## [aspida](https://github.com/aspida/aspida)
  
Aspidaは、TypeScriptのHTTPクライアント生成ツールで、これによりTypeScriptコードから型安全なAPIクライアントを生成することが可能。Aspidaは、APIリクエストとレスポンスの定義から実際のHTTPクライアントコードを自動生成し、フロントエンドとバックエンドとの間のインターフェースを統一する助けとなる。しかし、OpenAPIのSpecを生成できるわけではない。

## [tsoa](https://github.com/lukeautry/tsoa)

tsoaはTypeScriptを使用して`Express`や`Koa`のルーティングとAPIドキュメント（OpenAPI Specification）を自動生成するパッケージ。tsoaを使用すると、TypeScriptのデコレータを使用してAPIエンドポイントを定義し、その定義を基にルーティングとOpenAPI Specificationを自動生成できる。

### tsoaの主な機能

1. **自動ルーティング**：
   - TypeScriptのデコレータを使用してAPIエンドポイントを定義し、自動的にルーティングを生成する。

2. **OpenAPI Specificationの生成**：
   - APIの定義から自動的にOpenAPI Specificationを生成し、Swagger UIなどでドキュメントを表示できる。

3. **型安全なコード**：
   - TypeScriptの強力な型安全性を活用して、APIエンドポイントの定義とバリデーションを行う。

### コントローラーの作成例

`UserController.ts`

```ts
import { Controller, Get, Route, Tags, Post, Body, Path } from 'tsoa';

interface User {
  id: number;
  name: string;
}

interface CreateUserRequest {
  name: string;
}

@Route('users')
@Tags('User')
export class UserController extends Controller {

  private static users: User[] = [
    { id: 1, name: "John Doe" }
  ];

  @Get('/')
  public async getUsers(): Promise<User[]> {
    return UserController.users;
  }

  @Get('{id}')
  public async getUser(@Path() id: number): Promise<User | undefined> {
    return UserController.users.find(user => user.id === id);
  }

  @Post('/')
  public async createUser(@Body() requestBody: CreateUserRequest): Promise<User> {
    const newUser: User = {
      id: UserController.users.length + 1,
      name: requestBody.name,
    };
    UserController.users.push(newUser);
    return newUser;
  }
}
```
