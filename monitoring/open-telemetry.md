# OpenTelemetry

OpenTelemetryは、分散トレーシング、メトリクス、ログの収集とエクスポートを標準化するためのオープンソースのツールキットだ。CNCF（Cloud Native Computing Foundation）のプロジェクトであり、Observabilityの標準化に取り組んでいる。サービスメッシュやマイクロサービスアーキテクチャの普及により、システム全体の監視とトラブルシューティングが困難になっているが、OpenTelemetryを使うことでこれを一元的に管理できる。

また、異なるプログラミング言語、フレームワーク、環境で動作する統一された観測可能性ソリューションを提供するように設計されている。開発者が共通の API セットを使ってコードを計測することを可能にし、遠隔計測バックエンドの選択に柔軟性を提供する。OpenTelemetry は、ベンダーにとらわれないことを目指し、異なる遠隔測定バックエンドを選択し、それらの間を簡単に移動できるようにする。テレメトリーデータの標準フォーマットを推進し、異なるシステムやツール間の互換性と相互運用性を可能にする。

## 機能

### 分散トレーシング

異なるサービス間でのリクエストの流れを追跡し、性能ボトルネックや問題の特定が容易になる。

- サービス間のリクエストの流れを可視化し、問題の発生箇所を特定。
- レイテンシーやエラー率をサービス単位で分析。

### メトリクス収集

CPU使用率やリクエスト数、エラーレートなどのパフォーマンスデータを収集・分析できる。

- システム資源の利用状況（CPU、メモリ、I/Oなど）をモニタリング。
- アプリケーションのパフォーマンスメトリクス（リクエスト数、エラーレートなど）を収集し、トレンド分析やアラート設定が可能。

### ログ収集

アプリケーションやシステムのログを統一的な形式で収集し、他のデータと統合して分析できる。

- 各サービスのログデータを収集し、一元的に管理。
- トレースデータとログデータを統合し、深いトラブルシューティングを実現。

## 主要コンポーネント

### API

トレースやメトリクスの収集を行うための標準的なインターフェースを提供する。

### SDK

各プラットフォーム向けの具体的な実装を提供し、トレース、メトリクス、ログを収集・処理する。

### エージェント

各マイクロサービスやコンテナ内で動作し、トレースやメトリクスを収集・エクスポートする。

### Collector

トレース、メトリクス、ログを集約し、他のObservabilityサービスへエクスポートするための集積ポイントとして機能する。

## OpenTelemetry と OpenTracing 比較

- OpenTelemetry と OpenTracing は共通の祖先を持ち、`OpenTelemetry は OpenTracing と OpenCensus の合併の結果`
- OpenTelemetry は、テレメトリー計測と収集のための単一の標準化されたソリューションを提供するために、両プロジェクトの最良の機能を組み合わせることを目的とする
- OpenTracing が分散トレースにフォーカスしている
- OpenTelemetry はメトリックスやロギングといった観測性の他の側面を含むように範囲を広げている
- OpenTelemetry は、より広範な観測可能性という点では OpenTracing に取って代わられていますが、OpenTracing の原則と仕様は依然として価値があり、OpenTelemetry の開発に影響を与えている
- OpenTelemetry は、すでに OpenTracing を使用しているプロジェクトがスムーズに移行できるように、後方互換性を念頭に設計されている
- `OpenTracing は現在非推奨`

## Frontend での OpenTelemetry 対応

- [フロントエンドで収集するべきテレメトリは何か](https://zenn.dev/kimitsu/articles/frontend-and-telemetry)
  - 2024 時点で、`ブラウザ JS で OpenTelemetry を利用するのは避け、監視 SaaS ベンダーの SDK を利用した方が良い`としている
- [Datadog の OpenTelemetry](https://docs.datadoghq.com/ja/opentelemetry/)

## Cloud上で利用できるOpenTelemetry

### AWSでの利用

- **AWS X-Ray**: OpenTelemetryから収集されたトレースデータをAWS X-Rayにエクスポートし、可視化と分析を行う。
- **Amazon CloudWatch**: メトリクスデータをCloudWatchに送信し、アラートやダッシュボードを作成。

### Google Cloud Platform (GCP)での利用

- **Google Cloud Trace、Cloud Monitoring**: トレースデータをGoogle Cloud Traceに、メトリクスデータをCloud Monitoringに送信して分析・可視化。
- **Google Cloud Logging**: ログデータを統合管理。

### Microsoft Azureでの利用

- **Azure Monitor**: トレース、メトリクス、ログをAzure Monitorにエクスポートし、包括的な監視と分析を実現。

### Kubernetes環境での利用

- **JaegerやZipkinと統合**: OpenTelemetryから収集されたトレースデータをJaegerやZipkinにエクスポートして可視化。
- **Prometheusと統合**: メトリクスデータをPrometheusにエクスポートし、Grafanaで可視化。
- **FluentdやFluent Bitと統合**: ログデータを収集し、Elasticsearchや他のログ管理システムに送信。
