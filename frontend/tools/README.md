# Tools

## Bundler

## [Vite](./vite.md)
ビルドツールで、ヴィートと発音する

- [github](https://github.com/vitejs/vite)
  - Star: 56.9k

### 特徴
- 様々なFrameworkに対応している

## [SWC](https://swc.rs/)
Rust-based Bundlerで、Babelより桁違いに高速
`esbuild`との比較が多いがあまり性能差はないように見える。[benchmark](https://swc.rs/docs/benchmarks)

- [github](https://github.com/swc-project/swc)
  - Star: 27.6k

## [esbuild](https://esbuild.github.io/)
Goで実装されているビルドツール(Bundler)で高速

- [github](https://github.com/evanw/esbuild)
  - Star: 35.4k

### 特徴
- Extreme speed without needing a cache
- ES6 and CommonJS modules
- Tree shaking of ES6 modules
- An API for JavaScript and Go
- TypeScript and JSX syntax
- Source maps
- Minification
- Plugins

- viteのlocal server向け buildで使われている

### 特徴
- ESM ネイティブ
- プラグインが豊富
- viteのproduction buildで使われている

## [Turbopack](https://turbo.build/pack)
Webpackの後継となるBundlerで、Viteと比較されることが多い

### 特徴
- Next.js 13でも使われている

## [webpack](https://webpack.js.org/)
モジュールバンドラー

### 特徴
- 昔はよく使われていたが、もはや時代遅れか？
- Webpack は CommonJS しか認識できない
- `Turbopack`が後継とされる

## [rollup.js](https://rollupjs.org/)
小さなコードの断片を、ライブラリやアプリケーションのような、より大きく複雑なものにコンパイルするJavaScript用のモジュールバンドルラー。CommonJSやAMDのような従来の特異なソリューションではなく、JavaScriptのES6リビジョンに含まれるコードモジュールのための新しい標準化されたフォーマットを使用する。ESモジュールでは、お気に入りのライブラリから最も有用な個々の機能を自由かつシームレスに組み合わせることができる。

- [github](https://github.com/rollup/rollup)
  - Star: 23.5k
- [Docs](https://rollupjs.org/introduction/)

## [Rome](https://rome.tools/)
