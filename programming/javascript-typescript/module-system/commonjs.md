# CommonJS / CJS

CommonJS (CJS) は、主にサーバーサイド JavaScript 環境（特に `Node.js`）で使用されるモジュールシステム。CommonJS の目的は、JavaScript コードをモジュールという小さな単位に分割し、再利用性を高め、依存関係を管理しやすくすること。

## 基本的なコンセプト

### モジュールのエクスポート

モジュールをエクスポートするためには、`module.exports`または`exports`オブジェクトを使用する。`module.exports`と`exports`は同じものを指すが、`exports`は`module.exports`のショートカットとして使われる。

```js
// math.js
module.exports.add = (a, b) => a + b;
module.exports.subtract = (a, b) => a - b;

// または
exports.add = (a, b) => a + b;
exports.subtract = (a, b) => a - b;
```

### モジュールのインポート

他のモジュールからエクスポートされた関数やオブジェクトを使用するためには、`require`関数を使ってインポートする。

```js
// main.js
const math = require("./math");
console.log(math.add(2, 3)); // 5
console.log(math.subtract(5, 2)); // 3
```

## 詳細な仕組み

1. **モジュールキャッシュ**: 一度読み込まれたモジュールはキャッシュされるため、次回以降の`require`呼び出しはキャッシュされた結果を返す。これにより、パフォーマンスの向上が図れる。
2. **同期読み込み**: `require`は同期的にモジュールを読み込むため、モジュールのコードが全てロードされてから次のコードが実行される。
3. **依存関係の解決**: `require`関数はモジュールの依存関係を解決し、正しい順序で読み込む。

## CommonJS の利点

- **シンプルで直感的**: `require`と`module.exports`というシンプルな構文でモジュールを管理できる。
- **同期的な読み込み**: モジュールが同期的に読み込まれるため、シンプルで予測可能な実行順序が確保される。
- **広くサポートされている**: 特に Node.js 開発で標準的に使用され、多くの Node.js モジュールが CommonJS 形式で提供されている。

## CommonJS の欠点

- **ブラウザ非対応**: ブラウザ環境ではそのまま使用できないため、`ブラウザ用にトランスパイル（例えば Browserify などのツールを使用）する必要がある`。
- **非同期性の欠如**: 同期的な読み込みはシンプルだが、大規模アプリケーションやネットワーク越しの読み込みには非効率。

## 使用例

以下は、Node.js 環境での簡単な CommonJS の使用例

### math.js

```js
// math.js
module.exports = {
  add: (a, b) => a + b,
  subtract: (a, b) => a - b,
};
```

### main.js

```js
// main.js
const math = require("./math");
console.log(math.add(5, 3)); // 8
console.log(math.subtract(5, 3)); // 2
```

Node.js では、上記のように`require`で他のファイルから関数やオブジェクトを呼び出し、利用することができる。これによりコードの再利用性や保守性が向上する。
