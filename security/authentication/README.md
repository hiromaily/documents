# Authentication

## Authentication: 認証 と Authorization/Permission:認可の違い

- 認証: ユーザーの本人確認、通信の相手が誰（何）であるかを確認すること
- 認可: とある特定の条件に対して、リソースアクセスの権限を与えること

認証に基づく認可というケースが多くのシステムで発生する

## 認証/認可に関連する技術

- [JWT](./jwt.md)
- [OAuth2.0](./oauth2.0.md)
  - リソース所有者（User）とリソースサーバー（APIサービス）間で信頼できる方法でアクセス権を付与・管理するための`認可`フレームワーク
- [OpenID Connect (OIDC)](./openid-connect.md)
  - OAuth 2.0 の上に構築された`認証`レイヤーのプロトコル
- [OpenID Connect CIBA](./openid-connect-ciba.md)
  - `Client-Initiated Backchannel認証`を提供するためのプロトコル
- [FIDO 認証](./fido-auth.md)
  - `パスワードレス認証を目指して開発された標準規格`
- [FIDO2 認証](./fido2-auth.md)
  - 次世代のパスワードレス認証を実現するための標準規格
- [WebAuthn](./web-authn.md)
  - `FIDO認証`をベースとした、ブラウザ経由でパスワードレス認証を行うための仕組み
- [Passkey](./passkey.md)
  - パスワードレス認証基準を普及させる団体である`FIDOアライアンス`によって策定された、新しい`パスワードレス認証方法`
  - `FIDO2`と`WebAuthn`が技術として使われている
- [SAML 認証](./saml.md)
  - SAML 認証はインターネットドメイン間でユーザー認証を行なうための XML をベースにした認証情報の標準規格
- [Keycloak](./keycloak.md)
  - オープンソースのアイデンティティおよびアクセス管理 (IAM)ソフトウェア
- OpenAM
  - OpenAM はシングルサインオンを実現するためのオープンソースで、Java で開発されている
- [Microsoft Authentication Library (MSAL)](https://learn.microsoft.com/ja-jp/entra/identity-platform/msal-overview)
  - ユーザーを認証し、セキュリティで保護された Web API にアクセスするため、開発者は Microsoft ID プラットフォームからセキュリティ トークンを取得できる

## IDaaS

- `Identity as a Service`の略で、ID やパスワードなどのログイン情報の一括管理を行えるクラウド型の ID 管理サービス
