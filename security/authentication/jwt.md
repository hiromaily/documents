# JWT

JWT（JSON Web Token）は、ユーザー認証情報やその他の情報を安全に転送するためのコンパクトでURLセーフなトークン形式。JWTは特に分散システムやマイクロサービスアーキテクチャで広く利用されている。その軽量かつ自己完結型の特性により、様々なシナリオで効率的かつセキュアな情報交換を実現する。

## 基本的な構造

JWTは3つの部分から構成されている。これらの部分はピリオド（.）で区切られており、Base64 URLエンコードされている。

1. **ヘッダー（Header）**
2. **ペイロード（Payload）**
3. **署名（Signature）**

### 1. ヘッダー（Header）

ヘッダーは、トークンのメタデータを含む部分で、通常はトークンの種類（JWT）と署名アルゴリズム（例：`HMAC SHA256`や`RSA`）を指定する。ヘッダーは以下のようなJSONオブジェクト。

```json
{
  "alg": "HS256",
  "typ": "JWT"
}
```

このJSONオブジェクトは、Base64 URLエンコードされてJWTの一部として使用される。

### 2. ペイロード（Payload）

ペイロードは、トークンに含まれる情報を保持する。この情報はクレーム（claims）と呼ばれる。クレームには以下の種類がある：

- **登録済みクレーム（Registered Claims）**：予め定義されたクレーム。例：`iss`（発行者）, `exp`（有効期限）, `sub`（主体）, `aud`（受信者）。
- **公開クレーム（Public Claims）**：共通の登録基盤（IANA）に従い、カスタムクレームとして使用されるクレーム。
- **非公開クレーム（Private Claims）**：アプリケーション間で独自に定義されるクレーム。

ペイロードの例

```json
{
  "sub": "1234567890",
  "name": "John Doe",
  "admin": true,
  "exp": 1716239022
}
```

これもBase64 URLエンコードされ、JWTの一部となる

### 3. 署名（Signature）

署名は、JWTのデータが改竄されていないかを確認するために使用される。署名は以下の手順で作成される。

1. エンコード済みヘッダーとペイロードを結合し、ピリオドで区切る。
2. 共有秘密鍵または公開/秘密鍵ペアを使って署名アルゴリズムを適用。

- HMAC SHA256の場合：

```txt
HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  secret)
```

最終的に、この署名をJWTの一部として追加する。

## JWTの例

完全なJWTの例

```txt
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.     // ヘッダー（Header）
eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImV4cCI6MTcxNjIzOTAyMn0. // ペイロード（Payload）
TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ  // 署名（Signature）
```

## JWTの利用シナリオ

### 1. ユーザー認証

ユーザーが一度ログインすると、サーバーはJWTを生成してクライアントに渡す。クライアントはその後、このJWTをすべてのリクエストに含めることで、サーバーに認証情報を提供する。

### 2. API認証

APIサーバーは、受け取ったJWTの署名を検証し、トークンが有効かどうかを確認する。これにより、認証済みのリクエストのみが処理されるようになる。

## セキュリティに関する考慮点

1. **秘密鍵の管理**:
   - 秘密鍵が漏洩すると、JWTの署名を偽造されるリスクがある。秘密鍵は適切に保護する必要がある。

2. **短い有効期限**:
   - JWTは基本的にステートレス（トークン自体にすべての情報を持つ）。セキュリティの観点から、できるだけ短い有効期限を設定することが推奨される。

3. **HTTPSの使用**:
   - JWTは平文でデータを持つため、HTTPSを使用してトークンの送受信を行い、中間者攻撃（MITM）を防ぐことが重要。

4. **クレームの検証**:
   - サーバー側でクレームの適切な検証を行うこと。特に、`exp`（有効期限）や`iss`（発行者）、`aud`（受信者）の検証は必須。

## Node.jsでJWTを使用した基本的な認証フローの例

### トークン発行

```js
const jwt = require('jsonwebtoken');
const secret = 'your-256-bit-secret';

const token = jwt.sign(
  {
    sub: '1234567890',
    name: 'John Doe',
    admin: true
  },
  secret,
  { expiresIn: '1h' }
);

console.log(token);
```

### トークンの検証

```js
const jwt = require('jsonwebtoken');
const secret = 'your-256-bit-secret';
const token = 'JWT-TOKEN-HERE';

try {
  const decoded = jwt.verify(token, secret);
  console.log(decoded);
} catch (err) {
  console.error('Invalid token', err);
}
```

これにより、JWTを使った認証の基本的なロジックを実装できる。JWTは、そのシンプルさと柔軟性によって、多くの現代的な認証システムで重宝されている。

## References

- [JWT についての説明書](https://zenn.dev/nameless_sn/articles/the_article_of_jwt)
- [Node.js server-side authentication: Tokens vs. JWT](https://blog.logrocket.com/node-js-server-side-authentication-tokens-vs-jwt/)
