# DatadogのTracingについて

Datadogを使う場合、様々なアーキテクチャーが存在し、それぞれテレメトリデータの送信手法が異なるため、どのアーキテクチャを採用するか、最初に決定せねばならない。

## アーキテクチャ

1. OTel Collector でデータを収集し、Datadog に送信
2. Datadog Agent でデータを収集し、Datadog に送信

## [DatadogのExporter](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/exporter/datadogexporter/README.md) について

`The Datadog Exporter now skips APM stats computation by default. It is recommended to only use the Datadog Connector in order to compute APM stats.`とある。[Datadog Connector](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/connector/datadogconnector)

## Datadog Docs

### OpenTelemetry

- [OpenTelemetry in Datadog](https://docs.datadoghq.com/opentelemetry/)
- [Interoperability with Datadog and OpenTelemetry](https://docs.datadoghq.com/opentelemetry/interoperability/)
- [OpenTelemetry Collector and Datadog Exporter](https://docs.datadoghq.com/opentelemetry/collector_exporter/)

### APM

- [Go Custom Instrumentation using the OpenTelemetry API](https://docs.datadoghq.com/tracing/trace_collection/custom_instrumentation/go/otel/)
  - 一番実装されたコードがありわかりやすい
  - [datadogのopentelemetryパッケージ](https://pkg.go.dev/gopkg.in/DataDog/dd-trace-go.v1/ddtrace/opentelemetry)
  - [github: dd-race-go](https://github.com/DataDog/dd-trace-go)
    - これはDatadogのAgentにあたる。2024/12時点で。v2がrc.1
- [Tracing Go Applications](https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/go/)
  - あまり参考にならなそう

## References

- [Datadog って OpenTelemetry に対応しているの？](https://qiita.com/AoTo0330/items/b9a758555b7e049eca9f)
