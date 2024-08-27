# pnpm

ディスク容量の節約とインストール速度の向上、node_modules の厳格さに焦点を当てているので、monorepo向きと言える

- ストレージが効率的
- インストールが高速
  - 依存関係の解決（Resolving）
  - ディレクトリ構造の計算（Fetching）
  - 依存関係をリンク（Linking）

## Install

```sh
# 2024/8現在、`v9.9`がinstallされる
volta install pnpm
```

## コマンド例

```sh
pnpm init
pnpm create next-app

pnpm add <pkg>
pnpm add -D <pkg> # devDependencies
pnpm add -O <pkg> # optionalDependencies
pnpm add -g <pkg> # global install

pnpm install
pnpm store prune
pnpm update --latest
```

## pnpmに移行する際に発生した問題

### `WARN  The "workspaces" field in package.json is not supported by pnpm. Create a "pnpm-workspace.yaml" file instead.`

- `pnpm-workspace.yaml` を作成

```yaml
packages:
  - 'apps/*'
  - 'apps/batch/*'
  - 'packages/*'
  - 'packages/api/*'
  - 'packages/web/*'
```

### `ERROR  This project is configured to use yarn`

```sh
rm -rf yarn.lock .yarnrc.yml .yarnrc .yarn
```

- remove `yarn` from package.json
```json
{
 // ...
 "packageManager": "yarn@..." // switch to pnpm@9.9.0
 // ...
}
```

### `ERR_PNPM_FETCH_404  GET https://registry.npmjs.org/xxxxx: Not Found - 404`

- [github:pnpm ERR_PNPM_FETCH_404 for workspace packages](https://github.com/pnpm/pnpm/issues/8036)
- [pnpm: Workspace Settings](https://pnpm.io/npmrc#workspace-settings)
  - `.npmrc`ファイルを作成し以下設定を追加

```
link-workspace-packages=true
```

- `workspace: protocol in dependencies`とは？

## References

- [JavaScriptパッケージ管理ツール「pnpm」の紹介 (2023)](https://zenn.dev/cloud_ace/articles/articlejs-package-manager-pnpm)