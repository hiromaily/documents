# Jaeger

Jaeger は、オープンソースの分散トレーシングシステムで、コンテナ化されたマイクロサービスアーキテクチャのトラブルシューティングやパフォーマンス監視に広く用いられている。主に Uber Technologies によって開発され、CNCF（Cloud Native Computing Foundation）のプロジェクトとして採用されている。
マイクロサービスアーキテクチャのトレースおよびパフォーマンス監視において強力なツール。適応的サンプリングや OpenTelemetry との統合、さまざまなストレージバックエンドのサポートなど、新しい機能が追加されることで、さらに柔軟かつ強力なソリューションとなっている。観測性の向上を目指す組織にとって欠かせないツールと言える。

Jaeger の`v1.42.0`より、一部`OpenTelemetry SDK`に機能統合されている

![jaeger](https://github.com/hiromaily/documents/raw/main/images/jaeger-screen-shot.png "jaeger")

## Jaeger の主要機能

1. **分散コンテキスト伝播**：

   - マイクロサービス間でのリクエストの流れをトレースし、リクエストがどのサービスを経由したかを可視化する。

2. **トランザクション監視**：

   - システム全体のパフォーマンスを監視し、ボトルネックや高レイテンシ・エリアを特定する。

3. **依存関係可視化**：

   - サービス間の依存関係をグラフィカルに表示し、全体のアーキテクチャ理解を助ける。

4. **エラー分析**：

   - リクエストチェーン内で発生したエラーを特定し、エラーが発生した正確な場所と状況を追跡する。

5. **リアルタイム監視**：
   - リアルタイムでトレースデータを収集し、現在のシステムの状態を即座に把握する。

## 最新の動向と機能追加

1. **Adaptive Sampling**（適応的サンプリング）：

   - Jaeger は大量のデータを処理できるように、サンプリング戦略を導入している。最近では、動的にトラフィックパターンに適応するサンプリング戦略が追加され、システムの負荷を軽減しつつ、重要なトレースデータを確保することができる。

2. **新しいストレージバックエンド**：

   - Jaeger は従来から`Elasticsearch`、`Cassandra`、`Kubernetes`などのバックエンドをサポートしているが、最新のバージョンでは、`Amazon DynamoDB`や`gRPCストリーム`など、さまざまなストレージシステムが導入されており、異なるニーズに応える柔軟性が向上している。

3. **OpenTelemetry の統合**：

   - Jaeger は`OpenTelemetry`と密接に連携しており、OpenTelemetry のエージェントや SDK を使用してデータを収集し、Jaeger バックエンドに送信する事が可能。これにより、観測性データの一元管理と無駄のない運用が実現する。

4. **セキュリティの強化**：

   - Jaeger は TLS（Transport Layer Security）を使用したデータ転送をサポートし、トレーシングデータのセキュリティを向上している。また、API へのアクセス制御や認証メカニズムも改善されている。

5. **フロントエンドの改良**：
   - ユーザーインターフェースが改善され、より直感的で使いやすいダッシュボードが提供されるようになっている。トレースデータのフィルタリングや検索機能も向上し、デバッグがより簡単になっている。

## Jaeger のアーキテクチャ構成

Jaeger は以下の主要コンポーネントで構成されている：

- **Agent**：軽量なデーモンで、アプリケーションからトレースデータを受け取り、Collector に転送する。
- **Collector**：Agent から受け取ったトレースデータを処理し、適切なストレージバックエンドに保存する。
- **Ingester**：ストリーム処理等をサポートするため、ストレージシステムから直接データを読み込むコンポーネント。
- **Query Service**：ユーザーインターフェースや API からのクエリを受け付け、必要なトレースデータを返す。
- **UI**：ウェブベースのユーザーインターフェースで、トレースの可視化や分析を行うツール。

## コンポーネント詳細

Jaeger のコンポーネントの中で、ユーザーはさまざまな部分を切り替えてカスタマイズすることが可能

### 1. ストレージ・バックエンド

Jaeger は複数のストレージ・バックエンドをサポートしており、デプロイメントの要件に最適なものを選択できる。具体的には以下のバックエンドがサポートされており、これらは容易に切り替えることができる：

- **Elasticsearch**：スケーラブルで高パフォーマンスな検索と分析が可能。
- **Cassandra**：高可用性とスケーラブルな NoSQL データベース。
- **Amazon DynamoDB**：AWS によって提供されるフルマネージドな NoSQL データベース。
- **Kafka**：大規模なデータストリーム処理と耐障害性を提供。
- **Badger**：軽量なローカルストレージエンジン（開発やテスト環境に適）。
- **gRPC ストリーム**：異なるバックエンドへのストリーム処理をサポート。

### 2. エージェント (Application側に実装するもの)

Jaeger エージェントは各アプリケーションサーバー上にデプロイされ、トレースデータを収集して Collector に転送する。エージェントには特定のプラットフォーム向けのカスタマイズが可能であり、例えば OpenTelemetry エージェントと組み合わせて使用することもできる。

### 3. サンプリング戦略

Jaeger はトレースデータのサンプリング戦略をカスタマイズするための複数のオプションを提供する。サンプリング戦略はトラフィック量とパフォーマンス需要に応じて設定可能：

- **常にサンプリング（Always-On Sampling）**
- **確率的サンプリング（Probabilistic Sampling）**
- **ルールベースサンプリング（Rule-based Sampling）**
- **適応的サンプリング（Adaptive Sampling）**：動的にトラフィックに適応してサンプリングレートを調整。

### 4. データ処理パイプライン

Jaeger のデータ処理パイプラインはモジュール化されており、パイプラインの各ステージで切り替えが可能。例えば、`Collector` で行われるバッチ処理やデータの圧縮方法をカスタマイズできる。

#### Jaegerの`Collector`について

デフォルトでは、`Zipkin`互換のトレースデータだが、`COLLECTOR_OTLP_ENABLED=true`の設定により、`OpenTelemetry Protocol（OTLP）`形式のデータを受信できるようになる

### 5. Query Service と UI

Jaeger のクエリサービスと UI は、さまざまなバックエンドと連携できるように設計されており、利用するストレージやデータソースに合わせて設定を変更できる。Jaeger のウェブ UI もカスタマイズが可能であり、特定のニーズに応じたダッシュボードやビューを作成することができる。

## 実装とデプロイ

Jaeger は Kubernetes 環境で簡単にデプロイ可能であり、Helm チャートや Jaeger Operator を利用して管理されることが多い。これにより、迅速なスケーリングや運用の簡素化が図られている。

## WIP: `v2` の変更点

- [Jaeger v2 リリースの変更点について](https://zenn.dev/zenogawa/scraps/889aa25f8876e5)
- [Jaeger v2 released: OpenTelemetry in the core!](https://www.cncf.io/blog/2024/11/12/jaeger-v2-released-opentelemetry-in-the-core/)

## WIP: 導入方法

### docker compose

```yml
jaeger:
  image: jaegertracing/all-in-one:1.63.0
  profiles:
    - monitoring
  environment:
    - COLLECTOR_OTLP_ENABLED=true
    #- COLLECTOR_ZIPKIN_HOST_PORT=9411 # この設定はデフォルトポートを変更する場合のみ
  ports:
    - "16686:16686" # ダッシュボード用のポート
    - "4318:4318" # exporterの利用するプロトコル: HTTP
    #- "4317:4317" # exporterの利用するプロトコル: gRPC
    #- "9411:9411" # デフォルトのcollectorのportを変更する場合
```

- [Jaeger example: Hot R.O.D. - Rides on Demand](https://github.com/jaegertracing/jaeger/tree/main/examples/hotrod)

#### [利用するポート](https://www.jaegertracing.io/docs/next-release/getting-started/)

- `16686`: ダッシュボード UI のポート
- `4318`: accept OpenTelemetry Protocol (OTLP) over HTTP
- `4317`: accept OpenTelemetry Protocol (OTLP) over gRPC

#### 設定可能な環境変数

- `COLLECTOR_ZIPKIN_HOST_PORT=9411` # collector の Port 番号だが、Default から変更しないのであれば設定不要
- `COLLECTOR_OTLP_ENABLED=true`
  - collector を Jaeger の Exporter から OTLP exporter に変更する？
  - Jaeger の Collector が OpenTelemetry Protocol（OTLP）形式のデータを受信できるようになる
  - これは、Jaeger Collector が OTLP をサポートすることで、OpenTelemetry エクスポーターやエージェントから直接トレースデータを受け取ることを可能にする
- `SPAN_STORAGE_TYPE=elasticsearch`
  - storage を`in-memory`から指定したものに変更する
- `COLLECTOR_OTLP_HTTP_PORT=4318`
  - OTLP HTTPの受信ポートを指定
- `COLLECTOR_OTLP_GRPC_PORT=4317`
  - OTLP gRPCの受信ポートを指定
- `COLLECTOR_HTTP_BASIC_AUTH_USERNAME=admin`
  - HTTPベーシック認証のためのユーザー名を指定
- `COLLECTOR_HTTP_BASIC_AUTH_PASSWORD=secret`
  - HTTPベーシック認証のためのパスワードを指定

## References

- [Jaeger Official](https://www.jaegertracing.io/)
  - [Version1.63: Getting Started](https://www.jaegertracing.io/docs/1.63/getting-started/)
- [github](https://github.com/jaegertracing/jaeger)
- [OpenTelemetry / Go / Getting Started](https://opentelemetry.io/docs/languages/go/getting-started/)
  - [propagators/jaeger](https://pkg.go.dev/go.opentelemetry.io/contrib/propagators/jaeger)
  - [example](https://pkg.go.dev/go.opentelemetry.io/contrib/propagators/jaeger#example-Jaeger)
- [2024: Introduction to Tracing in Go with Jaeger & OpenTelemetry](https://medium.com/@nairouasalaton/introduction-to-tracing-in-go-with-jaeger-opentelemetry-71955c2afa39)
