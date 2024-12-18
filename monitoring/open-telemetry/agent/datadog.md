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

### Datadog Agentの役割

1. **システム情報の収集**:
   - Datadog Agentは、システムのメトリクスやログを収集し、Datadogのバックエンドに送信する。これには、CPU使用率、メモリ使用率、ディスク使用率などの情報が含まれる。

2. **インフラストラクチャーの監視**:
   - Agentはインフラストラクチャーの監視データを収集し、Datadogで可視化と分析を可能にする。

3. **トレース情報の収集と処理**:
   - Trace Agentはトレースの監視情報を扱う。アプリケーションから生成されるトレースデータを収集、処理し、Datadogバックエンドに送信する。

4. **プロセスとコンテナの監視**:
   - Process Agentはライブプロセスやコンテナモニタリングのための監視データを収集し、処理して送信する。

5. **ログの収集と管理**:
   - Datadogでは、複数のログリソースから収集されたログを一元的に管理できる。ログのフィルタリング、タグ付け、メトリクスの表示などが可能。

6. **セキュリティ情報の収集**:
   - Security Agentはセキュリティ情報を収集し、Datadogでセキュリティに関する監視と分析を可能にする。

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

### LambdaからDatadog を利用する

1. `DatadogのAgentを利用する`パターンと、2. `OTEL Collectorを利用するパターン`があるが、Tracingのみであれば、後者で良いはず。

#### 1. `DatadogのAgentを利用する`

- AWS Lambda関数にDatadog Lambda Layerを追加する
  - [Datadog-Extension](https://docs.datadoghq.com/serverless/libraries_integrations/extension/)レイヤーのARNを追加する
- Lambda上で動作するアプリケーション側に環境変数を設定

```env
DD_API_KEY=<YOUR_DATADOG_API_KEY>
DD_SITE=datadoghq.com
```

##### [Datadog Lambda Extenstionについて](https://docs.datadoghq.com/serverless/libraries_integrations/extension/)

Datadog Lambda Extension は、AWS Lambda 関数のメトリクス収集、トレース、ログの収集を簡単に行うための拡張機能。Datadog は総合的な監視およびセキュリティプラットフォームであり、この拡張機能を使用することで、サーバーレスアプリケーションのパフォーマンスと信頼性をリアルタイムでモニタリングできるようになる。

1. **メトリクス収集**：Lambda 関数の実行に関する詳細なメトリクス（例：実行時間、エラー率、コールドスタートの頻度など）を収集し、Datadog に送信できり。
2. **トレース**：分散トレースを有効にすることで、エンドツーエンドの要求を追跡し、パフォーマンスボトルネックや障害点を特定できる。
3. **ログ収集**：Lambda 関数のログを Datadog に自動的に送信し、集中管理および分析が可能。

#### 2. `OTEL Collectorを利用するパターン`

[Lambda Collector Configuration](https://opentelemetry.io/docs/faas/lambda-collector/)

- LambdaにCollector Lambdaレイヤーを追加して設定する
- OTel Collector LambdaレイヤーのARNを追加する (Amazon Resource Name)
  - [opentelemetry-lambda](https://github.com/open-telemetry/opentelemetry-lambda)

#### Datadog with AWS Lambda References

- [AWS Lambda](https://docs.datadoghq.com/integrations/amazon_lambda/)
- [Datadog Lambda Extension](https://docs.datadoghq.com/serverless/libraries_integrations/extension/)
- [Instrumenting Go Serverless Applications](https://docs.datadoghq.com/serverless/aws_lambda/installation/go/?tab=serverlessframework)
- [github: DataDog/datadog-lambda-go](https://github.com/DataDog/datadog-lambda-go)
- [datadogのserverlessのgo sample code](https://github.com/DataDog/serverless-sample-app/tree/main/src/go)

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
