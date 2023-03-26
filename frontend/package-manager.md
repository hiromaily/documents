# Package manager
- npm
- yarn
- pnpm

![npm vs yarn](https://raw.githubusercontent.com/hiromaily/documents/main/images/yarn-npm.png 'npm vs yarn')

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

## [yarn / yarn v2](https://yarnpkg.com/)

- npm ci 相当の yarn command

```
yarn install --frozen-lockfile
 or
rm -rf node_modules && yarn install --frozen-lockfile
```

## [pNPm](https://pnpm.io/)