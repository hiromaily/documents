# OpenID Connect (OIDC) Part 2

- OAuth2.0 の拡張規格で、`認証`を行うこともできる
- つまり、認証を目的とするならば、`OAuth2.0`ではなく、`OpenID Connect`を使うべき
- サードパーティーのサービス、例えば Google や Facebook などの認証サーバーを使ってユーザー認証を行うためのプロトコル
- OpenID Connect を利用したログインサービスは`ソーシャルログイン`と呼ばれる
- `ID連携`とは Google や Facebook といったサービスで利用しているユーザー ID で、他の Web サービスを利用する仕組みのこと

## ID 連携を使用するメリット

- ユーザーのパスワード情報の管理や認証処理は`IdP`側で実施するので、アプリ側でのパスワード管理や認証処理は不要
- ユーザー登録の煩わしさを省ける

## OpenID Connect の流れ

1. ユーザーはアプリにアクセスし、ログインページを表示
2. この時、ソーシャルログインの機能(Google,Facebook など)のログインボタンをクリック
3. そのアプリは認証クライアントとして認証サーバー側に認証を要求する (`認証リクエスト`)
4. IdP の`認可エンドポイント`にリダイレクトする
5. 未ログインの場合、Google,Facebook などのログイン画面が表示されるので、ログインする
6. 認証サーバーはユーザー認証を行い、認可ページをレスポンスとして返す
7. クライアントから、ID 連携の同意を送信する
8. 必要な`認可コード` を発行してクライアントに返す
9. 受け取った認可コードを用いて、IdP のトークンエンドポイントにトークンリクエストを送信する
10. トークンエンドポイントから、`アクセストークン`と`IDトークン` (アクセスするための認証情報)を生成して返す
11. アプリサービス側で、受け取った ID トークンの検証を行う
12. 検証に問題がなければ、IdP によりユーザー認証が完了したことになる
13. 更なるユーザー情報が必要な場合、アクセストークンによって、ユーザー情報エンドポイントにアクセスができる
14. アプリ側サービスはユーザーをログイン状態にし、適切なページに遷移させる

- 認証クライアントとなるアプリを `Relying Party`
- 認証サービスを行う事業者を `OpenID Provider`もしくは`Identity Provider`, `(IdP)` という
- ID トークンを用いて、`Relying Party`は外部 API（Google APIs や Facebook Graph API など）を利用することができる

## 認証フローの種類

1. Authorization Code フロー：サーバーサイドで認証
2. Implicit フロー：クライアントサイドで認証
3. Hybrid フロー：サーバーサイド・クライアントサイドの両方で認証

## OpenID Connect の ID トークンについて

- Web の世界的な標準規格である`RFC 7519` (JSON Web Token) で定められている
- この ID トークンには署名が付与されている
- 署名は暗号化され、さらにトークンの中にはユーザー情報の他にもトークンの発行者、トークン有効期間などの情報を含めることができる

## ID 連携を利用する場合、自社サービスでは何を保存すべきか？

自分のサイトでOpenID Connectなどのプロバイダーを利用して認証する場合、以下の情報を保存することが一般的

### 保存するべき情報

1. **ユーザーID**:
   - プロバイダーが提供するユーザーの一意の識別子（例えば、Googleの`sub`フィールド）。
   - 自分のサイト内でも独自のユーザーIDを生成し、プロバイダーのユーザーIDと関連付ける場合もある。

2. **ユーザー名**:
   - ユーザーの表示名（例：フルネームやニックネーム）。

3. **メールアドレス**:
   - ユーザーのメールアドレス（プロバイダーから取得）。

4. **プロバイダーの種類**:
   - どのプロバイダーを使用してログインしたかを特定するための情報（例："Google" , "Facebook"）。

5. **アクセストークン**（オプション, 非推奨）:
   - 必要に応じて、リソースサーバーに繰り返しアクセスするためのアクセストークン。ただし、セキュリティの観点から長期間保存するのは推奨されない。

6. **リフレッシュトークン**（オプション, 非推奨）:
   - アクセストークンが期限切れになった際に新しいアクセストークンを取得するためのリフレッシュトークン。これもセキュリティ上の理由から慎重に扱う必要がある。

7. **プロファイル情報の一部**：
   - ユーザーの基本的なプロファイル情報（例：プロフィール画像のURLなど）。

### ベストプラクティスと注意事項

1. **アクセストークンとリフレッシュトークンの管理**:
   - アクセストークンとリフレッシュトークンは高いセキュリティリスクを持つため、保存する場合は暗号化する。
   - 可能な限り短期間で保存する。

2. **メールアドレスの確認**:
   - メールアドレスは、プロバイダーから提供されるが、その信頼性を保つために、プロバイダーがメールアドレスを検証済みか確かめる。

3. **データベースの保護**:
   - ユーザー情報を保存するデータベースはセキュリティ対策を施し、不正アクセスを防ぐ。
   - 定期的なバックアップを行い、データの損失を防ぐ。

4. **ユーザーが複数のプロバイダーを使用するシナリオに対応**:
   - 同じユーザーが異なるプロバイダーを使ってログインする場合を想定し、同じメールアドレスに関連付けられた複数の認証情報を管理するロジックを実装。
