# Monitoring
バックエンドの監視システムを設計するには、いくつかの手順が必要となる
全体として、バックエンドの監視システムを設計するには、適切なツールを選択し、エージェントとアラートを構成し、データを分析してパフォーマンスの問題を特定し、システムの信頼性を向上させる必要がある

## 手順

### 1. 監視対象を特定する
- 監視システムを設計する前に、監視対象を特定する必要がある
- これには、CPU 使用率、メモリ使用率、ディスク容量、ネットワーク トラフィック、応答時間などのメトリックが含まれる
- システムに関連する特定のアプリケーション メトリックを監視することもできる

### 2. 監視ツールを選択する
- バックエンド システムの監視に役立つ、オープン ソースと商用の両方の監視ツールが多数存在する
- 一般的な監視ツールには、`Prometheus`、`Grafana`、`Nagios`、`Zabbix`、`Datadog` など

### 3. 監視エージェントをセットアップ
- 監視エージェントは、サーバー上で実行され、システム パフォーマンスに関するデータを収集するソフトウェア コンポーネント
- すべてのサーバーに監視エージェントをセットアップして、CPU 使用率、メモリ使用率、ディスク容量、ネットワーク トラフィック、およびその他のメトリックに関するデータを収集できる

### 4. アラートの構成
- 監視エージェントをセットアップしたら、アラートを構成する必要がある
- CPU 使用率が高い場合やディスク容量が少ない場合など、特定のしきい値に達したときに通知するようにアラートを構成できる
- 電子メール、SMS、またはその他の通知チャネルを介してアラートを送信するように構成できる

### 5. データの視覚化と分析
- 監視ツールを使用して、収集されたデータを視覚化および分析できる
- これは、傾向と異常を特定し、システム パフォーマンスに関する洞察を得るのに役立つ

### 6. 継続的な改善
- 監視は継続的なプロセスであり、監視システムを継続的に見直して改善する必要がある
- これには、新しいメトリックの追加、アラートのしきい値の微調整、視覚化および分析ツールの改善が含まれる場合がある

## APM (Application Performance Management)
アプリケーションやシステムの性能を管理・監視するサービス

It's important to evaluate each tool based on your specific requirements and the nature of your application environment before making a decision.


- New Relic
  - It is a cloud-based APM tool that helps to monitor application performance in real-time.
- Dynatrace
  - It provides AI-powered observability for cloud-native environments, containerized applications, and microservices.

- AppDynamics
  - It is an APM tool that provides end-to-end visibility into the performance of applications, infrastructure, and user experience.

- Datadog
  - It is a cloud-based monitoring tool that provides real-time visibility into the performance of applications, infrastructure, and logs.
- SolarWinds
  - It provides APM solutions for applications, servers, and databases, and also includes infrastructure monitoring capabilities.

- Splunk
  - It is a popular data analytics tool that can be used for APM, providing insights into application performance, user experience, and infrastructure.

## 分散Tracing
- Jaeger
  - https://www.jaegertracing.io/
- Zipkin
  - Zipkin is an open-source distributed tracing system that was originally developed by Twitter. It is similar to Jaeger in terms of functionality and provides support for several programming languages, including Java, Python, and Ruby.
- OpenTracing
  - OpenTracing is a vendor-neutral, open standard for distributed tracing that provides a consistent API for instrumenting applications. It is not a tracing system itself but can be used to integrate tracing into applications and connect them to different tracing backends, including Jaeger and Zipkin.
- LightStep
  - LightStep is a distributed tracing system that provides real-time visibility into the performance of microservices-based applications. It supports various programming languages, including Java, Python, and Ruby, and provides advanced features such as anomaly detection and performance regression analysis.
- AppDynamics
  - AppDynamics is an application performance monitoring (APM) tool that provides distributed tracing functionality. It supports various programming languages, including Java, .NET, and Node.js, and provides advanced features such as code-level visibility and automatic anomaly detection.
- Datadog
  - Datadog is a monitoring and analytics platform that provides distributed tracing functionality. It supports various programming languages, including Java, Python, and Ruby, and provides advanced features such as correlated traces and cross-service analytics.

## Prometheus

- [Docs](https://prometheus.io/docs/introduction/overview/)
