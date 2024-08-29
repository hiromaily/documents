# pnpm

ディスク容量の節約とインストール速度の向上、node_modules の厳格さに焦点を当てているので、monorepo 向きと言える

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

# monorepo内の指定packageのtaskを実行
pnpm --filter "@babel/core" test
```

## 構成

### [package.json](https://pnpm.io/package_json)

### [Settings (.npmrc)](https://pnpm.io/npmrc)

### [pnpm-workspace.yaml](https://pnpm.io/pnpm-workspace_yaml)

```yaml
packages:
  # packages/ の直下のサブディレクトリにあるすべてのパッケージ
  - "packages/*"
  # components/ のサブディレクトリにあるすべてのパッケージ
  - "components/**"
  # テストディレクトリ内にあるパッケージを除外
  - "!**/test/**"
```

これは再起的に参照していないように思える。階層が深い場合は、個別にも追加が必要かもしれない

```yaml
packages:
  - 'apps/*'
  - 'packages/*'
  - 'packages/common/*'
  - 'packages/web/*'
```

## pnpm に移行する際に発生した問題

### `WARN  The "workspaces" field in package.json is not supported by pnpm. Create a "pnpm-workspace.yaml" file instead.`

- `pnpm-workspace.yaml` を作成

```yaml
packages:
  - "apps/*"
  - "packages/*"
  - 'packages/common/*'
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

#### `.npmrc`ファイルを作成し以下設定を追加

```ini
link-workspace-packages=true
```

#### 各 package.json 内にて、internal の repository の参照方法に、`workspace:*`の指定が必要

```json
{
  "name": "web",
  "dependencies": {
    "next": "xx",
    "react": "xx",
    "ui": "workspace:*" // uiパッケージをinternalとして参照する
  }
}
```

### `ERR_PNPM_WORKSPACE_PKG_NOT_FOUND`

```sh
ERR_PNPM_WORKSPACE_PKG_NOT_FOUND  In apps/api: "@repo/typescript-config@workspace:*" is in the dependencies but no package named "@repo/typescript-config" is present in the workspace
```

- [github:pnpm ERR_PNPM_WORKSPACE_PKG_NOT_FOUND  when pnpm install in a workspace with local package](https://github.com/pnpm/pnpm/issues/7678)
- ["<PackageA> is in the dependencies but no package named <PackageA> is present in the workspace" - Error when running pnpm install](https://stackoverflow.com/questions/77865368/packagea-is-in-the-dependencies-but-no-package-named-packagea-is-present-in)

#### pnpm-workspace.yamlに `'packages/common/*'` を追加
```yaml
packages:
  - 'apps/*'
  - 'packages/*'
  - 'packages/common/*'
  - 'packages/web/*'
```

### ` This project's package.json defines "packageManager": "yarn@pnpm@9.9.0". However the current global version of Yarn is x.xx.`

- repositoryにyarn関連のファイルが残っていた

## コンテナ内で、`pnpm install`実行時に、lifetime scriptの実行で失敗する場合

- `--ignore-scripts` オプションをつける
  - Don't run lifecycle scripts

```dockerfile
RUN pnpm install --ignore-scripts
```

## References

- [JavaScript パッケージ管理ツール「pnpm」の紹介 (2023)](https://zenn.dev/cloud_ace/articles/articlejs-package-manager-pnpm)
