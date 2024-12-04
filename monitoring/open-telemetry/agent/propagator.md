# Propagator

分散コンテキスト（distributed context）を伝播させる役割を担うコンポーネント。具体的には、トレースやメトリクスのデータに関連するコンテキスト情報を、サービス間やプロセス間で渡すための仕組みを指す。

## Propagator の役割

分散システムにおいて、リクエストが複数のサービスやプロセスを経由する際に、トレース ID やスパン ID、その他のコンテキスト情報を適切に伝播させることが重要。この伝播により、各リクエストがどのように処理され、どこで時間が費やされているかを追跡することが可能になる。

## 主要なコンセプト

1. **Context**:

   - OpenTelemetry のコンテキストは、一連のトレースデータや Span データを関連付けるために使用される。コンテキストには、トレース ID、スパン ID、およびサンプリング情報などが含まれる。

2. **Carrier**:
   - Carrier は、コンテキスト情報を物理的に運ぶための媒体を指す。HTTP ヘッダーやメッセージキュー用のメッセージ属性などが典型的なキャリア。

## Propagator の種類

### 1. W3C TraceContext Propagator

- **概要**: W3C が提案している標準で、トレースコンテキストを HTTP ヘッダーを通じて伝播させるためのフォーマット。
- **HTTP ヘッダー**:
  - `traceparent`: トレースとスパン ID を含む主要なコンテキスト情報。
  - `tracestate`: トレースの状態やカスタムメタデータを含む追加情報。

### 2. Jaeger Propagator

- **概要**: Jaeger が用いるカスタムプロパゲーションフォーマットで、Jaeger トレースシステム用に最適化されている。
- **HTTP ヘッダー**:
  - `uber-trace-id`: トレース ID、スパン ID、親スパン ID、およびサンプルフラグの 4 つの値を含む単一のヘッダー。

### 3. B3 Propagator

- **概要**: B3 は、Twitter が開発した `Zipkin` トレースシステム用のプロパゲーションフォーマット。
- **HTTP ヘッダー**:
  - `X-B3-TraceId`: トレース ID。
  - `X-B3-SpanId`: スパン ID。
  - `X-B3-ParentSpanId`: 親スパン ID。
  - `X-B3-Sampled`: サンプルフラグ。

### 4. その他

[opentelemetry-go-contrib propagators内](https://github.com/open-telemetry/opentelemetry-go-contrib/tree/main/propagators)

- autoprop
- aws
- b3
- jaeger
- opencensus
- ot
