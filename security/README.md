# Security

- [Network Security](../server-network/security.md)

## References
- [情報処理推進機構: 安全なウェブサイトの作り方](https://www.ipa.go.jp/security/vuln/websecurity.html)
- [OWASP Top Ten](https://owasp.org/www-project-top-ten/)
- [OWASP Top 10:2021](https://owasp.org/Top10/)
  - [github](https://github.com/OWASP/Top10)

## [Web Application Security, 2nd Edition](https://www.oreilly.com/library/view/web-application-security/9781098143923/)
1. Secure Application Configuration
  - Content Security Policy
    - Implementing CSP
    - CSP Structure
    - Important Directives
    - CSP Sources and Source Lists
    - Strict CSP
    - Example Secure CSP Policy
  - Cross-Origin Resource Sharing
    - Types of CORS Requests
    - Simple CORS Requests
    - Preflighted CORS Requests
    - Implementing CORS
  - Headers
    - Strict Transport Security
    - Cross-Origin-Opener
    - Cross-Origin-Resource-Policy
    - Headers with Security Implications
    - Legacy Security Headers
  - Cookies
    - Creating and Securing Cookies
    - Testing Cookies
  - Framing and Sandboxing
    - Traditional Iframe
    - Web Workers
    - Subresource Integrity
    - Shadow Realms
2. Threat Modeling Applications
  - Designing an Effective Threat Model
  - Threat Modeling by Example
    - Logic Design
    - Technical Design
    - Threat Identification (Threat Actors)
    - Threat Identification (Attack Vectors)
    - Identifying Mitigations
    - Delta Identification

## Front-endで気をつけるべき問題
### HTTPS以外での通信
- Mixed Content(内部コンテンツの一部にHTTP通信が発生するものが含まれる)も許容しない
  - ただし、動画や画像、音声データなどはブラウザで実行されるコードを含まないため、許容可能
- `HSTS (HTTP Strict Transport Security)`を使うことでHTTPSを強制することが可能
  - レスポンスヘッダに`Strict-Transport-Security`ヘッダを付与する
  - `includeSubdomains`ディレクティブによって、subdomainにも強制を要求する
  - `preload`ディレクティブによって、`HSTS Preload`を有効化し、初回のアクセスからHTTPS通信させる
    - ただし、HSTS Preloadのリストにドメインを追加したい場合は、`HSTS Preload List Submission`に記載されているガイドラインに従って申請する 

### OriginによるWebアプリケーション間のアクセス制限
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
    -  (まだ過渡期のため詳細は割愛)
    - `Cross-Origin Resource Policy (CORP)`
    - `Cross-Origin Embedder Policy (COEP)`
    - `Cross-Origin Opener Policy (COOP)`
  - `SharedArrayBuffer`とは？

### XSS クロスサイトスクリプティング
- 攻撃者が不正なスクリプトを攻撃対象ページのHTMLに挿入して、ユーザーに不正スクリプトを実行させる攻撃手法
- 脆弱性の報告でも数が多い
- XSS脆弱性を完全に排除することは難しい
#### XSSの脅威
- 機密情報の漏洩
- Webアプリケーションの改ざん
- 意図しない操作
- なりすまし
- フィッシング

#### 3種類のXSS
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

#### XSSの対策
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

#### Content Security Policy (CSP) を使った XSS対策
- [MDN: CSP Docs](https://developer.mozilla.org/ja/docs/Web/HTTP/CSP)
- Content Security Policy (CSP)はXSSなど不正なコードを埋め込むインジェクション攻撃を検知して被害の発生を防ぐためのブラウザの機能
- サーバから許可されていないJavaScriptの実行やリソースの読み込みなどをブロックする
- `Content-Security-Policy`ヘッダをページのレスポンスに含めることで有効化される
- もしくは、HTMLに`<meta>`要素でCSPの設定を埋め込むことも可能だが、HTTPヘッダでのCSPの指定が優先されたり、一部の設定が使えない可能性がある
- 同一ホストからJavascriptを読み込めるようにする場合には`self`を指定する
  - `Content-Security-Policy: script-src 'self' *.trusted.com`
- ディレクティブはさまざまなものが存在するため、[Docs](https://developer.mozilla.org/ja/docs/Web/HTTP/CSP)を確認すること



## [OWASP Top 10:2021](https://owasp.org/Top10/)

### A01:2021-アクセス制御の不備

### A02:2021-暗号化の失敗

### A03:2021-インジェクション

### A04:2021-安全が確認されない不安な設計

### A05:2021-セキュリティの設定ミス

### A06:2021-脆弱で古くなったコンポーネント

### A07:2021-識別と認証の失敗

### A08:2021-ソフトウェアとデータの整合性の不具合

### A09:2021-セキュリティログとモニタリングの失敗

### A10:2021-サーバーサイドリクエストフォージェリ(SSRF)

## Security Tools / 脆弱性診断
### [Burp Suite](https://portswigger.net/)
- Webアプリケーションセキュリティテストツール
- セキュリティツールとしても最も広く普及している製品の1つ
- ソフトウェア開発におけるセキュリティテストのほか、ペネトレーションテストなどにも利用されている
- 対象のWebアプリケーションに対する動的スキャンや、ソフトウェア開発パイプラインへの連携、テストの自動化、プロキシサービスといった機能を利用することができる

### [OWASP ZAP](https://www.zaproxy.org/)
- 無料のWeb脆弱性診断ツール
- OWASP(The Open Web Application Security Project)というコミュニティーによって開発されたもの
- [Web脆弱性診断ツール「OWASP ZAP」とは](https://www.shadan-kun.com/blog/measure/vulnerability/2961/)

### [Nikto](https://github.com/sullo/nikto)
- Perlで記述されたプラグ可能なWebサーバーおよびCGIスキャナーであり、rfpのLibWhiskerを使用して高速なセキュリティまたは情報チェックを実行する
- Web脆弱性診断ツール


### [Metasploit](https://www.metasploit.com/)
- オープンソースのペネトレーションテスト用プラットフォーム
- エクスプロイトの作成・テスト・実行や、脆弱性テストなどの機能を備えている
- サイバー攻撃などに悪用されたりもしている
- [wiki](https://ja.wikipedia.org/wiki/Metasploit)

### [OpenVAS](https://www.openvas.org/)
- 脆弱性スキャンツール
- リモートから脆弱性をスキャンするためのセキュリティチェック用ツール

### Nmap
- ネットワークの調査や監査などに使用するオープンソースのツール
- ポートスキャンによく使われる


## GDPRへの対応
- Cookieの送信をユーザー側で拒否した場合、HTTP通信時にXMLHttpRequestの場合、`withCredentials`をfalseで送信する必要がある。(要確認)
- Cookie付きのリクエストをクロスオリジンへ送信するためには、サーバー側で`Access-Control-Allow-Credentials`ヘッダを追加することでリクエストを許可する
