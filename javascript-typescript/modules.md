# Modules

- `cjs` is CommonJS Module
- `esm` is ES Module
- `umd` is Umd Module


[typescript/modules](../typescript/modules.md)

## Module の種類

### CJS

Node.js で採用されているモジュールシステムで、`CommonJS`を指す。
`CJS` はそのままではクライアント(ブラウザ)で動かすことはできない。

```
const lib = require( "package/lib" );
function hello　()　{
    lib.hello( "Hello!" );
}

exports.hello = hello;
```

### ESM

JavaScript におけるスタンダードなモジュールシステムで、ES2015 で策定された。
Node.js もデフォルトは`CJS`だが、`ESM`のサポートも進んできている。

```
import React from 'react'
// ...
export default App
```

### UMD

UMD stands for Universal Module Definition.  
サーバー側・クライアント側どちらでも動かすことができる。UMD モジュールは、基本的には`Rollup`や`Webpack`などのバンドルツールで生成される。

### AMD

AMD（Asynchronous Module Definition）も JS モジュールシステムの 1 つ

## Node.js における ES Modules

- 最新版の Node.js では、モジュールシステムとして `ES Modules` を使うことができる
- `CommonJS` で書かれたモジュールを `ES Modules` で読み込むこともできる
- Node.js で使えるモジュールシステムとして、`ES Modules`, `CommonJS`があり、`CJS` がデフォルトになっている
- `CJS` で書かれたファイルとして扱われるのか、`ESM` で書かれたファイルとして扱われるのかで、挙動が変わる
  - 拡張子が`.cjs`のファイルは `CJS`、`.mjs`のファイルは `ESM` として扱われる
  - package.json の `type`
    - type フィールドが存在しない場合も、`CJS`
    - type フィールドを`module`にすると、.js ファイルが `ESM` として扱われるようになる
    - 拡張子が`.cjs`か`.mjs`のファイルについては、type フィールドの影響は受けない
- `ESM`における、import 方法について
  - `import Foo, {x} from './utils/foo.mjs';`
  - `import Foo, {x} from './utils/foo';` 拡張子の省略はできないため、`Error [ERR_MODULE_NOT_FOUND]` が発生する
  - node 実行時に、`--es-module-specifier-resolution=node` フラグをつけて実行すると、拡張子が省略可能になる
- `CJS` の挙動について

  - `const Bar = require('./utils/bar.cjs');`
  - `const Bar = require('./utils/bar');` のように、`.cjs`ファイルの拡張子を省略するとエラーになる。
    - `CJS` として扱われている.js ファイルを読み込む場合は、拡張子を省略できる

## Native ESM

- Native ESM とは ES Modules のこと
- [Native ESM + TypeScript 拡張子問題: 歯にものが挟まったようなスッキリしない書き流し](https://zenn.dev/qnighy/articles/19603f11d5f264)
- [Native ESM 時代とはなにか](https://zenn.dev/uhyo/articles/what-is-native-esm-era)
- ビルド時にバンドラによって import・export で繋がった複数の JavaScript ファイルたちを一つの JavaScript にまとめる処理が行われる。(バンドル)
  つまり、ビルド前に ES Modules を利用していたとしても、ビルド後の JavaScript ではもはや ES Modules が使われていないことになる

## DefinitelyTyped

- [github](https://github.com/DefinitelyTyped/DefinitelyTyped)
- [github:ja](https://github.com/DefinitelyTyped/DefinitelyTyped/blob/master/README.ja.md)
- 型定義ファイル


## import 方法の違い

- [import](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import_
- [import(ja)](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Statements/import)
