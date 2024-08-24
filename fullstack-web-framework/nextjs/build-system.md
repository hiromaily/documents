# Build System

## [How Next.js Works](https://nextjs.org/learn/foundations/how-nextjs-works)
- Compilerには[SWC](https://swc.rs/)を使っている
  - `SWC, a platform that can be used for compilation, minification, bundling, and more.`
  - compile, minify, bundleの全てに使われている？？
- CompilerはBrowserが解釈可能な形にするためのプロセスを担う
- Minifierはコードから不要な情報を省くプロセスを担う
- Bundlerは複数のファイルの依存関係を解決し、最適化されたバンドルファイルとしてまとめるプロセスを担う

## Compiler
[Next.js Compiler](https://nextjs.org/docs/architecture/nextjs-compiler)によると、`Next.js`はCompilerとして、[SWC](https://swc.rs/)を使っている。(`Babel`よりはるかに高速)  
これによりProduction環境のために、TypescriptをJavascriptにTransformしたりminifyする。

## Bundler
- 元々`Webpack`が使われていたが、dev環境のみ、[Turbopack](https://turbo.build/pack)を使うことが可能

### Turbopack
- Next.jsのDocs内の[Turbopack](https://nextjs.org/docs/architecture/turbopack)セクション
- `next dev`のみに対応しており、開発サーバー実行時に、`--turbo`フラグをつけることで有効化される
  - `"dev": "next dev --turbo"`
- つまり、`--turbo`をつけない限りは、Webpackが使われることになる。
  - 2023/7時点で、[Custom Webpack Config](https://nextjs.org/docs/app/api-reference/next-config-js/webpack)といったページが存在する。


## 様々なToolsについて
別途、[Tools](../../../tools/README.md)に情報をまとめている




