# [npm](https://www.npmjs.com/)

`npm`は github に買収されているので、開発体制はかなり整っていると思われる

## Command

### [npm install](https://docs.npmjs.com/cli/v10/commands/npm-install)

- 依存関係をローカルの`node_modules`ディレクトリにインストールする
- 以下の優先順位でファイルを探していく
  - npm-shrinkwrap.json
  - package-lock.json
  - yarn.lock
- `--production`オプションまたは環境変数`NODE_ENV`に`production`が設定されている場合は、devDependencies に
記述されている依存関係はインストールされない

### [npm ci](https://docs.npmjs.com/cli/v10/commands/npm-ci)

`clean-install`の意味

このコマンドは`npm install`と似ているが、テストプラットフォームや継続的インテグレーション、デプロイなどの自動化された環境で使うことを意図している

- CI 環境やテスト環境での利用、依存関係のクリーンインストールを行う場合に使用する
- 条件として、`package-lock.json`もしくは`npm-shrinkwrap.json`のどちらかを保持している必要がある
- `node_modules`ディレクトリが存在する場合は、`npm ci`の実行前に自動的に削除される
- `package.json`や`package-lock.json`ファイルへの更新は行われない

### npm install と npm ci の主な違い

- プロジェクトの `package-lock.json` または `npm-shrinkwrap.json` が存在しなければならない。
- package.lock 内の依存関係が package.json 内の依存関係と一致しない場合、 `npm ci` は package lock を更新する代わりにエラーで終了する。
- npm ci は一度にプロジェクト全体をインストールすることしかできない。
- `node_modules` が既に存在する場合、`npm ci` がインストールを開始する前に自動的に削除される。
- package.json や package.lock に書き込まれることはない。

[npm install と npm ci って結局どう使うの？2023 年版](https://bufferings.hatenablog.com/entry/2023/03/15/215044)

## monorepo における npm の不具合

- [[BUG] Dependency hoisting in workspaces not working, depending on workspace name](https://github.com/npm/cli/issues/4512)
