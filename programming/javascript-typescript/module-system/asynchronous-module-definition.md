# Asynchronous Module Definition / AMD

AMD（Asynchronous Module Definition）は、非同期でモジュールを定義および読み込むための JavaScript のモジュールシステム。`主にブラウザ環境向け`に設計されており、非同期ローディングをサポートすることで、ページのパフォーマンスを向上させ、モジュールの依存関係を管理することができる。AMD の主要実装としては、`RequireJS`がある。

## モジュールの定義

AMD では、`define`関数を使ってモジュールを定義する。`define`関数は通常、モジュール名、依存モジュール、およびモジュールのファクトリ関数を引数に取る。

```js
define("moduleName", ["dependency1", "dependency2"], function (
  dependency1,
  dependency2
) {
  // モジュールのファクトリ関数
  var moduleValue = {
    // モジュールの公開メンバ
  };
  return moduleValue;
});
```

## モジュールの読み込み

AMD では、`require`関数を使ってモジュールを読み込む。`require`関数も依存モジュールとコールバック関数を引数に取る。

```js
require(["dependency1", "dependency2"], function (dependency1, dependency2) {
  // 依存モジュールを利用した処理
});
```

## RequireJS の使用例

例えば、math.js という名前のモジュールを定義する

```js
// math.js
define([], function () {
  return {
    add: function (a, b) {
      return a + b;
    },
    subtract: function (a, b) {
      return a - b;
    },
  };
});
```

次に、この math モジュールを読み込み、利用する例

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AMD Example</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/require.js/2.3.6/require.min.js"></script>
    <script>
      require.config({
        baseUrl: "path/to/modules",
        paths: {
          math: "math",
        },
      });

      require(["math"], function (math) {
        console.log(math.add(2, 3)); // 5
        console.log(math.subtract(5, 2)); // 3
      });
    </script>
  </head>
  <body></body>
</html>
```

## 二つの関数：`define` と `require`

1. **define**:

   - モジュールの定義に使用する
   - 依存モジュールと、それを使って何をエクスポートするかを指定する

2. **require**:
   - モジュールの読み込みに使用する
   - 依存モジュールを指定し、それらを使用した処理をコールバック関数で定義する

## AMD の利点

1. **非同期ローディング**: モジュールの非同期読み込みが可能で、ページの初期読み込み時間が短縮される
2. **依存関係の明示**: 各モジュールが依存関係を明示するため、依存モジュールの管理が容易
3. **遅延読み込み**: 必要なモジュールだけを必要なときに読み込むことができる（Lazy Loading）。

## AMD の欠点

1. **ブラウザ依存**: 主にブラウザ環境向けに設計されたため、Node.js などのサーバーサイド環境では他のモジュールシステム（CommonJS など）を使うことが多い。
2. **構文の冗長さ**: 異なるモジュールを定義する際に、毎回`define`や`require`を記述する必要があり、コードが冗長になることがある。

## 実用シーン

AMD は特にブラウザ向けの大規模なアプリケーションで役立つ。例えば、以下のようなシナリオで使用される

1. **シングルページアプリケーション（SPA）**: SPA のような大規模なクライアントサイドアプリケーションでは、ページ遷移なしで多くの機能を提供する。AMD を使うことで、必要なモジュールだけを非同期で読み込み、パフォーマンスを最適化する。

2. **モジュールの依存管理**: 依存関係が複雑なプロジェクトでは、各モジュールがどの他のモジュールに依存しているかを明示的に示すために AMD が便利。

## まとめ

AMD（Asynchronous Module Definition）は、非同期でモジュールを読み込み、依存関係を簡単に管理できるようにする JavaScript のモジュール定義パターン。主にブラウザ環境向けに設計されており、RequireJS などのツールを通じて使用される。非同期ローディングをサポートすることで、ページの初期読み込み時間を短縮し、パフォーマンスを向上させることができる。不利な点としては、ブラウザ向けに特化しているため、サーバーサイド環境では他のモジュールシステム（例えば CommonJS）が推奨されることが多い。しかし、大規模なクライアントサイドアプリケーションでは非常に有効であり、依存関係の管理や遅延読み込みが容易になる。
