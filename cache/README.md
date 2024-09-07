# Cache

以下の方法を組み合わせることで、APIレスポンスのキャッシュを最適化し、パフォーマンスを向上させることができる。具体的なキャッシュ戦略は、APIの要件や使用状況に応じて設定する必要がある。

## 1. HTTP Headerの活用

HTTPキャッシュヘッダーを利用して、APIレスポンスのキャッシュを制御する方法。

### Cache-Control

`Cache-Control`ヘッダーを使用して、キャッシュポリシーを設定する。以下のオプションがよく使われる：

- `max-age=<seconds>`：キャッシュの有効期間を秒単位で指定。
- `no-cache`：キャッシュの検証が必要であることを示す。
- `no-store`：キャッシュストレージに保存しない。
- `must-revalidate`：キャッシュが期限切れの場合、オリジンサーバーに再確認。

```http
Cache-Control: max-age=3600, must-revalidate
```

### ETag

`ETag`ヘッダーを使用して、リソースのバージョンを識別するタグを提供。キャッシュされたリソースが更新されたかどうかを確認するために使用される。

```http
ETag: "abc123"
```

### Last-Modified

`Last-Modified`ヘッダーを使用して、リソースが最後に変更された日時を提供。キャッシュが期限切れかどうかを判断するのに役立つ。

```http
Last-Modified: Wed, 21 Oct 2015 07:28:00 GMT
```

## 2. CDN（Content Delivery Network）

CDNを利用して、APIレスポンスを地理的に分散されたサーバーにキャッシュする。これにより、ユーザーに近いサーバーからレスポンスを提供することで、遅延を減少させる。

### CDNのメリット

- 高速な配信
- サーバー負荷の軽減
- グローバルな可用性の向上

## 3. Reverse Proxy

リバースプロキシサーバー（例: NGINX、Varnish）を使って、APIリクエストをキャッシュする。リバースプロキシは、オリジンサーバーに代わってリクエストを受け取り、キャッシュされたレスポンスを返す。

### NGINXの例

```nginx
server {
    location /api/ {
        proxy_pass http://backend_server;
        proxy_cache my_cache;
        proxy_cache_valid 200 1h;
    }
}
```

## 4. アプリケーションレベルのキャッシュ

アプリケーション自体にキャッシュ機能を組み込む方法。メモリキャッシュ（例: Redis、Memcached）を使用して、頻繁にアクセスされるデータをキャッシュする。

### アプリケーションレベルのキャッシュのメリット

- 高速な読み込み
- 柔軟なキャッシュ戦略の設計

```py
import redis

cache = redis.Redis(host='localhost', port=6379)

def get_user_data(user_id):
    cache_key = f"user_data:{user_id}"
    cached_data = cache.get(cache_key)

    if cached_data:
        return cached_data
    else:
        user_data = fetch_user_data_from_db(user_id)
        cache.set(cache_key, user_data, ex=3600)  # キャッシュ有効期間1時間
        return user_data
```

## 5. ブラウザキャッシュ

APIレスポンスにキャッシュ制御ヘッダーを追加することで、クライアント側のブラウザにキャッシュさせる。

### ブラウザキャッシュのメリット

- クライアント側の負担軽減
- レスポンスタイムの短縮

```http
Cache-Control: public, max-age=3600
```
