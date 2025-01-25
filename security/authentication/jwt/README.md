# JWT

JWT（JSON Web Token）は、ユーザー認証情報やその他の情報を安全に転送するためのコンパクトで URL セーフなトークン形式。JWT は特に分散システムやマイクロサービスアーキテクチャで広く利用されている。その軽量かつ自己完結型の特性により、様々なシナリオで効率的かつセキュアな情報交換を実現する。

## 基本的な構造

JWT は 3 つの部分から構成されている。これらの部分はピリオド（.）で区切られており、Base64 URL エンコードされている。

1. **ヘッダー（Header）**
2. **ペイロード（Payload）**
3. **署名（Signature）**

### 1. ヘッダー（Header）

ヘッダーは、トークンのメタデータを含む部分で、通常はトークンの種類（JWT）と署名アルゴリズム（例：`HMAC SHA256`や`RSA`）を指定する。ヘッダーは以下のような JSON オブジェクト。

```json
{
  "alg": "HS256",
  "typ": "JWT"
}
```

この JSON オブジェクトは、Base64 URL エンコードされて JWT の一部として使用される。

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

これも Base64 URL エンコードされ、JWT の一部となる

### 3. 署名（Signature）

署名は、JWT のデータが改竄されていないかを確認するために使用される。署名は以下の手順で作成される。

1. エンコード済みヘッダーとペイロードを結合し、ピリオドで区切る。
2. 共有秘密鍵または公開/秘密鍵ペアを使って署名アルゴリズムを適用。

- HMAC SHA256 の場合：

```txt
HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  secret)
```

最終的に、この署名を JWT の一部として追加する。

## JWT の例

完全な JWT の例

```txt
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.     // ヘッダー（Header）
eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImV4cCI6MTcxNjIzOTAyMn0. // ペイロード（Payload）
TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ  // 署名（Signature）
```

## References

- [JWT についての説明書](https://zenn.dev/nameless_sn/articles/the_article_of_jwt)
- [Node.js server-side authentication: Tokens vs. JWT](https://blog.logrocket.com/node-js-server-side-authentication-tokens-vs-jwt/)
- [2018: どうしてリスクアセスメントせずに JWT をセッションに使っちゃうわけ？](https://co3k.org/blog/why-do-you-use-jwt-for-session)
