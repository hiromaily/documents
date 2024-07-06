# tower_http

[Crate tower_http](https://docs.rs/tower-http/latest/tower_http/)

`tower-http`は、tower の上に構築された HTTP 専用のミドルウェアとユーティリティを提供するライブラリ

すべてのミドルウェアは、HTTP の抽象化として http と http-body クレートを使っている。 つまり、hyper、tonic、warp など、これらのクレートを使用するライブラリやフレームワークとも互換性がある。

## サーバの例

サービスに tower-http のミドルウェアを適用し、hyper を使ってそのサービスを実行する方法

この例では hyper を使用しているが、tower-http は http と http-body のクレートを使用する HTTP クライアント/サーバーの実装をサポートしている

```rs
use tower_http::{
    add_extension::AddExtensionLayer,
    compression::CompressionLayer,
    propagate_header::PropagateHeaderLayer,
    sensitive_headers::SetSensitiveRequestHeadersLayer,
    set_header::SetResponseHeaderLayer,
    trace::TraceLayer,
    validate_request::ValidateRequestHeaderLayer,
};
use tower::{ServiceBuilder, service_fn, BoxError};
use http::{Request, Response, header::{HeaderName, CONTENT_TYPE, AUTHORIZATION}};
use std::{sync::Arc, net::SocketAddr, convert::Infallible, iter::once};
use bytes::Bytes;
use http_body_util::Full;

// Our request handler. This is where we would implement the application logic
// for responding to HTTP requests...
async fn handler(request: Request<Full<Bytes>>) -> Result<Response<Full<Bytes>>, BoxError> {
    // ...
}

// Shared state across all request handlers --- in this case, a pool of database connections.
struct State {
    pool: DatabaseConnectionPool,
}

#[tokio::main]
async fn main() {
    // Construct the shared state.
    let state = State {
        pool: DatabaseConnectionPool::new(),
    };

    // Use tower's `ServiceBuilder` API to build a stack of tower middleware
    // wrapping our request handler.
    let service = ServiceBuilder::new()
        // Mark the `Authorization` request header as sensitive so it doesn't show in logs
        .layer(SetSensitiveRequestHeadersLayer::new(once(AUTHORIZATION)))
        // High level logging of requests and responses
        .layer(TraceLayer::new_for_http())
        // Share an `Arc<State>` with all requests
        .layer(AddExtensionLayer::new(Arc::new(state)))
        // Compress responses
        .layer(CompressionLayer::new())
        // Propagate `X-Request-Id`s from requests to responses
        .layer(PropagateHeaderLayer::new(HeaderName::from_static("x-request-id")))
        // If the response has a known size set the `Content-Length` header
        .layer(SetResponseHeaderLayer::overriding(CONTENT_TYPE, content_length_from_response))
        // Authorize requests using a token
        .layer(ValidateRequestHeaderLayer::bearer("passwordlol"))
        // Accept only application/json, application/* and */* in a request's ACCEPT header
        .layer(ValidateRequestHeaderLayer::accept("application/json"))
        // Wrap a `Service` in our middleware stack
        .service_fn(handler);
}
```

## クライアントの例

tower-http ミドルウェアは HTTP クライアントにも適用できる

```rs
use tower_http::{
    decompression::DecompressionLayer,
    set_header::SetRequestHeaderLayer,
    trace::TraceLayer,
    classify::StatusInRangeAsFailures,
};
use tower::{ServiceBuilder, Service, ServiceExt};
use hyper_util::{rt::TokioExecutor, client::legacy::Client};
use http_body_util::Full;
use bytes::Bytes;
use http::{Request, HeaderValue, header::USER_AGENT};

#[tokio::main]
async fn main() {
let client = Client::builder(TokioExecutor::new()).build_http();
    let mut client = ServiceBuilder::new()
        // Add tracing and consider server errors and client
        // errors as failures.
        .layer(TraceLayer::new(
            StatusInRangeAsFailures::new(400..=599).into_make_classifier()
        ))
        // Set a `User-Agent` header on all requests.
        .layer(SetRequestHeaderLayer::overriding(
            USER_AGENT,
            HeaderValue::from_static("tower-http demo")
        ))
        // Decompress response bodies
        .layer(DecompressionLayer::new())
        // Wrap a `Client` in our middleware stack.
        // This is possible because `Client` implements
        // `tower::Service`.
        .service(client);

    // Make a request
    let request = Request::builder()
        .uri("http://example.com")
        .body(Full::<Bytes>::default())
        .unwrap();

    let response = client
        .ready()
        .await
        .unwrap()
        .call(request)
        .await
        .unwrap();
}
```

## 機能フラグ

全てのミドルウェアはデフォルトでは無効になっており、cargo features を使って有効にすることができる

```toml
tower-http = { version = "0.1", features = ["trace"] }

tower-http = { version = "0.1", features = ["full"] }
```

## [Modules](https://docs.rs/tower-http/latest/tower_http/#modules)

- auth
- cors
- follow_redirect
- limit
- request_id
- set_header
- set_status
- timeout
- trace
- validate_request
