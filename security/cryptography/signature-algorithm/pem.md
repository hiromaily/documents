# PEM（Privacy-Enhanced Mail）

PEM（Privacy-Enhanced Mail）は、証明書や暗号鍵などのデータを表現するためのフォーマット。もともとは電子メールのセキュリティを強化するために開発されたが、現在では様々な暗号学的アプリケーションで広く使用されている。

## PEMフォーマットの特徴

1. **Base64エンコード**：
   - PEMフォーマットはデータをBase64でエンコードする。これにより、バイナリデータをテキスト形式に変換し、電子メールやテキストファイルで容易に扱えるようになる。

2. **ヘッダーとフッター**：
   - PEMデータは特定のヘッダーとフッターによって囲まれる。ヘッダーとフッターによってデータの種類が識別される。
   - 例えば、RSAプライベートキーの場合、次のようになる：

     ```txt
     -----BEGIN RSA PRIVATE KEY-----
     [Base64 encoded data]
     -----END RSA PRIVATE KEY-----
     ```

## PEM 使用例

PEMフォーマットはSSL/TLS証明書、RSA鍵、EC鍵、CSR（Certificate Signing Request）など様々なセキュリティファイルで使われる。

### RSAプライベートキー

```plaintext
-----BEGIN RSA PRIVATE KEY-----
MIIBOgIBAAJBALf+xJr64hjA2Xv+XynnX9+T2VwSk7g6CizOw2b+Ld57VoP/TFn8
...
-----END RSA PRIVATE KEY-----
```

### X.509証明書

```plaintext
-----BEGIN CERTIFICATE-----
MIIBwjCCASigAwIBAgIUQr7Kw6V5K9jeO5/exAw3...
...
-----END CERTIFICATE-----
```

## RSA鍵の生成とPEMエンコードの例

```go
package main

import (
  "crypto/rand"
  "crypto/rsa"
  "crypto/x509"
  "encoding/pem"
  "fmt"
)

// RSAプライベートキーを生成する関数
func generateRSAPrivateKey() (*rsa.PrivateKey, error) {
  // 2048ビットのRSA鍵を生成
  privateKey, err := rsa.GenerateKey(rand.Reader, 2048)
  if err != nil {
    return nil, err
  }
  return privateKey, nil
}

// RSAプライベートキーをPEMフォーマットに変換する関数
func privateKeyToPEM(privateKey *rsa.PrivateKey) string {
  privKeyBytes := x509.MarshalPKCS1PrivateKey(privateKey) // PKCS1形式でエンコード
  privKeyPEM := pem.EncodeToMemory(&pem.Block{
    Type:  "RSA PRIVATE KEY",
    Bytes: privKeyBytes,
  })
  return string(privKeyPEM)
}

func main() {
  privateKey, err := generateRSAPrivateKey()
  if err != nil {
    fmt.Println("Error generating private key:", err)
    return
  }

  pemString := privateKeyToPEM(privateKey)
  fmt.Println("PEM formatted private key:\n", pemString)
}
```

## テストでの使用例

先ほどの鍵生成関数を活用して、テストケースでRSA鍵を動的に生成し使用する方法：

```go
package jwts_test

import (
  "crypto/rand"
  "crypto/rsa"
  "crypto/x509"
  "encoding/pem"
  "testing"
  "time"

  "github.com/lestrrat-go/jwx/v2/jwa"
  "github.com/lestrrat-go/jwx/v2/jwk"
  "github.com/lestrrat-go/jwx/v2/jwt"
  "github.com/stretchr/testify/assert"
  "github.com/stretchr/testify/require"
  "github.com/light-vortex/communication-hub/batch/pkg/logger"
  "github.com/light-vortex/communication-hub/batch/jwts"
)

// RSAプライベートキーを生成
func generateRSAPrivateKey() (*rsa.PrivateKey, error) {
  return rsa.GenerateKey(rand.Reader, 2048)
}

// RSAプライベートキーをPEMフォーマットに変換
func privateKeyToPEM(privateKey *rsa.PrivateKey) string {
  privKeyBytes := x509.MarshalPKCS1PrivateKey(privateKey)
  privKeyPEM := pem.EncodeToMemory(&pem.Block{
    Type:  "RSA PRIVATE KEY",
    Bytes: privKeyBytes,
  })
  return string(privKeyPEM)
}

func TestRS256Signer_Issue(t *testing.T) {
  mockLogger := &logger.MockLogger{} // 実際のロガーを設定してください

  privateKey, err := generateRSAPrivateKey()
  require.NoError(t, err)

  privateKeyPEM := privateKeyToPEM(privateKey)

  signer, err := jwts.NewRS256Signer(mockLogger, "1234", privateKeyPEM, "https://audience.url", 10, 30)
  require.NoError(t, err)

  token, err := signer.Issue()
  require.NoError(t, err)
  require.NotEmpty(t, token)

  publicKey := &privateKey.PublicKey
  jwkPublicKey, err := jwk.FromRaw(publicKey)
  require.NoError(t, err)

  parsedToken, err := jwt.Parse(
    []byte(token),
    jwt.WithVerify(jwa.RS256, jwkPublicKey),
  )
  require.NoError(t, err)

  assert.Equal(t, "1234", parsedToken.Subject())
  assert.Equal(t, "1234", parsedToken.Issuer())
  assert.ElementsMatch(t, []string{"https://audience.url"}, parsedToken.Audience())
  assert.WithinDuration(t, time.Now().Add(10*time.Second), parsedToken.Expiration(), 1*time.Second)

  tokenExpValue, exists := parsedToken.Get("token_exp")
  require.True(t, exists, "token_exp should exist in the token")
  assert.IsType(t, float64(0), tokenExpValue, "token_exp should be of type float64")
  assert.Equal(t, float64(1800), tokenExpValue, "token_exp value should be 1800")
}

```

1. **`generateRSAPrivateKey`** 関数は正しいフォーマットでRSAプライベートキーを生成します。
2. **`privateKeyToPEM`** 関数は生成されたプライベートキーをPEM形式の文字列に変換します。
3. **`TestRS256Signer_Issue`** 関数は動的に生成されたプライベートキーを使用してJWTを発行し、その正当性を検証します。
