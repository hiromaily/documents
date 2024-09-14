# OpenID Connect CIBA (`シーバ`)

OpenID Connect CIBA（Client-Initiated Backchannel Authentication）は、`Client-Initiated Backchannel認証`を提供するためのプロトコル。CIBAは、ユーザーがクライアントデバイスに直接アクセスできない場合や、クライアントデバイスがブラウザレス環境にある場合に特に役立つ。例えば、ウェアラブルデバイスやIoTデバイスなどで多要素認証を行うシナリオに適している。

- `サービス利用` と `認証/認可` を行うデバイス・ユーザーを分離したいというユースケースを実現するために生まれた考え方が `CIBA`
- `Keycloak`によって実現できるらしい

## Client-Initiated Backchannel認証とは

OpenID Connectの一部で、主にユーザーがクライアントデバイスに直接アクセスできない状況での認証フローを提供するプロトコル。これにより、ブラウザレス環境やデバイス間認証のシナリオに対応できる。

## 基本的な概念とコンポーネント

1. **認可サーバー（Authorization Server）**：ユーザーを認証し、認可コードやトークンを発行するサーバー。
2. **クライアント（Client）**：ユーザーの代わりにリソースにアクセスするアプリケーション。
3. **エンドユーザー（End User）**：認証を受けるユーザー。
4. **認証デバイス（Authentication Device）**：ユーザーが認証を行うデバイス。これは必ずしもクライアントデバイスと同一である必要はない。

## フローの概要

CIBAの認証フローは、以下のステップに分かれます。

1. **認証要求（Authentication Request）**：
   - クライアントは認可サーバーに対してユーザーの認証をリクエストします。このリクエストには、ユーザー識別情報やクライアントの認証情報が含まれる。
   - 例：

     ```http
     POST /bc-authorize
     Host: authorization-server.com
     Content-Type: application/json

     {
       "client_id": "client123",
       "client_secret": "secret",
       "login_hint": "user@example.com",
       "scope": "openid profile",
       "binding_message": "Please confirm your login"
     }
     ```

2. **ユーザー認証プロセス**：
   - 認可サーバーはユーザーの認証デバイスに通知を送る。この通知はプッシュ通知やSMSなどで送信される。
   - ユーザーは通知を受け取り、認証デバイス上で認証を完了する（例：スマートフォンアプリでの承認）。

3. **トークン取得（Token Request）**：
   - ユーザーが認証を完了すると、クライアントは認可サーバーからトークンを取得する。このプロセスはポーリングまたはプッシュ通知を使って行われる。
   - ポーリングの例：

     ```http
     POST /token
     Host: authorization-server.com
     Content-Type: application/x-www-form-urlencoded

     grant_type=urn:openid:params:grant-type:ciba
     &auth_req_id=xyz123
     &client_id=client123
     &client_secret=secret
     ```

4. **トークンの受け取り**：
   - 認可サーバーはクライアントにIDトークンとアクセストークンを返す。
   - 例：

     ```json
     {
       "access_token": "access-token-123",
       "expires_in": 3600,
       "id_token": "id-token-123",
       "token_type": "Bearer"
     }
     ```

## 利用シーン

CIBAは、以下のようなシナリオに適している：

1. **ウェアラブルデバイスの認証**：
   - スマートウォッチなど、ユーザーが認証デバイスを持っているが、リソースへのアクセスを求める別のデバイスからの認証が必要な場合。

2. **多要素認証（MFA）**：
   - ユーザーが柔軟に多要素認証を設定できる場面。例えば、スマートフォンアプリを使って認証を求める場合。

3. **IoTデバイス**：
   - ブラウザレス環境のデバイス（スマートホームデバイスなど）が、ユーザーのスマートフォンを認証デバイスとして利用する場合。

4. **コールセンター/カスタマーサポート**：
   - 電話を通じての顧客認証。カスタマーサポートが顧客の認証を行うために利用する。

## メリット

1. **対話的でないデバイスに対応**：ウェアラブルデバイスやIoTデバイスなど、ユーザーが直接対話できないデバイスでも認証可能。
2. **高いセキュリティ**：バックチャネルを使うため、直接URLや情報を公開しないので、セキュリティリスクが低減。
3. **柔軟性**：ユーザー側の認証デバイスを問わず、多様なシナリオに対応できる。

## 実装例（擬似コード）

以下は、CIBAを使った認証フローの擬似コードの例。

```py
# 認証要求の送信
def send_authentication_request(client_id, client_secret, login_hint, scope, binding_message):
    response = requests.post(
        'https://authorization-server.com/bc-authorize',
        json={
            'client_id': client_id,
            'client_secret': client_secret,
            'login_hint': login_hint,
            'scope': scope,
            'binding_message': binding_message
        }
    )
    return response.json()['auth_req_id']

# ポーリングによるトークン取得
def poll_for_token(auth_req_id, client_id, client_secret):
    while True:
        response = requests.post(
            'https://authorization-server.com/token',
            data={
                'grant_type': 'urn:openid:params:grant-type:ciba',
                'auth_req_id': auth_req_id,
                'client_id': client_id,
                'client_secret': client_secret
            }
        )
        if response.status_code == 200:
            return response.json()
        time.sleep(5)  # 5秒ごとにポーリング
```

このように、OpenID Connect CIBAは、ユーザーとクライアントデバイスが直接的に対話しない状況や特定のセキュリティ要件を満たす際に強力なツールとなる。デバイスの多様化やセキュリティ要件の高度化に応じて、活用が期待されるプロトコル。
