# JWK

JWK（JSON Web Key）は、JSON形式で表現された暗号鍵のデータ構造。JWKは、公開鍵や秘密鍵、対称鍵などを扱うための標準的な形式を提供する。これにより、さまざまなアプリケーションやシステム間で鍵を安全かつ互換性のある方法で共有することができる。
JWKは鍵の標準的なフォーマットの一つであり、特にWebアプリケーションやAPIのセキュリティにおいて広く使用されている。JWK形式を使用することで、鍵の管理と共有が容易になる。

## JWKの主な特徴

1. **標準化されたフォーマット**:
   - JWKは、鍵の種類（RSA、EC、対称鍵など）に応じて異なるフィールドを持つが、すべてJSON形式で統一されている。

2. **メタデータの定義**:
   - 鍵の使用目的（暗号化、署名など）やアルゴリズム、キーオペレーションなどの追加情報を含めることができる。

3. **互換性**:
   - JSON形式を使用するため、さまざまなプログラミング言語やライブラリで容易に扱うことができる。

## JWKの例

RSA鍵を含むJWKの例を以下に示す：

```json
{
  "kty": "RSA",
  "n": "vsbOUoFA......",  // モジュラス
  "e": "AQAB",             // 公開指数
  "d": "GaDzOmc4......",   // 私用指数 (秘密鍵の場合)
  "p": "5QJitCu9......",   // 一つ目の素数
  "q": "1ULfGui5......",   // 二つ目の素数
  "dp": "WAByrYmh......",  // D mod (P-1)
  "dq": "WLwjYun0......",  // D mod (Q-1)
  "qi": "2cK4apee......",  // (Q^(-1)) mod P
  "alg": "RS256",          // 使用アルゴリズム
  "kid": "example-key-id", // 鍵の識別子 (オプション)
  "use": "sig",            // 使用用途 (署名)
  "key_ops": ["sign"]      // キーの操作 (署名)
}
```

## フィールドの説明

- **kty (Key Type)**: 鍵の種類を示します。上記の例では「RSA」。
- **n**: RSAモジュラス。
- **e**: RSA公開指数。
- **d**: RSA秘密指数（秘密鍵の場合に使用）。
- **p**: RSA秘密鍵の一つ目の素数。
- **q**: RSA秘密鍵の二つ目の素数。
- **dp**: D modulo (P-1)。
- **dq**: D modulo (Q-1)。
- **qi**: Q^(-1) modulo P。
- **alg (Algorithm)**: 鍵が使用されるアルゴリズム。
- **kid (Key ID)**: 鍵の識別子（オプション）。
- **use (Public Key Use)**: 鍵の使用目的（例えば、署名「sig」）。
- **key_ops (Key Operations)**: 鍵の操作（例えば、署名「sign」）。

## JWKの使用例（Goでの実装）

以下に、GoでRSA鍵を生成し、JWK形式に変換する方法を示す。

```go
package main

import (
    "crypto/rand"
    "crypto/rsa"
    "crypto/x509"
    "encoding/json"
    "fmt"
    "log"

    "github.com/lestrrat-go/jwx/v2/jwk"
)

// RSAプライベートキーを生成
func generateRSAPrivateKey() (*rsa.PrivateKey, error) {
    return rsa.GenerateKey(rand.Reader, 2048)
}

// RSAプライベートキーをJWK形式に変換
func privateKeyToJWK(privateKey *rsa.PrivateKey) (jwk.Key, error) {
    jwkKey, err := jwk.New(privateKey)
    if err != nil {
        return nil, err
    }

    jwkKey.Set(jwk.AlgorithmKey, "RS256")
    jwkKey.Set(jwk.KeyIDKey, "example-key-id")
    jwkKey.Set(jwk.KeyUsageKey, "sig")

    return jwkKey, nil
}

func main() {
    privateKey, err := generateRSAPrivateKey()
    if err != nil {
        log.Fatalf("Error generating private key: %v", err)
    }

    jwkKey, err := privateKeyToJWK(privateKey)
    if err != nil {
        log.Fatalf("Error converting private key to JWK: %v", err)
    }

    // JWKをJSONとしてエンコード
    jwkJSON, err := json.MarshalIndent(jwkKey, "", "  ")
    if err != nil {
        log.Fatalf("Error encoding JWK to JSON: %v", err)
    }

    fmt.Println("JWK formatted private key:\n", string(jwkJSON))
}
```

### 詳しい説明

- **`generateRSAPrivateKey`**:
  - 2048ビットのRSAプライベートキーを生成する。

- **`privateKeyToJWK`**:
  - `jwk.New`関数を使用して、生成したRSAプライベートキーをJWK形式に変換する。
  - 鍵のアルゴリズムや使用目的などのメタデータを設定する。

- **JSONエンコード**:
  - 生成されたJWKをJSON形式としてエンコードし、出力する。
