# HTTP Request

HTTP（HyperText Transfer Protocol）リクエストヘッダーは、クライアント（通常はウェブブラウザ）がサーバにリクエストを送信するときに含まれるヘッダ情報。これらのヘッダーは、サーバがリクエストを適切に処理するための追加情報を提供する。

## 主なHTTPリクエストヘッダー

1. **Host**
    - 説明: サーバのホスト名（ドメイン名）とオプションのポート番号を指定します。HTTP/1.1では必須です。
    - 例: `Host: www.example.com`

2. **User-Agent**
    - 説明: リクエストを送信しているブラウザやクライアントの種類、バージョン、プラットフォーム情報を示します。
    - 例: `User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36`

3. **Accept**
    - 説明: クライアントが受け入れることができるメディアタイプ（MIMEタイプ）を指定します。
    - 例: `Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8`

4. **Accept-Language**
    - 説明: クライアントが好む言語を指定します。
    - 例: `Accept-Language: en-US,en;q=0.5`

5. **Accept-Encoding**
    - 説明: クライアントが受け入れることができるコンテンツエンコーディング（圧縮フォーマット）を指定します。
    - 例: `Accept-Encoding: gzip, deflate, br`

6. **Connection**
    - 説明: 通信の継続や切断に関する指示をサーバに対して行います。一般的な値としては `keep-alive`（接続を維持）や `close`（接続を切断）があります。
    - 例: `Connection: keep-alive`

7. **Cache-Control**
    - 説明: クライアントサイドでのキャッシングポリシーを指定します。
    - 例: `Cache-Control: no-cache`

8. **Referer**
    - 説明: リクエストが発生した元のURLを指定します。リンク元のページを示します。
    - 例: `Referer: https://www.google.com`

9. **Authorization**
    - 説明: 保護されたリソースにアクセスするための認証情報を提供します。
    - 例: `Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==`

10. **Content-Type**
    - 説明: リクエストボディのメディアタイプを指定します。POSTやPUTリクエストで送信されるデータのタイプに使用します。
    - 例: `Content-Type: application/x-www-form-urlencoded`

11. **Cookie**
    - 説明: クライアントに保存されたクッキー情報をサーバに送信します。ユーザーのセッション管理や状態を保持するために使用されます。
    - 例: `Cookie: sessionId=abc123; otherCookie=value`

12. **If-Modified-Since**
    - 説明: リソースが指定した日時以降に変更されたかどうかを確認するために使用されます。条件付きリクエストに利用します。
    - 例: `If-Modified-Since: Wed, 21 Oct 2015 07:28:00 GMT`

13. **Content-Length**
    - 説明: リクエストボディの長さをバイト単位で指定します。
    - 例: `Content-Length: 348`

## Cache関連のヘッダー

### [If-Modified-Since](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/If-Modified-Since)

サーバーは、受信したリクエストの`If-Modified-Since`ヘッダーの値を確認して、その URL のリソースの最終更新日がこの`If-Modified-Since`ヘッダーに指定した日時よりもあとだった場合には通常の HTTP レスポンスを返し、そうではない場合には `304 Not Modified` レスポンスを返す。

### [ETag](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/ETag)

ブラウザキャッシュを利用する仕組みで、ブラウザにて、コンテンツに対する Hash を持ち、これを最新のコンテンツ要求時に添える。サーバ側は送られた Hash と最新のコンテンツの Hash を比較し、更新の有無をクライアントへ返却する。更新が無ければコンテンツは返送しない。

### [Last-Modified](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Last-Modified)

Last-Modified は、当該リソースの最終更新日時を伝えるためのヘッダで、ETag ヘッダーよりも精度は低く、その代替手段になる

## `X-`

HTTPリクエストヘッダーは、標準的なものの他にもカスタムヘッダーを定義・使用することができる。ただし、カスタムヘッダーを使用する場合は、名前の前に `X-` 接頭辞を付けることが推奨されることもある（例：`X-Custom-Header`）。

## HTTPのバージョンの違いによる、リクエストヘッダの影響

また、リクエストヘッダーはHTTPのバージョン（HTTP/1.0, HTTP/1.1, HTTP/2など）や利用しているプロトコルの種類（HTTP, HTTPS）によって細かい仕様や使用可能なヘッダーが異なることがある。

### 事例1: curlではリクエストが通るが、GoやRustといったプログラムから同様のリクエストを行うと失敗する

HTTP バージョン差異が原因の場合。例えば、cURL は HTTP/2、Go アプリケーションは HTTP/1.1を使っているなど。

- HTTP/2 ではヘッダーは小文字のみ許容される
- Go HTTP/1.1 ではヘッダーは MIME 正規化される
  - 例えば、Go HTTP/1.1 においては X-Api-Key は X-Api-Key、x-api-key も X-Api-Key として扱われる

## References

- [内部Docs: cache](../cache/http-header/README.md)
- [ブラウザキャッシュの仕組み](https://zenn.dev/msy/articles/e81ff7cd52659a)
- [cURLは成功しGo HTTPリクエストは失敗する事象の裏にある仕様](https://developers.cyberagent.co.jp/blog/archives/53785/)
