# HTTP Status Code

## 103 Early Hints

103 Early Hints は、HTTP レスポンスのステータスコードの一つで、サーバーからクライアント（通常はウェブブラウザ）に対して、最終的なレスポンスが得られる前にヘッダー情報を先行通知するために使用される。これは、ブラウザなどのクライアントがリソースの本体を待機している間に、リンクされたリソースを事前にフェッチしたりキャッシュしたりするために用いられる可能性がある。

具体的には、103 ステータスコードは、`Link`ヘッダーを使用して、次に読み込むべきリソース（例えば、CSS や JavaScript ファイルなど）を指定する。これにより、クライアントはメインの HTML ドキュメントがロードされる前に、これらのリソースを並行して取得し始めることができ、最終的なページの表示をスピードアップすることができる。

103 Early Hints は、特にページロードのパフォーマンスを向上させるために HTTP/2 や HTTP/3 のようなより新しいプロトコルで効果的に利用される。このステータスコードは、最適なエクスペリエンスを提供するために、ウェブ開発者やサーバー管理者がサイトのレスポンス速度を向上させるための一助となる。

- [103 Early Hints とは何か？ ～マイナーだけど革新的な HTTP ステータスの世界～](https://tech.repro.io/entry/2025/01/28/125334)

## HTTP Status Code For Redirect

### 301 Moved Permanently

- Do cache
- It's possible to change from POST to GET

### 302 Found

- Not cache
- It's possible to change from POST to GET

### 307 Temporary Redirect

- Not cache
- It's not possible to change from POST to GET

### 308 Moved Permanently

- Do cache
- It's not possible to change from POST to GET
