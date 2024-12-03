# Open Telemetry Agent (Exporter)

各マイクロサービスやコンテナ内で動作し、トレースやメトリクスを収集し、収集したトレース、メトリクス、およびログデータを外部のシステムやバックエンドに送信する役割を担うコンポーネントであり、Application 側に組み込むものとなる。

## [Exporters](<(https://opentelemetry.io/docs/languages/go/exporters/)>)

- [github: opentelemetry-go](https://github.com/open-telemetry/opentelemetry-go/tree/main/exporters)

### Exporter の種類

- Stdout (console)
  - Debug や UT などに便利
- OTLP
  - Jaeger など
- Prometheus (Experimental) プロメテウス
- Zipkin

#### OTLP について

OTLP（OpenTelemetry Protocol）は、OpenTelemetry プロジェクトによって定義された通信プロトコルで、トレース、メトリクス、およびログデータを様々なバックエンドに送信するための標準的な方法を提供する。OTLP は`HTTP/JSON`や`gRPC形式`でデータを送信でき、効率的なデータ転送とシリアライズをサポートしている。

## Propagator

分散コンテキスト（distributed context）を伝播させる役割を担うコンポーネント。具体的には、トレースやメトリクスのデータに関連するコンテキスト情報を、サービス間やプロセス間で渡すための仕組みを指す。

### Propagator の役割

分散システムにおいて、リクエストが複数のサービスやプロセスを経由する際に、トレース ID やスパン ID、その他のコンテキスト情報を適切に伝播させることが重要。この伝播により、各リクエストがどのように処理され、どこで時間が費やされているかを追跡することが可能になる。

### 主要なコンセプト

1. **Context**:

   - OpenTelemetry のコンテキストは、一連のトレースデータや Span データを関連付けるために使用される。コンテキストには、トレース ID、スパン ID、およびサンプリング情報などが含まれる。

2. **Carrier**:
   - Carrier は、コンテキスト情報を物理的に運ぶための媒体を指す。HTTP ヘッダーやメッセージキュー用のメッセージ属性などが典型的なキャリア。

### Propagator の種類

#### 1. W3C TraceContext Propagator

- **概要**: W3C が提案している標準で、トレースコンテキストを HTTP ヘッダーを通じて伝播させるためのフォーマット。
- **HTTP ヘッダー**:
  - `traceparent`: トレースとスパン ID を含む主要なコンテキスト情報。
  - `tracestate`: トレースの状態やカスタムメタデータを含む追加情報。

#### 2. Jaeger Propagator

- **概要**: Jaeger が用いるカスタムプロパゲーションフォーマットで、Jaeger トレースシステム用に最適化されている。
- **HTTP ヘッダー**:
  - `uber-trace-id`: トレース ID、スパン ID、親スパン ID、およびサンプルフラグの 4 つの値を含む単一のヘッダー。

#### 3. B3 Propagator

- **概要**: B3 は、Twitter が開発した Zipkin トレースシステム用のプロパゲーションフォーマット。
- **HTTP ヘッダー**:
  - `X-B3-TraceId`: トレース ID。
  - `X-B3-SpanId`: スパン ID。
  - `X-B3-ParentSpanId`: 親スパン ID。
  - `X-B3-Sampled`: サンプルフラグ。

### Go 言語でのプロパゲーター設定例

以下は、Go 言語における OpenTelemetry のプロパゲーター設定の一例です：

```go
import (
    "go.opentelemetry.io/otel"
    "go.opentelemetry.io/otel/propagation"
    "go.opentelemetry.io/otel/trace"
    "go.opentelemetry.io/otel/exporters/stdout"
    sdktrace "go.opentelemetry.io/otel/sdk/trace"
)

func initTracer() {
    // Create and configure a stdout exporter
    exporter, _ := stdout.NewExporter(stdout.WithPrettyPrint())

    // Create a simple span processor
    bsp := sdktrace.NewSimpleSpanProcessor(exporter)

    // Create a trace provider
    tp := sdktrace.NewTracerProvider(sdktrace.WithSpanProcessor(bsp))

    // Configure the global trace provider
    otel.SetTracerProvider(tp)

    // Configure the global propagator to use W3C TraceContext
    otel.SetTextMapPropagator(propagation.TraceContext{})
}

func main() {
    initTracer()

    // Use your tracer
    tracer := otel.Tracer("example")
    ctx, span := tracer.Start(context.Background(), "example-operation")
    defer span.End()
}
```

## Go のコード

- [opentelemetry-go](https://github.com/open-telemetry/opentelemetry-go)
- [opentelemetry-go-contrib](https://github.com/open-telemetry/opentelemetry-go-contrib)
  - [propagators](https://github.com/open-telemetry/opentelemetry-go-contrib/tree/main/propagators)
- [opentelemetry-collector-contrib](https://github.com/open-telemetry/opentelemetry-collector-contrib)
  - [OpenTelemetry to Jaeger Transformation](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/pkg/translator/jaeger/README.md)
