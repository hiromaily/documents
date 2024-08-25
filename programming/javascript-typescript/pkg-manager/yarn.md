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

これは monorepo 構成を使っているプロジェクトにおいて、各 workspace に存在しない依存パッケージが外部の workspace で install されている場合、参照できてしまう問題。  
Yarn v1 では、さまざまなパッケージのすべての依存関係がデフォルトでルートの `node_modules` フォルダーにまとめられる。つまり、1 つのパッケージ (A) だけが eslint を依存関係として宣言している場合でも、パッケージ B を含むワークスペース内のすべてのパッケージで eslint を利用できてしまう。
これは、[phantom dependencies](https://rushjs.io/pages/advanced/phantom_deps/)と呼ばれるらしい。ここでも、`Unfortunately this project's missing declarations are best considered a bug`として考えられている。

そもそも nonorepo の外に workspace を出して、npm install で動かないのであれば、package.json がおかしい。
この問題は npm でも存在している

[zenn の Phantom Dependencies](https://zenn.dev/estra/articles/npm-about-dependencsies#phantom-dependencies)

### 解決方法

- "nohoist" configuration in your root package.json.
- Switching to stricter package managers like `pnpm`, which avoid hoisting by design
