# Vite

Viteはフロントエンド開発のための次世代ビルドツールで、特にその高速なビルドと開発サーバーで注目されている。
Viteは最初に`Vue.js`の作者であるEvan Youによって開発されたが、現在はVue.jsにとどまらず、`React`や`Svelte`などのフレームワークにも対応している。Viteは「速さ」に主眼を置いて設計されている

## 主な特徴

1. **超高速開発サーバー**:
   - Viteは開発サーバーの起動が非常に速く、変更をホットモジュールリロード（HMR）で即座に反映する。これにより、開発スピードが大幅に向上する。

2. **ESモジュールベース**:
   - ブラウザがネイティブにサポートするESモジュール（ESM）を活用して、効率的にバンドルを行う。これにより、ビルド時間が大幅に短縮される。

3. **ビルド速度**:
   - プロダクションビルドも非常に高速で、`esbuild`や`Rollup`を使用して最適化されたバンドルを生成する。

4. **プラグインAPI**:
   - 拡張性の高いプラグインAPIが用意されており、さまざまな機能を追加できる。

5. **幅広いフレームワーク対応**:
   - Vue.js、React、Svelte、Lit、Preact、など多くのフレームワークに対応している。

6. **統合環境**:
   - 開発時にはdev server、プロダクション時には静的アセットのbunderとして一貫して使える。

## 基本的な使い方

### 1. インストール

Viteを使って新しいプロジェクトを作成する場合は、以下のコマンドを使用します。これにより雛形コードをセットアップできます。

```sh
npm create vite@latest my-project
cd my-project
npm install
```

### 2. プロジェクト構造

通常、Viteを使ったプロジェクト構造

```txt
my-project/
├── node_modules/
├── public/
│   └── index.html
├── src/
│   └── main.js
├── index.html
├── package.json
└── vite.config.js
```

### 3. 基本的な設定ファイル

`vite.config.js` でViteの設定をカスタマイズできる

```javascript
// vite.config.js
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  build: {
    outDir: 'dist', // 出力ディレクトリの指定
  },
  server: {
    port: 3000, // 開発サーバーのポート番号
  }
})
```

### 4. 開発サーバーの起動

開発サーバーを起動する

```sh
npm run dev
```

これにより、`http://localhost:3000` で開発サーバーが起動し、リアルタイムで変更が反映される

## 使用ケース

Viteは以下のような使用ケースに非常に適している

1. **高速な開発が求められるプロジェクト**:
   - 開発サーバーの超高速起動とリアルタイムでのホットリロードが可能なため、開発スピードを大幅に上げることができる

2. **モダンなフロントエンドフレームワークの使用**:
   - Vue、React、Svelteなどのフレームワークに対応しており、これらのフレームワークとの統合がスムーズ

3. **簡単なセットアップが求められる場合**:
   - 非常にシンプルな設定で始められるため、小規模から中規模のプロジェクトに最適

## 結論

Viteはその高速な開発体験やシンプルな設定、モダンなフレームワークのサポートから、特に新しいプロジェクトや迅速な開発が求められるプロジェクトに非常に適している。開発体験を向上させたいフロントエンド開発者には非常に魅力的な選択肢となる。
他のビルドツール（例えばWebpackやRollup）と比べると、特定のシナリオでより優れたパフォーマンスを発揮するため、それぞれのツールの強みを理解し、プロジェクトの特性に最適なツールを選ぶことが重要
