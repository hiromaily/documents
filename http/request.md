# HTTP Request

- [内部Docs: cache](../cache/http-header/README.md)
- [ブラウザキャッシュの仕組み](https://zenn.dev/msy/articles/e81ff7cd52659a)

## [If-Modified-Since](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/If-Modified-Since)

サーバーは、受信したリクエストの`If-Modified-Since`ヘッダーの値を確認して、その URL のリソースの最終更新日がこの`If-Modified-Since`ヘッダーに指定した日時よりもあとだった場合には通常の HTTP レスポンスを返し、そうではない場合には `304 Not Modified` レスポンスを返す。

## [ETag](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/ETag)

ブラウザキャッシュを利用する仕組みで、ブラウザにて、コンテンツに対する Hash を持ち、これを最新のコンテンツ要求時に添える。サーバ側は送られた Hash と最新のコンテンツの Hash を比較し、更新の有無をクライアントへ返却する。更新が無ければコンテンツは返送しない。

## [Last-Modified](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Last-Modified)

Last-Modified は、当該リソースの最終更新日時を伝えるためのヘッダで、ETag ヘッダーよりも精度は低く、その代替手段になる
