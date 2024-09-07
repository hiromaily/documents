# package.json + npmrc

[package.json (npm: v10)](https://docs.npmjs.com/cli/v10/configuring-npm/package-json)

## 設定

### 基本情報

- **name**:

  - プロジェクトの名前を指定する。npm リポジトリに公開する場合、全て小文字で、スペースを含むことはできず、ハイフンで区切られるべき。

  ```json
  "name": "my-project"
  ```

- **version**:

  - プロジェクトのバージョンを指定する。セマンティックバージョニング（SemVer）に従うことが推奨される。

  ```json
  "version": "1.0.0"
  ```

- **description**:

  - プロジェクトの簡単な説明を記述する。

  ```json
  "description": "A sample project"
  ```

- **main**:

  - プロジェクトのエントリーポイントとなるファイルを指定する。通常「index.js」とされることが多い。
  - このパッケージを他のプロジェクトでインストールし、`import`を使用してロードするとき、指定のファイルが自動的にロードされる。
  - `main`フィールドが指定されていない場合、Node.js はデフォルトで`index.js`ファイルを探しに行く。

  ```json
  "main": "index.js"
  ```

### 依存関係の管理

- **dependencies**:

  - プロジェクトが動作するために必要なパッケージのリスト。これらは`npm install`を実行すると自動的にインストールされる。

  ```json
  "dependencies": {
    "react": "^17.0.2",
    "typescript": "^4.3.5"
  }
  ```

- **devDependencies**:

  - 開発環境で必要なパッケージ。プロジェクトの開発やビルドには必要だが、最終的なプロダクトには含めないもの。

  ```json
  "devDependencies": {
    "eslint": "^9.32.0",
    "typescript": "^5.3.5"
  }
  ```

- **peerDependencies**:

  - 他のパッケージとともにインストールされる必要がある依存関係。ユーザーに特定のバージョンのパッケージのインストールを促すために使用される。

  ```json
  "peerDependencies": {
    "react": "^18.0.0"
  }
  ```

- **optionalDependencies**:

  - プロジェクトの動作に必須ではないが、利用する可能性のある依存関係。インストールに失敗してもプロジェクト全体がインストールされることを防止しない。

  ```json
  "optionalDependencies": {
    "fsevents": "^2.3.2"
  }
  ```

### Task 管理

- **scripts**:

  - npm で実行可能なスクリプトを定義する。これにより、ビルド、テスト、デプロイなどのタスクを簡単に実行できる。

  ```json
  "scripts": {
    "dev": "bun run --hot src/index.ts",
    "prod": "bun run src/index.ts",
    "lint:biome": "bunx @biomejs/biome check --write ./src"
  }
  ```

### CLI の場合

- **bin**:

  - コマンドラインツールとして使用される実行可能ファイルを指定する。これにより、npm インストール後にシステムのパスにシンボリックリンクが作成される。

  ```json
  "bin": {
    "mycli": "./bin/mycli.js"
  }
  ```

### あると便利な設定

- **imports**:

  - 特定のモジュールやパスがインポートされたときに、異なるモジュールやパスを指すように設定するためのマッピングを提供する。
  - [内部 Docs](../../../monorepo/turborepo.md#imports-option)

  ```json
  "imports": {
    "#alias/path": "./real-path.js",
    "#*": "./*"
  }
  ```

- **private**:

  - プロジェクトが公開されないように設定する。このフィールドを`true`に設定すると、誤って npm に公開されることを防止できる。

  ```json
  "private": true
  ```

- **config**:

  - プロジェクトに特有の設定値を定義するために使用する。スクリプト内で利用することができる。
  - Node.js のプロセスで利用される設定であり、フロントエンド（ブラウザ側）で直接利用することはできない

  ```json
  "config": {
    "port": "8080"
  }
  ```

  これにより、`process.env.npm_package_config_port`を利用して「port」の値を参照可能。

- **engines**:

  - プロジェクトが動作する Node.js のバージョンや npm のバージョンを指定する。特定のバージョンに依存する機能を使う場合に役立つ。

  ```json
  "engines": {
    "node": ">=20.0.0",
    "npm": ">=10.0.0"
  }
  ```

- **browser**:

  - Node.js 用のモジュールをブラウザでも利用できるようにするためのエントリーポイントを指定する。これはブラウザ対応を考慮したパッケージに特に有用。

  ```json
  "browser": {
    "./lib/index.js": "./lib/browser.js"
  }
  ```

### 公開する場合に有用な設定

- **files**:

  - npm にパッケージを公開する際に含めるファイルやディレクトリを指定する。不要なファイルを除外して、パッケージを軽量化するために使用される。

  ```json
  "files": [
    "lib/",
    "README.md"
  ]
  ```

- **man**:

  - マニュアルページを指定する。これにより、インストールされたパッケージのマニュアルページを`man`コマンドで参照できるようになる。

  ```json
  "man": "./man/mycli.1"
  ```

- **directories**:

  - プロジェクト内の特定のディレクトリを指定する。ドキュメントディレクトリやテストディレクトリなどに使用される。これらは情報提供のためで、動作に影響を与えるわけではない。

  ```json
  "directories": {
    "doc": "./docs",
    "test": "./test"
  }
  ```

- **publishConfig**:

  - npm にパッケージを公開する際の設定を指定する。このフィールドを利用して、特定のレジストリやパブリッシュタグを設定できる。

  ```json
  "publishConfig": {
    "registry": "https://my-custom-registry.com",
    "tag": "beta"
  }
  ```

- **bundleDependencies**（または**bundledDependencies**）:

  - パッケージと一緒にバンドルして公開する依存関係を指定する。これにより、特定のバージョンの依存関係を含めて配布することができる。

  ```json
  "bundleDependencies": [
    "some-dependency",
    "another-dependency"
  ]
  ```

### サブ情報 (無くても困らない)

- **author**:

  - プロジェクトの開発者の情報を指定する。

  ```json
  "author": {
    "name": "Your Name",
    "email": "you@example.com",
    "url": "https://yourwebsite.com"
  }
  ```

- **contributors**:

  - プロジェクトの貢献者のリストを指定する。これにより、複数の開発者の情報を記載できる。

  ```json
  "contributors": [
    {
      "name": "Contributor One",
      "email": "contributor1@example.com"
    },
    {
      "name": "Contributor Two",
      "email": "contributor2@example.com"
    }
  ]
  ```

- **repository**:

  - プロジェクトのリポジトリ情報を指定する。主にオープンソースプロジェクトで使用される。

  ```json
  "repository": {
    "type": "git",
    "url": "https://github.com/user/repo.git"
  }
  ```

- **bugs**:

  - バグ報告用の URL やメールアドレスを指定する。

  ```json
  "bugs": {
    "url": "https://github.com/user/repo/issues",
    "email": "support@example.com"
  }
  ```

- **homepage**:

  - プロジェクトのホームページやドキュメントへのリンクを指定する。

  ```json
  "homepage": "https://example.com/my-project"
  ```

- **keywords**:

  - プロジェクトに関連するキーワードをリスト形式で指定する。npm の検索結果での可視性を向上させるために役立つ。

  ```json
  "keywords": [
    "typescript",
    "frontend",
    "react"
  ]
  ```

- **license**:

  - プロジェクトのライセンス情報を指定する。

  ```json
  "license": "MIT"
  ```
