# Open Tracing / OpenTelemetry

## Open Tracing

OpenTracing は、ベンダーに依存しない分散トレースのオープン スタンダードであり、インストルメンテーション用の一貫した API と、分散システム内のコンポーネント間でコンテキスト情報を表現および伝達するための標準化された方法を提供する

### OpenTracing のアプローチ

- 計測ライブラリ
  - OpenTracing は、Java、Python、Node.js、Ruby、Go などの一般的なプログラミング言語およびフレームワーク用の計測ライブラリをいくつか提供している
- サービス メッシュの統合
  - サービス メッシュは、トラフィック管理、サービス検出、セキュリティ、可観測性などの一連の機能をマイクロサービス ベースのアプリケーションに提供するインフラストラクチャ レイヤー
  - `Istio`、`Linkerd`、`Consul` などの多くのサービス メッシュ実装は、OpenTracing API を使用した分散トレースの組み込みサポートを提供する
- 手動計測
  - 計測ライブラリまたはサービス メッシュ統合が利用できない場合、開発者は OpenTracing API を使用してコードを手動で計測できる
  - これには、システム内の各コンポーネントにトレース コードを追加する必要があり、時間がかかり、エラーが発生しやすくなりますが、トレース プロセスをよりきめ細かく制御できる
- OpenTracing 互換ツール
  - OpenTracing には、分散トレーシング バックエンド、ログ アグリゲーター、パフォーマンス監視ソリューションなど、OpenTracing API と互換性のあるツールと統合の大規模なエコシステムがある
  - これらのツールを使用すると、開発者はアプリケーションから収集したトレース データを視覚化および分析できるため、パフォーマンスのボトルネックやその他の問題を特定するのに役立つ

### OpenTracing 互換 log アグリゲーター

- Elastic Stack
  - 以前は ELK スタックと呼ばれていた Elastic Stack は、ログ データのリアルタイム検索、分析、および視覚化機能を提供する、人気のあるオープン ソース ログ管理プラットフォーム
  - Elastic Stack には、分散システムからトレース データを収集して関連付ける `APM (アプリケーション パフォーマンス モニタリング)`モジュールによる OpenTracing のサポートが組み込まれている
- Grafana Loki
  - Grafana Loki は、Prometheus に触発された、水平方向にスケーラブルなマルチテナント ログ集約システム
  - Loki を使用すると、開発者は Kubernetes や Docker コンテナーなど、さまざまなソースからログ データを保存、インデックス作成、検索できる
  - Loki は、トレース機能を通じて OpenTracing をサポートしています。これにより、開発者はリクエストをトレースし、Loki ダッシュボードでトレースを視覚化できます。
- Jaeger
  - Jaeger は、マイクロサービス ベースのアプリケーションにエンド ツー エンドのトランザクション監視を提供する、人気のあるオープン ソースの分散トレース システム
  - Jaeger は OpenTracing をネイティブでサポートしているため、開発者はアプリケーションからトレース データを取得して分析できる
  - Jaeger は、Elasticsearch、Cassandra、Kafka など、複数のストレージ バックエンドをサポートしている
- Zipkin
  - Zipkin は、マイクロサービス ベースのアプリケーションにエンド ツー エンドのトレースとレイテンシ分析を提供する、もう 1 つの人気のあるオープンソースの分散トレース システム
  - Zipkin は、開発者がさまざまなプログラミング言語とフレームワークを使用してアプリケーションにトレースを追加できるようにする Zipkin Instrumentation ライブラリを通じて OpenTracing をサポートしている
  - Zipkin は、トレース データを視覚化および分析するための Web ベースの UI も提供する
- Splunk
  - Splunk は、組織が大量のマシン生成データを収集、インデックス付け、および分析できるようにする、広く使用されているログ集約および分析プラットフォーム
  - Splunk には、Splunk Observability Suite による OpenTracing の組み込みサポートがあり、マイクロサービス ベースのアーキテクチャに分散トレースおよび監視機能を提供する

### References

[Open Tracing](https://opentracing.io/)
[Go](https://github.com/opentracing/opentracing-go)

## OpenTelemetry

OpenTelemetry は、異なるプログラミング言語、フレームワーク、環境で動作する統一された観測可能性ソリューションを提供するように設計されている。開発者が共通の API セットを使ってコードを計測することを可能にし、遠隔計測バックエンドの選択に柔軟性を提供する。
OpenTelemetry は、ベンダーにとらわれないことを目指し、異なる遠隔測定バックエンドを選択し、それらの間を簡単に移動できるようにする。テレメトリーデータの標準フォーマットを推進し、異なるシステムやツール間の互換性と相互運用性を可能にする。

## OpenTelemetry と OpenTracing 比較

- OpenTelemetry と OpenTracing は共通の祖先を持ち、OpenTelemetry は OpenTracing と OpenCensus の合併の結果
- OpenTelemetry は、テレメトリー計測と収集のための単一の標準化されたソリューションを提供するために、両プロジェクトの最良の機能を組み合わせることを目的とする
- OpenTracing が分散トレースにフォーカスしている
- OpenTelemetry はメトリックスやロギングといった観測性の他の側面を含むように範囲を広げている
- OpenTelemetry は、より広範な観測可能性という点では OpenTracing に取って代わられていますが、OpenTracing の原則と仕様は依然として価値があり、OpenTelemetry の開発に影響を与えている
- OpenTelemetry は、すでに OpenTracing を使用しているプロジェクトがスムーズに移行できるように、後方互換性を念頭に設計されている
- OpenTracing は現在非推奨

## Frontend での OpenTelemetry 対応

- [フロントエンドで収集するべきテレメトリは何か](https://zenn.dev/kimitsu/articles/frontend-and-telemetry)
  - 2024 時点で、`ブラウザ JS で OpenTelemetry を利用するのは避け、監視 SaaS ベンダーの SDK を利用した方が良い`としている
- [Datadog の OpenTelemetry](https://docs.datadoghq.com/ja/opentelemetry/)
