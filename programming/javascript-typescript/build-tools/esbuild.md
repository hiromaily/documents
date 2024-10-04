# esbuild

非常に高速なJavaScriptバンドラーおよびトランスパイラ。esbuildはGo言語で書かれたツールで、そのパフォーマンスの高さが一番の特徴。

## 主な特徴

1. **高性能**:
   - Go言語による実装により、驚くほど速いビルド時間を実現している。これは特に大規模なプロジェクトで効果を発揮する。

2. **簡単な設定**:
   - 設定ファイルがなくても、CLIコマンドやシンプルなJavaScript APIを使用してすぐに始められる。

3. **トランスパイルとバンドリング**:
   - 最新のJavaScriptおよびTypeScriptの機能を古いブラウザでも動作する形式にトランスパイルする。

4. **Tree-Shaking**:
   - デッドコードを自動的に削除することによって、バンドルサイズを最小化する。

5. **拡張性**:
   - プラグインAPIを提供しており、さまざまなビルドプロセスをカスタマイズできる。

## 基本的な使い方

### 1. インストール

```sh
npm install --save-dev esbuild
```

### 2. シンプルなビルド

シンプルなビルドを行うためのコマンドは以下の通り

```sh
npx esbuild src/index.js --outfile=dist/bundle.js
```

### 3. 基本的な設定ファイル

プロジェクトディレクトリに `esbuild.config.js` を作成する (Typescriptファイルでもよい)

```js
// esbuild.config.js
const esbuild = require('esbuild');

esbuild.build({
  entryPoints: ['src/index.ts'],
  bundle: true,
  outfile: 'dist/bundle.js',
  minify: true,
  sourcemap: true,
  target: ['es2015'],
}).catch(() => process.exit(1));
```

上記の設定ファイルを使用してビルドする

```sh
node esbuild.config.js
```

## 使用ケース

esbuildはその高速性から、特に以下のようなケースに適している

1. **シンプルで高速なビルドが必要なプロジェクト**:
   - コンパイル時間が重要となる小規模から中規模のプロジェクトで、インクリメンタルビルドの速度が求められる場合。

2. **開発体験の向上**:
   - 開発中のホットリロードやビルド時間の短縮を求める場合。

3. **ビルドプロセスが複雑でない場合**:
   - 例えば、あまり多くのカスタマイゼーションが不要なプロジェクト。
