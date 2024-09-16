# TSyringe

TSyringeは、非常にシンプルで軽量なDependency Injection（DI）ライブラリ

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

### 1. エンティティの定義

各クラスとインターフェースを定義。例えば、`Logger` インターフェースを定義し、`SimpleLogger` クラスがこれを実装する形にする。

```ts
interface Logger {
    log(message: string): void;
}

@injectable()
class SimpleLogger implements Logger {
    public log(message: string): void {
        console.log(message);
    }
}
```

続いて、`Weapon` インターフェースとその実装である `Katana` クラスを定義し、`Katana` も `Logger` に依存すると仮定。

```ts
interface Weapon {
    attack(): string;
}

@injectable()
class Katana implements Weapon {
    constructor(@inject("Logger") private logger: Logger) {}

    public attack(): string {
        this.logger.log("Katana used");
        return 'cut!';
    }
}
```

そして、`Ninja` クラスが `Weapon` に依存します。

```ts
@injectable()
class Ninja {
    constructor(@inject("Weapon") private weapon: Weapon) {}

    public fight(): string {
        return this.weapon.attack();
    }
}
```

### 2. コンテナに登録

各クラスをコンテナに登録する。ここでは、それぞれのインターフェースに対する具体的なクラス実装を登録する。

```ts
container.register<Logger>("Logger", { useClass: SimpleLogger });
container.register<Weapon>("Weapon", { useClass: Katana });
container.register<Ninja>(Ninja);  // Ninjaは直接クラスを登録
```

### 3. インスタンスの解決と使用

コンテナから `Ninja` のインスタンスを解決し、そのメソッドを使用する。

```ts
const ninja = container.resolve<Ninja>(Ninja);
console.log(ninja.fight()); // 'Katana used' と 'cut!' が表示される。
```

### 全体のコード例

```ts
import 'reflect-metadata';
import { container, inject, injectable } from 'tsyringe';

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
