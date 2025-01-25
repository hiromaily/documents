# CORS

CORS（Cross-Origin Resource Sharing）は、Webアプリケーションが異なるオリジン間でリソースを安全にやり取りできるようにする機能で、`HTTPヘッダー`によって制御される。
CORSは、ウェブページが他のドメインからリソースを要求するときに、セキュリティを確保するためのメカニズム。通常、ブラウザは同一オリジンポリシー（Same-Origin Policy, SOP）を適用して、異なるドメインからのリソース取得を制限するが、CORSを利用することでこの制約を越えることができる。

CORSの適切な設定は、セキュリティと機能性のバランスを取ることが重要。リソースを共有する際には、必要最小限の設定に留めること。

## HTTPヘッダー

CORSの設定は主に以下のHTTPヘッダーによって行われる：

1. **Access-Control-Allow-Origin**
    - 指定したオリジンからのリクエストを許可します。
    - 例: `Access-Control-Allow-Origin: https://example.com`
    - すべてのオリジンを許可するにはアスタリスク（`*`）を使用しますが、セキュリティリスクが高いため注意が必要です。

2. **Access-Control-Allow-Methods**
    - 許可されたHTTPメソッドを指定します。
    - 例: `Access-Control-Allow-Methods: GET, POST, PUT, DELETE`

3. **Access-Control-Allow-Headers**
    - 許可されたHTTPリクエストヘッダーを指定します。
    - 例: `Access-Control-Allow-Headers: Content-Type, Authorization`

4. **Access-Control-Allow-Credentials**
    - 認証情報（クッキーやHTTP認証情報）をリクエストに含めることを許可するかどうかを指定します。
    - 例: `Access-Control-Allow-Credentials: true`

5. **Access-Control-Max-Age**
    - プリフライトリクエストの結果をキャッシュする時間を秒単位で指定します。
    - 例: `Access-Control-Max-Age: 3600`

6. **Access-Control-Expose-Headers**
    - レスポンスがJavaScriptからアクセス可能なヘッダーを指定します。
    - 例: `Access-Control-Expose-Headers: Content-Length, X-Kuma-Revision`

## Preflight request プリフライトリクエスト

- 特定の条件（例：メソッドがGET, HEAD, POST以外、カスタムヘッダーの使用など）のもとに、ブラウザは実際のリクエストを送信する前に、OPTIONSメソッドを使ってプリフライトリクエストを送信する。これは、サーバーが実際のリクエストを許可するかどうかを確認するため。

## Clientからのリクエストsample

```http
GET /api/data HTTP/1.1
Host: api.example.com
Origin: https://mywebsite.com
```

## Serverからのレスポンスsample

```http
HTTP/1.1 200 OK
Access-Control-Allow-Origin: https://mywebsite.com
Content-Type: application/json

{"data": "example"}
```

## 設定例

### Apache

```apache
<IfModule mod_headers.c>
    Header set Access-Control-Allow-Origin "*"
    Header set Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS"
    Header set Access-Control-Allow-Headers "Origin, X-Requested-With, Content-Type, Accept, Authorization"
    Header set Access-Control-Allow-Credentials "true"
</IfModule>
```

### Nginx

```nginx
location /api/ {
    if ($request_method = 'OPTIONS') {
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, DELETE, PUT';
        add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range';
        add_header 'Access-Control-Max-Age' 1728000;
        add_header 'Content-Type' 'text/plain charset=UTF-8';
        add_header 'Content-Length' 0;
        return 204;
    }
    if ($request_method = 'GET') {
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Credentials' 'true';
    }
}
```

## GoによるSample

### ライブラリを使わない場合

```go
package main

import (
    "net/http"
)

func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        w.Header().Set("Access-Control-Allow-Origin", "*")
        w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE")
        w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
        
        if r.Method == "OPTIONS" {
            w.WriteHeader(http.StatusOK)
            return
        }
        
        // Handle your requests here
        w.Write([]byte("Hello, World!"))
    })

    http.ListenAndServe(":8080", nil)
}
```

### `github.com/rs/cors`を使う場合

```go
package main

import (
    "github.com/rs/cors"
    "net/http"
)

func main() {
    mux := http.NewServeMux()
    mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        // Handle your requests here
        w.Write([]byte("Hello, World!"))
    })

    // Default CORS policy
    c := cors.New(cors.Options{
        AllowedOrigins:   []string{"*"},
        AllowedMethods:   []string{"GET", "POST", "PUT", "DELETE"},
        AllowedHeaders:   []string{"Content-Type", "Authorization"},
        AllowCredentials: true,
        MaxAge:           3600,
    })

    // Use the CORS handler to wrap the main handler
    handler := c.Handler(mux)

    // Start the server using the CORS handler
    http.ListenAndServe(":8080", handler)
}
```

## References

- [CORS ガイドの決定版](https://postd.cc/cors-the-ultimate-guide/)
