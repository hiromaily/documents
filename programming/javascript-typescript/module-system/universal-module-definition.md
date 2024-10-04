# Universal Module Definition / UMD

UMD (Universal Module Definition) は、JavaScriptのモジュール定義パターンの一つで、主にライブラリやパッケージを複数の環境（ブラウザ、Node.js、AMD）で互換性を持たせるために設計されている。UMDは、特定の環境に依存せずにコードを実行できるようにするため、グローバルスコープ、CommonJS、AMDの三つのモジュールシステムに対応する。
`ライブラリ作者が一つのコードベースで広く互換性を提供したい場合に特に有用`。UMDを使用することで、環境に依存せず、どのプラットフォームでも同じライブラリを利用できるようになる。

## 基本的な概念

1. **環境の自動検出**: UMDは、自動的に実行環境（Node.js、AMD、ブラウザ）を検出し、その環境に適した方法でモジュールを定義する。
2. **ブラウザグローバル**: ブラウザ環境では、モジュールをグローバル変数として定義する。
3. **CommonJS**: Node.js環境では、`module.exports`を使用してモジュールをエクスポートする。
4. **AMD**: Asynchronous Module Definition (AMD) 環境では、`define`関数を使ってモジュールを定義する。

## UMDの実装

UMDの実装は、通常以下のような構造を取る。コードがどの環境で実行されても適切に動作するようにしている。

```javascript
(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD環境
        define([], factory);
    } else if (typeof module === 'object' && module.exports) {
        // CommonJS環境
        module.exports = factory();
    } else {
        // ブラウザ環境
        root.myLibrary = factory();
    }
}(typeof self !== 'undefined' ? self : this, function () {
    // ここにライブラリのコードを書く
    const myLibrary = {
        add: (a, b) => a + b,
        subtract: (a, b) => a - b,
    };
    return myLibrary;
}));
```

## 詳細な仕組み

1. **即時関数IIFE**: 最初に、即時関数（IIFE）を定義し、モジュールの範囲を閉じる。
2. **環境チェックとFactory関数呼び出し**:
    - **AMDチェック**: `if (typeof define === 'function' && define.amd)` を使って、Asynchronous Module Definition (AMD) かどうかをチェックする。AMDの場合は`define`関数を使用する。
    - **CommonJSチェック**: `else if (typeof module === 'object' && module.exports)` を使って、Node.jsまたはCommonJSかどうかをチェックする。CommonJSの場合は`module.exports`を使用する。
    - **ブラウザチェック**: 上記二つの条件に該当しない場合は、ブラウザ環境として扱い、グローバル変数（通常は`window`）にモジュールを設定する。

3. **Factory関数**:  `factory`関数が実際のモジュールを定義し、エクスポートする。この関数は依存関係を引数として取り、ライブラリの主要な機能を提供する。

## UMDの利点

- **互換性が高い**: 一つのコードベースで複数のモジュールシステムをサポートするので、多くの環境で動作する。
- **汎用性**: ライブラリを作成する際に非常に便利で、ユーザーがどのような環境でも使用できるようにすることができる。
- **簡単な移植**: 既存のライブラリやモジュールをUMDフォーマットに変換することが比較的容易。

## math.js (UMD形式)による実例

```js
(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define([], factory);
    } else if (typeof module === 'object' && module.exports) {
        module.exports = factory();
    } else {
        root.math = factory();
    }
}(typeof self !== 'undefined' ? self : this, function () {
    const add = (a, b) => a + b;
    const subtract = (a, b) => a - b;

    return {
        add,
        subtract,
    };
}));
```

**Node.js環境での使用**:

```js
const math = require('./math');
console.log(math.add(2, 3)); // 5
console.log(math.subtract(5, 2)); // 3
```

**ブラウザ環境での使用**:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UMD Example</title>
    <script src="path/to/math.js"></script>
    <script>
        console.log(math.add(2, 3)); // 5
        console.log(math.subtract(5, 2)); // 3
    </script>
</head>
<body>
</body>
</html>
```

## 実際にUMDが使われている例

1. **Lodash** - JavaScriptのユーティリティライブラリ
   - URL: <https://lodash.com/>
   - LodashのビルドファイルはUMD形式で提供されており、ブラウザ、Node.js、AMDの各環境で使用できる

2. **Moment.js** - 日付処理のためのライブラリ
   - URL: <https://momentjs.com/>
   - Moment.jsもUMD形式でエクスポートされており、どの環境でも一貫して使用することができる

3. **Axios** - HTTP通信ライブラリ
   - URL: <https://github.com/axios/axios>
   - AxiosはHTTPリクエストを簡単に行うための非同期通信ライブラリで、UMD形式で提供されているのでブラウザでもNode.jsでも動作する
