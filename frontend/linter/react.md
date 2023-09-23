# ESLint with React

- [Set Up ESLint and Prettier in a React TypeScript App (2023)](https://javascript.plainenglish.io/set-up-eslint-and-prettier-in-a-react-typescript-app-2022-7d9a5f40b634)

## Install

- bare minimum

```sh
npm install eslint --save-dev
npx eslint --init

npm install --save-dev eslint-plugin-import @typescript-eslint/parser eslint-import-resolver-typescript
npm install --save-dev eslint-plugin-react-hooks
```

- maybe useful

```sh
npm install --save-dev \
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

## `.eslintrc.json`

### Pattern A

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
  "plugins": ["react", "react-hooks", "@typescript-eslint", "prettier"],
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

### Pattern B

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
    "project": ["./tsconfig.json"]
  },
  // Configuring third-party plugins
  "plugins": ["react", "@typescript-eslint"],
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
