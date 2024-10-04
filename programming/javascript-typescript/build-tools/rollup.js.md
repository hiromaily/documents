# Rollup.js

Rollup.jsは、JavaScriptのモジュールバンドラとして、特にESモジュール（ESM）に特化しており、小規模なアプリケーションのビルドに適している。

## 主な特徴

1. **ESモジュールサポート**:
   - Rollup.jsは、ESモジュール（ESM）をネイティブにサポートしており、バンドル後もE2015（ES6）を利用できる

2. **Tree-Shaking**:
   - 未使用のコードを自動的に削除するTree-Shaking機能を提供し、バンドルサイズを最小化する

3. **シンプルで直感的な設定**:
   - 設定ファイルがシンプルで、必要な設定だけを記述できる

4. **プラグインシステム**:
   - 豊富なプラグインエコシステムを持ち、さまざまな機能拡張が可能

5. **小さなバンドルサイズ**:
   - 純粋な関数の分析と最適化により、非常に小さなバンドルサイズを実現する

## 基本的な使い方

### 1. インストール

```sh
npm install --save-dev rollup @rollup/plugin-node-resolve @rollup/plugin-commonjs @rollup/plugin-typescript
```

### 2. プロジェクト構造

```txt
my-project/
├── src/
│   └── index.ts
├── dist/
└── rollup.config.js
```

### 3. 基本的な設定ファイル

Rollup.jsの設定ファイル `rollup.config.js` は以下のようになる

```js
import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import typescript from '@rollup/plugin-typescript';

export default {
  input: 'src/index.ts',
  output: {
    file: 'dist/bundle.js',
    format: 'es',  // 'es' for ES modules, 'cjs' for CommonJS
    sourcemap: true,
  },
  plugins: [
    resolve(),    // Node.js モジュールの解決
    commonjs(),   // CommonJS モジュールのバンドル
    typescript()  // TypeScript のサポート
  ]
};
```

### 4. ビルドの実行

設定ファイルを使ってビルドを実行する

```sh
npx rollup -c
```

## 使用ケース

Rollup.jsは特に以下のようなケースに適している

1. **ライブラリのビルド**:
   - ソースコードが主にESモジュールで、最適なTree-Shakingと小さなバンドルサイズが求められる場合。

2. **パフォーマンスとバンドルサイズが重要**:
   - バンドルサイズが重要で、JavaScriptの配布ライブラリや小規模なプロジェクトに適しています。

3. **シンプルな設定と高いカスタマイズ性**:
   - 少ない設定で始められ、高い拡張性やカスタマイズ性が求められる場合。

## 結論

Rollup.jsは、その小さなバンドルサイズと効率的なTree-Shakingにより、特にライブラリや小規模プロジェクトのビルドに適している。一方で、大規模アプリケーションの複雑なビルドプロセスには、Webpackや他のより汎用的なツールのほうが適している場合がある。
