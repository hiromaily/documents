# npm

`npm`は github に買収されているので、開発体制はかなり整っていると思われる

## [npm ci](https://docs.npmjs.com/cli/v10/commands/npm-ci)

`clean-install`の意味

このコマンドは`npm install`と似ているが、テストプラットフォームや継続的インテグレーション、デプロイなどの自動化された環境で使うことを意図している

### npm install と npm ci の主な違い

- プロジェクトの `package-lock.json` または `npm-shrinkwrap.json` が存在しなければならない。
- package.lock 内の依存関係が package.json 内の依存関係と一致しない場合、 `npm ci` は package lock を更新する代わりにエラーで終了する。
- npm ci は一度にプロジェクト全体をインストールすることしかできない。
- `node_modules` が既に存在する場合、`npm ci` がインストールを開始する前に自動的に削除される。
- package.json や package.lock に書き込まれることはない。

[npm install と npm ci って結局どう使うの？2023 年版](https://bufferings.hatenablog.com/entry/2023/03/15/215044)
