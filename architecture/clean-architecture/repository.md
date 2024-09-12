# Repository

リポジトリ（Repository）は、データの永続化と取得を担当するオブジェクトであり、クリーンアーキテクチャにおいて重要な役割を果たす。具体的な `UserRepository` のようなリポジトリは、以下のように層ごとに異なる形で位置付けられる。

リポジトリ（例えば `UserRepository`）のインターフェースは`ドメイン層`に属し、具体的な実装は`インフラストラクチャ層（インターフェースアダプター層）`に配置される。このようにして、アプリケーション層はリポジトリの具体的な実装に依存せず、クリーンな依存関係が保たれる。これにより、システム全体の保守性、柔軟性、テスタビリティが向上する。

## 1. ドメイン層（Domain Layer）

- **リポジトリインターフェース（Repository Interface）**:
  - ドメイン層には詳細な実装は含まれず、インターフェースとしてのリポジトリが存在します。このインターフェースは、例えば `UserRepository` インターフェースのような形で定義されます。これにより、ドメイン層が具体的なデータアクセス技術に依存しないようにする。

```ts
// Domain/Repositories/UserRepository.ts
export interface UserRepository {
  findById(userId: string): Promise<User | null>;
  save(user: User): Promise<void>;
}
```

## 2. アプリケーション層（Application Layer）

- リポジトリインターフェースは、ユースケース（Use Cases）またはインタラクタ（Interactors）で注入され使用されます。この層では具体的なデータアクセスの実装には依存せず、リポジトリインターフェースのみを使用する。

```ts
// Application/UseCases/GetUserById.ts
export class GetUserById {
  constructor(private userRepository: UserRepository) {}

  async execute(userId: string): Promise<User | null> {
    return this.userRepository.findById(userId);
  }
}
```

## 3. インターフェースアダプター層（Interface Adapters）

- この層では、リポジトリインターフェースの実装が行われ、具体的なデータアクセスのロジックが含まれる。外部のデータベースや API などに依存する具体的な技術をここで扱う。
- goの場合、Interfaceと実装を同じファイルまたはディレクトリにまとめたほうが可読性は高まるという認識

```ts
// Infrastructure/Repositories/MongoUserRepository.ts
import { UserRepository } from "../../Domain/Repositories/UserRepository";
import { User } from "../../Domain/Entities/User";

export class MongoUserRepository implements UserRepository {
  async findById(userId: string): Promise<User | null> {
    // MongoDBの具体的なクエリを実行
    const user = await mongoCollection.findOne({ _id: userId });
    return user ? new User(user._id, user.name) : null;
  }

  async save(user: User): Promise<void> {
    await mongoCollection.insertOne(user);
  }
}
```

## 4. 外部エージェント層（Frameworks & Drivers）

- この層は、リポジトリ自体の実装というよりも、そのリポジトリが使用する具体的なデータベースや外部 API のドライバー、フレームワークを含みます。具体的なリポジトリ実装とデータベース技術の間の連携がここに含まれる。

## 統合例

システム全体でリポジトリがどのように統合されるか

```ts
// Main.ts
import { MongoUserRepository } from "./Infrastructure/Repositories/MongoUserRepository";
import { GetUserById } from "./Application/UseCases/GetUserById";

// リポジトリの実装を作成
const userRepository = new MongoUserRepository();

// ユースケースとリポジトリを結びつける
const getUserById = new GetUserById(userRepository);

// APIハンドラなどでユースケースを使用
async function handleGetUserByIdRequest(req, res) {
  const userId = req.params.id;
  const user = await getUserById.execute(userId);
  res.json(user);
}
```
