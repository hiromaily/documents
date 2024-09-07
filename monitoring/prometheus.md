# Prometheus

Prometheusはオープンソースのモニタリングおよびアラートシステムで、特にクラウドネイティブ環境やマイクロサービスアーキテクチャにおけるメトリクス収集に強力なツール。CNCF (Cloud Native Computing Foundation) によってホストされており、高度なスケーラビリティと自動化されたモニタリング機能を提供する。

## 主な特徴

### データモデル

- タイムシリーズデータモデリングを使用し、各データポイントはタイムスタンプとデータ値、および一連のラベル（タグ）からなる。
- ラベルはデータポイントのメタデータを提供し、効率的なフィルタリングと集計が可能。

### スクラッピング (Pull モデル)

- インテグレーションのための簡素化されたメカニズムを提供する。
- サーバが定期的にターゲットエンドポイントからメトリクスデータをプルする方式。

### クライアントライブラリ

- 多種多様なプログラミング言語（Go、Java、Python、Rubyなど）に対応しており、独自のアプリケーションメトリクスを収集するためのライブラリを提供。

### 高可用性とスケーラビリティ

- シャーディングとフェデレーションによって大規模環境でのスケーリングが容易。
- 複数のPrometheusサーバをフェデレーションにより統合し、一元的に管理・クエリ可能。

## 主なコンポーネント

### 1. **Prometheusサーバ**

Prometheusサーバは、メトリクスデータを収集・保存し、クエリを実行してそのデータを分析する中心的なコンポーネント。サーバ自体がタイムシリーズデータベースを内蔵しており、指定されたインターバルでエンドポイントからデータをプルする。

### 2. **Exporter**

Exporterは、特定のアプリケーションやインフラのメトリクスデータを収集し、Prometheusが読み取れる形式でエクスポートする。例えば、Node ExporterはLinuxサーバのシステムメトリクスを収集し、Prometheusに提供する。

### 3. **Alertmanager**

Alertmanagerは、Prometheusから送信されたアラートを処理するコンポーネント。アラートのルーティング、抑制、グルーピングを行い、メールやチャットツールなどを通じて通知を送る。

### 4. **Pushgateway**

Pushgatewayは、ショートリビングジョブ（短期間で動作するジョブ）のメトリクスデータを一時的に保存し、Prometheusが収集できるようにする。例えば、バッチジョブやCI/CDパイプラインからのメトリクスをプッシュする。

### 5. **PromQL**

PromQL（Prometheus Query Language）は、収集したメトリクスデータに対してクエリを実行するためのドメイン固有言語。メトリクスの計算、フィルタリング、集計を行い、複雑なクエリを作成できる。

## クラウド上での利用ケース

### AWS

- **Amazon Managed Service for Prometheus**: フルマネージドプロメテウスサービスで、Prometheusの設定やスケーリングの手間を省く。
- **EC2やECSのExporter**: EC2インスタンスやECSサービスのメトリクスを収集するためのExporterが提供されている。

### GCP

- **Google Cloud Managed Service for Prometheus**: GCPのフルマネージドプロメテウスサービスで、スケーリングや高可用性の管理が簡素化。
- **GKEとの統合**: GKEクラスター内のリソースをマネージメントし、Prometheusを導入してクラスタ全体のメトリクスを収集。

### Azure

- **Azure Monitorとの連携**: Azure MonitorのメトリクスデータをPrometheusフォーマットで収集。
- **AKSでのデプロイ**: Azure Kubernetes Service (AKS) でkube-prometheusやPrometheus Operatorを使って簡単にPrometheusスタックをデプロイ。

### Kubernetesとの統合

- **kube-prometheus**: Kubernetesのモニタリングスタック（Prometheus、Alertmanager、Grafana、いくつかのExporterを含む）をデプロイするための統合パッケージ。
- **Prometheus Operator**: Kubernetes上でPrometheusインスタンスを簡単にデプロイ・管理するためのツール。Custom Resource Definitions (CRDs) を使ってPrometheus設定をネイティブに管理。

## References

- [Docs](https://prometheus.io/docs/introduction/overview/)
