# API Gateway

API ゲートウェイは、バックエンドのサービスや API にアクセスするための client リクエストの中心的なエントリーポイントとして機能する、最新のウェブ開発における重要なコンポーネント。基本的には、client（ウェブアプリケーションやモバイルアプリケーションなど）と、要求された機能やデータを提供するバックエンドサービスとの仲介役となる。

## 機能

### Routing and Forwarding: ルーティングと転送

Gateway は client からのリクエストを受信し、リクエスト URL、HTTP メソッド、ヘッダー、またはその他の条件に基づいて、適切なバックエンド・サービスにルーティングする。リクエストを指定されたサービスに転送する。

### Authentication and Authorization: 認証と認可

API ゲートウェイは多くの場合、認証と認可を処理し、適切な権限を持つ認証ユーザーのみが特定のリソースにアクセスできるようにする。これには、OAuth、JWT、またはカスタム認証システムのような ID プロバイダとの統合が含まれるかもしれない。

### Load Balancing and Scaling: ロードバランシングとスケーリング

多くの場合、API ゲートウェイは、高い可用性、信頼性、スケーラビリティを確保するために、バックエンド・サービスの複数のインスタンスに受信リクエストを分散する。API ゲートウェイは、トラフィックを均等に分散するロードバランシングを実行し、需要に応じてスケールアップまたはスケールダウンすることができる

### Request Transformation: リクエストの変換

ゲートウェイはリクエストとレスポンスを変換し、異なるプロトコル、メッセージ形式、データ構造の間で適応させることができる。例えば、JSON と XML を変換したり、リクエストヘッダーを修正したりする。

### Rate Limiting and Throttling: レート制限とスロットリング

バックエンドリソースの乱用や過剰な使用を防ぐために、API ゲートウェイはしばしばレート制限とリクエストスロットルを実装する。これらは、ある時間枠内でクライアントが行うことのできるリクエスト数の制限を強制する。

### Monitoring and Analytics: モニタリングと分析

API ゲートウェイは通常、使用状況、パフォーマンス、エラー、その他のメトリクスを追跡するためのロギング、モニタリング、分析機能を提供する。これは、開発者と管理者が API がどのように使用されているかを理解し、問題点や改善点を特定するのに役立つ。

## API Gateway に使われる Framework やサービス

### [Express Gateway](https://www.express-gateway.io/)

Express.js の上に構築された Express Gateway は、動的な設定エンジンと、認証、レート制限、ロギングなどの機能のための幅広いプラグインを提供する。拡張性とカスタマイズ性が高く、さまざまなユースケースに適している。

### [Kong](https://github.com/Kong/kong)

Kong はオープンソースの API ゲートウェイであり、Nginx の上に構築されたマイクロサービス管理レイヤである。リクエストルーティング、認証、レート制限、ロギングなどの機能を提供する。Kong は非常にスケーラブルで、機能を拡張するためのプラグインアーキテクチャをサポートしている。

Star: 37.6K

### [Tyk](https://tyk.io/)

Tyk はオープンソースの API ゲートウェイと管理プラットフォームで、レート制限、認証、分析、開発者ポータル機能などの機能をサポートしている。拡張性が高く、マルチクラウドのデプロイメントをサポートしている。Tyk はオープンソース版とエンタープライズ版の両方を提供している。

[github: Star: 9.3K](https://github.com/TykTechnologies/tyk)

### [API Umbrella](https://github.com/NREL/api-umbrella)

API Umbrella は、API ゲートウェイコンポーネントを含むオープンソースの API 管理プラットフォームである。API キー管理、レート制限、分析、開発者ポータル機能などの機能を提供する。API Umbrella は API を大規模に管理するために設計されており、Nginx の上に構築されている。

Star: 2K

### [AWS API Gateway](https://aws.amazon.com/jp/api-gateway/)

Amazon Web Services (AWS)を使用している場合、AWS API Gateway はフルマネージドサービスであり、あらゆる規模の API を簡単に作成、公開、保守、監視、保護できる。他の AWS サービスとシームレスに統合され、認証、認可、スロットリングなどの機能を提供する。

### [Google Cloud Endpoints](https://cloud.google.com/endpoints?hl=ja)

Google Cloud Endpoints は、Google Cloud Platform 上に API をデプロイ、管理、モニタリングするためのフルマネージドサービスである。認証、認可、モニタリング、ロギングなどの機能をサポートしている。Cloud Endpoints は他の Google Cloud サービスと緊密に統合されている。

### [Azure API Management](https://azure.microsoft.com/ja-jp/products/api-management)

Microsoft Azure の API Management サービスは、API の公開、管理、セキュア化、分析を可能にする。ポリシーの適用、認証、キャッシュ、分析などの機能が含まれる。Azure API Management は、他の Azure サービスとうまく統合され、クラウドとハイブリッドの両方のデプロイメントオプションを提供する。
