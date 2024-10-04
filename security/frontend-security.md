# Front-endで気をつけるべき問題

## HTTPS以外での通信

- Mixed Content(内部コンテンツの一部にHTTP通信が発生するものが含まれる)も許容しない
  - ただし、動画や画像、音声データなどはブラウザで実行されるコードを含まないため、許容可能
- `HSTS (HTTP Strict Transport Security)`を使うことでHTTPSを強制することが可能
  - レスポンスヘッダに`Strict-Transport-Security`ヘッダを付与する
  - `includeSubdomains`ディレクティブによって、subdomainにも強制を要求する
  - `preload`ディレクティブによって、`HSTS Preload`を有効化し、初回のアクセスからHTTPS通信させる
    - ただし、HSTS Preloadのリストにドメインを追加したい場合は、`HSTS Preload List Submission`に記載されているガイドラインに従って申請する

## OriginによるWebアプリケーション間のアクセス制限

- 同一オリジンポリシー(Same-Origin Policy)によって他のWebアプリケーションからのアクセスを制限する
  - ブラウザ側でデフォルトで有効化されている
  - サブドメインもCrossオリジンと見做される
  - iframeにも有効で、外部のJavascriptからはアクセスができない
  - WebStorageやIndexedDBに保存されたデータにも有効
  - これを回避するためにはCORSを利用する必要がある
- CORS (Cross-Origin Resource Sharing)
  - 許可するリソースの選定
  - サーバー側で`Access-Control-Allow-Origin`を設定するが、値に`*`は使わない
  - fetch関数にはリクエストのモードとして`same-origin`, `cors`(default), `no-cors`とあるが、状況によって使い分ける
- サイドチャネル攻撃
  - ブラウザを実行しているコンピューターのCPUやメモリの特性を悪用した攻撃
  - [`Spectre`](https://ja.wikipedia.org/wiki/Spectre)が有名
  - この攻撃を防ぐために、最新ブラウザではRendererのプロセスが分離するようになっている。この仕組みが`Site Isolation`
  - オリジン毎にプロセスを分離する仕組みを`Cross-Origin Isolation`といい、サーバー側のレスポンスヘッダに指定できる
    - (まだ過渡期のため詳細は割愛)
    - `Cross-Origin Resource Policy (CORP)`
    - `Cross-Origin Embedder Policy (COEP)`
    - `Cross-Origin Opener Policy (COOP)`
  - `SharedArrayBuffer`とは？

## XSS クロスサイトスクリプティング

- 攻撃者が不正なスクリプトを攻撃対象ページのHTMLに挿入して、ユーザーに不正スクリプトを実行させる攻撃手法
- 脆弱性の報告でも数が多い
- XSS脆弱性を完全に排除することは難しい

### XSSの脅威

- 機密情報の漏洩
- Webアプリケーションの改ざん
- 意図しない操作
- なりすまし
- フィッシング

### 3種類のXSS

- 反射型XSS (Reflected XSS)
  - Server-sideのコード不備で発生
- 蓄積型XSS (Stored XSS)
  - Server-sideのコード不備で発生
- DOM-based XSS
  - Front-endのコード不備で発生
  - URLの#以降の文字を何かの値に使う場合など、注意が必要
  - DOM-based XSSを引き起こす原因となる文字列を`ソース`呼ぶ
    - location.hash
    - location.search
    - location.href
    - document.referrer
    - postMessage
    - Webストレージ
    - IndexedDB
  - `ソース`の文字列からJavascriptを生成、実行してしまう箇所を`シンク`という。
    - `シンク`となる機能はなるべく使わない
      - innerHTML
      - eval
      - location.href
      - document.write
      - jQuery

### XSSの対策

- 文字列に対してエスケープ処理を行い、HTMLとして解釈させないこと
- 属性値の文字列はエスケープ処理に加え、クォーテーションで囲む
- XSS対策を自動で行うライブラリやフレームワークを使う
- LINK URLのスキームをhttp/httpsに限定する
  - これは、`<a>`のhref属性にはjavascriptスキームを指定することもできるため
- Cookieに`HttpOnly`属性を付与する
  - これはサーバーサイドでCookieを発行するタイミングでこの属性を追加することで、JavaScriptからCookieの値を取得できなくなる
- Reactといったフレームワークでは、自動的にフレームワーク内部でエスケープ処理が走る
  - 例外として、Reactの`dangerouslySetInnerHTML`を使う場合はエスケープ処理が実行されないので注意が必要
  - ReactでもjavascriptスキームによるXSSは防ぐことができないが、Consoleで警告文が出るので開発時にチェックが必要
- [`DOMPurify`](https://github.com/cure53/DOMPurify)というライブラリによって、sanitizeが可能
  - `const clean = DOMPurfify.sanitize(dirty);`
- `Sanitizer API`を使った対策
  - [ブラウザ対応状況](https://caniuse.com/mdn-api_sanitizer)

```js
const sanitizer = new Sanitizer();
el.setHTML(dirty, sanitizer);
```

- DOM-based XSSの`シンク`は使わず、適切なDOM APIを使うこと

### Content Security Policy (CSP) を使った XSS対策

- [MDN: CSP Docs](https://developer.mozilla.org/ja/docs/Web/HTTP/CSP)
- Content Security Policy (CSP)はXSSなど不正なコードを埋め込むインジェクション攻撃を検知して被害の発生を防ぐためのブラウザの機能
- サーバから許可されていないJavaScriptの実行やリソースの読み込みなどをブロックする
- `Content-Security-Policy`ヘッダをページのレスポンスに含めることで有効化される
- もしくは、HTMLに`<meta>`要素でCSPの設定を埋め込むことも可能だが、HTTPヘッダでのCSPの指定が優先されたり、一部の設定が使えない可能性がある
- 同一ホストからJavascriptを読み込めるようにする場合には`self`を指定する
  - `Content-Security-Policy: script-src 'self' *.trusted.com`
- ディレクティブはさまざまなものが存在するため、[Docs](https://developer.mozilla.org/ja/docs/Web/HTTP/CSP)を確認すること
