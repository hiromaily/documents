# tsyringe

軽量 DI コンテナで、コンストラクタの注入を行う

- [github](https://github.com/microsoft/tsyringe)
- [How to use tsyringe - 10 common examples](https://snyk.io/advisor/npm-package/tsyringe/example)

## Install

```sh
npm install --save tsyringe reflect-metadata
```

- tsconfig.json

```json
{
  "compilerOptions": {
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true
  }
}
```

## API

### Decorators

- injectable()
  - クラスの依存関係を実行時に注入できるようにする Class decorator factory
  - TSyringe は、インスタンス化するクラスのメタデータを収集するために、いくつかの decorator に依存する
- singleton()
  - Class をシングルトンとしてグローバルコンテナ内に登録する Class decorator factory
- autoInjectable()
  - デコレートされたクラスのコンストラクタを パラメータなしのコンストラクタに置き換える
- inject()
  - コンストラクタのメタデータに、 Interface やその他の Class 以外の情報を格納できるようにする
- injectAll()
  - 配列パラメータ用のパラメータデコレータで、配列の中身はコンテナから取得する
  - 指定した injection token を使用して配列を注入し、 値を解決する
- injectWithTransform()
  - 結果を返す前に、Transformer オブジェクトが解決したオブジェクトに対してアクションを実行できるようにするパラメータデコレーター
- injectAllWithTransform()
  - このパラメータ・デコレータは、配列の内容を transformer に渡す
  - transformer は任意の型を返すことができるので、 配列を map したり fold したりする際に使用する
- scoped()
  - グローバルコンテナ内のスコープされた依存関係としてクラスを登録する Class decorator factory

### Container

- Inversion of Control(IoC) 制御の逆転 コンテナの一般的な原理は、コンテナにトークンを渡すと、それと引き換えにインスタンスや値を受け取るというもの
- TSyringe のコンテナは、ほとんどの場合自動的にトークンを割り出すことができるが、2 つの大きな例外 (Interface と非 Class 型)がある
- Interface では、コンストラクタのパラメータに`@inject()`デコレーターを使用して注入する必要がある
- デコレートしたクラスを使用するには、コンテナに登録する必要がある
- 登録は Token と Provider のペアの形をとる

```ts
container.register("LoggerInterface", {
  useClass: ConsoleLoggerImpl,
});
```

- 上記では、`'LoggerInterface'` が Token で、`{useClass: ConsoleLoggerImpl}` が Provider となる

#### Injection Token

Token は以下のいずれか

- string
- symbol
- class の constructor
- DelayedConstructor のインスタンス

#### Providers

Provider は DI コンテナーに登録され、与えられた Token のインスタンスを解決するために必要な情報をコンテナーに提供する。Tsyringe では以下の 4 種類のプロバイダーがある

##### 1.Class Provider

```ts
{
  token: InjectionToken<T>;
  useClass: constructor<T>;
}
```

- コンストラクタによってクラスを解決するために使用される
- Class Provider を登録する際には、もちろんエイリアス（トークンがクラスそのものではない Class Provider）を作成するのでなければ、コンストラクタそのものを使用することができる

##### 2.Value Provider

```ts
{
  token: InjectionToken<T>;
  useValue: T;
}
```

- トークンを指定された値に解決するために使用される
- これは、定数や、すでに特定の方法でインスタンス化されているものを登録するのに有効

##### 3.Factory provider

```ts
{
  token: InjectionToken<T>;
  useFactory: FactoryFunction<T>;
}
```

- 指定されたファクトリーを使用してトークンを解決するために使用される
- ファクトリは依存関係コンテナにフルアクセスできる
- `FactoryFunction<T>`シグネチャにマッチする関数であれば、ファクトリーとして使用することができる
  - `type FactoryFunction<T> = (dependencyContainer: DependencyContainer) => T;`

##### 3.2 Factory の種類

- instanceCachingFactory
  - このファクトリーは、オブジェクトの遅延構築と結果のキャッシュに使用される
  - これは`@singleton()`によく似ている

```ts
import { instanceCachingFactory } from "tsyringe";

{
  token: "SingletonFoo";
  useFactory: instanceCachingFactory<Foo>((c) => c.resolve(Foo));
}
```

- instancePerContainerCachingFactory
  - `DependencyContainer` ごとにオブジェクトを遅延構築し、結果をキャッシュする
  - これは`@scoped(Lifecycle.ContainerScoped)`に非常に似ている

```ts
import { instancePerContainerCachingFactory } from "tsyringe";

{
  token: "ContainerScopedFoo";
  useFactory: instancePerContainerCachingFactory<Foo>((c) => c.resolve(Foo));
}
```

- predicateAwareClassFactory
  - resolve 時に条件付きの振る舞いを提供するために使用される
  - デフォルトでは結果をキャッシュするが、毎回新鮮な結果を解決するオプションのパラメータもある

```ts
import {predicateAwareClassFactory} from "tsyringe";

{
  token: "FooHttp",
  useFactory: predicateAwareClassFactory<Foo>(
    c => c.resolve(Bar).useHttps, // Predicate for evaluation
    FooHttps, // A FooHttps will be resolved from the container if predicate is true
    FooHttp // A FooHttp will be resolved if predicate is false
  );
}
```

##### 4.Token Provider

```ts
{
  token: InjectionToken<T>;
  useToken: InjectionToken<T>;
}
```

- リダイレクトやエイリアスと考えることができ、トークン`x`が与えられたら、トークン`y`を使用して解決することを示すだけ

#### Register 登録

- 最初の decorated class がインスタンス化される前に、プログラムのどこかに`DependencyContainer.register()`を追加する

```ts
container.register<Foo>(Foo, { useClass: Foo });
container.register<Bar>(Bar, { useValue: new Bar() });
container.register<Baz>("MyBaz", { useValue: new Baz() });
```

##### RegistrationOptions

```ts
type RegistrationOptions = {
  /**
   * Customize the lifecycle of the registration
   * See https://github.com/microsoft/tsyringe#available-scopes for more information
   */
  lifecycle: Lifecycle;
};
```

#### Registry (WIP:まだ理解できていない)

- 任意のクラスを`@registry()`デコレータでマークアップすると、 指定したプロバイダがマークアップしたクラスのインポート時に登録されるようになる
- `registry()`は、プロバイダの配列を受け取る

```ts
@registry([
  { token: Foobar, useClass: Foobar },
  {
    token: "theirClass",
    useFactory: (c) => {
      return new TheirClass("arg");
    },
  },
])
class MyClass {}
```

- これは、同じトークンに対して複数のクラスを登録したい場合に便利
- また、`@registry`のアノテーションが付けられたクラスや、オブジェクトの登録を担当するクラスなど、他のクラスではインポートされないオブジェクトを登録・宣言する場合にも使用できる
- 最後に、`container.register(...)`メソッドの代わりに、サードパーティのインスタンスを登録する場合にも使用できる
- 注：このクラスを`@injectable`にしたい場合は、`@registry`の前にデコレーターを付ける必要がある

#### Resolution

- トークンとインスタンスを交換するプロセスとなる
- Tsyringe のコンテナは、完全に構築されたオブジェクトを返すために、解決されるトークンの依存関係を再帰的に満たす
- オブジェクトが解決される典型的な方法は、`resolve()`を使ってコンテナから解決する方法

```ts
const myFoo = container.resolve(Foo);
const myBar = container.resolve<Bar>("Bar");
```

- また、`resolveAll()`を使えば、指定したトークンに対して登録されたすべてのインスタンスを解決することもできる

```ts
interface Bar {}

@injectable()
class Foo implements Bar {}
@injectable()
class Baz implements Bar {}

@registry([
  // registry is optional, all you need is to use the same token when registering
  { token: "Bar", useToken: Foo }, // can be any provider
  { token: "Bar", useToken: Baz },
])
class MyRegistry {}

const myBars = container.resolveAll<Bar>("Bar"); // myBars type is Bar[]
```

#### Interception

- 特定のトークンの解決前または解決後に呼び出されるコールバックを登録することができる
- このコールバックは、一度だけ実行するように登録することもできるし（たとえば初期化を実行するため）、解決ごとにロギングを実行するように登録することもできる
- `beforeResolution`は、オブジェクトが解決される前にアクションを起こすために使われる

```ts
class Bar {}

container.beforeResolution(
  Bar,
  // Callback signature is (token: InjectionToken<T>, resolutionType: ResolutionType) => void
  () => {
    console.log("Bar is about to be resolved!");
  },
  { frequency: "Always" }
);
```

- `afterResolution`は、オブジェクトが解決された後にアクションを起こすために使われる

```ts
class Bar {
  public init(): void {
    // ...
  }
}

container.afterResolution(
  Bar,
  // Callback signature is (token: InjectionToken<T>, result: T | T[], resolutionType: ResolutionType)
  (_t, result) => {
    result.init();
  },
  { frequency: "Once" }
);
```

#### Child Containers

- 異なる登録セットを持つ複数のコンテナを持つ必要がある場合は、子コンテナを作成することができる

```ts
const childContainer1 = container.createChildContainer();
const childContainer2 = container.createChildContainer();
const grandChildContainer = childContainer1.createChildContainer();
```

- 子コンテナはそれぞれ独立した登録を持つが、解決時に子コンテナに登録がない場合、トークンは親から解決される
- これにより、共通のサービス一式をルートに登録し、子コンテナに特化したサービスを登録することができる
- これは、ルートコンテナから共通のステートレスサービスを使用するリクエストごとのコンテナを作成する場合などに便利

#### インスタンスのクリア

- `container.clearInstances()`メソッドを使用すると、以前に作成および登録したすべてのインスタンスをクリアできる
- `container.reset()`とは異なり、登録自体はクリアされない。 これは特にテストに便利

## Example

### 環境変数で、依存関係を switch する

- logger.ts

```ts
// Logger interface
interface ILogger {
  log(message: string): void;
}

// DebugLogger implementation
class DebugLogger implements ILogger {
  log(message: string): void {
    console.debug(message);
  }
}

// ProductionLogger implementation
class ProductionLogger implements ILogger {
  log(message: string): void {
    console.log(message);
  }
}
```

- baseClass.ts

```ts
import { injectable, inject } from "tsyringe";

@injectable()
class MyClass {
  constructor(@inject("Logger") private logger: ILogger) {}

  myMethod() {
    this.logger.log("Logging a message");
  }
}
```

- main.ts

```ts
import { container } from "tsyringe";
import { DebugLogger, ProductionLogger } from "./logger";

// Register logger implementations based on NODE_ENV
if (process.env.NODE_ENV === "debug") {
  container.register<ILogger>("Logger", { useClass: DebugLogger });
} else {
  container.register<ILogger>("Logger", { useClass: ProductionLogger });
}
```

### Factory を使って、環境変数で、依存関係を switch する

```ts
import { container, DependencyContainer, factory } from "tsyringe";

// Logger interface and implementations (same as before)

// Factory function to determine the logger implementation based on NODE_ENV
function loggerFactory(container: DependencyContainer) {
  if (process.env.NODE_ENV === "debug") {
    //return container.resolve(DebugLogger);
    return DebugLogger;
  } else {
    //return container.resolve(ProductionLogger);
    return ProductionLogger;
  }
}

// Register the factory provider
container.register<ILogger>("Logger", { useFactory: loggerFactory });
```

## Typescript5.0 で動かない問題 (2023/7/1 現在)

- [tsyringe を TypeScript 5 で使う方法](https://blog.open.tokyo.jp/2023/05/02/tsyringe-with-typescript-5.html)
