# OpenID Connect (OIDC)

OpenID Connect（OIDC）は、OAuth 2.0 の上に構築された認証レイヤー。OAuth 2.0 は認可（authorization）に焦点を当てているが、OpenID Connect は特にユーザーの認証（authentication）を標的にしている。このプロトコルは、アプリケーションがユーザーを認証し、ユーザーに関する基本的なプロファイル情報を取得するために使用される。

OpenID Connect は、ユーザー認証のための強力で柔軟なフレームワークを提供し、多くの現代的なアプリケーションで利用されている。ユーザーのアイデンティティを安全かつ一貫した方法で管理できるため、広く採用されている。

## 基本的な概念とコンポーネント

1. **OpenID Provider（OP）**: 認証サーバーで、ユーザーの認証を行い、ID トークンやアクセストークンを発行する。
2. **Relying Party（RP）**: クライアントアプリケーションやサービスで、ユーザーの認証を依頼し、ID トークンを受け取る。
3. **エンドユーザー**: 認証を受けるユーザー。

## トークンの種類

1. **ID トークン**: ユーザーの認証情報を含むトークン。JWT（JSON Web Token）形式で、ユーザーの識別子（一意の ID）、発行者、発行時間、その他の属性が含まれる。
2. **アクセストークン**: リソースサーバー（API）に対してアクセス権を付与するトークン。
3. **リフレッシュトークン**: アクセストークンの期限が切れたときに新しいアクセストークンを取得するためのトークン。

## 認証フロー

OpenID Connect にはいくつかの認証フローがあるが、最も一般的な「認可コードフロー」について

### 認可コードフロー（Authorization Code Flow）

1. **認可リクエスト**：

   - クライアント（Relying Party：RP）はユーザーを OpenID Provider（OP）の認証エンドポイントにリダイレクトし、認可コードをリクエストする。
   - リクエストの例：

     ```http
     GET /authorize?response_type=code&client_id={client_id}&redirect_uri={redirect_uri}&scope=openid%20profile%20email&state={state}
     ```

2. **認可コード受け取り**：

   - ユーザーが OpenID Provider で認証を完了すると、OP は認可コードを手に入れて、指定されたリダイレクト URI（クライアントのエンドポイント）にリダイレクトする。
   - 例：

     ```http
     https://client.example.com/callback?code={authorization_code}&state={state}
     ```

3. **認可コードの交換**：

   - クライアントは認可コードを用いて、OP のトークンエンドポイントにアクセスし、ID トークンとアクセストークンを取得する。
   - リクエストの例：

     ```http
     POST /token
     Content-Type: application/x-www-form-urlencoded

     grant_type=authorization_code
     &code={authorization_code}
     &redirect_uri={redirect_uri}
     &client_id={client_id}
     &client_secret={client_secret}
     ```

4. **トークンの受け取り**：

   - トークンエンドポイントは、ID トークンとアクセストークンを応答する。ID トークンにはユーザー情報が含まれており、クライアントはこれを検証してユーザーを認証する。
   - レスポンスの例：

     ```json
     {
       "access_token": "eyJraWQiOiJ...",
       "token_type": "Bearer",
       "expires_in": 3600,
       "id_token": "eyJhbGciOiJSUzI1NiIsIn..."
     }
     ```

5. **ユーザー情報リクエスト（オプション）**：
   - 必要に応じて、クライアントはアクセストークンを使ってオープン ID プロバイダーのユーザー情報エンドポイントにアクセスし、追加のユーザー情報を取得できる。
   - リクエストの例：

     ```http
     GET /userinfo
     Authorization: Bearer {access_token}
     ```

## 利点

1. **統一した認証プロセス**：異なるサービス間で統一された方法で認証を行うことができる。
2. **拡張性**：OAuth 2.0 を基盤として構築されているため、既存のシステムに統合しやすい。
3. **セキュリティ**：JWT 形式のトークンを使用し、署名と暗号化で高いセキュリティを提供する。
4. **標準化**：OpenID Connect は標準化されており、多くのプロバイダーがサポートしている。

## 実際の利用シーン

1. **シングルサインオン（SSO）**：企業環境や大規模サービスで、ユーザーが一度のログインで複数の関連サービスにアクセスできるようにする。
2. **フィットネスアプリと健康データ**：Google Fit や Apple Health など、ユーザーが複数のフィットネスアプリを統一された認証方式で利用する。
3. **エンタープライズ ID プロバイダー**：Okta や Microsoft Azure AD などが提供する、企業向けの ID 管理ソリューション。
