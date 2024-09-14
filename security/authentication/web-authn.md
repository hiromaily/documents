# WebAuthn

WebAuthn（Web Authentication）は、W3Cによって標準化されたAPIであり、ユーザー認証をセキュアに行うためのプロトコル。WebAuthnは`FIDO2`の一部として、パスワードレス認証や多要素認証（MFA）の実装を支援している。このAPIを使用することで、Webアプリケーションはユーザーの物理的な認証デバイス（例：スマートフォン、生体認証デバイス、FIDOキー）を活用して強力な認証を行うことができる。

## 概念と用語

1. **リライングパーティー（Relying Party, RP）**：
   - サービスプロバイダーやウェブアプリケーションを指します。認証情報を要求し、管理する。

2. **クライアントデバイス（Client Device）**：
   - ユーザーがWebAuthnを通じて認証を行うデバイスです。通常はPC、スマートフォン、タブレットなど。

3. **認証器（Authenticator）**：
   - ユーザーの認証を行う実際のデバイスや機能。認証器は秘密鍵を安全に管理し、署名を生成します。例として、FIDOキーやスマートフォンの生体認証センサーが挙げられる。

4. **クレデンシャル（Credential）**：
   - ユーザーが登録や認証時に生成される公開鍵ペアのことを指す。秘密鍵は認証器内に保存され、公開鍵はリライングパーティーに提供される。

## WebAuthnの主要なフロー

WebAuthnのフローは、大きく二つのステップに分かれる： **登録（Registration）** と **認証（Authentication）**。

### 1. 登録（Registration）

1. **登録要求の作成（Create a Registration Request）**：
   - リライングパーティーがユーザーに対して認証器の登録を要求する。この要求には、チャレンジング文字列、RPの情報（RPID）、ユーザーの情報（ユーザーID）などが含まれる。

2. **ユーザーの操作（User Interaction）**：
   - クライアントデバイスは、この要求をユーザーの認証器に送信する。ユーザーは指紋スキャナーやFIDOキーを使って認証を行う。

3. **公開鍵ペアの生成（Generate Key Pair）**：
   - 認証器は公開鍵ペアを生成し、秘密鍵は認証器内に安全に保存される。生成された公開鍵、認証器の情報、署名付きのチャレンジを含むレスポンスをクライアントデバイスに返す。

4. **公開鍵の保存（Store Public Key）**：
   - リライングパーティーは公開鍵と関連情報を受け取り、データベースに保存す。これによって、ユーザーのアカウントが認証器に関連付けられる。

### 2. 認証（Authentication）

1. **認証要求の作成（Create an Authentication Request）**：
   - リライングパーティーがユーザーに対してログイン要求を送る。この要求には、チャレンジング文字列、RPID、許可されるクレデンシャルIDリストなどが含まれる。

2. **ユーザーの操作（User Interaction）**：
   - クライアントデバイスはこの要求を認証器に送信する。ユーザーが認証器を使って認証を行う。

3. **署名の生成（Generate Signature）**：
   - 認証器は秘密鍵でチャレンジを署名し、署名と関連データをクライアントデバイスに返す。

4. **署名の検証（Verify Signature）**：
   - リライングパーティーは受け取った署名と公開鍵を使って署名の検証を行う。検証が成功すると、ユーザーの認証が完了する。

## WebAuthnのメリット

1. **高いセキュリティ**：
   - 公開鍵暗号を使用することで、パスワードに依存せずにセキュアな認証を行える。秘密鍵がデバイスから出ることはないため、フィッシング攻撃やリプレイ攻撃のリスクが大幅に減少する。

2. **ユーザビリティの向上**：
   - パスワードを覚える必要がなく、指紋や顔認証などを使った簡単な操作で認証が行えるため、ユーザーエクスペリエンスが向上する。

3. **汎用性**：
   - 多様なデバイスやプラットフォームに対応しており、クロスプラットフォームでの利用が可能。

4. **プライバシー保護**：
   - サイト間でユーザーの認証情報が共有されないため、プライバシーが保護される。

## JavaScriptによるWebAuthnの実装

### ユーザー登録の例

```js
async function registerUser() {
    const publicKey = {
        challenge: new Uint8Array(32), // サーバーから取得したランダムなチャレンジ
        rp: { name: "Example RP", id: "example.com" },
        user: {
            id: new Uint8Array(16), // サーバーから取得したユーザーID
            name: "user@example.com",
            displayName: "User Example"
        },
        pubKeyCredParams: [
            {
                type: "public-key",
                alg: -7 // ES256 (ECDSA using P-256 and SHA-256)
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

### ユーザー認証の例

```js
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

## WebAuthnまとめ

- WebAuthn は `WebAuthentication`の略で、 `FIDO認証`をベースとした、ブラウザ経由でパスワードレス認証を行うための仕組み
- WebAuthn を実現するために用意されている JavaScript API を `WebAuthn API` と呼ぶ
- WebAuthn というのは、`FIDO2`の仕様の一部のことを指している

- 認証クライアントとなるアプリケーションなどのサービスを `Relying Party`
- ユーザーが使用するデバイスには`認証器`が必要となる
  - 署名の作成、キーペアの作成、認証情報の管理、所有確認や生体認証の実施などの機能
- `認証サーバ`は、つまり FIDO の認証の処理を行うサーバのこと
