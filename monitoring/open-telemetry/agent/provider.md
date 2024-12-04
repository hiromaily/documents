# Provider

OpenTelemetetryには複数の`Provider`が定義されている。これにExporterや様々な設定を行い、Applicationで利用する。

## [SDK Provider](https://github.com/open-telemetry/opentelemetry-go/tree/main/sdk)

```go

import (
    "context"

    "go.opentelemetry.io/otel"
    "go.opentelemetry.io/otel/propagation"
    "go.opentelemetry.io/otel/sdk/resource"
    sdktrace "go.opentelemetry.io/otel/sdk/trace"
    semconv "go.opentelemetry.io/otel/semconv/v1.27.0"
    oteltrace "go.opentelemetry.io/otel/trace"
)

func tracerProvider(traceExporter sdktrace.SpanExporter, serviceName, version string) *sdktrace.TracerProvider {
    return sdktrace.NewTracerProvider(
        sdktrace.WithSampler(sdktrace.AlwaysSample()), // sampling設定
        sdktrace.WithBatcher(traceExporter),
        sdktrace.WithResource(resource.NewWithAttributes(
            semconv.SchemaURL,
            semconv.ServiceNameKey.String(serviceName),
            semconv.ServiceVersionKey.String(version)),
        ),
    )
}
```

### SDK Provider Option

- WithSyncer()
  - `SimpleSpanProcessor` によってexporterを登録するもので、production環境では非推奨とのこと
- WithBatcher()
  - `BatchSpanProcessor` によってexporterを登録する
- WithSpanProcessor()
  - `TracerProvider`と一緒に`SpanProcessor`を登録する。WithBatcher,WithSyncerも内部で`WithSpanProcessor`を使っている
- WithResource()
  - resourceを設定する
- WithIDGenerator()
- WithSampler()
- WithSpanLimits()
- WithRawSpanLimits()

## [Trace Noop](https://github.com/open-telemetry/opentelemetry-go/tree/main/trace/noop)について

実装時に機能をOffにしたい場合に使うためのもので、Exporterは存在しない。

```go
import (
    "context"

    oteltrace "go.opentelemetry.io/otel/trace"
    "go.opentelemetry.io/otel/trace/noop"
)

type NoopProvider struct {
    tp     *noop.TracerProvider
    tracer oteltrace.Tracer
}

func NewNoopProvider() *NoopProvider {
    tp := noop.NewTracerProvider()
    return &NoopProvider{
        tp:     &tp,
        tracer: tp.Tracer("noop"),
    }
}

func (n *NoopProvider) NewSpan(ctx context.Context, name string) (context.Context, oteltrace.Span) {
    return n.tracer.Start(ctx, name)
}

// Note: batchが終了する直前に呼び出すこと
func (n *NoopProvider) Close() error {
    return nil
}
```
