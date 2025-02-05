# [OpenMetrics](https://openmetrics.io/)

メトリクス収集に特化したソリューションが必要な場合はOpenMetricsが適しており、トレーシング、メトリクス、ログの全体を一元管理する必要がある場合はOpenTelemetryが適している。

## OpenMetricsとOpenTelemetryの違い

OpenMetricsとOpenTelemetryは、双方とも観測性（observability）を高めるための標準やツールセットを提供するが、具体的な機能と目的が異なる。

1. **フォーカス領域**：
   - OpenMetricsは主にメトリクスの収集とエクスポートに焦点を当てている。
   - OpenTelemetryは、メトリクスだけでなく、分散トレーシングやログの収集にも対応し、観測性データ全体をカバーする。

2. **標準化の範囲**：
   - OpenMetricsはメトリクスデータのフォーマットと収集方法の標準化に特化している。
   - OpenTelemetryは観測性データの統一収集とエクスポートを目指しており、広範なエコシステムを提供する。

3. **ツールチェーンのサポート**：
   - OpenMetricsは特定のフォーマットに基づいているため、主に`Prometheus`のエコシステムに最適化されているが、他のツールとも互換性を持っている。
   - OpenTelemetryは多様なバックエンドをサポートするために設計されており、広範なアプリケーションやサービスに適用できる。

## OpenMetricsについて

OpenMetricsは、メトリクス（metrics）の収集とエクスポートに焦点を当てたオープンスタンダード。特に、Prometheusというモニタリングツールで使用されるメトリクスフォーマットの標準化を目指している。OpenMetricsは、以下の特徴がある：

1. **標準化フォーマット**：メトリクスデータをエクスポートするための標準的なフォーマットを提供し、異なるツール間での互換性を高めます。
2. **効率的なデータ転送**：テキストフォーマットでメトリクスを送信し、HTTPによるデータ収集をサポートします。
3. **多様なサポート**：多くの観測性ツールやモニタリングツールでサポートされており、プロメテウスを主体としつつも広範なツールチェーンと互換性があります。

## OpenTelemetryについて

OpenTelemetryは、オープンソースの観測性フレームワークであり、分散トレーシング、メトリクス、およびログの収集を一元化して行うことを目指している。主要な特徴は次の通り：

1. **統一的な収集**：分散トレーシングとメトリクスの収集を一つのフレームワークで統合して提供する。
2. **拡張性とモジュール性**：さまざまなプラグインやエクスポートオプションを持ち、異なるバックエンドシステム（例えばPrometheus、Jaeger、Elasticsearchなど）へデータを送信できる。
3. **広範なサポート**：豊富なSDKとエージェントを提供し、多様なプログラミング言語およびプラットフォームで利用可能。

## 別のまとめ

OpenMetrics は、システムおよびアプリケーションからメトリック データを収集および送信するためのオープンスタンダードで、システム パフォーマンスを視覚化および分析するために監視および分析ツールで使用できる`メトリック データの統一された形式`を提供する

元々`Prometheus`が利用しているフォーマットで、Prometheus は`Promethues exporter`と呼ばれる監視対象からメトリクスを集約する作りになっている。
Prometheus exporter は実は`単なるHTTPのエンドポイント`であり、そのレスポンスが独自のテキストフォーマットになっている。このフォーマットを標準化しようとして提唱されているのが`OpenMetrics`となる

Prometheus は高度にスケーラブルになるように設計されており、システムとアプリケーションをリアルタイムで監視できる。

OpenMetrics の主な利点は、複数のプラットフォームやアプリケーションで使用できるメトリック データの共通言語を提供することで、これにより、異なるツールやシステム間でのメトリック データの共有が容易になり、新しい監視ツールを既存のインフラストラクチャに統合するプロセスが簡素化される

OpenMetrics は柔軟性も高く、ユーザーは独自のメトリックとデータ構造を定義できる
これは、単純な Web サーバーから複雑な分散システムまで、幅広いシステムやアプリケーションの監視に使用できることを意味する

全体として、OpenMetrics はシステム パフォーマンスを監視および分析するための重要な標準
