# Tree shaking

Tree shaking は、JavaScript のモジュールバンドルの最適化手法の一つで、使われていないコード（デッドコード）を検出して除去するプロセス。これにより、最終的なバンドルサイズを削減し、パフォーマンスを向上させる。
Tree shaking という名前は、木（ツリー）から不要な部分（使われていない枝や葉）を振り落とすことに由来している。モジュール間の依存関係を解析し、実際に使用されているコードのみを残すことによって、不要なコードを削除する。

## 仕組み

Tree shaking は通常、以下のステップで実行される

1. **ES6 モジュール（ESM）の使用**:

   - Tree shaking は主に ES6 のモジュール（ESM）形式を利用して行われる。なぜなら、ESM は静的に解析可能であり、モジュール間の依存関係を容易に検出できる。

2. **依存関係の解析**:

   - バンドラー（例：Webpack、Rollup、esbuild など）がエントリーポイントから、すべての依存関係を遡って解析する。

3. **使用されているエクスポートのみを残す**:
   - 各モジュールの中で実際に使用されているエクスポート（関数や変数）だけをバンドルする。不要なエクスポートはバンドルから完全に削除される。

## 主なツールでの Tree shaking の実装

### Webpack での Tree shaking

Webpack は ES6 モジュールを利用してデフォルトで Tree shaking を行う。ただし、特定の設定が必要。

**package.json**:

```json
{
  "name": "my-project",
  "version": "1.0.0",
  "main": "dist/index.js",
  "scripts": {
    "build": "webpack"
  },
  "sideEffects": false, // オプション: 副作用のないモジュール
  "devDependencies": {
    "webpack": "^5.0.0",
    "webpack-cli": "^4.0.0"
  }
}
```

**webpack.config.js**:

```javascript
const path = require("path");

module.exports = {
  entry: "./src/index.js",
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "dist"),
  },
  mode: "production", // Tree shaking を有効にするため必ず production モードに設定
  optimization: {
    usedExports: true, // Tree shaking をサポートするオプション
  },
};
```

### Rollup での Tree shaking

Rollup は、Tree shaking 機能をデフォルトで内蔵しており、特別な設定なしで利用できる。

**rollup.config.js**:

```javascript
import resolve from "@rollup/plugin-node-resolve";
import commonjs from "@rollup/plugin-commonjs";
import babel from "@rollup/plugin-babel";

export default {
  input: "src/index.js",
  output: {
    file: "dist/bundle.js",
    format: "es", // 'es' 形式を利用することで Tree shaking が可能
    sourcemap: true,
  },
  plugins: [resolve(), commonjs(), babel({ babelHelpers: "bundled" })],
};
```

### esbuild での Tree shaking

esbuild も Tree shaking をデフォルトでサポートしている。特に設定なしで利用できるが、モジュール形式（ESM）の指定が必要。

**ビルドコマンド**:

```sh
esbuild src/index.js --bundle --outfile=dist/bundle.js --minify --format=esm
```

### SWC での Tree shaking

SWC を使用する場合、Tree shaking はオプションとして利用できる。設定ファイルにて指定する。

**.swcrc**:

```json
{
  "jsc": {
    "parser": {
      "syntax": "typescript",
      "tsx": true
    },
    "transform": {
      "optimizer": {
        "globals": {
          "vars": {
            // Tree shakingを有効にする設定
            "process.env.NODE_ENV": "development"
          }
        }
      }
    }
  },
  "module": {
    "type": "es6",
    "ignoreDynamic": true // Dynamic import を無視
  }
}
```

## 副作用 (Side Effects) の概念

Tree shaking がうまく動作するためには、副作用のあるコード（例：グローバル変数の変更や外部ファイルの読み書き）がないかどうかが重要。この情報は、モジュールがどの程度副作用を持つかを定義するために `package.json` の `sideEffects` フィールドで明示できる。

**副作用の設定例**:

```json
{
  "name": "my-library",
  "version": "1.0.0",
  "main": "dist/index.js",
  "sideEffects": false // 全ファイルに副作用がない場合
  // "sideEffects": ["*.css"]  // 特定のファイルに副作用がある場合
}
```

## 取得されないコードの例

以下に、Tree shaking がどのように機能するかという具体例を示す。

**src/util.js**:

```js
// 使われていない関数
export function unusedFunction() {
  console.log("This function is not used");
}

// 使われている関数
export function usedFunction() {
  console.log("This function is used");
}
```

**src/index.js**:

```js
import { usedFunction } from "./util.js";

usedFunction();
```

この場合、最終的なバンドルには `unusedFunction` が含まれない。なぜなら、この関数が `index.js` でインポートされておらず、使用されていないから。
