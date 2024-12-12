# DatadogのTracingについて

Datadogを使う場合、様々なアーキテクチャーが存在し、それぞれテレメトリデータの送信手法が異なるため、どのアーキテクチャを採用するか、最初に決定せねばならない。

## アーキテクチャ

1. OTel Collector でデータを収集し、Datadog に送信
2. Datadog Agent でデータを収集し、Datadog に送信

![Datadog Architecture](https://github.com/hiromaily/documents/raw/main/images/datadog-open-telemetry-architecture.png "Hexagonal Architecture")

## [DatadogのExporter](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/exporter/datadogexporter/README.md) について

`The Datadog Exporter now skips APM stats computation by default. It is recommended to only use the Datadog Connector in order to compute APM stats.`とある。[Datadog Connector](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/connector/datadogconnector)

## [Datadog Agentについて](https://docs.datadoghq.com/agent/?tab=Linux)

Datadog Agent は、ホスト上で実行されるソフトウェアで、ホストからイベントとメトリックを収集し、それらを Datadog に送信する。よって、監視対象とするホストやサーバーにAgentをインストールする必要がある。

### [github: DataDog/dd-trace-go](https://github.com/DataDog/dd-trace-go)

go製のclientパッケージ。内部的に環境変数の`DD_TRACE_AGENT_URL`が利用されている。

```go
func AgentURLFromEnv() *url.URL {
    if agentURL := os.Getenv("DD_TRACE_AGENT_URL"); agentURL != "" {
        u, err := url.Parse(agentURL)
        if err != nil {
            log.Warn("Failed to parse DD_TRACE_AGENT_URL: %v", err)
        } else {
            switch u.Scheme {
            case "unix", "http", "https":
                return u
            default:
                log.Warn("Unsupported protocol %q in Agent URL %q. Must be one of: http, https, unix.", u.Scheme, agentURL)
            }
        }
    }
  ...
}
```

### LambdaからDatadog Agentを利用する

- [AWS Lambda](https://docs.datadoghq.com/integrations/amazon_lambda/)
- [Datadog Lambda Extension](https://docs.datadoghq.com/serverless/libraries_integrations/extension/)
- [Instrumenting Go Serverless Applications](https://docs.datadoghq.com/serverless/aws_lambda/installation/go/?tab=serverlessframework)
- [github: DataDog/datadog-lambda-go](https://github.com/DataDog/datadog-lambda-go)

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
    - これはDatadogのAgentにあたる。2024/12時点で。v2が`rc.1`
- [Tracing Go Applications](https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/go/)
  - あまり参考にならなそう

## References

- [Datadog って OpenTelemetry に対応しているの？](https://qiita.com/AoTo0330/items/b9a758555b7e049eca9f)
