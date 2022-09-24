# Linter

- [ESLint + Prettier + Typescript and React in 2022](https://blog.devgenius.io/eslint-prettier-typescript-and-react-in-2022-e5021ebca2b1)

## ESLint
### For React
```sh
npm install eslint --save-dev
npx eslint --init

npm install --save-dev eslint-plugin-import @typescript-eslint/parser eslint-import-resolver-typescript
npm install --save-dev eslint-plugin-react-hooks
```

- `.eslintrc.json` e.g.
```json
{
    "env": {
        "browser": true,
        "es2021": true,
        "jest": true
    },
    "extends": [
        "eslint:recommended",
        "plugin:react/recommended",
        "plugin:@typescript-eslint/recommended",
        "prettier"
    ],
    "parser": "@typescript-eslint/parser",
    "parserOptions": {
        "ecmaFeatures": {
            "jsx": true
        },
        "ecmaVersion": "latest",
        "sourceType": "module"
    },
    "plugins": [
        "react",
        "react-hooks",
        "@typescript-eslint",
        "prettier"
    ],
    "rules": {
        "react/react-in-jsx-scope": "off",
        "camelcase": "error",
        "spaced-comment": "error",
        "quotes": ["error", "single"],
        "no-duplicate-imports": "error"
    },
    "settings": {
        "import/resolver": {
            "typescript": {}
        }
    }  
}
```
### For Next.js
- [【2022年】Next.js + TypeScript + ESLint + Prettier の構成でサクッと環境構築する](https://zenn.dev/hungry_goat/articles/b7ea123eeaaa44)

### Import Rules
- `.eslintrc.json` e.g.
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

## Prettier
```sh
npm install --save-dev prettier eslint-config-prettier eslint-plugin-prettier
```

- `.prettierrc`
```json
{
  "semi": false,
  "tabWidth": 2,
  "printWidth": 100,
  "singleQuote": true,
  "trailingComma": "all",
  "jsxSingleQuote": true,
  "bracketSpacing": true
}
```

## `package.json` scripts
```json
  "scripts": {
    "lint": "eslint src/**/*.{js,jsx,ts,tsx,json}",
    "lint:fix": "eslint --fix 'src/**/*.{js,jsx,ts,tsx,json}'",
    "format": "prettier --write 'src/**/*.{js,jsx,ts,tsx,css,md,json}' --config ./.prettierrc",
    "type-check": "tsc --noEmit",
    "all": "npm run format && npm run lint:fix && npm run type-check"
  },
```
