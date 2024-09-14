# Keycloak

Keycloakは、オープンソースのアイデンティティおよびアクセス管理 (IAM) ソリューションであり、アプリケーションやサービスの認証と認可をシンプルにするために設計されている。Keycloakは、`Single Sign-On (SSO)`、`アイデンティティフェデレーション`、`多要素認証 (MFA)`、および`ユーザープロビジョニング`など多様な機能を提供する。

Keycloakは、アイデンティティ管理とアクセス制御をシンプルかつセキュアに実現するための強力なツール。シングルサインオン、アイデンティティフェデレーション、多要素認証など、多彩な機能を提供し、企業やアプリケーション開発者にとって非常に有益なソリューション。オープンソースであるため、柔軟なカスタマイズが可能で、さまざまな環境に適応できる。

## 主な特徴

1. **シングルサインオン（SSO）**：
   - 一度ログインすると、すべての関連アプリケーションにアクセス可能。複数のシステム間でシームレスなユーザー体験を提供する。

2. **アイデンティティフェデレーション**：
   - 複数のIdP (Identity Provider) からの認証を統合可能。たとえば、Google、Facebook、Twitter、LDAP、Active Directoryなどを使った認証が可能。

3. **多要素認証（MFA）**：
   - パスワードに加えて、追加の認証要素 (例：TOTP, WebAuthn, OTP) を使用してセキュリティを強化。

4. **カスタマイズ可能な認証フロー**：
   - 認証フローをカスタマイズ可能。スクリプトベースのカスタム認証方法や条件設定が可能。

5. **ユーザープロビジョニング**：
   - 新規ユーザーの作成や削除、ユーザー情報の更新などのプロビジョニング機能を提供。LDAPやActive Directoryとの自動同期も可能。

6. **豊富なプロトコルサポート**：
   - OAuth 2.0、OpenID Connect (OIDC)、SAML 2.0に対応しており、標準的な認証および認可プロトコルをサポート。

7. **管理コンソールとAPI**：
   - 管理者用のWebコンソールとREST APIを提供しており、柔軟な管理と統合が可能。

## アーキテクチャ

Keycloakは、以下の主要なコンポーネントで構成

1. **Realm**：
   - 管理ドメインであり、Keycloakの論理的な区分け。異なるRealmに対して異なる設定やポリシーを適用できる。

2. **Client**：
   - Keycloakに登録されたアプリケーションやサービス。クライアントはKeycloakを通じて認証および認可を受ける。

3. **User**：
   - Keycloakに登録されたユーザー。ユーザーは、Keycloakを介して認証されるエンドユーザー。

4. **Identity Providers (IdPs)**：
   - 他の認証サービスやプロバイダー。Keycloakがアイデンティティフェデレーションを行うときに使われる。

## 基本的な使用方法

### 1. Keycloakのインストール

Keycloakは、Dockerコンテナとして簡単にデプロイできる。

```bash
docker run -p 8080:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=password jboss/keycloak
```

### 2. Web管理コンソールへのアクセス

ブラウザで`http://localhost:8080`にアクセスし、管理インターフェースにログインする。デフォルトのAdminユーザーは上記の環境変数で設定されたものを使用。

### 3. Realmの作成

1. **管理コンソールにログイン**：
   - `http://localhost:8080` にアクセスし、Adminユーザーでログイン。

2. **Realmの作成**：
   - 管理コンソールで "Add realm" をクリックし、新しいRealmを作成。

### 4. Clientの作成

1. **新しいRealmを選択**：
   - 作成したRealmを選択し、左側のメニューから "Clients" を選択。

2. **Clientの追加**：
   - "Create" をクリックし、新しいClientを登録。クライアントIDやリダイレクトURIなどを設定。

### 5. ユーザーの作成

1. **左側のメニューから "Users" を選択**：
   - "Add user" をクリックし、新しいユーザーを作成。

2. **ユーザー情報の入力**：
   - ユーザー名やメールアドレスなどの基本情報を入力し、保存。

3. **パスワードの設定**：
   - 作成したユーザーの詳細設定に移動し、"Credentials" タブでパスワードを設定。

## Keycloakを使った認証フローの一例

以下は、JavaScriptでOAuth 2.0のクライアントとしてKeycloakと通信する例

### クライアントの設定

まず、クライアントに必要な設定を行う。以下に設定する項目の一例を示す:

- Realm：demo
- Client ID：my-app
- Client Protocol：openid-connect
- Root URL：<http://localhost:3000>

### JavaScriptでのKeycloakクライアントの設定

まず、KeycloakのJavaScriptアダプターを含める。

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/keycloak-js/11.0.2/keycloak.min.js"></script>
```

次に、Keycloakクライアントを初期化する。

```javascript
const keycloak = new Keycloak({
    url: 'http://localhost:8080/auth',
    realm: 'demo',
    clientId: 'my-app'
});

keycloak.init({ onLoad: 'login-required' }).then(authenticated => {
    if (authenticated) {
        console.log('Authenticated');
        console.log('Access Token:', keycloak.token);
        console.log('Refresh Token:', keycloak.refreshToken);
    } else {
        console.log('Not authenticated');
    }
}).catch(error => {
    console.error('Failed to initialize Keycloak', error);
});
```

このコードは、ユーザーがアプリケーションにアクセスした際に、Keycloakの認証ページにリダイレクトしてログインを要求し、認証が完了するとトークン情報をコンソールに表示する。

## Keycloakまとめ

- オープンソースのアイデンティティ・アクセス管理ソフトウェア
- Keycloak の目的はセキュリティーをシンプルに実現することで、様々なセキュリティー機能が実装されている
- シングルサインオンや API アクセスの認証・認可制御を実現するもの
- Web アプリケーションおよび RESTful な Web サービスのための SSO ソフトウェア
- OpenAM と比べて、後発 (つまり新しい)

### Keycloak の機能

- Web 上での SSO
- OpenID Connect のサポート
- OAuth 2.0 のサポート
- SAML のサポート
- 外部の OpenID Connect もしくは SAML に対応したアイデンティティー・プロバイダーによる認証
- ソーシャル・ログイン
- ユーザー・フェデレーション: LDAP や Active Directory からのユーザー同期
- ケルベロス連携: ケルベロス・サーバーにログイン済のユーザーに対する認証連携
- 二要素認証: Google Authenticator や FreeOTP を使用した TOTP/HOTP のサポート
