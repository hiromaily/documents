# FIDO 認証

FIDO（Fast Identity Online）は、`パスワードレス認証を目指して開発された標準規格`で、インターネット上でのユーザー認証をシンプルかつセキュアにすることを目的としている。FIDOは、ユーザーのパスワード依存をなくし、より強固な認証方式を提供するために開発された。

FIDO認証は、セキュリティとユーザビリティの両立を目指しており、将来的にはインターネット上の認証手法として標準となることが期待されている。これにより、パスワードに依存しない、安全かつ利便性の高い認証が広がることが期待される。

FIDOには主に以下の二つの規格がある：

1. **UAF（Universal Authentication Framework）**：ユーザーがパスワードを使わずにデバイスを使った認証を行う。
2. **U2F（Universal 2nd Factor）**：既存のパスワード認証に対して二要素認証（2FA）を追加する。

また、`FIDO2`という次世代規格も登場しており、FIDO UAFとU2Fの両方の長所を活かしつつ、WebAuthn（Web Authentication）とCTAP（Client to Authenticator Protocol）という二つの主要技術を含んでいる。

## FIDO2のコンポーネント

1. **WebAuthn**：
   - **Web Authentication API**：W3Cが標準化しているAPIで、ブラウザやウェブプラットフォームが提供する。
   - **クライアント側の対応**：WebAuthnを利用するためのJavaScript APIは、ブラウザやWeb Applicationで動作し、ユーザーの認証を管理する。

2. **CTAP**（Client to Authenticator Protocol）：
   - **CTAP1**：U2Fに基づくプロトコル。
   - **CTAP2**：より高度な機能を持つFIDO2の一部で、パスワードレス認証を支援。

## FIDO認証の基本的なフロー

FIDO2の認証フローは、大きく以下の二つのステップに分かれる。

1. **登録（Registration）**：
   - **ユーザーの登録**：ユーザーは認証プロセスにまだ登録されていないため、最初に認証器（Authenticator）を使用して自身を登録する。これには、スマートフォン、ハードウェアキー、内蔵生体認証（例えば指紋リーダーや顔認証）などが含まれる。

2. **認証（Authentication）**：
   - **ユーザーの認証**：登録済みのユーザーが認証器を使用して自身を認証する。これにより、ユーザーはサービスにログインすることができる。

## 具体的なステップ

### 1. 登録（Registration）

1. **登録要求（Registration Request）**：
   - サービスがユーザーに対して認証器の登録を要求する。この要求は、クライアントデバイス（ブラウザやアプリ）を通じて行われる。

2. **認証器の応答（Authenticator Response）**：
   - ユーザーはスマートフォンやFIDOキーなどの認証器を使って要求に応答する。認証器は公開鍵（Public Key）を生成し、それをサービスに送信する。秘密鍵（Private Key）は認証器内部に安全に保持される。

3. **公開鍵の保存**：
   - サービスはユーザーの公開鍵とその他の情報（例えばユーザーID）をデータベースに保存する。

### 2. 認証（Authentication）

1. **認証要求（Authentication Request）**：
   - ユーザーがサービスにログインしようとすると、サービスは認証を要求する。この要求はクライアントデバイスを通じて行われる。

2. **認証器の応答（Authenticator Response）**：
   - ユーザーは認証器を使い、要求に応答する。ここでは、認証器が秘密鍵を使って要求を署名し、その署名をクライアントデバイス経由でサービスに返す。

3. **署名の検証**：
   - サービスは受け取った署名を検証する。その際、登録時に保存していた公開鍵を使用して署名の正当性を確認する。検証が成功すれば、ユーザーは認証され、ログインが完了する。

### FIDOのメリット

1. **高いセキュリティ**：
   - パスワードの代わりに公開鍵暗号方式を使用するため、フィッシング攻撃やパスワードリスト攻撃を防ぎやすい。
   - 秘密鍵はデバイスから出ることがないため、ハードウェアレベルでのセキュリティが確保される。

2. **ユーザビリティ**：
   - パスワードの管理が不要であり、ユーザーは生体認証などの簡便な方法でログインできる。
   - 複数デバイス間での認証がシームレスにできる。

3. **プライバシー**：
   - サービスごとに異なる鍵が生成されるため、同じ認証器を使っても複数のサービス間でユーザーIDの追跡が困難。

## FIDO2/WebAuthnを使ってユーザー登録と認証を実装する例

ブラウザ経由で認証器を利用する方法

### 登録の実装

```js
async function register() {
    const publicKey = {
        challenge: new Uint8Array(32), // サーバーから取得したランダムなチャレンジ
        rp: { name: "Example Corp" },
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
            authenticatorAttachment: "platform", // platform = 内蔵センサー, cross-platform = 外部デバイス
        },
        timeout: 60000, // タイムアウトの設定
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

### 認証の実装

```js
async function login() {
    const publicKey = {
        challenge: new Uint8Array(32), // サーバーから取得したランダムなチャレンジ
        timeout: 60000,
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

## FIDO 認証 まとめ

- パスワードレスによって、利便性と安全性を満たすための認証プロトコル
  - パスワードレス認証とは、多要素認証 (MFA)の一種
- FIDO: `Fast Identity Online`の略であり、日本語だと`ファイド`と発音される
- サーバーとユーザーで秘密の情報を共有しないのが大きな特徴

### FIDO 認証の仕組み

- サーバーからの認証要求(チャレンジ)に対して、正規ユーザーである証の `署名` を返すことで認証を行う
- この `署名` が本物であるかどうかを確認するために`秘密鍵`と`公開鍵`の鍵ペアを利用する

  | 鍵の種類 | 役割・用途                       | 役割・用途         |
  | -------- | -------------------------------- | ------------------ |
  | 秘密鍵   | FIDO 登録情報の署名生成に利用    | ユーザーデバイス内 |
  | 公開鍵   | ペアとなる秘密鍵の署名を検証する | サーバー内         |

- `秘密鍵`を使用して署名を行うためには、登録時に指定した方法(生体認証など)で正規のユーザーであることを確認する
- これにより FIDO 登録を行った本人しか、署名を行うことはできず、署名の本人性を確認できる
- また、`秘密鍵`と`公開鍵`のセットは、FIDO 登録時にユーザーデバイス内で生成され、`公開鍵`のみをサーバーへ送信し、`秘密鍵`はユーザーデバイス内で厳重に保管される
- `公開鍵`は、署名を検証するためにサーバーに保管されている
- これが、`サーバーとユーザーで秘密の情報を共有しない` という FIDO 認証の仕組みとなる

### FIDO2 生体認証

- FIDO2（Web 認証）は、W3C の Web 認証仕様 (WebAuthn)と FIDO アライアンスのデバイス間連携仕様（CTAP）から成る技術仕様で構成される
- 生体認証デバイスなどを利用してウェブブラウザーを通じたオンラインサービスへの安全なログインを実現
