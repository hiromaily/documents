# API 設計 ベストプラクティス 2

[ReadLater]

[API 設計スキルを次のレベルに引き上げるベストプラクティス 22 選](https://betterprogramming.pub/22-best-practices-to-take-your-api-design-skills-to-the-next-level-65569b200b9)

## [リソース志向設計/Resource-oriented design](https://cloud.google.com/apis/design/resources)

API設計は、リソース指向設計というものに従う。3つの重要な概念で構成されている。

- `リソース`：データの一部（e.g. User）
- `コレクション`：リソースのグループ（e.g User List）
- `URL`：リソースやコレクションの場所（e.g. /user）

## 1. URLにケバブケースを使う

Case: 注文リストを取得する場合

[悪い例]

```http
/systemOrders
/system_orders
```

[良い例]

```http
/system-orders
```

## 2. パラメータにキャメルケースを使う

Case: 特定のショップの商品を取得する場合

[悪い例]

```http
/system-orders/{order_id}
/system-orders/{OrderId}
```

[良い例]

```http
/system-orders/{orderId}
```

## 3. コレクションを指す複数形の名前

Case: システムの全ユーザーを取得する場合

[悪い例]

```http
GET /user
GET /User
```

[良い例]

```http
GET /users
```

## 4. URLはコレクションで始まり、識別子で終わる

Case: 概念の単一性と一貫性を保つ場合

[悪い例]

リソースではなくプロパティを指すのはよくない

```http
GET /shops/:shopId/category/:categoryId/price
```

[良い例]

```http
GET /shops/:shopId/ or GET /category/:categoryId
```

## 5. リソースURLに動詞を使わない

URLで意図を表すために動詞を使わない。代わりに、適切なHTTPメソッドを使って操作を記述すべき

[悪い例]

```http
POST /updateuser/{userId}
GET /getusers
```

[良い例]

```http
PUT /user/{userId}
```

## 6. 非リソースURLには動詞を使う

操作のみを返すエンドポイントの場合、動詞を使う。

Case: ユーザーにアラートを再送する場合

[良い例]

```http
POST /alerts/245743/resend
```

## 7. JSONのプロパティにキャメルケースを使う

リクエスト本文やレスポンスがJSONのシステムを構築している場合、プロパティ名はキャメルケースである必要がある

[悪い例]

```json
{
  "user_name": "Mohammad Faisal",
  "user_id": "1"
}
```

[良い例]

```json
{
  "userName": "Mohammad Faisal",
  "userId": "1"
}
```

## 8. モニタリング

RESTful HTTPサービスは、`/health`、`/version`、`/metrics`の各APIエンドポイントを実装する必要がある。これらは以下の情報を提供する

- `/health`: `/health`へのリクエストに200 OKステータスコードで応答する
- `/version`: `/version`へのリクエストにバージョン番号で応答する
- `/metrics`: このエンドポイントは、平均応答時間などのさまざまなmetricsを提供する
- `/debug`: ??
- `/status`: ??

## 9. リソース名にテーブル名を使わない

基本的なアーキテクチャの公開が目的ではないため、リソース名にテーブル名を使うべきではない

[悪い]

```http
/product_order
```

[良い]

```http
product-orders
```

## 10. API設計ツールを使う

- [API BluePrint](https://apiblueprint.org/)
- [Swagger](https://swagger.io/)

## 11. バージョンに単純な序数を使う

APIに常にバージョン管理を使い、左に移動して範囲を広げます。バージョン番号は`v1`、`v2`などにする。
APIが外部エンティティに使われている場合、エンドポイントを変更するとその機能が使えなくなる可能性があるため、APIには常にバージョン管理を使う必要がある。

```http
http://api.domain.com/v1/shops/3/products
```

## 12. レスポンスにリソースの総数を含める

APIがオブジェクトのリストを返す場合、totalプロパティを使って、必ずリソースの総数をレスポンスに含める。

```json
{
    "users": [
        ...
    ],
    "total": 9566
}
```

## 13. limitパラメータとoffsetパラメータを受け入れる

フロントエンドでのページネーションなど、GET操作では、常にlimitパラメータとoffsetパラメータを受け入れる。

```http
GET /shops?offset=5&limit=5
```

## 14. fieldsクエリパラメータを使う

fieldsパラメータを追加して、APIから必要なフィールドのみを公開し、返されるデータ量も考慮する

Case: ショップ名、住所、連絡先のみを返す場合

```http
GET /shops?fields=id,name,address,contact
```

## 15. URLに認証トークンを渡さない

多くの場合、URLがログに記録され、認証トークンも不必要に記録されるため、非常に悪い習慣となる

[悪い]

```http
GET /shops/123?token=some_kind_of_authenticaiton_token
```

[良い]

ヘッダーで認証トークンを渡す。また、認証トークンは短命であるべき

```http
Authorization: Bearer xxxxxx
```

## 16. コンテンツタイプを有効にする

サーバーは、コンテンツタイプを憶測してはいけない。例えば、`application/x-www-form-urlencoded`を受け入れた場合、攻撃者はフォームを作成し、単純なPOSTリクエストをトリガーできる。そのため、常にコンテンツタイプを有効にし、デフォルトのものを使う場合は、`content-type: application/json`を使う。

## 17. CRUD機能にHTTPメソッドを使う

HTTP メソッドは、CRUD機能を説明する目的で使う

- `GET`: リソースの表現を取得する
- `POST`: 新しいリソースやサブリソースを作成する
- `PUT`: 既存のリソースを更新する
- `PATCH`: 既存のリソースを更新する、提供されたフィールドのみを更新し、他のフィールドはそのままにする
- `DELETE`: 既存のリソースを削除する

## 18. ネストされたリソースURLにリレーションを使う

- `GET /shops/2/products`: ショップ2の全商品リストを取得する
- `GET /shops/2/products/31`: ショップ2の商品31の詳細を取得する
- `DELETE /shops/2/products/31`: ショップ2の商品31を削除する
- `PUT /shops/2/products/31`: 商品31の情報を更新する、PUTはコレクションではなくリソースURLのみに使う
- `POST /shops`: 新しいショップを作成し、そのショップの詳細を返す、POSTはコレクションURLに使う

## 19. CORS

全公開APIに対して`CORS（Cross-Origin Resource Sharing）`ヘッダーをサポートする。
CORSが許可した「*」のオリジンのサポートと、有効なOAuthトークンを使った認証の実施を検討する。
ユーザー資格情報とオリジン認証の組み合わせは避けたほうがよい (?)

## 20. セキュリティ

全エンドポイント、リソース、サービスにHTTPS（TLS暗号化）を適用する。
全コールバックURL、プッシュ通知エンドポイント、Webhookに、HTTPSを適用してリクエストする。

## 21. エラー

エラー、厳密にはサービスエラーが発生するのは、クライアントがサービスに対して、無効または不正なリクエストを行ったり、無効または不正なデータを渡したりして、サービスがそのリクエストを拒否した時。例えば、`無効な認証情報`、`不正なパラメータ`、`不明なバージョンID`など。

- 1つ以上のサービスエラーによりクライアントリクエストを拒否する場合は、`4xx` HTTPエラーコードを返す
- 全属性を処理してから、単一の応答で複数の認証問題を返すことを検討する

## 22. ゴールデンルール

APIフォーマットの決定に迷った場合は、以下のゴールデンルールが正しい決定をする指針となる

- フラットはネストより良い
- 単純は複雑より良い
- 文字列は数字より良い
- 一貫性はカスタマイズより良い
