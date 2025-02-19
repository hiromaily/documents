# Passkey

Passkey（パスキー）は、`FIDO Alliance`と`W3C`が推進する新しいパスワードレス認証方法で、ユーザーのデバイスに保存されている生体認証情報やPINを使用して安全にログインするための技術。Passkeyは特にユーザーエクスペリエンスとセキュリティの向上を目指して設計されており、従来のパスワードに依存しない、利便性の高い認証を提供する。

Passkeyは、従来のパスワードに依存しない、高セキュリティでユーザビリティに優れた認証手法を提供する。公開鍵暗号方式を利用し、ユーザーのデバイスに生体情報やPINを保存することで、フィッシング攻撃やパスワードリスト攻撃のリスクを大幅に低減する。クロスプラットフォームでの互換性も確保されており、未来のWeb認証のスタンダードとして期待されている。

## Passkeyの基本概念

1. **パスワードレス認証**：
   - ユーザーはパスワードを使わずに、デバイスに保存された生体情報（例：指紋、顔認証）やPINを使って認証する。

2. **公開鍵暗号方式**：
   - Passkeyは公開鍵暗号に基づいており、登録時に生成された鍵ペア（公開鍵と秘密鍵）を使用する。秘密鍵はユーザーのデバイスから出ることはなく、公開鍵はリライングパーティ（RP）に提供される。

3. **クロスプラットフォーム互換**：
   - Passkeyは複数のデバイス間でシームレスに利用でき、ユーザーが異なるデバイスからでも一貫した認証体験を享受できるように設計されている。

## Passkeyのフロー

Passkeyの基本的なフローは、`WebAuthn`の流れと似ているが、ユーザーエクスペリエンスがさらに向上するよう工夫されている。

### 登録（Registration）

1. **登録要求（Registration Request）**：
   - リライングパーティ（RP）がユーザーに対して認証器の登録を要求する。リクエストにはチャレンジ、RPの情報（RPID）、ユーザーの情報（ユーザーID）などが含まれる。

2. **ユーザーの操作（User Interaction）**：
   - ユーザーがデバイスの生体認証センサーやPINを使用して登録を完了する。デバイスは公開鍵のペアを生成し、秘密鍵を安全に保存し、公開鍵をRPに返送する。

3. **公開鍵の保存（Store Public Key）**：
   - RPは公開鍵とその他の関連情報をデータベースに保存する。

### 認証（Authentication）

1. **認証要求（Authentication Request）**：
   - ユーザーがサービスにログインしようとすると、RPはブラウザを通じて認証要求を送る。要求にはチャレンジ、RPID、許可されたクレデンシャルIDリストなどが含まれる。

2. **ユーザーの操作（User Interaction）**：
   - ユーザーはデバイスの生体認証センサーやPINを使用して認証する。デバイスはチャレンジに対する署名を生成し、それをRPに返送する。

3. **署名の検証（Verify Signature）**：
   - RPは受け取った署名と保存された公開鍵を使用して署名の検証を行い、ユーザーの認証を完了する。

## Passkeyの利点

1. **高いセキュリティ**：
   - パスワードを使用しないため、パスワードを使った攻撃（フィッシング、パスワードのリスト攻撃、盗難など）を防止。

2. **ユーザーフレンドリー**：
   - ユーザビリティが高く、パスワードを覚える必要がない。生体認証やPINを使用するため、ログインプロセスが簡便。

3. **プライバシー保護**：
   - 鍵ペアは異なるサービス間で使いまわされないため、ユーザーのプライバシーが保護される。

4. **クロスプラットフォーム**：
   - Passkeyは異なるデバイスやプラットフォームでシームレスに動作するため、ユーザー体験が一貫している。

## Passkeyの実装例（JavaScript）

### ユーザー登録の例

