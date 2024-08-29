# Turborepo

Vercel 製の monorepo ツールだが、monorepo 以外でのワークフローの高速化も可能。  
turbo は `Workspaces` の上に構築されており、これは JavaScript エコシステムのパッケージマネージャの機能で、複数のパッケージを 1 つのリポジトリにまとめることができる。

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

## Docker 内での利用 `prune`

```dockerfile
# turbo prune [パッケージ]
RUN turbo prune patient-api --docker
```

### prune

- 対象パッケージの部分モノレポを生成する
- 出力は`out`というディレクトリに置かれ、以下のものが含まれる
  - ターゲットのビルドに必要なすべての内部パッケージの完全なソースコード
  - ターゲットのビルドに必要なオリジナルのロックファイルのサブセットを含むプルーニングされたロックファイル
  - root の package.json のコピー

#### --docker オプション

- default: false
- docker の layer caching を使いやすくするために、出力ディレクトリを変更する
  - `json`ディレクトリ: プルーニングされたワークスペースの `package.json` ファイルが含まれる
  - `full`ディレクトリ: ターゲットのビルドに必要な内部パッケージの、刈り込まれたワークスペースの完全なソースコードが格納される
  - ターゲットの構築に必要な元のロックファイルのサブセットを含むプルーニングされたロックファイル

以下コマンドの実行例

```dockerfile
RUN turbo prune frontend --docker
```

package 名に`frontend`を指定していても、それ以外も格納されている？

```
.
├── pnpm-lock.yaml (partial)
├── full/
│   ├── package.json (from root)
│   ├── apps
│   └── packages
└── json/
    ├── package.json (from root)
    └── packages/
        ├── ui/
        │   └── package.json
        ├── shared/
        │   └── package.json
        └── frontend/
            └── package.json
```

実際に Dockerfile 内で、`RUN ls -al`を実行して確認してみた

- `RUN ls -la /app/out`

  - full
  - json
  - pnpm-lock.yaml
  - pnpm-workspace.yaml

- `RUN ls -la /app/out/json`

  - .npmrc
  - apps
  - package.json
  - packages
  - pnpm-lock.yaml
  - pnpm-workspace.yaml

- `RUN ls -la /app/out/json/apps/batch/example`

  - package.json

- `RUN ls -la /app/out/full`

  - .gitignore
  - .npmrc
  - apps
  - package.json
  - packages
  - pnpm-workspace.yaml
  - turbo.json

- `RUN ls -la /app/out/full/apps/batch/example`

  - .env.example
  - Dockerfile
  - package.json
  - src
  - tsconfig.json

### `prune` references

