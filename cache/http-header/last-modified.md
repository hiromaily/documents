# HTTP Response Header `Last-Modified`

`Last-Modified`ヘッダーは`HTTPレスポンスヘッダー`として使用され、指定されたリソースが最後に変更された日時を示す。これにより、クライアントはリソースの更新状態を効率的に確認できる。クライアントはこの情報を後でリクエストに利用して、再度リソースを取得する必要があるかどうかを判断する。

クライアント側では、この情報を`If-Modified-Since`リクエストヘッダーとして送信し、リソースが変更されていないかを確認する。

## サーバー側でHTTP Response `Last-Modified`ヘッダーを返す

サーバーはリソースの最終更新日時を`Last-Modified`ヘッダーに設定してレスポンスを送信する。

```http
HTTP/1.1 200 OK
Content-Type: application/json
Last-Modified: Wed, 21 Oct 2015 07:28:00 GMT

{
  "id": 1,
  "name": "Example Resource",
  "updated": "2023-10-05T10:00:00Z"
}
```

このレスポンスは指定された日時にリソースが最後に更新されたことを示している。

## クライアント側の確認方法

クライアントは、先に受け取った`Last-Modified`日時を使用して、リソースが変更されたかどうかを確認するために`If-Modified-Since`ヘッダーをリクエストに含める。

```http
GET /resource/1 HTTP/1.1
Host: example.com
If-Modified-Since: Wed, 21 Oct 2015 07:28:00 GMT
```

サーバーはリソースの最終更新日時を確認し、リソースが変更されていない場合には`304 Not Modified`レスポンスを返し、変更がある場合には新しいリソースと共に`200 OK`を返す。

## サーバー側でのGolangによる実装例

以下の例では、`Last-Modified`ヘッダーを設定し、クライアント側から`If-Modified-Since`ヘッダーを受け取ってリソースの変更状態を確認する方法を示す。

```go
package main

import (
  "fmt"
  "net/http"
  "time"
)

func main() {
  http.HandleFunc("/", handler)
  fmt.Println("Server is running at :8080")
  http.ListenAndServe(":8080", nil)
}

func handler(w http.ResponseWriter, r *http.Request) {
  lastModified := time.Date(2023, 10, 5, 10, 0, 0, 0, time.UTC)

  // Last-Modified ヘッダーを設定
  w.Header().Set("Last-Modified", lastModified.Format(http.TimeFormat))

  // If-Modified-Since ヘッダーをチェック
  ifModifiedSince := r.Header.Get("If-Modified-Since")
  if ifModifiedSince != "" {
    // If-Modified-Sinceの値を時刻に変換
    t, err := time.Parse(http.TimeFormat, ifModifiedSince)
    if err == nil && lastModified.Before(t.Add(1*time.Second)) {
      w.WriteHeader(http.StatusNotModified) // 304 Not Modified
      return
    }
  }

  // Exampleのレスポンスデータ
  w.WriteHeader(http.StatusOK)
  fmt.Fprintf(w, "Hello, World!")
}
```

## まとめ

- **HTTPレスポンスヘッダーとしての`Last-Modified`**：
  - サーバーがリソースの最終更新日時をクライアントに伝えるために使用する。
  - 例：`Last-Modified: Wed, 21 Oct 2015 07:28:00 GMT`
  
- **HTTPリクエストヘッダーとしての`If-Modified-Since`**：
  - クライアントがリソースの更新状態を確認するためにサーバーに送信する。
  - 例：`If-Modified-Since: Wed, 21 Oct 2015 07:28:00 GMT`

これらのヘッダーを適切に使用することで、キャッシュの効率を向上させ、無駄なデータ転送を避けることができる。
