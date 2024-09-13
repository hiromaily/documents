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

## Goで実装したRepositoryについて

例えば、usecase 層があり、repository I/F に依存しているとする

```go
type SampleUsecaser interface {
  // parameter and response may be changed as specification
  DoFirst(ctx context.Context) (response.Response, error)
  DoSecond(ctx context.Context) (response.Response, error)
}

type SampleUsecase struct {
  logger   logger.Logger
  addressRepo repository.AddressRepositorier
}
```

repository Interface は以下の通り

```go
type AddressRepositorier interface {
  GetAll(accountType account.AccountType) ([]*models.Address, error)
  GetAllAddress(accountType account.AccountType) ([]string, error)
}
```

実装は以下の通り

```go
// AddressRepository is repository for address table
type AddressRepository struct {
  dbConn       *sql.DB
  tableName    string
  logger       *zap.Logger
}

// NewAddressRepository returns AddressRepository object
func NewAddressRepository(dbConn *sql.DB, logger *zap.Logger) *AddressRepository {
  return &AddressRepository{
    dbConn:       dbConn,
    tableName:    "address",
    logger:       logger,
  }
}

// GetAll returns all records by account
func (r *AddressRepository) GetAll(accountType account.AccountType) ([]*models.Address, error) {
  // sql := "SELECT * FROM %s WHERE account=%s;"
  ctx := context.Background()

  items, err := models.Addresses(
    qm.Where("coin=?", r.coinTypeCode.String()),
    qm.And("account=?", accountType.String()),
  ).All(ctx, r.dbConn)
  if err != nil {
    return nil, errors.Wrap(err, "failed to call models.Addresss().All()")
  }
  return items, nil
}
```

このとき、Repository (AddressRepository を実装した AddressRepository) は、`Interface Adapter (Controllers, Presenters, Gateways)`レイヤーに該当する。
例えば、上記の`GetAll()`は Interface を介して Usecase 層から呼ばれる。そしてこの`GetAll()`内で`models.Addresses(..).All(..)`という DB ライブラリの実装を呼び出している。

## Logger

logger Interface は以下の通り

```go
type Logger interface {
  Debug(msg string, args ...any)
  Info(msg string, args ...any)
  Warn(msg string, args ...any)
  Error(msg string, args ...any)
}
```

実装は以下の通り

```go
package logger

import (
  "log/slog"
  "os"
)

type SlogLogger struct {
  log *slog.Logger
}

func NewLogger() *SlogLogger {
  return &SlogLogger{
    log: slog.New(slog.NewJSONHandler(os.Stdout, nil)),
  }
}

// Debug
func (s *SlogLogger) Debug(msg string, args ...any) {
  s.log.Debug(msg, args...)
}
```

このとき、Logger (Logger を実装した SlogLogger) も、`Interface Adapter (Controllers, Presenters, Gateways)`レイヤーに該当する。
例えば、上記の`Debug()`は Interface を介して Usecase 層から呼ばれる。そしてこの`Debug()`内で`log.Debug()`という slog 標準ライブラリの実装を呼び出している。