- [turborepo: prune](https://turbo.build/repo/docs/reference/prune)
- [turborepo: Experimental: Pruned Workspaces](https://turbo.build/blog/turbo-0-4-0#experimental-pruned-workspaces)

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

#### name の命名について [重要]

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

### [依存関係のインストールのベストプラクティス](https://turbo.build/repo/docs/crafting-your-repository/managing-dependencies#best-practices-for-dependency-installation) [重要]

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

#### `$TURBO_DEFAULT$` でデフォルトに戻す

デフォルトの inputs 動作は、多くの場合、あなたのタスクに必要なものだが、inputs を微調整して、`タスクの出力に影響しないことが分かっているファイルの変更を無視する`ことで、特定のタスクのキャッシュヒット率を上げることができる

このため、$TURBO_DEFAULT$ マイクロシンタックスを使って、デフォルトの inputs の動作を微調整することができる

```json
{
  "tasks": {
    "build": {
      "inputs": ["$TURBO_DEFAULT$", "!README.md"]
    }
  }
}
```

このタスク定義では、Turborepo は inputs のデフォルトの動作を build タスクに使用するが、`README.md`ファイルの変更は無視する。  
README.md ファイルが変更されても、タスクはキャッシュをヒットする。

### ルートタスクの登録

- package.json 内のスクリプトを、turbo を使用してワークスペースのルートで実行することもできる
- たとえば、各パッケージの lint タスクに加えて、ワークスペースのルート・ディレクトリのファイルに対して`lint:root`タスクを実行したい場合

- turbo.json

```json
{
  "tasks": {
    "lint": {
      "dependsOn": ["^lint"]
    },
    "//#lint:root": {}
  }
}
```

- root package.json

```json
{
  "scripts": {
    "lint": "turbo run lint",
    "lint:root": "eslint ."
  }
}
```

### 副作用の実行

- キャッシュビルド後のデプロイスクリプトのように、何があっても常に実行されるべきタスクもある
- このようなタスクには、タスク定義に `"cache": false` を追加する

```json
{
  "tasks": {
    "deploy": {
      "dependsOn": ["^build"],
      "cache": false
    },
    "build": {
      "outputs": ["dist/**"]
    }
  }
}
```

### 並列実行可能な依存タスク

他のパッケージに依存しているにもかかわらず、Linter といった並列実行できるタスクがある。 リンターは正常に実行するために、依存関係の出力を待つ必要がない。

```json
{
  "tasks": {
    "check-types": {
      "dependsOn": ["^check-types"] // This works...but could be faster!
    }
  }
}
```

以下が正しい設定らしいが、まだ理解できていない  
[トランジット・ノード](https://turbo.build/repo/docs/core-concepts/package-and-task-graph#transit-nodes)をタスク・グラフに導入する

```json
{
  "tasks": {
    "transit": {
      "dependsOn": ["^transit"]
    },
    "check-types": {
      "dependsOn": ["transit"]
    }
  }
}
```

これらの Transit Node は、package.json のスクリプトにマッチしないため何もしないタスクを使用して、パッケージの依存関係の関係を作成する。 このため、タスクは内部の依存関係の変更を認識しながら、 並行して実行することができる。

## [タスクの実行](https://turbo.build/repo/docs/crafting-your-repository/running-tasks)

turbo によるタスクの実行は、開発中および CI パイプラインでリポジトリ全体のワークフローを実行するための 1 つのモデルを得られるので強力

`turbo` は `turbo run` のエイリアス  
将来追加される可能性のある turbo サブコマンドとの衝突を避けるため、`turbo run` を package.json と CI ワークフローで turbo を使用することを望ましい。

### scripts を package.json で使用する [重要]

頻繁に実行するタスクについては、turbo コマンドをルートの package.json に直接書き込むことができる。
これは root の package.json のみに留めないと再帰的に実行されてしまうので注意。

```json
{
  "scripts": {
    "dev": "turbo run dev",
    "build": "turbo run build",
    "test": "turbo run test",
    "lint": "turbo run lint"
  }
}
```

root から以下のように実行できる

```sh
npm run dev
```

### グローバルな turbo を使う (推奨されている様子)

グローバルに turbo をインストールすると、ターミナルから直接コマンドを実行できるようになる。 必要なときに必要なものを正確に実行することが容易になるため、ローカルでの開発体験が向上する。
さらに、グローバルな turbo は CI パイプラインで有用であり、パイプラインの各ポイントで実行するタスクを最大限にコントロールできる。

### パッケージの自動スコープ

パッケージのディレクトリにいるとき、turbo は自動的にそのパッケージの Package Graph にコマンドをスコープする。 つまり、パッケージ用のフィルタを書かなくても、素早くコマンドを書くことができる。(前提として global な turbo が利用できる必要がある)

```sh
cd apps/docs
turbo build
```

### 動作のカスタマイズ

#### 共通コマンドのバリエーション

`turbo build --filter=@repo/ui` を使えば、興味のある特定のパッケージを素早くフィルタリングできる

#### 単発のコマンド

`turbo build --dry` のようなコマンドは頻繁に必要になるものではないので、package.json にスクリプトを作成する必要はない。

#### turbo.json 設定の上書き

CLI フラグの中には、`turbo.json` に同等のものがあり、それを上書きすることができる。
グローバルな turbo を使えば、`turbo lint --output-logs=errors-only` でエラーだけを表示できます。

(global な turbo 限定?)

### 複数タスクの実行

turbo は複数のタスクを実行することができ、可能な限り並列化する

```sh
turbo run build test lint check-types
```

### フィルタの使用

- パッケージ名によるフィルタリング

```sh
turbo build --filter=@acme/web
```

- ディレクトリによるフィルタリング

```sh
turbo lint --filter="./packages/utilities/*"
```

- 依存関係を含めるフィルタリング

```sh
turbo build --filter=...ui
```

- ソース管理変更によるフィルター (複雑なので割愛)
- フィルタの組み合わせ (複雑なので割愛)

## [キャッシュ](https://turbo.build/repo/docs/crafting-your-repository/caching)

Turborepo はビルドを高速化するためにキャッシュを使用し、同じ作業を 2 度行わないようにする。 タスクがキャッシュ可能な場合、Turborepo はタスクが最初に実行された時のフィンガープリントを使用して、キャッシュからタスクの結果を復元する。  
また、[リモートキャッシュ](https://turbo.build/repo/docs/core-concepts/remote-caching)を有効にすると、チーム全体と CI 間でキャッシュを共有することができ、さらに強力になる

Turborepo は、タスクが決定論的であることを前提としている。 タスクが、Turborepo が認識している入力セットから異なる出力を生成できる場合、キャッシュは期待通りに動作しない可能性がある。

### 最初の Turborepo キャッシュを実行する

- 新しい Turborepo プロジェクトを作成する
- 初めてビルドを実行する: `npm run build`
- キャッシュを実行する: `npm run build`をもう一度実行すると、cache 結果が表示される。

### リモートキャッシュ

Turborepo は、タスクの結果を`.turbo/cache`ディレクトリに保存する。 しかし、このキャッシュをチームメイトや CI と共有することで、組織全体をさらに高速化することができる。

#### リモートキャッシュを有効にする

```sh
npx turbo login # Remote Cacheプロバイダーで認証
npx turbo link  # マシン上のリポジトリをリモートキャッシュにリンク
```

### 何がキャッシュされるのか？

- タスクの出力
- ログ
- タスクの入力
- グローバルハッシュ入力
- パッケージのハッシュ入力

### [トラブルシューティング](https://turbo.build/repo/docs/crafting-your-repository/caching#troubleshooting)

- `dry runs`の使用
- Run Summaries の使用
- キャッシュのオフ
- キャッシュの上書き
- タスクのキャッシュはタスクの実行よりも遅い

## [アプリケーションの開発](https://turbo.build/repo/docs/crafting-your-repository/developing-applications)

monorepo でアプリケーションを開発すると、強力なワークフローが解放され、コードに簡単にアクセスしながらソース管理へアトミックなコミットができるようになる。
ほとんどの開発タスクは、コードの変更を監視する長時間のタスク。 Turborepo は、強力なターミナル UI や様々な機能によって、このような経験を向上させる。

### 開発タスクの設定

```json
{
  "tasks": {
    "dev": {
      "cache": false,
      "persistent": true
    }
  }
}
```

- `"cache": false`: タスクの結果をキャッシュしないように Turborepo に指示
- `"persistent": true`: タスクを停止するまで実行し続けるように Turborepo に指示
  - このキーは、ターミナル UI がタスクを長時間実行するインタラクティブなものとして扱うためのシグナル
  - さらに、終了しないタスクに誤って依存することを防ぐ

#### タスクとの対話

いくつかのスクリプトでは、`stdin` を使って対話的に入力することができる。 [terminal ui](https://turbo.build/repo/docs/reference/configuration#ui) を使って、タスクを選択し、それを入力し、`stdin` を使うことができる。  
この機能を有効にするには、タスクは interactive でなければならない

### `dev` の前にセットアップタスクを実行する

開発環境のセットアップやパッケージの pre-build を行うスクリプトを実行したい場合、これらのタスクは、dev タスクの前に `dependsOn` で実行されるようにすることができる

```json
{
  "tasks": {
    "dev": {
      "cache": false,
      "persistent": true,
      "dependsOn": ["//#dev:setup"]
    },
    "//#dev:setup": {
      "outputs": [".codegen/**"]
    }
  }
}
```

この例では、ルート・タスクを使っているが、パッケージ内の任意のタスクにも同じアイデアを使うことができる

### 特定のアプリケーションの実行

```sh
turbo dev --filter=web
```

### ウォッチ・モード

多くのツールには、`tsc --watch`のように、ソースコードの変更に反応するウォッチャーが組み込まれているが、そうでないものもある。
`turbo watch` は、依存関係を意識したウォッチャーを任意のツールに追加する。 ソース コードへの変更は、他のすべてのタスクと同様に、turbo.json に記述したタスク グラフに従う。

- turbo.json

```json
{
  "tasks": {
    "dev": {
      "persistent": true,
      "cache": false
    },
    "lint": {
      "dependsOn": ["^lint"]
    }
  }
}
```

- package/ui

```json
{
  "name": "@repo/ui"
  "scripts": {
    "dev": "tsc --watch",
    "lint": "eslint ."
  }
}
```

- apps/web

```json
{
  "name": "web"
  "scripts": {
    "dev": "next dev",
    "lint": "eslint ."
  },
  "dependencies": {
      "@repo/ui": "workspace:*"
    }
}
```

`turbo watch dev lint`を実行すると、ESLint には組み込みのウォッチャーがないにもかかわらず、ソースコードを変更するたびに lint スクリプトが再実行される。 turbo watch は内部依存関係も認識しているため、@repo/ui でコードを変更すると、@repo/ui と web の両方でタスクが再実行される。

web にある Next.js 開発サーバーと、@repo/ui にある TypeScript コンパイラ組み込みのウォッチャーは、persistent でマークされているので、通常どおり動作する。

### 制限事項

#### Teardown tasks

場合によっては、dev タスクが停止しているときにスクリプトを実行したいことがある。 turbo が dev タスクの終了時に終了してしまうため、Turborepo は終了時にこれらのティアダウンスクリプトを実行することができない。

代わりに、`turbo dev:teardown`スクリプトを作成し、プライマリの turbo dev タスクが終了した後に個別に実行する。

## 環境変数の使用

Turborepo は、システム環境変数を使って、独自の動作を設定することもできる

### タスクハッシュに環境変数を追加する

Turborepo は、アプリケーションの動作の変化を考慮するために、環境変数を認識する必要がある。  
そのためには、`env` と `globalEnv` を `turbo.json` ファイルに記述する。

```json
{
  "globalEnv": ["IMPORTANT_GLOBAL_VARIABLE"],
  "tasks": {
    "build": {
      "env": ["MY_API_URL", "MY_API_KEY"]
    }
  }
}
```

- `globalEnv`: このリストにある環境変数の値を変更すると、すべてのタスクのハッシュが変更される。
- `env`: タスクに影響を与える環境変数の値の変更を含み、より細かい設定ができる。
  - 例えば、lint タスクは、`API_KEY` の値が変更されたときにキャッシュを逃す必要はないだろうが、build タスクはキャッシュを逃す必要があるだろう

#### フレームワーク推論

Turborepo では、`env` キーに、一般的なフレームワークのプレフィックスワイルドカードを自動的に追加する。
以下のフレームワーク(ここでは一部のみ記載)をパッケージで使用している場合、これらのプレフィックスで環境変数を指定する必要はない

- Next.js: `NEXT_PUBLIC_*`
- Create React App: `REACT_APP_*`

- フレームワーク推論をオプトアウトしたい場合
  - `--framework-inference=false` でタスクを実行
  - env キーに負のワイルドカードを追加する（e.g. `"env": ["!NEXT_PUBLIC_*"]`)

### 環境モード

Turborepo の環境モードでは、タスクの実行時に利用可能な環境変数を制御することができる

- Strict Mode (デフォルト)
  - 環境変数を`env`と`globalEnv`の turbo.json キーで指定されたものだけに絞り込む。
- Loose Mode
  - プロセスのすべての環境変数を利用可能にする。

### `.env` ファイルの取り扱い

`.env` ファイルはアプリケーションをローカルで作業するのに適している。 Turborepo は`.env` ファイルをタスクのランタイムにロードしない。
そのため、フレームワークや dotenv のようなツールに任せる必要がある。

しかし、turbo が`.env` ファイルの値の変更を知っていて、ハッシュに使えるようにしておくことは重要。
ビルドの間に `.env` ファイル内の変数を変更した場合、build タスクはキャッシュを見逃すだろう。

これを行うには、`inputs` キーにファイルを追加する

```json
{
  "globalDependencies": [".env"], // All task hashes
  "tasks": {
    "build": {
      "inputs": ["$TURBO_DEFAULT$", ".env", ".env.local"] // Only the `build` task hash
    }
  }
}
```

### ベストプラクティス [重要]

#### パッケージで .env ファイルを使う

- リポジトリのルートに`.env`ファイルを使用することは推奨されない。 代わりに、.env ファイルを使用するパッケージに配置する。
- 環境変数は各アプリケーションのランタイムに個別に存在するため、この方法はアプリケーションのランタイム動作をより忠実にモデル化する。
- さらに、モノレポの規模が大きくなるにつれて、この方法は各アプリケーションの環境管理を容易にし、アプリケーション間での環境変数のリークを防ぐ

#### `eslint-config-turbo`を使う

[eslint-config-turbo](https://turbo.build/repo/docs/reference/eslint-config-turbo)パッケージは、turbo.json にリストされていないコードで使用される`環境変数`を見つけるのに役立つ。 これにより、すべての環境変数が設定に含まれていることを確認できる。

#### 実行時の環境変数の作成や変更を避ける

Turborepo は、タスクの開始時にタスクの環境変数をハッシュ化する。タスクの途中で環境変数を作成したり、変更したりした場合、Turborepo はその変更を知ることができず、タスクハッシュに考慮されない

例えば、以下の例では、Turborepo はインライン変数を検出できない

```json
{
  "scripts": {
    "dev": "export MY_VARIABLE=123 && next dev"
  }
}
```

### 環境変数を使った例

- Next.js

```json
{
  "tasks": {
    "build": {
      "env": ["MY_API_URL", "MY_API_KEY"],
      "inputs": [
        "$TURBO_DEFAULT$",
        ".env.production.local",
        ".env.local",
        ".env.production",
        ".env"
      ]
    },
    "dev": {
      "inputs": [
        "$TURBO_DEFAULT$",
        ".env.development.local",
        ".env.local",
        ".env.development",
        ".env"
      ]
    },
    "test": {}
  }
}
```

### トラブルシューティング

- `--summarize`を使う

`--summarize` フラグを `turbo run` コマンドに追加することで、タスクに関するデータをまとめた JSON ファイルを生成することができる。
`globalEnv` と `env` キーの diff をチェックすることで、設定に欠けている環境変数を特定することができる。

## [CI の構築](https://turbo.build/repo/docs/crafting-your-repository/constructing-ci)

## [Upgrading](https://turbo.build/repo/docs/crafting-your-repository/upgrading)

## [`turbo.json`の設定](https://turbo.build/repo/docs/reference/configuration)

turbo.json ファイルを変更すると、グローバル ハッシュで考慮されるため、すべてのタスクのキャッシュが無効になる。
グローバル・ハッシュに影響を与えずに設定を柔軟に変更したい場合は、パッケージ設定を使用する必要がある。

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

build task の実行：リポジトリの依存関係グラフに従って、build スクリプトを実行する

```sh
turbo build
```

### グローバルオプション

- extends
  - [Package Configurations](https://turbo.build/repo/docs/reference/package-configurations)を使用してパッケージの特定の設定を作成するために、ルートの`turbo.json` から拡張する。
- globalDependencies
  - すべてのタスク・ハッシュに含めたいグロブのリスト。これらのグロブに一致するファイルが変更された場合、すべてのタスクはキャッシュを逃す
  - デフォルトでは、ワークスペースのルートでソース管理されているすべてのファイルがグローバルハッシュに含まれる
- globalEnv
  - 全タスクのハッシュに影響を与えたい環境変数のリスト。
  - これらの環境変数を変更すると、全てのタスクがキャッシュを逃すことになる。
- globalPassThroughEnv
  - タスクが利用できるようにしたい環境変数のリスト。
  - このキーを使用すると、すべてのタスクが Strict 環境変数モードになる
- ui
  - リポジトリのターミナル UI を選択
  - `"tui"` は各ログを一度に表示し、タスクと対話できる。
  - `"stream"` は入ってきたログをそのまま出力し、対話的ではない
    - Default: `"stream"`
- dangerouslyDisablePackageManagerCheck
- cacheDir
  - ファイルシステムのキャッシュ・ディレクトリを指定する
  - Default: `".turbo/cache"`
- daemon
  - Turborepo は、いくつかの高価な処理を事前に計算するためにバックグラウンドプロセスを実行する。
  - このスタンドアロンプロセス(デーモン)はパフォーマンスの最適化
  - Default: `true`
- envMode
  - Turborepo の環境モードでは、タスクの実行時に利用可能な環境変数を制御することができる
  - Default: `"strict"`

### task の定義

- tasks

#### タスク options

- dependsOn
  - タスクが実行を開始する前に完了する必要のあるタスクのリスト
- env
  - タスクが依存する環境変数のリスト
- passThroughEnv
  - `Strict Environment Mode` のときでも、このタスクのランタイムが利用できるようにする環境変数の許可リスト
- outputs
  - タスクが正常に完了したときにキャッシュする、パッケージの package.json に関連するファイル glob パターンのリスト
- cache
  - タスク出力をキャッシュするかどうかを定義する
  - Default: `true`
- inputs
  - ソース・コントロールにチェックインされたパッケージの全ファイル
  - Default: `[]`
- outputLogs
  - 出力ロギングの冗長度を設定する
  - Default: `full`
- persistent
  - タスクに`persistent`というラベルを付けることで、 他のタスクが長時間実行するプロセスに依存しないようにする
  - Default: `false`
- interactive
  - interactive としてラベル付けされたタスクは、ターミナル UI で `stdin` からの入力を受け付ける
  - Default: `true`

## [パッケージ構成](https://turbo.build/repo/docs/reference/package-configurations)

## [コマンド](https://turbo.build/repo/docs/reference#commands)

- `turbo run`
- `turbo prune`
- `turbo generate`
  - [Generator](https://turbo.build/repo/docs/guides/generating-code)を実行して新しいコードをリポジトリに追加する
- `turbo login`
- `turbo logout`
- `turbo link`
- `turbo unlink`
- `turbo scan`
- `turbo bin`
- `turbo telemetry`
