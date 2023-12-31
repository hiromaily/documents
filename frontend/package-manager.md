# Package Manager

- npm
- yarn
- pnpm
- Bun's package manager

## [npm](https://www.npmjs.com/)

### Command

- [npm install](https://docs.npmjs.com/cli/v8/commands/npm-install)
  - 依存関係をローカルの`node_modules`ディレクトリにインストールする
  - 以下の優先順位でファイルを探していく
    - npm-shrinkwrap.json
    - package-lock.json
    - yarn.lock
  - `--production`オプションまたは環境変数`NODE_ENV`に`production`が設定されている場合は、devDependencies に
    記述されている依存関係はインストールされない
- [npm ci](https://docs.npmjs.com/cli/v8/commands/npm-ci)
  - CI 環境やテスト環境での利用、依存関係のクリーンインストールを行う場合に使用する
  - 条件として、`package-lock.json`もしくは`npm-shrinkwrap.json`のどちらかを保持している必要がある
  - `node_modules`ディレクトリが存在する場合は、`npm ci`の実行前に自動的に削除される
  - `package.json`や`package-lock.json`ファイルへの更新は行われない

## [yarn / yarn v2, v3, v4](https://yarnpkg.com/)

Yarn is an established open-source package manager used to manage dependencies in JavaScript projects

### npm ci 相当の yarn command

```sh
yarn install --frozen-lockfile
 or
rm -rf node_modules && yarn install --frozen-lockfile
```

## [pnPm](https://pnpm.io/)

Fast, disk space efficient package manager

### 特徴

- Fast: pnpm is up to 2x faster than npm
- Efficient: Files inside node_modules are cloned or hard linked from a single content-addressable storage
- Supports monorepos

## [bun](https://bun.sh/guides/install)

- [なんで bun install は速いのか？](https://zenn.dev/laiso/scraps/9a787a6888e228)
  - [疑問] node project の代わりにはなるが、frontend project では難しい？？

## Performance 比較

- [npm vs yarn](https://raw.githubusercontent.com/hiromaily/documents/main/images/yarn-npm.png "npm vs yarn")
- [2023: npm, yarn, pnpm パッケージマネージャをベンチマークしてみた](https://zenn.dev/minedia/articles/2023-08-30-pnpm)
  - `yarn v4` は全項目において最速らしいが、2023 年末時点で`dev`バージョンのみで stable ではない様子
