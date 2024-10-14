# Package Manager

- npm
- yarn
- pnpm
- Bun's package manager

## Trend

- [npm vs pnpm vs yarn](https://npmtrends.com/npm-vs-pnpm-vs-yarn)

圧倒的に`npm`、次いで`pnpm`

## コマンド チートシート

| 機能                         | npm コマンド                   | Yarn コマンド                    | pnpm コマンド                    |
| ---------------------------- | ------------------------------ | -------------------------------- | -------------------------------- |
| パッケージのインストール     | `npm install`                  | `yarn install`                   | `pnpm install`                   |
| パッケージの追加             | `npm install <pkg>`            | `yarn add <pkg>`                 | `pnpm add <pkg>`                 |
| 開発依存の追加               | `npm install --save-dev <pkg>` | `yarn add <pkg> --dev`           | `pnpm add -D <pkg>`              |
| グローバルパッケージの追加   | `npm install -g <pkg>`         | `yarn global add <pkg>`          | `pnpm add -g <pkg>`              |
| パッケージの削除             | `npm uninstall <pkg>`          | `yarn remove <pkg>`              | `pnpm remove <pkg>`              |
| パッケージの更新             | `npm update`                   | `yarn upgrade`                   | `pnpm update`                    |
| パッケージのリスト           | `npm list`                     | `yarn list`                      | `pnpm list`                      |
| グローバルパッケージのリスト | `npm list -g --depth 0`        | `yarn global list`               | `pnpm list -g`                   |
| キャッシュのクリア           | `npm cache clean --force`      | `yarn cache clean`               | `pnpm store prune`               |
| パッケージの実行             | `npx <pkg>`                    | `yarn dlx <pkg>`                 | `pnpm dlx <pkg>`                 |
| スクリプトの実行             | `npm run <script>`             | `yarn run <script>`              | `pnpm run <script>`              |
| プロジェクトの初期化         | `npm init`                     | `yarn init`                      | `pnpm init`                      |
| ロックファイルの生成         | `npm install` (自動生成)       | `yarn install` (自動生成)        | `pnpm install` (自動生成)        |
| クリーンインストール         | `npm ci`                       | `yarn install --frozen-lockfile` | `pnpm install --frozen-lockfile` |

## npm/yarn/pnpmは何が違うのか？

## Performance 比較

- [npm vs yarn](https://raw.githubusercontent.com/hiromaily/documents/main/images/yarn-npm.png "npm vs yarn")
- [2023: npm, yarn, pnpm パッケージマネージャをベンチマークしてみた](https://zenn.dev/minedia/articles/2023-08-30-pnpm)
  - `yarn v4` は全項目において最速らしいが、2023 年末時点で`dev`バージョンのみで stable ではない様子
- [Benchmarks of JavaScript Package Managers](https://pnpm.io/benchmarks)
  - yarn は`v4`を使ってようやくいい勝負ができるレベル
