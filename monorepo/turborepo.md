# Turborepo

Vercel 製の monorepo ツールだが、monorepo 以外でのワークフローの高速化も可能。  
turbo は `Workspaces` の上に構築されており、これはは JavaScript エコシステムのパッケージマネージャの機能で、複数のパッケージを 1 つのリポジトリにまとめることができる。

- [Turborepo](https://turbo.build/repo)
  - [Docs](https://turbo.build/repo/docs)
- [github](https://github.com/vercel/turborepo)

## 機能

- 実行結果はコンテンツを考慮してキャッシュされる
  - インクリメンタルビルドが高速化される
  - キャッシュはクラウドに保存できるため CI/CD/チーム間で共有できる
- 並列ビルドでき、ビルド時の依存関係も設定できる
- monorepo の中から特定のサブセット(ある 1 つの repository に必要なファイル群)を抽出できる
- 慣習を元にすることで、より複雑な設定が数行の JSON で設定できる
  - ex. lint, build, test, deploy などの依存関係は慣習的に定まる
- ビルドプロファイルを生成でき、ブラウザでインポートして時間がかかっているタスクを把握できる

## [Support Policy](https://turbo.build/repo/docs/getting-started/support-policy)

### 利用可能なパッケージマネージャ

Turborepo は npm エコシステムの規約に準拠しているため、npm、yarn、pnpm など、どのパッケージマネージャでも使用できる

- pnpm 8+
- npm 8+
- yarn 1+

## [ディレクトリ構成](https://turbo.build/repo/docs/crafting-your-repository/structuring-a-repository)

Turborepo では、`apps` と `packages` ディレクトリを作ることを慣例としている

```
.
├── package.json
├── package-lock.json
├── turbo.json
├── apps/
│   ├── docs/
│   │   └── package.json
│   └── web/
│       ├── package.json
│       └── file
└── packages/
    ├── pkg1/
    │   └── package.json
    ├── pkg2/
    │   └── package.json
    └── pkg3/
        └── package.json
```

### パッケージ用ディレクトリの宣言

最初に、パッケージマネージャはパッケージの場所を記述する必要がある。 アプリケーションやサービスは`apps/` に、ライブラリやツールのようなその他は `packages/` にパッケージを分割することから始める。
この設定を使うと、`apps`または`packages`ディレクトリ内の`package.json`を持つ全てのディレクトリがパッケージとみなされる。

```json
{
  "workspaces": ["apps/*", "packages/*"]
}
```

### 各 package 内のディレクトリ

一般的に`src`ディレクトリを使ってソースコードを格納し、`dist`ディレクトリにコンパイルする

### [気をつける点](https://turbo.build/repo/docs/crafting-your-repository/structuring-a-repository#common-pitfalls)

TypeScript を使用している場合は、ワークスペースのルートに `tsconfig.json` ファイルは必要ない。
パッケージはそれぞれ独自に構成を指定する必要があり、通常はワークスペース内の別のパッケージから共有された `tsconfig.json` を基に構築する

パッケージの境界を越えてファイルにアクセスすることはできるだけ避けたい。
もし、あるパッケージから別のパッケージに移動するために ../ と記述していることに気づいたら、必要なパッケージをインストールしてコードにインポートすることで、アプローチを再考する。

### root の package.json

```json
{
  "private": true,
  "scripts": {
    "build": "turbo run build",
    "dev": "turbo run dev",
    "lint": "turbo run lint"
  },
  "devDependencies": {
    "turbo": "latest"
  },
  "packageManager": "npm@10.0.0"
}
```

### package の構造

#### name の命名について

`name` はパッケージを識別するために使用されるため、ワークスペース内で一意の必要がある

`npm レジストリの他のパッケージとの衝突を避けるため`に、内部パッケージには`名前空間接頭辞`を使うのがベストプラクティス
例えば、あなたの組織の名前が `acme` の場合、パッケージ名を `@acme/package-name` とするとよい。
docs とサンプルでは `@repo` を使っていますが、これは npm レジストリで未使用の、主張できない名前空間のためであり、リネームした方が良い

#### scripts

パッケージ内で実行可能なスクリプトを定義するために使われる

scripts フィールドは、パッケージのコンテキストで実行可能なスクリプトを定義するために使用される。 Turborepo は、これらのスクリプトの名前を使って、パッケージ内で実行するスクリプトを(もしあれば)特定する。

[Running tasks](https://turbo.build/repo/docs/crafting-your-repository/running-tasks)

#### exports

パッケージを使用したい他のパッケージのエントリポイントを指定するために使用される。あるパッケージのコードを別のパッケージで使いたいときは、そのエントリーポイントからインポートする。

exports フィールドの例

```json
{
  "exports": {
    ".": "./dist/constants.ts",
    "./add": "./dist/add.ts",
    "./subtract": "./dist/subtract.ts"
  }
}
```

apps/example からの import する例

```ts
import { GRAVITATIONAL_CONSTANT, SPEED_OF_LIGHT } from "@repo/math";
import { add } from "@repo/math/add";
import { subtract } from "@repo/math/subtract";
```

exports の利点

- barrel ファイルを避ける
  - barrel ファイルとは、同じパッケージ内の他のファイルを再エクスポートし、パッケージ全体に対して 1 つのエントリ ポイントを作成するファイル
  - コンパイラーやバンドラーが扱うには難しく、すぐにパフォーマンスの問題につながる
- `exports`は、`main`フィールドと比較して、`条件付きエクスポート`のような他の強力な機能も持っているため、main より exports を使用したほうがよい
  - [main](https://nodejs.org/api/packages.html#main)
- IDE オートコンプリート
  - ワイルドカードを使って exports を指定することもできるが、オートコンプリート機能を失うことになる

#### imports (option)

パッケージ内の他のモジュールへのサブパスを作成する方法を提供する。パッケージ内の他のモジュールに行くためのショートカットとなる。
TypeScript の`compilerOptions#paths`と同じ事が可能だが、より優れたオプションとなる。

```json
{
  "imports": {
    "#*": "./*"
  }
}
```

内部的に import する場合

```ts
import { add } from "#add";
```

## 依存関係の管理

- Turborepo は依存関係を管理せず、パッケージマネージャに任される

```json
{
  "dependencies": {
    "next": "latest", // External dependency
    "@repo/ui": "*" // Internal dependency
  }
}
```

### node_modules の場所

利用するパッケージマネージャに依存する

### [依存関係のインストールのベストプラクティス](https://turbo.build/repo/docs/crafting-your-repository/managing-dependencies#best-practices-for-dependency-installation)

#### 使用する場所に依存関係をインストールする

```sh
npm install jest --workspace=web --workspace=@repo/ui --save-dev
```

- 依存関係をリポジトリにインストールするときは、それを使うパッケージに直接インストールするべき
- つまり共通として root に install するという使い方はしないということ

利点

- わかりやすさの向上
- 柔軟性の向上
- より優れたキャッシュ能力
  - root の変更は不必要なキャッシュミスにつながる
- 未使用の依存関係の実行

#### ルートに少ない依存関係

- ワークスペースのルートに属する依存関係は、リポジトリを管理するためのツールだけ
- アプリケーションやライブラリをビルドするための依存関係は、それぞれのパッケージにインストールされる

### npm 利用時の依存関係

- TOP ディレクトリの `node_modules` にすべての npm パッケージが含まれる
- 別 repo に含まれる npm モジュールを package.json へ追加しなくても参照できてしまうらしい (要確認)
- 全 repo に共通して利用しるいる npm パッケージは monoorepo TOP の package.json へ追加する
- 各 repo だけで利用している npm パッケージは、該当する repo の package.json へ追加する

### 依存関係を同じバージョンに保つ

- 専用ツールの使用
  - [syncpack](https://www.npmjs.com/package/syncpack), [manypkg](https://www.npmjs.com/package/@manypkg/cli), [sherif](https://www.npmjs.com/package/sherif) のようなツール
- パッケージマネージャを使う

```sh
npm install typescript@latest --workspaces
yarn upgrade-interactive --latest
pnpm up --recursive typescript@latest
```

## [内部パッケージの作成](https://turbo.build/repo/docs/crafting-your-repository/creating-an-internal-package)

### 作成方法

- 空のディレクトリを作成する
- package.json を追加する

```json
{
  "name": "@repo/math",
  "type": "module",
  "scripts": {
    "dev": "tsc --watch",
    "build": "tsc"
  },
  "exports": {
    "./add": {
      "types": "./src/add.ts",
      "default": "./dist/add.js"
    },
    "./subtract": {
      "types": "./src/subtract.ts",
      "default": "./dist/subtract.js"
    }
  },
  "devDependencies": {
    "@repo/typescript-config": "*",
    "typescript": "latest"
  }
}
```

- `tsconfig.json` を追加する

```json
{
  "extends": "@repo/typescript-config/base.json",
  "compilerOptions": {
    "outDir": "dist",
    "rootDir": "src"
  },
  "include": ["src"],
  "exclude": ["node_modules", "dist"]
}
```

- ソースコードのある src ディレクトリを追加する
- アプリケーションに必要なパッケージを追加する

```json
  "dependencies": {
    "@repo/math": "*",
    "next": "latest",
    "react": "latest",
    "react-dom": "latest"
  },
```

```ts
import { add } from "@repo/math/add";

function Page() {
  return <div>{add(1, 2)}</div>;
}

export default Page;
```

- turbo.json を編集する
  - 新しい`@repo/math` ライブラリの成果物を、build タスクの `outputs` に追加する
  - これにより、ビルド出力は Turborepo にキャッシュされ、ビルドを開始したときに即座に復元できるようになる

```json
"tasks": {
  "build": {
    "dependsOn": ["^build"],
    "outputs": [".next/**", "!.next/cache/**", "dist/**"]
  },
}
```

- `turbo build` を実行する

### 内部パッケージのベストプラクティス

- 一つのパッケージに一つの目的
- アプリケーション・パッケージには共有コードを含めない

## [Task の設定](https://turbo.build/repo/docs/crafting-your-repository/configuring-tasks)

turborepo における npm-run-script のタスクを処理する関係性を定義するもので、`turbo.json`で管理される。
Turborepo が実行するタスクを登録することで、`turbo run`によって実行することが可能となる。

### タスクの定義

`tasks` オブジェクトの各キーは、`turbo run` で実行できるタスクとなる

- 以下の場合、`turbo run build`を実行すると、Turborepo はパッケージ内のすべての build スクリプトを並行して実行する

```js
{
  "tasks": {
    "build": {} // Incorrect!
  }
}
```

#### 正しい順序でタスクを実行

`dependsOn`キーによって、別のタスクが実行を開始する前に完了しなければならないタスクを指定する

- ほとんどの場合、アプリケーションの build スクリプトが実行される前に、ライブラリの build スクリプトが完了するようにする
- 依存関係を先にビルドする
- `^`のマイクロシンタックスは、依存関係のグラフの一番下からタスクを実行するように Turborepo に指示する

```json
{
  "tasks": {
    "build": {
      "dependsOn": ["^build"]
    }
  }
}
```

#### 同じパッケージ内のタスクへの依存

- 同じパッケージ内の 2 つのタスクが特定の順序で実行されるようにする必要がある場合

```json
{
  "tasks": {
    "test": {
      // build成功後にtestが実行される
      "dependsOn": ["build"]
    }
  }
}
```

#### 特定のパッケージの特定のタスクに依存する

- 以下の例では、`utils` の `build` タスクは、`lint` タスクの前に実行されなければならない

```json
{
  "tasks": {
    "lint": {
      "dependsOn": ["utils#build"]
    }
  }
}
```

#### 依存タスクをより具体的にする

- 特定のパッケージに限定する

```json
{
  "tasks": {
    "web#lint": {
      "dependsOn": ["utils#build"]
    }
  }
}
```

#### 依存関係がない場合

```json
{
  "tasks": {
    "spell-check": {
      "dependsOn": []
    }
  }
}
```

### output の指定

- `outputs`キーは、タスクが正常に完了したときにキャッシュするファイルとディレクトリを Turborepo に伝える
- Turborepo では、タスクの出力をキャッシュすることで、同じ作業を 2 度行うことはしない。

```json
{
  "tasks": {
    "build": {
      "outputs": [".next/**", "!.next/cache/**"]
    }
  }
}
```

### inputs の指定

- `inputs`キーは、キャッシュのためにタスクのハッシュに含めるファイルを指定するために使う
- デフォルトでは、Turborepo は Git が追跡しているパッケージ内のすべてのファイルを含める
- しかし、inputs キーを使うことで、ハッシュに含めるファイルをより細かく指定することができる

- 例として、Markdown ファイルのタイプミスを見つけるタスク

```json
{
  "tasks": {
    "spell-check": {
      "inputs": ["**/*.md", "**/*.mdx"]
    }
  }
}
```

### `turbo.json`

- [Configuring turbo.json](https://turbo.build/repo/docs/reference/configuration)

```json
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "tui",
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "inputs": ["$TURBO_DEFAULT$", ".env*"],
      "outputs": [".next/**", "!.next/cache/**"]
    },
    "lint": {
      "dependsOn": ["^lint"]
    },
    "dev": {
      "cache": false, // cacheを作るかどうか
      "persistent": true
    },
    "start": {
      "dependsOn": ["^start"]
    }
  }
}
```

## コマンド

- `turbo build`
  - リポジトリの依存関係グラフに従って、build スクリプトを実行する
- `turbo generate`
  - [Generator](https://turbo.build/repo/docs/guides/generating-code)を実行して新しいコードをリポジトリに追加する

## Scope

## Cache

## Build
