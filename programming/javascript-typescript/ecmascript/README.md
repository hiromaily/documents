# ECMAScript

ECMAScript (エクマスクリプト) は、主に`ブラウザ上で動作するオブジェクト指向のスクリプト言語であるJavaScriptの標準規格`。この規格は Ecma International によって策定されている。ECMAScript は JavaScript だけでなく、JScript（Microsoft）や ActionScript（Adobe）などの他の実装でも使用されていた。

## 歴史

- **ECMAScript 1 (ES1)**: 1997 年に初めて規格化された、最初の標準化バージョン
- **ECMAScript 2 (ES2)**: 1998 年にマイナーバージョンアップした
- **ECMAScript 3 (ES3)**: 1999 年に大幅な改訂が行われ、正規表現や新しい制御構文が追加された
- **ECMAScript 4 (ES4)**: 企画変更や技術的困難から正式にはリリースされていない
- **ECMAScript 5 (ES5)**: 2009 年にリリースされ、厳格モード（strict mode）や JSON サポート、Array の新メソッドなどが追加された
- **ECMAScript 5.1 (ES5.1)**: 2011 年に若干の修正を含むバージョンとしてリリースされました
- **ECMAScript 6 (ES6) / ECMAScript 2015 (ES2015)**: 大改訂であり、クラス構文、モジュール、矢印関数、let と const のブロックスコープ、新しいコレクション（Map、Set）、テンプレートリテラルなど、多くの機能が追加された
- **ECMAScript 2016 (ES7) 以降**: 2016 年以降は毎年新しいバージョンがリリースされる形になり、新しい機能が順次追加されている

## 主な機能

- **データ型と変数**: number, string, boolean, object, undefined, null といった基本的なデータ型をサポートしている。また、後のバージョンでは Symbol や BigInt も追加された
- **関数**: 関数リテラル、矢印関数、匿名関数、クロージャなどが利用できる
- **オブジェクト指向**: プロトタイプベースのオブジェクト指向をサポートしている。ES6 からはクラス構文も追加された
- **制御構文**: if-else 文、switch 文、for ループ、while ループ、try-catch など、一般的な制御構文が利用できる
- **非同期処理**: コールバック、Promise、async/await といった非同期処理のためのメカニズムが用意されている
- **モジュール**: ES6 以降、モジュールシステムが公式にサポートされるようになった。`import`と`export`を使ってモジュールを分割、再利用することができる。

## ECMAScript のバージョン

- **ES6 (ES2015)**: クラス、Promise、let/const、テンプレートリテラルなど。
- **ES7 (ES2016)**: Array.prototype.includes, Exponentiation operator (\*\*)。
- **ES8 (ES2017)**: async/await, Object.entries, Object.values など。
- **ES9 (ES2018)**: async iteration, Object spread/rest properties。
- **ES10 (ES2019)**: Array.flat(), Array.flatMap(), Object.fromEntries()など。
- **ES11 (ES2020)**: Nullish Coalescing (??), Optional Chaining (?.), BigInt など。
- **ES12 (ES2021)**: Logical Assignment Operators (&&=, ||=, ??=), String.prototype.replaceAll()など。
- **ES13 (ES2022)**: ??
- **ES14 (ES2023)**: 配列操作メソッドの追加、`#!（シバン）`のサポート、WeakMapのキーにおけるSymbolの利用
