# ES Modules with Node.js

Node.js は、バージョン 12 から正式に ES Modules をサポートしているが、いくつかの設定や特定のルールに従う必要がある

## ファイル拡張子

Node.js で ESM を使うためには、以下のいずれかの方法でファイルを識別する

1. ファイル拡張子を`.mjs`にする
2. `package.json`に`"type": "module"`を追加する

### 方法 1: 拡張子 .mjs を使用

```js
// math.mjs
export const add = (a, b) => a + b;
export const subtract = (a, b) => a - b;
```

```js
// main.mjs
import { add, subtract } from "./math.mjs";
console.log(add(2, 3)); // 5
console.log(subtract(5, 2)); // 3
```

この場合、`.mjs`拡張子を使うことで Node.js はファイルを ESM として扱う。

### 方法 2: package.json に "type": "module" を追加

```json
// package.json
{
  "type": "module"
}
```

```js
// math.js
export const add = (a, b) => a + b;
export const subtract = (a, b) => a - b;
```

```js
// main.js
import { add, subtract } from "./math.js";
console.log(add(2, 3)); // 5
console.log(subtract(5, 2)); // 3
```

`package.json`に`"type": "module"`を追加すると、そのディレクトリ以下の全ての`.js`ファイルが ESM として扱われる

## CommonJS との互換性

ESM と CommonJS (CJS) のモジュールは異なるものとして扱われるが、必要に応じて相互にインポートすることが可能。

### CommonJS モジュールから ESM モジュールをインポート

```js
// math.cjs（CommonJS形式）
module.exports = {
  add: (a, b) => a + b,
  subtract: (a, b) => a - b,
};
```

```js
// main.mjs（ESM形式）
import { createRequire } from "module";
const require = createRequire(import.meta.url);
const math = require("./math.cjs");
console.log(math.add(2, 3)); // 5
```

### ESM モジュールから CommonJS モジュールをインポート

```js
// math.mjs（ESM形式）
export const add = (a, b) => a + b;
export const subtract = (a, b) => a - b;
```

```js
// main.cjs（CommonJS形式）
const { add, subtract } = await import("./math.mjs");
console.log(add(2, 3)); // 5
```

## 特徴と注意点

1. **トップレベル await**: ESM ではトップレベルで`await`を使用することができる。

   ```js
   // main.mjs
   const result = await someAsyncFunction();
   console.log(result);
   ```

2. **キャッシング**: ESM モジュールは一度ロードされるとキャッシュされるため、次回のインポート時には即座にそのモジュールが利用可能になる。

3. **デフォルトエクスポートの制限**: CommonJS と異なり、ESM では一つのモジュールに対して一つのデフォルトエクスポートしか定義できない。

4. **ファイルシステムの扱い**: ファイルシステムを扱う場合は、`import.meta.url`や`URL`コンストラクタを活用できる。

   ```js
   import path from "path";
   const __dirname = path.dirname(new URL(import.meta.url).pathname);
   ```

## まとめ

Node.js 環境における ES Modules（ESM）は、モダンな JavaScript の開発にとって強力なツール。異なるファイル拡張子や設定を理解し、適切なインポート・エクスポートの方法を用いることで、コードの再利用性、保守性、パフォーマンスを向上させることができる。また、CommonJS との互換性もあるため、既存のライブラリやパッケージとの相互運用も問題なく行える。
