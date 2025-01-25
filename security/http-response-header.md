# HTTP Response Header for Security

## X-Content-Type-Options

このヘッダーを使用して、特定の種類の攻撃から保護するのに役立つ MIME タイプ スニッフィングを防止できる。 例えば：

```http
X-Content-Type-Options: nosniff
```

このヘッダーは、応答の MIME タイプを盗聴しないようにブラウザに指示し、代わりに応答ヘッダーで指定されたコンテンツ タイプを使用する。
nosniff これが含まれる場合はブラウザ側で MIME スニッフィングは行わず、サーバが Content-Type で指定したメディアタイプに必ず従うようになる。

## Referrer-Policy

referer を送信するブラウザの挙動を変更することができる。

```http
Referrer-Policy: strict-origin-when-cross-origin
```

同一のプロトコル水準 (HTTP→HTTP, HTTPS→HTTPS) で同一 origin のリクエストを行う場合は origin、パス、クエリー文字列を送信する。オリジン間リクエストや安全性の低下する移動先 (HTTPS→HTTP) では origin のみを送信する。

## Content-Type

リソースの media type を示す

```http
Content-Type: text/html; charset=UTF-8
```

charset は html 内で XSS を防ぐための 1 つの重要な要素となる

## Set-Cookie

Cookie の設定

- `Secure`属性で HTTPS 上でのみリクエストを許可
- `HttpOnly` 属性で js の Document.cookie API を禁止
- `Domain`属性で、受信 host を指定 (しかし Default で Cookie を設定した host が設定される) 設定不要なはず
- `SameSite`属性で、cross-site 上での挙動を指定。設定不要なはず

## Strict-Transport-Security (HSTS)

TLS による通信の強制

```http
Strict-Transport-Security: max-age=63072000; includeSubDomains; preload
```

## Access-Control-Allow-Origin

CORS (cross-origin resource sharing)

```http
Access-Control-Allow-Origin: https://yoursite.com
```

値に\*は使わないこと

## X-Frame-Options (Deprecated)

このヘッダーは、クリックジャッキング攻撃を防ぐために使用できる。クリックジャッキング攻撃は、ユーザーをだまして非表示または偽装したリンクをクリックさせるために使用できる。 例えば：

```http
X-Frame-Options: DENY
```

このヘッダーは、ページがフレームまたは iframe に読み込まれるのを防ぎ、クリックジャッキング攻撃から保護するのに役立つ。

### X-Frame-Options の Replacement

Content security policy の`frame-ancestors` directive を使う

## X-XSS-Protection 　(Deprecated)

最新のブラウザではサポートされていない

このヘッダーを使用して、ブラウザーの組み込み XSS 保護を有効にすることができる。これは、クロスサイト スクリプティング攻撃から保護するのに役立つ。 例えば：

```http
X-XSS-Protection: 1; mode=block
```

このヘッダーは、ブラウザーの組み込み XSS 保護を有効にし、XSS 攻撃が検出された場合にページをブロックするように指示する。

### X-XSS-Protection の Replacement

Content security policy を使う
