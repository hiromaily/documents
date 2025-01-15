# [Datadog Agentについて](https://docs.datadoghq.com/agent/?tab=Linux)

Datadog Agent は、ホスト上で実行されるソフトウェアで、ホストからイベントとメトリックを収集し、それらを Datadog に送信する。よって、監視対象とするホストやサーバーにAgentをインストールする必要がある。

## Datadog Agentの役割

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

- [2023: Datadog って OpenTelemetry に対応しているの？](https://qiita.com/AoTo0330/items/b9a758555b7e049eca9f)
  - コード例はないが、かなりよくまとまっている
