# AWS Cognito

Amazon Cognito（AWS Cognito）は、`アプリケーションのユーザー管理と認証のための AWS サービス`。ユーザーがサインアップ、サインイン、パスワードリセットを行うための機能を提供する。また、SNS アカウントや SAML 2.0、OIDC 認証なども統合してサポートしている。

## 主要機能

### 1. ユーザープール（User Pool）

ユーザープールは、アプリケーションのユーザーを管理するためのデータベース。ユーザープールを使用すると、ユーザーはアプリケーションにサインアップおよびサインインできる。ユーザープールでは、以下の機能が提供される：

- サインアップとサインイン： ソーシャル ID プロバイダーや SAML、OpenID Connect を使用した認証もサポート。
- 多要素認証（MFA）： セキュリティを強化するために、SMS やソフトウェアトークンを使用した MFA をサポート。
- カスタム属性： 必要に応じてカスタム属性を追加し、ユーザー情報を管理。
- 自動確認と通知： ユーザーのメールアドレスや電話番号の自動確認、パスワードリセットのための通知を提供。
- グループとロール： ユーザーをグループに分け、異なるアクセス権を設定。

### 2. ID プール（Identity Pool、旧称：フェデレーテッドアイデンティティ）

ID プールは、ユーザー認証後の役割（Role）を割り当て、AWS リソースにアクセスするための一時的な認証情報を提供。ID プールは以下を提供：

- フェデレーション： 社内のディレクトリ、サードパーティのプロバイダ（Google、Facebook など）、または AWS Cognito ユーザープールからの認証。
- 一時的なクレデンシャル： 認証されたユーザーに一時的な AWS 認証情報を提供し、特定の AWS サービスにアクセスを許可。

### 3. セキュリティ

Amazon Cognito は、データを保護するために複数のセキュリティ機能を提供：

- データ暗号化： 静止中および転送中のデータの暗号化。
- セキュリティポリシー： IAM（Identity and Access Management）ポリシーを使用して細かいアクセス制御を設定。
- コンポライアンス： GDPR、HIPAA、SOC などのセキュリティ標準に準拠。

### 4. カスタム認証

Amazon Cognito は、トリガー（Triggers）と呼ばれる Lambda 関数を使ってカスタム認証フローを提供。これを使用すると、必要に応じて独自の認証ロジックを追加することが可能。

### 5. シングルサインオン (SSO)

Amazon Cognito は、ユーザーが一度ログインすると複数のアプリケーションやサービスを使用できるシングルサインオンもサポート。

これらの機能により、Amazon Cognito はユーザー認証と管理のための強力で柔軟なソリューションを提供し、スケーラブルなアプリケーションを迅速に構築するのに役立つ。

## 他の類似サービス

これらのサービスは、AWS Cognitoと同様にユーザー管理と認証の機能を提供し、それぞれのクラウドプラットフォームのエコシステムに統合されている。各クラウド環境の特有のメリットを活かしながら、ユーザー管理と認証の需要を満たすことが可能。

### GCP: Google Cloud Identity Platform

Google Cloud Identity Platformは、AWS Cognitoと同様にユーザー管理と認証のためのサービスを提供する。

- **ユーザープール管理**： Googleアカウント、メール・パスワード、電話番号を使った認証。
- **ソーシャルログイン**： Google、Facebook、Twitter、GitHubなどのサードパーティプロバイダを使用したログイン。
- **匿名認証**： ユーザーが個人情報を提供せずにアプリケーションを利用できるようにする。
- **多要素認証（MFA）**： SMSベースの二要素認証。
- **フェデレーション**： SAML 2.0やOpenID Connect（OIDC）を利用したカスタム認証提供者の統合。
- **カスタムトークン**： 独自の認証システムとの統合が可能。

### Firebase Authentication

特にモバイルアプリケーションのバックエンドを簡単に構築するために利用されることが多い。

- **ユーザープール管理**： メール・パスワード、電話番号を使った認証。
- **ソーシャルログイン**： Google、Facebook、Twitterなど。
- **匿名認証**： スムーズなユーザー体験のため、匿名ユーザーから登録ユーザーへの移行がサポート。
- **多要素認証（MFA）**： 新しい追加機能として、多要素認証が利用可能。

### Azure Active Directory B2C（Azure AD B2C）

Azure Active Directory B2Cは、コンシューマー向けのアプリケーションのためのユーザー管理と認証を提供する。

- **ユーザープール管理**： メール・パスワードを使った認証、カスタム属性の設定。
- **ソーシャルログイン**： Microsoft、Google、Facebook、Twitterなどのプロバイダーをサポート。
- **カスタムポリシー**： より高度なシナリオ用に、カスタムポリシーを作成してカスタマイズ可能。
- **多要素認証（MFA）**： SMS、電子メール、認証アプリを使用した二要素認証。
- **フェデレーション**： 他のIDプロバイダー（Azure AD、SAMLなど）との統合をサポート。
- **カスタマイズ**： 完全にカスタマイズ可能なサインイン、サインアップ、プロファイル編集ページ。

#### Azure Active Directory（Azure AD）

以下の機能も含まれている：

- **シングルサインオン（SSO）**： 多数のSaaSアプリケーションとのシングルサインオン（SSO）をサポート。
- **多要素認証（MFA）**： 強力なセキュリティ向けのMFAを提供。
- **B2Bコラボレーション**： 外部の組織やユーザーと簡単に安全に共有できる。

## 使い方

Amazon Cognitoは、ウェブアプリケーションやモバイルアプリケーションにユーザー認証、認可、ユーザーデータ管理の機能を簡単に追加するためのAWSサービス。

### 1. Amazon Cognitoのセットアップ

1. ユーザープールの作成
2. アプリクライアントの作成

### 2. ユーザープールの設定

### 3. ユーザーの管理

ユーザープールにユーザーを手動で追加するか、サインアップのためのフローを実装する方法がある

### 4. アプリケーションへの統合

#### AWS SDKを使って、認証フローを実装する例

```js
import { CognitoUserPool, CognitoUser, AuthenticationDetails } from 'amazon-cognito-identity-js';

const poolData = { 
    UserPoolId : 'us-east-1_ExamplePoolId',
    ClientId : '1example234client567id'
}; 
const userPool = new CognitoUserPool(poolData);

// ユーザーのサインアップ
userPool.signUp('username', 'password', attributeList, null, (err, result) => {
    if (err) {
        alert(err.message || JSON.stringify(err));
        return;
    }
    cognitoUser = result.user;
    console.log('user name is ' + cognitoUser.getUsername());
});

// ユーザーのサインイン
const authenticationDetails = new AuthenticationDetails({
    Username : 'username',
    Password : 'password',
});

const userData = {
    Username : 'username',
    Pool : userPool
};

const cognitoUser = new CognitoUser(userData);
cognitoUser.authenticateUser(authenticationDetails, {
    onSuccess: (result) => {
        console.log('access token + ' + result.getAccessToken().getJwtToken());
    },
    onFailure: (err) => {
        alert(err.message || JSON.stringify(err));
    },
});
```

### 5. 認証後のユーザーの扱い

認証に成功したユーザーに対して、特定のリソースやサービスへのアクセス権を付与するために、認可プロセスを設定することができる。これには、AWS IAMポリシーの設定や、カスタム属性を利用した権限の制御が含まれる。

### 6. 自動スケーリングとセキュリティ

Amazon Cognitoは自動スケーリング機能を持ち、大規模なユーザー管理に対応する。また、データは暗号化され、セキュリティの向上が図られている。

## References

- [Official](https://aws.amazon.com/jp/cognito/)
