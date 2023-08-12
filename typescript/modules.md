# Modules
[frontend/modules](../frontend/modules.md)

## [TypescriptのModule](https://www.typescriptlang.org/docs/handbook/modules.html)について
- これは、TypeScriptが出力するモジュールの形式を指定するオプションであったが、
- 仕組みは、TypeScriptのソースコードではimportやexportを使ってモジュールを定義し、TypeScriptのコンパイラがそれをmoduleオプションで指定した形式に変換する
  - moduleがcommonjsであれば、importはrequireに変換され、exportはmodule.exportsに変換される
  - moduleがes2015であれば、importはimportのまま、exportはexportのまま

### [種類](https://www.typescriptlang.org/tsconfig#module)
- commonjs
- amd
- umd
- system
- es6/es2015
- es2020
- es2022
  - モジュールのトップレベル（他の関数の中ではない部分）にawaitを書けるようにする機能である`top-level await`が使える
- esnext
- node16
  - Node.jsに準拠
  - `CommonJS`と`ES Modules`の両方に対応している
  - .ctsファイルは.cjsファイルにトランスパイルされる。ES Modulesの構文で.ctsファイルを書くとCommonJSに変換される
  - .mtsファイルは.mjsファイルにトランスパイルされる。ES Modulesの構文で.mtsファイルを書くとES Modulesのままになる
  - .tsファイルは.jsファイルにトランスパイルされるが、どちらのモジュールシステムになるかはpackage.jsonのtypeフィールドによって決まる
- nodenext

## Typescript の `esModuleInterop` について

- [tsconfig#esModuleInterop](https://www.typescriptlang.org/tsconfig#esModuleInterop)
- ほとんどの環境で`true`に設定していることが多いはず

デフォルトでは（esModuleInterop が false または設定されていない場合）、TypeScript は CommonJS / AMD/UMD モジュールを ES6 モジュールと同様に扱う。この問題として、

```ts
import * as moment from "moment"
```

のような名前空間のインポートは、

```ts
const moment = require（ "moment"）
```

と同じように機能する。

```ts
import moment from "moment"
```

のようなデフォルトのインポートは、

```ts
const moment = require（ "moment"）
```

もまた、default と同じように機能する。
この不一致により、次の 2 つの問題が発生する

ES6 モジュールの仕様では、名前空間のインポート`（import * as x）`はオブジェクトにしかなれない。
これは、TypeScript `require（"x"）`と同じように処理することで、TypeScript でインポートを呼び出し可能な関数として処理できるようになる。
2 つめの問題として、仕様によると、これは無効。

`esModuleInterop`をオンにすると、TypeScript によってトランスパイルされたコードのこれらの問題の両方が修正される。
1 つ目はコンパイラーの動作を変更し、2 つ目は発行された JavaScript の互換性を確保するためのシム(くさび)を提供する 2 つの新しいヘルパー関数によって修正される。

## 初期化したobjectのexportについて
```js
// myClass.js
class MyClass {
  constructor() {
    // Initialize your class instance here
  }

  // Methods and properties of your class
}

const myInstance = new MyClass();

export default myInstance;
```

```js
// someModule.js
import myInstance from './myClass.js';

// Now you can use the myInstance in this module
```

## Jest環境でのModule非互換に起因するエラーについて

```sh
  ● Test suite failed to run

    Jest encountered an unexpected token

    Jest failed to parse a file. This happens e.g. when your code or its dependencies use non-standard JavaScript syntax, or when Jest is not configured to support such syntax.

    Out of the box Jest supports Babel, which will be used to transform your files into valid JS based on your Babel configuration.

    By default "node_modules" folder is ignored by transformers.

    Here's what you can do:
     • If you are trying to use ECMAScript Modules, see https://jestjs.io/docs/ecmascript-modules for how to enable it.
     • If you are trying to use TypeScript, see https://jestjs.io/docs/getting-started#using-typescript
     • To have some of your "node_modules" files transformed, you can specify a custom "transformIgnorePatterns" in your config.
     • If you need a custom transformation specify a "transform" option in your config.
     • If you simply want to mock your non-JS modules (e.g. binary assets) you can stub them out with the "moduleNameMapper" config option.

    You'll find more details and examples of these config options in the docs:
    https://jestjs.io/docs/configuration
    For information about custom transformations, see:
    https://jestjs.io/docs/code-transformation

    Details:

    /Users-Dir/path/my-repo/app/node_modules/@wagmi/core/dist/index.js:1
    ({"Object.<anonymous>":function(module,exports,require,__dirname,__filename,jest){import "./chunk-KX4UEHS5.js";
                                                                                      ^^^^^^

    SyntaxError: Cannot use import statement outside a module
```

- 発生する環境: jest実行時

### 対応方法

- Detailsに記載のある原因となったファイルパスを確認し、node_modules以下のディレクトリ、上記であれば、`@wagmi` を確認する
- `jest.config.mjs`と`next.config.js`に上記で確認したpackageを追加する
  - `jest.config.mjs`
```js
  transformIgnorePatterns: [
    'node_modules/(?!(@wagmi|wagmi|viem|abitype|@adraffy|@tanstack)/)',
  ],
```
  - `next.config.js`
```js
  transpilePackages: [
    '@wagmi',
    'wagmi',
    'viem',
    'abitype',
    '@adraffy',
    '@tanstack',
  ],
```
