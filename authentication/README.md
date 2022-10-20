# Authentication

## Authentication: 認証 とAuthorization/Permission:認可の違い
- 認証: ユーザーの本人確認、通信の相手が誰（何）であるかを確認すること
- 認可: とある特定の条件に対して、リソースアクセスの権限を与えること

認証に基づく認可というケースが多くのシステムで発生する

## OAuth2.0
- OAuth2.0は認可を行うためのプロトコル
- 所有者の代わりにリソースへのアクセスを許可するためのプロトコル
- サードパーティーアプリケーションによるHTTPサービスへの限定的なアクセスを可能にする認可フレームワーク
- エンドユーザーがあるサービスに対して別のサービスへのアクセスを許可するためのトークンを発行するための手段
  - これによって、SNSのアカウントでログインすることで、認可によって、連携しているサービスへのアクセスが可能になる
- OAuthは認可のためのプロトコルだが、認証を行うためのプロトコルではない
- [単なる OAuth 2.0 を認証に使うと、車が通れるほどのどでかいセキュリティー・ホールができる
](https://www.sakimura.org/2012/02/1487/)
  - 悪意のあるサイトは`access_token`を取得後、任意のOAuth認証に対応しているサイトへのアクセスができてしまう
  - [図解](https://tech-lab.sios.jp/archives/13002)

### OAuth2.0の流れ
前提条件として、`認可サーバー`はここでは、Googleとする
1. Webサイトにアクセス
2. 「Googleアカウントでログイン」をクリック
3. これにより、認可サーバー(Google)にリダイレクトされる
4. 未ログインの場合、Googleのログイン画面が表示されるので、ログインする
5. ユーザーに、Googleのリソース(情報)へのアクセスの認可を許可するかどうか確認する
6. 認可サーバーからアクセストークンが発行され、元のWebサイトにリダイレクトされる
7. また、アクセストークンを使って、Googleのリソースにアクセスできる


## OpenID Connect (OIDC)
- OAuth2.0 の拡張規格で、`認証`を行うこともできる
- つまり、認証を目的とするならば、`OAuth2.0`ではなく、`OpenID Connect`を使うべき
- サードパーティーのサービス、例えばGoogleやFacebookなどの認証サーバーを使ってユーザー認証を行うためのプロトコル
- OpenID Connectを利用したログインサービスは`ソーシャルログイン`と呼ばれる
- `ID連携`とはGoogleやFacebookといったサービスで利用しているユーザーIDで、他のWebサービスを利用する仕組みのこと

### ID連携を使用するメリット
- ユーザーのパスワード情報の管理や認証処理は`IdP`側で実施するので、アプリ側でのパスワード管理や認証処理は不要
- ユーザー登録の煩わしさを省ける

### OpenID Connectの流れ
1. ユーザーはアプリにアクセスし、ログインページを表示
2. この時、ソーシャルログインの機能(Google,Facebookなど)のログインボタンをクリック
3. そのアプリは認証クライアントとして認証サーバー側に認証を要求する (`認証リクエスト`)
4. IdPの`認可エンドポイント`にリダイレクトする
5. 未ログインの場合、Google,Facebookなどのログイン画面が表示されるので、ログインする
6. 認証サーバーはユーザー認証を行い、認可ページをレスポンスとして返す
7. クライアントから、ID連携の同意を送信する
8. 必要な`認可コード` を発行してクライアントに返す
9. 受け取った認可コードを用いて、IdPのトークンエンドポイントにトークンリクエストを送信する
10. トークンエンドポイントから、`アクセストークン`と`IDトークン` (アクセスするための認証情報)を生成して返す
11. アプリサービス側で、受け取ったIDトークンの検証を行う
12. 検証に問題がなければ、IdPによりユーザー認証が完了したことになる
13. 更なるユーザー情報が必要な場合、アクセストークンによって、ユーザー情報エンドポイントにアクセスができる
14. アプリ側サービスはユーザーをログイン状態にし、適切なページに遷移させる

- 認証クライアントとなるアプリを `Relying Party`
- 認証サービスを行う事業者を `OpenID Provider`もしくは`Identity Provider`, `(IdP)` という
- IDトークンを用いて、`Relying Party`は外部API（Google APIsやFacebook Graph APIなど）を利用することができる

### 認証フローの種類
1. Authorization Code フロー：サーバーサイドで認証
2. Implicit フロー：クライアントサイドで認証
3. Hybrid フロー：サーバーサイド・クライアントサイドの両方で認証


### [WIP] ID連携を使う場合、何を保存すべきか？
- まず、パスワードは不要になる


### OpenID ConnectのIDトークンについて
- Webの世界的な標準規格である`RFC 7519` (JSON Web Token) で定められている
- このIDトークンには署名が付与されている
- 署名は暗号化され、さらにトークンの中にはユーザー情報の他にもトークンの発行者、トークン有効期間などの情報を含めることができる

### OpenID Connect References
- [Official](https://openid.net/connect/)
- [Google Docs](https://developers.google.com/identity/openid-connect/openid-connect)
- [Facebook Docs](https://developers.facebook.com/docs/facebook-login/limited-login/token/)
- [一番分かりやすい OpenID Connect の説明](https://qiita.com/TakahikoKawasaki/items/498ca08bbfcc341691fe)
- [図解 OpenID Connect による ID 連携](https://qiita.com/TakahikoKawasaki/items/701e093b527d826fd62c)
- [OpenID Connect入門: 画面遷移+シーケンス図](https://qiita.com/nabeatsu/items/380058915629c0ce795e)


## [WIP] OpenID Connect CIBA
- `Client Initiated Backchannel Authentication` の略で、`シーバ`と読むらしい
- OpenID Connect Coreでは、認可、認証の代表的なプロセスとして、認可コードフローが定義されている
- しかし、サービスを利用するユーザー自身が`認証/認可`を行う流れが一般的
- 多様なデバイス（例えば、スマートスピーカーやIoT、POSなど）への対応や、第三者がユーザーの同意に基づいてAPIを実行できるような仕様にはなっていない
- そこで、`サービス利用` と `認証/認可` を行うデバイス・ユーザーを分離したいというユースケースを実現するために生まれた考え方が `CIBA`

- `Keycloak`によって実現できるらしい
  - [Keycloak(14.0.0)で試す OpenID Connect CIBA](https://www.creationline.com/lab/43470)


## FIDO認証
- パスワードレスによって、利便性と安全性を満たすための認証プロトコル
  - パスワードレス認証とは、多要素認証 (MFA)の一種
- FIDO: `Fast Identity Online`の略であり、日本語だと`ファイド`と発音される
- サーバーとユーザーで秘密の情報を共有しないのが大きな特徴

### FIDO認証の仕組み
- サーバーからの認証要求(チャレンジ)に対して、正規ユーザーである証の `署名` を返すことで認証を行う
- この `署名` が本物であるかどうかを確認するために`秘密鍵`と`公開鍵`の鍵ペアを利用する
| 鍵の種類 | 役割・用途                       | 役割・用途         |
| -------- | -------------------------------- | ------------------ |
| 秘密鍵   | FIDO登録情報の署名生成に利用     | ユーザーデバイス内 |
| 公開鍵   | ペアとなる秘密鍵の署名を検証する | サーバー内         |

- `秘密鍵`を使用して署名を行うためには、登録時に指定した方法(生体認証など)で正規のユーザーであることを確認する
- これによりFIDO登録を行った本人しか、署名を行うことはできず、署名の本人性を確認できる
- また、`秘密鍵`と`公開鍵`のセットは、FIDO登録時にユーザーデバイス内で生成され、`公開鍵`のみをサーバーへ送信し、`秘密鍵`はユーザーデバイス内で厳重に保管される
- `公開鍵`は、署名を検証するためにサーバーに保管されている
- これが、`サーバーとユーザーで秘密の情報を共有しない` というFIDO認証の仕組みとなる


## [WIP] FIDO2 生体認証
- FIDO2（Web認証）は、W3CのWeb認証仕様（WebAuthn)とFIDOアライアンスのデバイス間連携仕様（CTAP）から成る技術仕様で構成される
- 生体認証デバイスなどを利用してウェブブラウザーを通じたオンラインサービスへの安全なログインを実現


## [WIP] WebAuthn
- WebAuthnは `WebAuthentication`の略で、 `FIDO認証`をベースとした、ブラウザ経由でパスワードレス認証を行うための仕組み
- WebAuthnを実現するために用意されているJavaScript APIを `WebAuthn API` と呼ぶ
- WebAuthnというのは、`FIDO2`の仕様の一部のことを指している

- 認証クライアントとなるアプリケーションなどのサービスを `Relying Party`
- ユーザーが使用するデバイスには`認証器`が必要となる
  - 署名の作成、キーペアの作成、認証情報の管理、所有確認や生体認証の実施などの機能
- `認証サーバ`は、つまりFIDOの認証の処理を行うサーバのこと

### References
- [Official](https://webauthn.io/)


## SAML認証
- SAMLはSecurity Assertion Markup Languageの略称
- SAML認証はインターネットドメイン間でユーザー認証を行なうためのXMLをベースにした標準規格
- 一つのアカウント情報を持って複数のサービスで使い回せる `シングルサインオン（SSO）` などに利用される


## [WIP] Keycloak
- オープンソースのアイデンティティ・アクセス管理ソフトウェア
- Keycloakの目的はセキュリティーをシンプルに実現することで、様々なセキュリティー機能が実装されている
- シングルサインオンやAPIアクセスの認証・認可制御を実現するもの
- WebアプリケーションおよびRESTfulなWebサービスのためのSSOソフトウェア
- OpenAMと比べて、後発 (つまり新しい)

### Keycloakの機能
- Web上でのSSO
- OpenID Connectのサポート
- OAuth 2.0のサポート
- SAMLのサポート
- 外部のOpenID ConnectもしくはSAMLに対応したアイデンティティー・プロバイダーによる認証
- ソーシャル・ログイン
- ユーザー・フェデレーション: LDAPやActive Directoryからのユーザー同期
- ケルベロス連携: ケルベロス・サーバーにログイン済のユーザーに対する認証連携
- 二要素認証: Google AuthenticatorやFreeOTPを使用したTOTP/HOTPのサポート

### Keycloak References
- [Official](https://www.keycloak.org/)
- [Keycloak (jp)](https://keycloak-documentation.openstandia.jp/master/ja_JP/server_admin/index.html)
- [Github](https://github.com/keycloak/keycloak)
  - Javaで書かれている


## OpenAM
- OpenAMはシングルサインオンを実現するためのオープンソースで、Javaで開発されている


## IDaaS
- `Identity as a Service`の略で、IDやパスワードなどのログイン情報の一括管理を行えるクラウド型のID管理サービス