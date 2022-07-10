# Modules

- `cjs` is CommonJS Module
- `esm` is ES Module
- `umd` is Umd Module

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

## Typescript の `esModuleInterop` について

- [tsconfig#esModuleInterop](https://www.typescriptlang.org/tsconfig#esModuleInterop)

デフォルトでは（esModuleInterop が false または設定されていない場合）、TypeScript は CommonJS / AMD/UMD モジュールを ES6 モジュールと同様に扱う。この問題として、

```
import * as moment from "moment"
```

のような名前空間のインポートは、

```
const moment = require（ "moment"）
```

と同じように機能する。

```
import moment from "moment"
```

のようなデフォルトのインポートは、

```
const moment = require（ "moment"）
```

もまた、default と同じように機能する。
この不一致により、次の 2 つの問題が発生する

ES6 モジュールの仕様では、名前空間のインポート`（import * as x）`はオブジェクトにしかなれない。
これは、TypeScript `require（"x"）`と同じように処理することで、TypeScript でインポートを呼び出し可能な関数として処理できるようになる。
2 つめの問題として、仕様によると、これは無効。

`esModuleInterop`をオンにすると、TypeScript によってトランスパイルされたコードのこれらの問題の両方が修正される。
1 つ目はコンパイラーの動作を変更し、2 つ目は発行された JavaScript の互換性を確保するためのシム(くさび)を提供する 2 つの新しいヘルパー関数によって修正される。

## import 方法の違い [WIP]

```
import \* as \_m0 from "protobufjs/minimal.js";
import \_m0\_\_default from "protobufjs/minimal.js";
```
