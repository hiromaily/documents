# ESLint + Prettier

- [ESLInt](https://eslint.org/)
- [サバイバル Typescript: ESLint で TypeScript のコーディング規約チェックを自動化しよう](https://typescriptbook.jp/tutorials/eslint)
- [ESLint + Prettier + Typescript and React in 2022](https://blog.devgenius.io/eslint-prettier-typescript-and-react-in-2022-e5021ebca2b1)

## Flat Config

- ファイル名が `eslint.config.js` 固定であり、必ず JavaScript で書かなければいけない

### 設定方針

- ベースとなる設定を選ぶ
  - airbnb (人気が高いが、設定が多い)
  - standard (シンプル)
  - google
- 環境に合わせて Plugin を入れる
- 必要に応じて独自設定を追加する

## Plugin

- strict-dependencies
- @typescript-eslint
- eslint-plugin-import
- eslint-plugin-react
- eslint-plugin-jest
- eslint-plugin-storybook

## Rules

## VSCode の 設定

- Install [ESLInt extension](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)

### Settings の編集

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "prettier.trailingComma": "es5",
  "prettier.requireConfig": false,
  "prettier.singleQuote": true,
  "prettier.useTabs": true,
  "prettier.tabWidth": 2,
  "prettier.printWidth": 80,
  "editor.tabSize": 2,
  "editor.codeActionsOnSave": ["source.formatDocument", "source.fixAll.eslint"]
}
```

## `package.json` scripts

### Pattern A

```json
  "scripts": {
    "lint": "eslint src/**/*.{js,jsx,ts,tsx,json}",
    "lint:fix": "eslint --fix 'src/**/*.{js,jsx,ts,tsx,json}'",
    "format": "prettier --write 'src/**/*.{js,jsx,ts,tsx,css,md,json}' --config ./.prettierrc",
    "type-check": "tsc --noEmit",
    "all": "npm run format && npm run lint:fix && npm run type-check"
  },
```

### Pattern B

```json
"lint": "tsc --noEmit && eslint src/**/*.ts{,x} --cache --max-warnings=0",
"lint:fix": "eslint src/**/*.ts{,x} --fix"
```

## `.eslintignore` の編集

```txt
dist
```

## [ESLint Rules](https://eslint.org/docs/latest/rules/)

## 便利な機能

### import の自動ソート / Import Rules

- [ESlint で import を自動ソートする](https://zenn.dev/riemonyamada/articles/02e8c172e1eeb1)
- [TypeScript / JavaScript の import を自動でソートする](https://buildersbox.corp-sansan.com/entry/2021/05/28/110000)

```json
{
    "extends": [
        ...
        "plugin:import/recommended",
        "plugin:import/warnings"
    ],
    ...
    "rules": {
        "import/order": [
          "error",
          {
            "alphabetize": {
              "order": "asc"
            }
          }
        ]
    }
}
```

### 循環参照の検知

- [import/no-cycle](https://github.com/import-js/eslint-plugin-import/blob/main/docs/rules/no-cycle.md)

```json
{
  "plugins": ["import"], // これは`"strict-dependencies"` もしくは `@typescript-eslint`が設定されていれば不要
  "rules": {
    "import/no-cycle": "error"
  }
}
```

### 未参照の function や variable の検知

- [ESLint: no-unused-vars](https://eslint.org/docs/latest/rules/no-unused-vars)
- [no-unused-vars](https://github.com/typescript-eslint/typescript-eslint/blob/main/packages/eslint-plugin/docs/rules/no-unused-vars.md)
  - function の場合、`export`されているものに関しては、検知されない

```js
  rules: {
    '@typescript-eslint/no-unused-vars': ['warn', { 'vars': 'all', 'args': 'none' }],
  },
```

#### export された function を検知する場合

- [eslint-plugin-unused-imports](https://www.npmjs.com/package/eslint-plugin-unused-imports)

```js
  plugins: ['unused-imports'],
  rules: {
    'unused-imports/no-unused-imports': 'error',
  },
```

### enum の禁止

- [eslint-plugin-typescript-enum](https://github.com/shian15810/eslint-plugin-typescript-enum/tree/main)

### spell チェック

- [eslint-plugin-spellcheck](https://www.npmjs.com/package/eslint-plugin-spellcheck)

### 命名規則の導入

- [typescript-eslint/naming-convention](https://typescript-eslint.io/rules/naming-convention/)
