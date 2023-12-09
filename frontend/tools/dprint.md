# [dprint](https://dprint.dev/)

Rust 製の高速で動作するコードフォーマッター

## 設定

```sh
dprint init
```

### 設定例

```json
{
  "lineWidth": 100,
  "typescript": {
    "quoteStyle": "preferSingle",
    "quoteProps": "asNeeded",
    "semiColons": "always"
  },
  "json": {},
  "markdown": {},
  "toml": {},
  "includes": ["**/*.{ts,tsx,js,jsx,cjs,mjs,json,md,toml,html,graphql,yml}"],
  "excludes": ["**/node_modules", "**/*-lock.json"],
  "plugins": [
    "https://plugins.dprint.dev/typescript-0.88.3.wasm",
    "https://plugins.dprint.dev/json-0.19.0.wasm",
    "https://plugins.dprint.dev/markdown-0.16.2.wasm",
    "https://plugins.dprint.dev/toml-0.5.4.wasm"
  ]
}
```

## チェック

```sh
dprint check
```

## フォーマット

```sh
dprint fmt
```
