# Biome: Install / Migrate

## Install with bun

```sh
bun add --dev --exact @biomejs/biome
bunx biome init
```

`biome init`後のメッセージ

```sh
Files created

  - biome.json
    Your project configuration. See https://biomejs.dev/reference/configuration

Next Steps

  1. Setup an editor extension
     Get live errors as you type and format when you save.
     Learn more at https://biomejs.dev/guides/integrate-in-editor/

  2. Try a command
     biome check  checks formatting, import sorting, and lint rules.
     biome --help displays the available commands.

  3. Migrate from ESLint and Prettier
     biome migrate eslint   migrates your ESLint configuration to Biome.
     biome migrate prettier migrates your Prettier configuration to Biome.

  4. Read the documentation
     Find guides and documentation at https://biomejs.dev/guides/getting-started/

  5. Get involved with the community
     Ask questions and contribute on GitHub: https://github.com/biomejs/biome
     Seek for help on Discord: https://discord.gg/BypW39g6Yc
```

## [Migration eslint with bun](https://biomejs.dev/guides/migrate-eslint-prettier/)

```sh
# bunx biome migrate eslint
bunx biome migrate eslint --write
# bunx biome migrate eslint --write --include-inspired
```

### `ERR_MODULE_NOT_FOUND`エラーが発生

```sh
  ✖ Migration has encountered an error: `node` was invoked to resolve '@hono-bun/eslint-config-eslint-config/index.js'. This invocation failed with the following error:
    node:internal/modules/esm/resolve:839
      throw new ERR_MODULE_NOT_FOUND(packageName, fileURLToPath(base), null);
            ^

    Error [ERR_MODULE_NOT_FOUND]: Cannot find package '@hono-bun/eslint-config-eslint-config' imported from /Users/{HOME}/work/org/repo/apps/web/[eval]
  ...
  ...
.eslintignore contains negated glob patterns that start with !.
These patterns cannot be migrated because Biome doesn't support them.
```

- [biome: eslint migration find/replace bug](https://github.com/biomejs/biome/issues/3079)
- monorepo による外の workspace の依存を解決できないと思われる。
  ~~`@hono-bun/eslint-config`側の依存を暫定的に、該当 workspace に install。~~
- 依存の`"@hono-bun/eslint-config": "workspace:*",`を一旦削除し、root から再 install
  - なぜか、参照してもいない、`Cannot find package '@hono-bun/eslint-config-eslint-config'`のエラーが引き続き発生する
- エラーは出るが、`biome.json`は下記蹴られた

## Migration prettier with bun

```sh
bunx biome migrate prettier --write
```

- prettier の migrate はほぼ問題なさそう

```sh
❯ bunx biome migrate prettier --write
.prettierignore contains negated glob patterns that start with !.
These patterns cannot be migrated because Biome doesn't support them.
.prettierrc has been successfully migrated.
```
