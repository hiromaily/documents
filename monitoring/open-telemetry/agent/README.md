# Open Telemetry Agent (Exporter)

各マイクロサービスやコンテナ内で動作し、トレースやメトリクスを収集し、収集したトレース、メトリクス、およびログデータを外部のシステムやバックエンドに送信する役割を担うコンポーネントであり、Application 側に組み込むものとなる。

[Docs: Exporters](https://opentelemetry.io/docs/languages/go/exporters/)

## [Exporter の種類 (opentelemetry-go内)](https://github.com/open-telemetry/opentelemetry-go/tree/main/exporters)

- Stdout (console)
  - Debug や UT などに便利
- OTLP
  - Jaeger など
- Prometheus (Experimental) プロメテウス
- Zipkin

## [3rd PartyのExporter (opentelemetry-collector-contrib内)](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/exporter)

- [Datadog](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/exporter/datadogexporter)
- [AWS X-Ray](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/exporter/awsxrayexporter)
- [AWS Cloud Watch Logs](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/exporter/awscloudwatchlogsexporter)
- [GCP](https://github.com/GoogleCloudPlatform/opentelemetry-operations-go)

## OTLP について

OTLP（OpenTelemetry Protocol）は、OpenTelemetry プロジェクトによって定義された通信プロトコルで、トレース、メトリクス、およびログデータを様々なバックエンドに送信するための標準的な方法を提供する。OTLP は`HTTP/JSON`や`gRPC形式`でデータを送信でき、効率的なデータ転送とシリアライズをサポートしている。

## Go のコード

- [opentelemetry-go](https://github.com/open-telemetry/opentelemetry-go)
- [opentelemetry-go-contrib](https://github.com/open-telemetry/opentelemetry-go-contrib)
  - [propagators](https://github.com/open-telemetry/opentelemetry-go-contrib/tree/main/propagators)
- [opentelemetry-collector-contrib](https://github.com/open-telemetry/opentelemetry-collector-contrib)
  - [OpenTelemetry to Jaeger Transformation](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/pkg/translator/jaeger/README.md)
