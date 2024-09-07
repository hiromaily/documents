# TypeScript

## Typescriptのバージョン毎の大きな変更について

### Typescript 4.1

- [Template Literal Types](https://www.typescriptlang.org/docs/handbook/2/template-literal-types.html)

```
type PrefixName = `prefix_${string}`
const cat: PrefixName = 'prefix_foo' // OK
const wrongDog: PrefixName = 'foo'   // Error

type EmailLocaleIDs = "welcome_email" | "email_heading";
type FooterLocaleIDs = "footer_title" | "footer_sendoff";
type AllLocaleIDs = `${EmailLocaleIDs | FooterLocaleIDs}_id`;
```

### Typescript 4.7

- Node.jsにおけるESModuleに対応するためのコンパイル・オプション追加
  - [TypeScript 4.7 と Native Node.js ESM](https://quramy.medium.com/typescript-4-7-%E3%81%A8-native-node-js-esm-189753a19ba8)

#### Node.jsのファイル拡張子の違いによる解釈

- `.js`ファイル
  - package.json に "type": "module" の記述があれば ESM, そうでなければ CJS
- `.mjs`: ESM
- `.cjs`: CJS

### Typescript 4.9

- satisfies operator
  - 型チェックを行う
  - 従来の`as const`と組み合わせ、型チェックと widening(拡張) 防止を同時に行うことができる
