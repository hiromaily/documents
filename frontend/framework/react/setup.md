# React Set up

- [Start Development](../../start-development.md)

## Pattern A
- [Set Up ESLint and Prettier in a React TypeScript App (2023)](https://javascript.plainenglish.io/set-up-eslint-and-prettier-in-a-react-typescript-app-2022-7d9a5f40b634)

### 依存
- eslint
- eslint-config-airbnb
- prettier

```
yarn add -D \
@typescript-eslint/eslint-plugin \
@typescript-eslint/parser \
eslint \
eslint-config-airbnb \
eslint-config-airbnb-typescript \
eslint-config-prettier \
eslint-import-resolver-typescript \
eslint-plugin-import \
eslint-plugin-jsx-a11y \
eslint-plugin-prettier \
eslint-plugin-react \
eslint-plugin-react-hooks \
prettier
```
- `npm install --save-dev` or `yarn add -D`

### ESLintの設定 `.eslintrc.json`
```json
{
    "env": {
        "browser": true,
        "es6": true
    },
    "extends": [
        "eslint:recommended",
        "airbnb/hooks",
        "airbnb-typescript",
        "plugin:react/recommended",
        "plugin:react/jsx-runtime",
        "plugin:@typescript-eslint/recommended",
        "plugin:@typescript-eslint/recommended-requiring-type-checking",
        "plugin:prettier/recommended",
        "plugin:import/recommended"
    ],
    // Specifying Parser
    "parser": "@typescript-eslint/parser",
    "parserOptions": {
        "ecmaFeatures": {
            "jsx": true
        },
        "ecmaVersion": "latest",
        "sourceType": "module",
        "tsconfigRootDir": ".",
        "project": [
            "./tsconfig.json"
        ]
    },
    // Configuring third-party plugins
    "plugins": [
        "react",
        "@typescript-eslint"
    ],
    // Resolve imports
    "settings": {
        "import/resolver": {
            "typescript": {
                "project": "./tsconfig.json"
            }
        },
        "react": {
            "version": "18.x"
        }
    },
    "rules": {
        "linebreak-style": "off",
        // Configure prettier
        "prettier/prettier": [
            "error",
            {
                "printWidth": 80,
                "endOfLine": "lf",
                "singleQuote": true,
                "tabWidth": 2,
                "indentStyle": "space",
                "useTabs": true,
                "trailingComma": "es5"
            }
        ],
        // Disallow the `any` type.
        "@typescript-eslint/no-explicit-any": "warn",
        "@typescript-eslint/ban-types": [
            "error",
            {
                "extendDefaults": true,
                "types": {
                    "{}": false
                }
            }
        ],
        "react-hooks/exhaustive-deps": "off",
        // Enforce the use of the shorthand syntax.
        "object-shorthand": "error",
        "no-console": "warn"
    }
}
```

### `.eslintignore` の編集
```
dist
```

### `package.json`の`scripts`の編集
```
"lint": "tsc --noEmit && eslint src/**/*.ts{,x} --cache --max-warnings=0",
"lint:fix": "eslint src/**/*.ts{,x} --fix"
```

### VSCodeのSettingsの編集
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
    "editor.codeActionsOnSave": [
        "source.formatDocument",
        "source.fixAll.eslint"
    ],
}
```

## Next.js
[nextjs-setup](./nextjs-setup.md)

## Viteを使った開発環境の構築
- viteについては[こちら](../vite.md)

```
npm create vite
```
