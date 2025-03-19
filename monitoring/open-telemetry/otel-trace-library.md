# `go.opentelemetry.io/otel/trace`

## Tracer

```go
type Tracer interface {
    // Users of the interface can ignore this. This embedded type is only used
    // by implementations of this interface. See the "API Implementations"
    // section of the package documentation for more information.
    embedded.Tracer

    // Start creates a span and a context.Context containing the newly-created span.
    //
    // If the context.Context provided in `ctx` contains a Span then the newly-created
    // Span will be a child of that span, otherwise it will be a root span. This behavior
    // can be overridden by providing `WithNewRoot()` as a SpanOption, causing the
    // newly-created Span to be a root span even if `ctx` contains a Span.
    //
    // When creating a Span it is recommended to provide all known span attributes using
    // the `WithAttributes()` SpanOption as samplers will only have access to the
    // attributes provided when a Span is created.
    //
    // Any Span that is created MUST also be ended. This is the responsibility of the user.
    // Implementations of this API may leak memory or other resources if Spans are not ended.
    Start(ctx context.Context, spanName string, opts ...SpanStartOption) (context.Context, Span)
}
```

### SpanStartOption

- WithLinks(links ...Link)
- WithNewRoot()
- WithSpanKind(kind SpanKind)
