
# FIDO2 認証

次世代のパスワードレス認証を実現するための標準規格で、特にWebベースのアプリケーションやサービスにおけるセキュアなユーザー認証を目指している。FIDO2は、Web Authentication（WebAuthn）APIとClient to Authenticator Protocol（CTAP）2という二つの主要コンポーネントから構成される。

FIDO2は、パスワードに依存しない強力かつ使いやすい認証を提供するための標準規格。これにより、セキュリティとユーザビリティの両方を向上させることができる。WebAuthnとCTAPを組み合わせることで、さまざまなデバイスやプラットフォームでの安全な認証が可能となり、将来的にはインターネット上の標準的な認証手法となることが期待されている。

## FIDOとFIDO2の主要な違い

```markdown

| 特徴                         | FIDO (UAF, U2F)                    | FIDO2 (WebAuthn + CTAP)               |
|-----------------------------|-----------------------------------|----------------------------------------|
| **認証方法**                | パスワードレス認証（UAF）、二要素認証（U2F） | パスワードレス認証、 多要素認証 (MFA)   |
| **ブラウザサポート**        | 限定的（主にU2Fのサポート）            | 幅広い（モダンブラウザがWebAuthnをサポート） |
| **プロトコル**              | UAF, U2F                          | WebAuthn, CTAP1, CTAP2                 |
| **目的**                    | パスワードレス認証、二要素認証           | パスワードレス認証、MFA                  |
| **主なユースケース**        | サイト固有の認証、二要素認証             | Webアプリケーションの強力な認証           |
| **公開鍵暗号の使用**        | 一部サポート                         | 完全サポート                            |
| **ユーザエクスペリエンス**  | UAFはUX向上、U2Fは二要素認証の強化          | 簡便で直感的、クロスプラットフォームの認証体験 |
| **拡張性**                  | サイト固有の実装                      | 広範な互換性と標準化                      |
```

## FIDO2のコンポーネント

1. **WebAuthn（Web Authentication）**:
   - **概要**: WebAuthnは、W3C（World Wide Web Consortium）によって標準化されたAPIで、Webブラウザやウェブプラットフォームがユーザーの認証を行うための仕組み。これにより、Webアプリケーションはユーザーが持つ物理的な認証器（USBキー、スマートフォン、内蔵センサーなど）を利用して強力なユーザー認証を実現できる。
   - **機能**: 公開鍵暗号方式に基づき、ユーザー登録時に公開鍵を生成し、認証時には秘密鍵（ユーザーのデバイスに安全に保存）で署名を行い、その署名をサーバー側が検証する。

2. **CTAP（Client to Authenticator Protocol）**:
   - **CTAP1**: 従来のU2F（Universal 2nd Factor）規格に基づくプロトコルで、既存のU2Fデバイスとの後方互換性を提供する。
   - **CTAP2**: 新しいFIDO2の機能をサポートするためのプロトコルで、パスワードレス認証や多要素認証を実現します。CTAP2は認証器とクライアントデバイス（例：PCやスマートフォン）間の通信を規定している。

## FIDO2の基本的なフロー

FIDO2の認証フローは主に以下の二つのステップで構成される：

### 1. 登録（Registration）

1. **登録要求（Registration Request）**:
   - サービス（リライングパーティ、RP）がブラウザ（クライアント）を通じてユーザーに対して認証器の登録を要求する。この際、サーバーはチャレンジ、ユーザー識別子、RPの情報などを提供する。

2. **Authenticatorの対応**:
   - ユーザーはスマートフォン、FIDOキー、またはPC内蔵の指紋リーダーなどの認証器を利用し、認証要求に応答する。認証器は公開鍵と秘密鍵のペアを生成し、公開鍵をRPに送信する。秘密鍵は認証器内に安全に保存される。

3. **サーバー側の処理**:
   - サーバーは送信された公開鍵とその他のメタデータを保存し、登録を完了する。

### 2. 認証（Authentication）

1. **認証要求（Authentication Request）**:
   - ユーザーがサービスにログインしようとすると、サービスはブラウザを通じて認証要求を送る。要求にはチャレンジや登録された公開鍵などの情報が含まれる。

2. **Authenticatorの対応**:
   - ユーザーは認証器（スマートフォンやFIDOキー）を使用して認証要求に応答する。認証器はチャレンジに対する署名を生成し、それをRPに送信する。

3. **サーバー側の処理**:
   - サーバーは署名を検証し、認証の成功/失敗を判断する。署名の検証には、登録時に保存された公開鍵が使用される。

## FIDO2の利点

1. **パスワードレス認証**:
   - パスワード不要のセキュアな認証を実現。フィッシング攻撃やパスワードリスト攻撃のリスクを大幅に減少。

2. **二要素認証（2FA）**:
   - 高セキュリティな二要素認証を提供。パスワードに加えて、物理デバイスを用いた強力な二要素認証が可能。

3. **互換性**:
   - WebAuthnとCTAPはクロスプラットフォームで動作し、複数のデバイスと認証器に対応。これにより、ユーザーエクスペリエンスがシームレスに。

4. **利便性**:
   - 生体認証（指紋、顔認証）や物理デバイス（スマートフォン、FIDOキー）を用いることで、迅速かつ直感的な認証が可能。

## FIDO2/WebAuthnを用いた基本的なユーザー登録と認証の実装例

### ユーザー登録（Registration）

```javascript
async function registerUser() {
    const publicKey = {
        challenge: new Uint8Array(32), // サーバーから取得したランダムなチャレンジ
        rp: { name: "Example RP" },
        user: {
            id: new Uint8Array(16), // サーバーから取得したユーザーID
            name: "user@example.com",
            displayName: "User Example"
        },
        pubKeyCredParams: [
            {
                type: "public-key",
                alg: -7 // "ES256"
            }
        ],
        authenticatorSelection: {
            authenticatorAttachment: "platform",
            userVerification: "preferred"
        },
        timeout: 60000,
        attestation: "direct"
    };

    try {
        const credential = await navigator.credentials.create({ publicKey });
        // サーバーにcredentialを送信して登録を完了
    } catch (err) {
        console.error("Registration failed", err);
    }
}
```

### ユーザー認証（Authentication）

```javascript
async function authenticateUser() {
    const publicKey = {
        challenge: new Uint8Array(32), // サーバーから取得したランダムなチャレンジ
        timeout: 60000,
        rpId: "example.com",
        allowCredentials: [
            {
                id: new Uint8Array(64), // サーバーから取得した登録済みのクレデンシャルID
                type: "public-key",
                transports: ["usb", "nfc", "ble", "internal"]
            }
        ],
        userVerification: "preferred"
    };

    try {
        const assertion = await navigator.credentials.get({ publicKey });
        // サーバーにassertionを送信して認証を完了
    } catch (err) {
        console.error("Authentication failed", err);
    }
}
```
