# TSyringe

TSyringeは、非常にシンプルで軽量なDependency Injection（DI）ライブラリ
シンプルな依存関係の解決にはいいが、初期化時に様々なパラメータを必要とする依存関係はコードが複雑化する

## Note

- 2024/9現在、bunを使った環境では動かない。[Reflect-metadata doesn't work for tsyringe](https://github.com/oven-sh/bun/issues/4677)

## インストール

```sh
npm install tsyringe reflect-metadata
```

`reflect-metadata`はデコレータを使用するために必要。

## 1. reflect-metadataのインポート

まず、TypeScriptファイルの先頭で `reflect-metadata` をインポートする。

```ts
import 'reflect-metadata';
```

## 2. クラスの定義

次に、注入されるクラス（例：`Weapon` インターフェースと `Katana` クラス）を定義

```ts
interface Weapon {
    attack(): string;
}

class Katana implements Weapon {
    public attack(): string {
        return 'cut!';
    }
}
```

インターフェースはTypeScriptの型システムには影響するが、実際のコンテナには直接関与しない。

## 3. デコレータと注入を使用するクラスを定義

注入されるクラスには `@injectable()` デコレータを使用し、コンストラクタで依存関係をインジェクトする。

```ts
import { container, inject, injectable } from 'tsyringe';

@injectable()
class Ninja {
    constructor(@inject('Weapon') private weapon: Weapon) {}

    public fight(): string {
        return this.weapon.attack();
    }
}
```

## 4. コンテナに登録する

コンテナにクラスや値を登録する。ここでは、`'Weapon'` というトークンで `Katana` クラスを登録している。

```ts
container.register('Weapon', { useClass: Katana });
```

## 5. 解決して使用する

コンテナから `Ninja` クラスのインスタンスを解決し、メソッドを呼び出す。

```ts
const ninja = container.resolve(Ninja);
console.log(ninja.fight()); // 'cut!'
```

## 全体のコード例

```ts
import 'reflect-metadata';
import { container, inject, injectable } from 'tsyringe';

interface Weapon {
    attack(): string;
}

@injectable()
class Katana implements Weapon {
    public attack(): string {
        return 'cut!';
    }
}

@injectable()
class Ninja {
    constructor(@inject('Weapon') private weapon: Weapon) {}

    public fight(): string {
        return this.weapon.attack();
    }
}

container.register('Weapon', { useClass: Katana });

const ninja = container.resolve(Ninja);
console.log(ninja.fight()); // 'cut!'
```

## その他の機能

### シングルトン登録

```ts
container.registerSingleton('Weapon', Katana);
```

### 値の登録

```ts
container.register('API_URL', { useValue: 'https://api.example.com' });

@injectable()
class ApiService {
    constructor(@inject('API_URL') private apiUrl: string) {}

    public getApiUrl(): string {
        return this.apiUrl;
    }
}

const apiService = container.resolve(ApiService);
console.log(apiService.getApiUrl()); // 'https://api.example.com'
```

### ファクトリーの使用

```ts
container.register('WeaponFactory', {
    useFactory: (c) => () => new Katana()
});

@injectable()
class Ninja {
    constructor(@inject('WeaponFactory') private weaponFactory: () => Weapon) {}

    public fight(): string {
        const weapon = this.weaponFactory();
        return weapon.attack();
    }
}

const ninja = container.resolve(Ninja);
console.log(ninja.fight()); // 'cut!'
```

## 依存関係が入れ子になっているケース

```ts
import 'reflect-metadata';
import { container, inject, injectable } from 'tsyringe';

// 新たにLoggerを追加
interface Logger {
    log(message: string): void;
}

@injectable()
class SimpleLogger implements Logger {
    public log(message: string): void {
        console.log(message);
    }
}

interface Weapon {
    attack(): string;
}

// KatanaがLoggerに依存
@injectable()
class Katana implements Weapon {
    constructor(@inject("Logger") private logger: Logger) {}

    public attack(): string {
        this.logger.log("Katana used");
        return 'cut!';
    }
}

@injectable()
class Ninja {
    constructor(@inject("Weapon") private weapon: Weapon) {}

    public fight(): string {
        return this.weapon.attack();
    }
}

container.register<Logger>("Logger", { useClass: SimpleLogger });
container.register<Weapon>("Weapon", { useClass: Katana });

const ninja = container.resolve<Ninja>(Ninja);
console.log(ninja.fight()); // 'Katana used' と 'cut!' が表示される
```

## 依存関係が初期化パラメータを必要としているケース

```ts
import 'reflect-metadata';
import { container, inject, injectable } from 'tsyringe';

// Loggerクラス
interface Logger {
    log(message: string): void;
}

@injectable()
class SimpleLogger implements Logger {
    public log(message: string): void {
        console.log(message);
    }
}

interface Weapon {
    attack(): string;
}

// Katanaクラスは初期化時にパラメータが必要
@injectable()
class Katana implements Weapon {
    constructor(
        @inject("Logger") private logger: Logger,
        private name: string
    ) {}

    public attack(): string {
        this.logger.log(`${this.name} used`);
        return `${this.name} cuts!`;
    }
}

// Ninja
@injectable()
class Ninja {
    constructor(@inject("Weapon") private weapon: Weapon) {}

    public fight(): string {
        return this.weapon.attack();
    }
}

// Register Logger
container.register<Logger>("Logger", { useClass: SimpleLogger });

// インスタンスを作成
const katanaWithCustomName = new Katana(container.resolve("Logger"), "Sharp Katana");
// 作成したインスタンスをregisterInstance()で登録
container.registerInstance<Weapon>("Weapon", katanaWithCustomName);

const ninja = container.resolve<Ninja>(Ninja);
console.log(ninja.fight()); // 'Sharp Katana used' と 'Sharp Katana cuts!' が表示されます
```
