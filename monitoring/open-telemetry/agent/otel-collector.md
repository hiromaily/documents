# Otel Collector

OpenTelemetry（Otel）は、分散トレーシング、メトリクス、ロギングなどのテレメトリデータを収集、処理、エクスポートするためのオープンソースプロジェクトであり、OpenTelemetry Collector（Otel Collector）は、このプロジェクトの中心的なコンポーネントの一つで、`テレメトリデータの収集と処理を行う役割`を持っている。

## Otel Collectorの主要なポイント

1. **分離されたコンポーネント:**
   - **Receiver（受信者）**: テレメトリデータを様々なソースから受信します。例えば、OpenTelemetryのSDK、Jaeger、Prometheusなどからデータを受け取ることができる。
   - **Processor（処理者）**: 受信したデータを処理する。データのフィルタリングやバッチ処理、エンハンスメント、データの変換などを行う。
   - **Exporter（エクスポーター）**: 処理されたデータを外部の観測・分析ツール（例えば、Jaeger、Prometheus、Elasticsearch、Grafana、Datadogなど）に送出する。

2. **拡張性とプラグイン性:**
   Otel Collectorはモジュラーアーキテクチャを採用しており、必要に応じてカスタムのReceiver、Processor、Exporterを追加することが容易。

3. **標準フォーマットのサポート:**
   Otel Collectorは、OpenTelemetry Protocol（OTLP）をはじめとする複数の標準プロトコルをサポートしている。これにより、多様な環境やツール間でのデータ連携が容易になる。

4. **デプロイメントの柔軟性:**
   - **エージェントモード**: 各アプリケーションサーバにデプロイして、それぞれのサーバからテレメトリデータを収集する。
   - **ゲートウェイモード**: 集中型にデプロイして、複数のアプリケーションサーバからのデータを一元的に処理する。

5. **設定の柔軟性:**
   Otel Collectorは、YAMLやJSON形式の設定ファイルを使用して、簡単に設定を変更・拡張できる。これにより、特定のニーズに合わせてCollectorの設定を調整することが可能。

### 実際の設定例

こちらは、基本的なOtel Collectorの設定ファイルの例。

```yaml
receivers:
  otlp:
    protocols:
      grpc:
      http:

processors:
  batch:
    timeout: 10s

exporters:
  logging:
    logLevel: debug
  otlp:
    endpoint: "exporter-endpoint:55680"

service:
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch]
      exporters: [logging, otlp]
    metrics:
      receivers: [otlp]
      processors: [batch]
      exporters: [logging, otlp]
```

この設定ファイルでは、gRPCおよびHTTPプロトコルを使用してOTLPデータを受信し、バッチ処理を行った後にログ出力とOTLPエクスポーターにデータを送信する。

## docker compose例

```yaml
services:
  otel-collector:
    image: otel/opentelemetry-collector:latest
    volumes:
      - ./config.yaml:/etc/otel/config.yaml
    command:
      - --config=/etc/otel/config.yaml
    ports:
      - "4317:4317"   # OTLP gRPC
      - "4318:4318"   # OTLP HTTP
      - "55680:55680" # Deprecated OTLP gRPC
```
