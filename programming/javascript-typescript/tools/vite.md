# Vite

ビルドツールで、ヴィートと発音する

2023年6月時点でVersion 4.3

## References

- [Vite](https://vitejs.dev/)
- [Vite (ja)](https://ja.vitejs.dev/)

## 機能

- 瞬時にスタートするサーバ ... 開発時はバンドル不要で動作する
- 超高速な HMR(Hot Module Replacement) ... 画面の再描画無しにファイル変更をブラウザに適用してくれる機能
- 豊富な機能
- 最適化されたビルド
- ユニバーサルなプラグイン
- 完全に型定義がされている API

## 特徴

- Node.js >=14.6.0 のバージョンが必要
- native ES modules を利用している
- Rollup.js をベースとしたプロダクションビルド機能 (開発時には`esbuild`が使われる)
- SWCのサポート
- Vite はデフォルトでは構文変換のみを扱い デフォルトでは Polyfill をカバーしていない
- Vite は Typescript のトランスパイルは行うが、型チェックは行わないため、ビルド時に型チェックを行うことが推奨される

```json
"scripts": {
  "build": "tsc --noEmit && vite build"
},
```

## コマンド

- `vite dev`
  - 開発サーバーを起動
- `vite build`
  - プロダクション用にビルド (`Rollup`が使われる)
- `vite preview`
  - プロダクション用ビルドをローカルでプレビュー

## NPM の依存関係の解決と事前バンドル

- ネイティブ ES のインポートは次のような生のモジュールをサポートしない

```ts
import { someMethod } from 'my-dep'
```

- vite で生のモジュールのインポートを検出
- 事前バンドルは [esbuild](https://esbuild.github.io/) で実行され、CommonJS / UMD モジュールを ESM に変換する
- import を `my-dep.js` のように書き換える

## 発生した問題

### `vite build` 実行時エラー　 ERR_MODULE_NOT_FOUND

```sh
Error [ERR_MODULE_NOT_FOUND]: Cannot find module '/Users/me/app/node_modules/protobufjs/minimal' imported from /Users/me/app/.svelte-kit/output/server/entries/pages/index.svelte.js
Did you mean to import protobufjs/minimal.js?
```

### `ERR_MODULE_NOT_FOUND`解決のための References

- [Importing a .js typescript resource from a typescript file fails](https://github.com/vitejs/vite/issues/3040)
- [Could not resolve error on .js extension in import with TypeScript](https://github.com/vitejs/vite/issues/5539)

### `ERR_MODULE_NOT_FOUND`解決のSolutions

- パスを変更する。これは ESM の問題

```ts
import * as _m0 from "protobufjs/minimal";
=>
import * as _m0 from "protobufjs/minimal.js";
```

- 実行時に、`--es-module-specifier-resolution=node` を追加する

```sh
NODE_OPTIONS='--es-module-specifier-resolution=node' npm run build
```

### `vite build` 実行時エラー　 TypeError: Cannot read properties of undefined

```sh
TypeError: Cannot read properties of undefined (reading 'Long')
```

- これは、sevelte を使っているものの、vite の問題かもしれないし、原因が発生している、protobufjs の問題かもしれないし、proto から generate する際に利用したプラグインである、ts-proto の問題かもしれない。
- ts-proto の[Readme](https://github.com/stephenh/ts-proto)にも、vite を使う場合の注意点いついての記載がある。

```sh
--ts_proto_opt=esModuleInterop=true
```

#### `TypeError: Cannot read properties of undefined` 解決のReferences

- [my post on svelte/kit](https://github.com/sveltejs/kit/issues/5418)
- [my post on vite](https://github.com/vitejs/vite/issues/9018)

- [There is a problem with protoubfjs when building with the vite command](https://github.com/vitejs/vite/issues/7797)
- [Vite + React: "TypeError: Cannot read properties of undefined (reading 'classes')"](https://github.com/vitejs/vite/issues/8395)
  - But it doesn't work

```json
  "overrides": {
  "rollup": "2.74.1"
  }
```

- [protobuf.js: error after vite building](https://github.com/protobufjs/protobuf.js/issues/1673)

#### `TypeError: Cannot read properties of undefined` のSolutions

- import パスが間違っていた

```ts
import * as _m0 from "protobufjs/minimal.js";
```

のような名前空間のインポートは、ES6 モジュールの仕様では、名前空間のインポート`（import * as x）`はオブジェクトにしかなれない。
よって、以下のように修正する必要がある。

```ts
import _m0 from "protobufjs/minimal.js";
```
