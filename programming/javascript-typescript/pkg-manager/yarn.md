# yarn

- [npm vs pnpm vs yarn](https://npmtrends.com/npm-vs-pnpm-vs-yarn)
  - 見てもわかるが、完全に down trend
- `yarn v4`は速いが、mac 環境で`brew`経由で yarn を install している人は知らずに`v1`を使い続けることになるので注意

## Install

```sh
volta install yarn@4
```

## monorepo における v1 の不具合

- [Yarn workspace not hoisting dependencies correctly](https://github.com/yarnpkg/yarn/issues/7572)

これは monorepo 構成を使っているプロジェクトにおいて、各 workspace に存在しない依存パッケージが外部の workspace ですでに install されている場合、参照できてしまう問題。
そのため、
