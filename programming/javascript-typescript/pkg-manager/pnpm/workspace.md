# workspace (monorepo)

## [Workspace Settings (.npmrc)](https://pnpm.io/npmrc#workspace-settings)

### `hoisting`の設定

#### `hoist`: true (default)

`true` の場合、全ての依存パッケージは `node_modules/.pnpm/node_modules` にホイストされる。 これにより、node_modules 内のすべてのパッケージから、リストにない依存関係にアクセスできるようになる。

#### `hoist-workspace-packages`: true (default)

`true` の場合、ワークスペースのパッケージは `<workspace_root>/node_modules/.pnpm/node_modules` または `<workspace_root>/node_modules` のいずれかにシンボリックリンクされる

#### `hoist-pattern`: `['*'] ['*']` (default)

## シンボリックリンクされた`node_modules`構造体

- pnpm の `node_modules` レイアウトは、 シンボリックリンクを使って依存関係の入れ子構造を作る
-