```js
async function registerPasskey() {
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
                alg: -7 // "ES256" = ECDSA with SHA-256
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
async function authenticatePasskey() {
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

## Passkey まとめ

パスワードレス認証基準を普及させる団体である`FIDOアライアンス`によって策定された、新しいパスワードレス認証方法で、`パスワードを使用しないパスワードレス認証`。正式名称は`マルチデバイス対応FIDO認証資格情報（multi-device FIDO credential)`。パスキーは指紋や顔といった生体認証を利用する。

### Passkey に使われる技術

- FIDO2: 生体認証に公開鍵暗号方式を用いるパスワードレス認証技術
- WebAuthn: FIDO2 認証を Web ブラウザ経由で利用する仕組み

これらを使って、資格認証情報をクラウド経由で同期する

### Passkey 認証フロー

1. サービスの利用開始時、利用者は公開鍵と秘密鍵のペアを作成
2. サービス提供者側に公開鍵を登録
3. 利用者はデバイスに秘密鍵を保存。秘密鍵はデバイスの保護機能を適用し、そのデバイスでのみ利用可能な状態にする
4. ログインの際に、サービス提供者側は公開鍵を使って本人確認を行ない、利用者は秘密鍵で応答する

### Passkey の特徴

- 公開鍵暗号方式を利用することで、サービス提供者側にすべてのログイン情報を登録する必要がない
- サービス提供者側に保存された情報は公開鍵であるため、仮に情報が漏れたとしても秘密鍵がないとログインは不可能
- 利用者が保存する秘密鍵は、デバイスごとに異なるものが生成されるため、これを使って他のデバイスでログインすることはできない

## 用語集

### リライングパーティ（RP）

リライングパーティ（`Relying Party`、略してRP）とは、ユーザー認証のコンテキストにおいて、`サービスプロバイダー`や`アプリケーション`を指す。RPは、ユーザーの認証情報を受け取り、その情報をもとにユーザーの身元を確認し、アクセスを許可する主体。簡単に言えば、RPは`ユーザーがログインしようとするサービスやアプリケーション`を意味する。

Relying Party（RP）は、ユーザー認証において中心的な役割を果たすサービスプロバイダーやアプリケーションを指す。RPは認証の要求と応答を管理し、ユーザーの身元を確認してアクセス制御を行う。WebAuthnやFIDOといった現代の認証技術において、RPはユーザー体験とセキュリティを向上させるために重要な役割を担っている。

#### Relying Partyの役割

1. **認証要求の送信**:
   - RPはユーザーに対して認証を要求する。この要求は、ウェブブラウザやネイティブアプリのクライアントデバイスを通じて行われる。

2. **認証情報の受け取り**:
   - ユーザーが認証器（Authenticator）を使って認証プロセスを完了した後、RPはユーザーの認証情報（例えば公開鍵、署名、認証器のメタデータなど）を受け取る。

3. **認証情報の検証**:
   - RPは受け取った情報を検証する。これには、公開鍵による署名の検証や、リプレイ攻撃を防ぐためのチャレンジ応答の確認が含まれる。

4. **アクセス制御**:
   - 認証が成功すると、RPはユーザーに対してアクセス権を付与する。これにより、ユーザーはRPが提供するサービスやリソースにアクセスできる。

#### WebAuthnやFIDOにおけるRPの役割

WebAuthn（Web Authentication）やFIDO（Fast Identity Online）では、RPの役割が特に重要。

##### 1. ユーザー登録時（Registration）

- RPはユーザーに対して認証器の登録を要求する。これには、ランダムなチャレンジ文字列、RPのID、ユーザーのIDなどが含まれる。
- ユーザーが認証器で認証プロセスを完了すると、RPは認証器から公開鍵と関連メタデータを受け取り、データベースに保存する。この公開鍵を使用して、後の認証プロセスでユーザーを識別する。

##### 2. ユーザー認証時（Authentication）

- RPはユーザーに対して認証要求を送信する。この要求には、認証前に生成されたチャレンジ文字列やストレスに対する許可されたクレデンシャルIDリストなどが含まれる。
- ユーザーが認証器で認証プロセスを完了すると、RPは署名された応答を受け取る。RPは保存された公開鍵を使用して署名を検証し、認証の正当性を確認する。

#### 実際のRPの例

多くのWebサービスやアプリケーションがRPとして機能している。

- **Webmailサービス（例：Gmail、Outlook）**：
  - ユーザーが自分のメールアカウントにログインするためにパスワードレス認証を設定する。サービスプロバイダーは、ユーザーが提供した認証情報を検証してアクセスを許可する。

- **オンラインバンキングシステム**：
  - バンキングアプリがユーザーの認証器を使って取引の認証を行う。ユーザーが認証器を使って認証を完了すると、バンキングシステムはその情報を基に取引を承認する。

- **ソーシャルメディアプラットフォーム（例：Facebook、Twitter）**：
  - ユーザーがソーシャルメディアアカウントにログインする際、RPとしてのプラットフォームがユーザーの認証情報を受け取り、検証する。

## References

- [書籍: パスキーのすべて](https://gihyo.jp/book/2025/978-4-297-14653-5)
