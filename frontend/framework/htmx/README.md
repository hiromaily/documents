# HTMX

htmx は、JavaScript フレームワークの一つだが、クライアントサイドのコードを最小限に抑えつつ、サーバーから直接 HTML を取得して、動的なウェブページを生成できるようにするライブラリ

一般的な JavaScript フレームワーク（React や Vue.js など）は、クライアントサイドで多くの処理を行い、データを API 経由で取得してページをレンダリングする。しかし、`htmx`は、サーバーから直接レンダリングされた HTML を取得することによって、これらの一般的なフレームワークとは違った設計思想を持っている。

`htmx`はシンプルで直感的な方法でウェブページを動的にする手段を提供してくれる。従来のサーバーサイドレンダリングと SPA（シングルページアプリケーション）の間の隙間を埋めるような存在。

## 役割

1. **インタラクティブな操作の簡易化**：ボタンのクリックやフォームの送信など、HTML属性を使って簡単にインタラクションを定義できる。
2. **部分的なページ更新**：サーバーからHTMLを取得し、部分的にページを更新することで、ページの再読み込みを回避する。

これによって、クライアントサイドでの複雑なJavaScriptコードを書かずにインタラクティブな機能を実装できるようになる。これだけの機能提供に焦点を絞っているため、動的なウェブアプリケーションの構築には非常に有用なツールとなる。

## `htmx`の定義

`htmx`では、HTML 属性を使って動作を定義する。例えば、`hx-get`属性を使って特定のエンドポイントからコンテンツを取得し、それをページに挿入することができる。

```html
<button hx-get="/some-endpoint" hx-target="#result">Get Content</button>
<div id="result"></div>
```

この例では、ボタンがクリックされると、`/some-endpoint`から HTML コンテンツが取得され、その結果が`#result`という ID を持つ`div`に挿入される。

## htmx のメリット

- 既存の HTML コードに簡単に組み込むことができる点
  - 特定のフレームワークに依存せずに、必要な部分にだけ動的な機能を追加することが可能

## htmx のセットアップ

htmx を使うためには、htmx のライブラリを HTML に include する必要がある。CDN を使えば簡単に導入できる。

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>htmx Example</title>
    <script src="https://unpkg.com/htmx.org@2.0.2" defer></script>
  </head>
  <body>
    <!-- htmxを使ったコンテンツはここに入る -->
  </body>
</html>
```

## htmx の基本的な例

簡単なボタンとサーバーからデータを取得する例。例えば、ボタンをクリックしたときに、サーバーからデータを取得して、その結果をページ内の特定の`div`に挿入するパターン。

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>htmx Example</title>
    <script src="https://unpkg.com/htmx.org@2.0.2" defer></script>
  </head>
  <body>
    <button hx-get="/fetch-data" hx-target="#result">Load Data</button>
    <div id="result"></div>

    <!--
      サーバーサイドスクリプト例 (例えばPython Flask)
      from flask import Flask, jsonify
      app = Flask(__name__)

      @app.route('/fetch-data')
      def fetch_data():
          return "<p>This is the content loaded via HTMX!</p>"

      if __name__ == '__main__':
          app.run(debug=True)
    -->
  </body>
</html>
```

この例では、`hx-get`属性が`/fetch-data`エンドポイントからデータを取得し、`hx-target`で指定された場所にコンテンツを挿入する。また、サーバーサイドで Flask などを使って簡単なエンドポイントを設定することで、レスポンスとして返す HTML コードを担当させる。

### フォームの送信と部分的なアップデート

フォームの送信とその結果を部分的にページに反映する例。

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>htmx Example</title>
    <script src="https://unpkg.com/htmx.org@2.0.2" defer></script>
  </head>
  <body>
    <form hx-post="/submit-form" hx-target="#form-status" hx-swap="outerHTML">
      <input type="text" name="username" placeholder="Enter your name" />
      <button type="submit">Submit</button>
    </form>
    <div id="form-status"></div>

    <!--
      サーバーサイドスクリプト例 (例えばPython Flask)
      from flask import Flask, request

      app = Flask(__name__)

      @app.route('/submit-form', methods=['POST'])
      def submit_form():
          username = request.form['username']
          return f"<p>Thank you, {username}, for submitting the form!</p>"

      if __name__ == '__main__':
          app.run(debug=True)
    -->
  </body>
</html>
```

この例では、フォームが送信されると、サーバーにデータを POST し、その結果が`hx-target`で指定された場所に挿入される。また、`hx-swap`属性を使うことで、特定の方法（例えば`outerHTML`）で新しいコンテンツをどのように反映するかを指定できる。

### コンテンツの部分更新

ページの一部だけを更新する例。

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>htmx Example</title>
    <script src="https://unpkg.com/htmx.org@2.0.2" defer></script>
  </head>
  <body>
    <div id="main-content">
      <p>Initial content of the main area.</p>
    </div>

    <button hx-get="/new-content" hx-target="#main-content" hx-trigger="click">
      Update Content
    </button>

    <!--
      サーバーサイドスクリプト例 (例えばPython Flask)
      from flask import Flask

      app = Flask(__name__)

      @app.route('/new-content')
      def new_content():
          return "<p>This is the newly loaded content!</p>"

      if __name__ == '__main__':
          app.run(debug=True)
    -->
  </body>
</html>
```

この例では、ボタンがクリックされると、サーバーから新しいコンテンツが取得され、その結果が`#main-content`に更新される。
