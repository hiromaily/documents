# Datadog Tracingに伴うアーキテクチャ

Datadogを使う場合、様々なアーキテクチャーが存在し、それぞれテレメトリデータの送信手法が異なるため、どのアーキテクチャを採用するか、最初に決定せねばならない。

## アーキテクチャ

1. OTel Collector でデータを収集し、Datadog に送信
2. Datadog Agent でデータを収集し、Datadog に送信

![Datadog Architecture](https://github.com/hiromaily/documents/raw/main/images/datadog-open-telemetry-architecture.png "Hexagonal Architecture")
