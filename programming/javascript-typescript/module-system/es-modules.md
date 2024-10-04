# ES Modules / ESM

ES Modules (ESM) は、ECMAScript 2015 (ES6)で導入された  Javascript の標準モジュールシステム。モダンなブラウザや Node.js などの JavaScript 実行環境でサポートされている。ES Modules は、モジュールの非同期読み込みと`Tree Shaking`（未使用コードの削除）を可能にし、パフォーマンスと最適化の面で多くの利点を提供する。

## モジュールのExport

ES Modules では、`export`キーワードを使ってモジュールの一部または全体をExportすることができる。主に`名前付きExport`と`Default Export`の 2 種類がある。

### 名前付きExport

```js
// math.js
export const add = (a, b) => a + b;
export const subtract = (a, b) => a - b;
```

### Default Export

```js
// math.js
const add = (a, b) => a + b;
const subtract = (a, b) => a - b;

export default { add, subtract };
```

## モジュールのImport

他のモジュールからExportされた関数やオブジェクトを使用するためには、`import`キーワードを使ってImportする。

### 名前付きImport

```js
// main.js
import { add, subtract } from "./math.js";
console.log(add(2, 3)); // 5
console.log(subtract(5, 2)); // 3
```

### Default Import

```js
// main.js
import math from "./math.js";
console.log(math.add(2, 3)); // 5
console.log(math.subtract(5, 2)); // 3
```

## 相対パスと絶対パス

ESM では、モジュールをインポートする際にファイルの拡張子を明示的に指定する必要がある。また、相対パスと絶対パスの両方がサポートされている。

```js
import { add } from "./lib/math.js"; // 相対パス
import { greet } from "/lib/greet.js"; // 絶対パス（ルートディレクトリからの相対パス）
```

## ダイナミックインポート

ESM の強力な機能の一つとして、`import()`関数を使用してモジュールを動的にインポートすることができる。この機能は非同期で Promise を返す。

```js
// main.js
(async () => {
  const math = await import("./math.js");
  console.log(math.add(2, 3)); // 5
})();
```

## 詳細な仕様と特徴

1. **非同期読み込み**: ES Modules は非同期でモジュールを読み込む。これにより、Web ページの初期読み込み時間を短縮し、ネットワーク遅延に対応しやすくなる。

2. **静的解析**: モジュールは静的に解析されるため、ビルドツール（例えば Webpack や Rollup）は最適化（例えばツリーシェイキング）がしやすくなる

3. **スコープの分離**: モジュールごとに独立したスコープを持つため、グローバル変数の衝突を防ぐことができる

4. **ブラウザサポート**: `<script type="module">`タグを使うことで、ブラウザで直接 ES Modules を読み込むことができる

   ```html
   <!DOCTYPE html>
   <html lang="en">
     <head>
       <meta charset="UTF-8" />
       <meta name="viewport" content="width=device-width, initial-scale=1.0" />
       <title>ES Modules Example</title>
     </head>
     <body>
       <script type="module">
         import { add } from "./math.js";
         console.log(add(2, 3)); // 5
       </script>
     </body>
   </html>
   ```

## モジュールの種類と使用方法

### 名前付きExportとImport

名前付きExportでは、複数のExportを 1 ファイルで定義できる

```js
// utils.js
export function multiply(a, b) {
  return a * b;
}
export function divide(a, b) {
  return a / b;
}
```

Import

```js
// main.js
import { multiply, divide } from "./utils.js";
console.log(multiply(4, 2)); // 8
console.log(divide(4, 2)); // 2
```

### エイリアス（別名）の使用

Importする際に別名を付けることができる

``` js
// main.js
import { multiply as mul, divide as div } from "./utils.js";
console.log(mul(4, 2)); // 8
console.log(div(4, 2)); // 2
```

### 全てのExportをまとめてImport

全てのExportを一つのオブジェクトとしてImportすることもできます。

``` js
// main.js
import * as utils from "./utils.js";
console.log(utils.multiply(4, 2)); // 8
console.log(utils.divide(4, 2)); // 2
```

## 使用上の注意点

1. **ファイル拡張子**: ES Modules を使用する際は、ファイル拡張子を`.js`と明示する必要がある
2. **相対パス**: モジュールをImportする際には相対パスを明示的に指定する必要がある

## Native ESM

`Native ESM` とは、JavaScriptランタイム環境（ブラウザやNode.jsなど）がこのESMをネイティブにサポートしている状況を指す。つまり、追加のツールやトランスパイルを必要とせずに、モジュールのエクスポートとインポートがそのまま実行できる環境のこと。

### ESMとNative ESMの違いと共通点

1. **用語の違い**:
   - **ESM**: ECMAScript Modules自体の仕様とその構文。
   - **Native ESM**: JavaScript実行環境が`追加のトランスパイルやツールなし`でESMをそのままサポートしている状態。

2. **サポート環境**:
   - **ESM**: ECMAScript 2015以来の仕様で、トランスパイル（例えばBabelを使って）で古い環境でも使用可能。
   - **Native ESM**: モダンなブラウザや最新のNode.jsランタイムがネイティブサポート。

3. **使用方法**:
   - **ESM**: トランスパイル手段を使用して、ネイティブサポートがない環境でも実行可能。
   - **Native ESM**: トランスパイル無しで、モジュールのインポートやエクスポートがそのまま使用可能。

## まとめ

ES Modules は、モダンな JavaScript 開発における標準的なモジュールシステム。非同期読み込みと静的解析の強力な特性を持ち、パフォーマンスの最適化や保守性の向上を図ることができる。ブラウザや Node.js で広くサポートされており、JavaScript 開発の主要な部分を担っている。
