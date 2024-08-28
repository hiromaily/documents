# workspace (monorepo)

## [Workspace Settings (.npmrc)](https://pnpm.io/npmrc#workspace-settings)

### `hoisting`の設定

- hoist: true (default)

`true` の場合、全ての依存パッケージは `node_modules/.pnpm/node_modules` にホイストされる。 これにより、node_modules 内のすべてのパッケージから、リストにない依存関係にアクセスできるようになる。


