# WIP: middleware

[docs.rs: Module axum::middleware](https://docs.rs/axum/latest/axum/middleware/index.html)

axum は、独自の特注ミドルウェアシステムを持たず`tower`と統合しており、[tower](https://docs.rs/tower/latest/tower/) と [tower-http](https://crates.io/crates/tower-http) ミドルウェアのエコシステムはすべて axum で動作する。
axum でミドルウェアを書いたり使ったりするために `tower` の概念を基本的に理解しておくことが推奨される。 また、`tower::ServiceBuilder` のドキュメントを読むことも推奨される。

## middleware の適用

ミドルウェアをあらゆる場所に追加することができる

- To entire routers with `Router::layer` and `Router::route_layer`.
- To method routers with `MethodRouter::layer` and `MethodRouter::route_layer`.
- To individual handlers with `Handler::layer`.

`tower::ServiceBuilder` を使って、`layer (またはroute_layer)` を繰り返し呼び出すのではなく、一度に複数のミドルウェアを適用することが推奨される

```rs
use axum::{
    routing::get,
    Extension,
    Router,
};
use tower_http::{trace::TraceLayer};
use tower::ServiceBuilder;

async fn handler() {}

#[derive(Clone)]
struct State {}

let app = Router::new()
    .route("/", get(handler))
    .layer(
        ServiceBuilder::new()
            .layer(TraceLayer::new_for_http())
            .layer(Extension(State {}))
    );
```

## よく使われる middleware

- `TraceLayer`: 高レベルのトレース／ログ用。
- `CorsLayer`: CORS を扱う。
- `CompressionLayer`: レスポンスを自動的に圧縮する。
- `RequestIdLayer` と `PropagateRequestIdLayer`: リクエスト ID の設定と伝搬を行う。
- `TimeoutLayer`: タイムアウトのためのもの。

```rs
use tower_http::{add_extension::AddExtensionLayer, trace::TraceLayer};

let mw = ServiceBuilder::new()
  .layer(TraceLayer::new_for_http())
  .layer(AddExtensionLayer::new(state.clone()))
  .layer(axum::middleware::from_fn_with_state(
    state.clone(),
    auth_jwt::mw_admin_auth_jwt,
  ));
```

## Ordering

`Router::layer` (または同様のもの)でミドルウェアを追加すると、以前に追加されたすべてのルートがミドルウェアにラップされる。 一般的に、この結果、ミドルウェアは`下`から`上`に実行される。
しかし、どのミドルウェアも、例えばリクエストが認可されない場合など、次のレイヤーを呼び出さず、早期にリターンすることができる。

```rs
use axum::{routing::get, Router};

async fn handler() {}

let app = Router::new()
    .route("/", get(handler)) // 4 (handler)
    .layer(layer_one)    // 3
    .layer(layer_two)    // 2
    .layer(layer_three); // 1
```

`tower::ServiceBuilder` を使って複数のミドルウェアを追加することが推奨されるが、これも順序に影響する。

```rs
use tower::ServiceBuilder;
use axum::{routing::get, Router};

async fn handler() {}

let app = Router::new()
    .route("/", get(handler)) // 4
    .layer(
        ServiceBuilder::new()
            .layer(layer_one) // 1
            .layer(layer_two) // 2
            .layer(layer_three), // 3
    );
```

`ServiceBuilder` は、すべてのレイヤーを、上から下へ流れるように 1 つにまとめることで動作する。 つまり、前のコードでは layer_one が最初にリクエストを受け取り、次に layer_two 、そして layer_three となります、 そしてハンドラーを経て、レスポンスは layer_three、layer_two、最後に layer_one とバブルアップしていく。

ミドルウェアを上から下へ実行することは、一般的に理解しやすいため、`ServiceBuilder` が推奨される。

## middleware の書き方

- axum::middleware::from_fn
  - ミドルウェアを書くとき
  - 使い慣れた async/await 構文が使える
- axum::middleware::from_fn_with_state

  - 更に State を引数で渡す場合

  ```rs
  let mw = ServiceBuilder::new().layer(axum::middleware::from_fn_with_state(
    state.clone(),
    auth_jwt::mw_admin_auth_jwt,
  ));
  ```

- axum::middleware::from_extractor
  - ミドルウェアを書くとき
  - 独自の Future を実装するのが面倒
  - extractor として使いたいときもあれば、ミドルウェアとして使いたいときもある型
- axum::middleware::from_extractor_with_state

## tower の 結合子(combinator)

tower には、リクエストやレスポンスに簡単な修正を加えるために使える いくつかのユーティリティコンビネータがあります。
最もよく使われるものは

- ServiceBuilder::map_request
- ServiceBuilder::map_response
- ServiceBuilder::then
- ServiceBuilder::and_then

これらは以下のような場合に使用する

- ヘッダーの追加など、ちょっとしたアドホック(その場その場)な操作を行いたい場合
- ミドルウェアをクレートとして公開し、他の人が使えるようにするつもりがない場合

## [tower::Service and Pin<Box<dyn Future>>](https://docs.rs/axum/latest/axum/middleware/index.html#towerservice-and-pinboxdyn-future)

最大限の制御（より低レベルの API）を行うには、`tower::Service` を実装して独自のミドルウェアを書くことができるが、これは、`tower::Service with Pin<Box<dyn Future>>` を使用してミドルウェアを記述する

- ミドルウェアは、例えば `tower::Layer` のビルダーメソッド（tower_http::trace::TraceLayer など）を使って設定する必要がある
- ミドルウェアを他の人が使えるようにクレートとして公開するつもりである
- 自分の Future を実装することに抵抗がある

このようなミドルウェアのテンプレートとしては、以下のようなものが考えられる

```rs
// 割愛
```

## tower::Service とカスタム Future

独自のフューチャーを実装するのが好きで（または、学びたいと思っていて）、できるだけ多くのコントロールが必要な場合は、`tower::Service` をボックスフューチャーなしで使用するのがよい。

tower::Service と manual フューチャを使用してミドルウェアを記述するケース

- ミドルウェアのオーバーヘッドをできるだけ小さくしたい
- ミドルウェアは、例えば tower::Layer のビルダーメソッド（tower_http::trace::TraceLayer など）を使って設定できる必要がある
- おそらく tower-http の一部として、他の人が使えるようにミドルウェアをクレートとして公開する場合
- 独自のフューチャーを実装するのに慣れている、または非同期 Rust の低レベルの仕組みを学びたい場合

tower の[Building a middleware from scratch](https://github.com/tower-rs/tower/blob/master/guides/building-a-middleware-from-scratch.md)ガイドは、この方法を学ぶのに良い

## middleware のエラーハンドリング

axum のエラーハンドリングモデルでは、ハンドラは常にレスポンスを返す必要がある。 しかし、ミドルウェアはアプリケーションにエラーを導入する可能性のある方法の一つ。 `hyper`がエラーを受信すると、レスポンスを送信せずに接続を閉じる。 したがって axum は、これらのエラーを優雅に処理することを要求する

## サービス／ミドルウェアへのルーティングと背圧

一般的に、複数のサービスのうちの 1 つへのルーティングとバックプレッシャーは、うまく混ざり合いません。 理想的には、サービスを呼び出す前に、そのサービスがリクエストを受け取る準備ができていることを確認したい。 しかし、どのサービスを呼び出すべきかを知るためには、リクエスト...

1 つのアプローチは、すべてのデスティネーションサービスが準備完了になるまで、ルーターサービス自体を準備完了と見なさないことである。 これは tower::steer::Steer で使われているアプローチです。

もう一つのアプローチは、Service::poll_ready から常にすべてのサービスが準備完了であるとみなし（常に Poll::Ready(Ok(())) を返す）、Service::call によって返されるレスポンスフューチャーの内部で実際に準備完了を駆動することです。 これは、サービスが背圧を気にせず、常に準備ができている場合に有効です。

axum は、アプリで使用するすべてのサービスがバックプレッシャーを気にしないことを想定しているため、後者の戦略を使用します。 しかし、背圧を気にするサービスへのルーティング（またはミドルウェアの使用）は避けるべきです。 少なくとも、リクエストが素早くドロップされ、溜まり続けることがないように、[load shed]すべきです。

また、poll_ready がエラーを返した場合、そのエラーは call からはレスポンスの未来に返され、poll_ready からは返されません。 この場合、基礎となるサービスは破棄されず、将来のリクエストに引き続き使用されます。 poll_ready が失敗した場合に破棄されることを期待するサービスは、axum では使用しないでください。

可能なアプローチの 1 つは、背圧に敏感なミドルウェアだけをアプリ全体に適用することです。 これは、axum アプリケーション自体がサービスであるため可能です：

```rs
//割愛
```

しかし、この方法でアプリケーション全体にミドルウェアを適用する場合、エラーが適切に処理されるように注意する必要があります。

また、非同期関数から作成されたハンドラーは背圧を気にせず、常に準備ができていることに注意してください。 そのため、Tower ミドルウェアを使用していない場合は、このようなことを気にする必要はありません。

## ミドルウェアでステートにアクセスする

- axum::middleware::from_fn で状態にアクセスする
- カスタム tower::Layers でステートにアクセスする

## ミドルウェアからハンドラへの状態の受け渡し

状態は、リクエスト拡張を使ってミドルウェアからハンドラに渡すことができます：

レスポンスエクステンションも使用できますが、リクエストエクステンションは自動的にレスポンスエクステンションに移動しないことに注意してください。 必要な拡張子については手動で行う必要があります。

## ミドルウェアでのリクエスト URI の書き換え

Router::layer で追加されたミドルウェアは、ルーティングの後に実行されます。 つまり、リクエスト URI を書き換えるミドルウェアの実行には使えないということです。 ミドルウェアが実行されるときには、ルーティングはすでに終わっています。

回避策は、ミドルウェアを Router 全体に巻き付けることです（Router は Service を実装しているので、これは機能します）：
