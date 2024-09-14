# Cloud

## AWS、GCP、Azureの主要なサービス比較

| AWS Service                  | GCP Service                       | Azure Service                    | 説明                                                                   |
|------------------------------|------------------------------------|----------------------------------|------------------------------------------------------------------------|
| Amazon EC2                   | Google Compute Engine             | Azure Virtual Machines           | 仮想マシン                                                       |
| Amazon S3                    | Google Cloud Storage              | Azure Blob Storage               | オブジェクトストレージ                                                 |
| Amazon EBS                   | Google Persistent Disks           | Azure Disk Storage               | 永続的なブロックストレージ                                             |
| Amazon RDS                   | Cloud SQL / Cloud Spanner         | Azure SQL Database / MySQL/PostgreSQL/MariaDB | フルマネージドなリレーショナルデータベース                             |
| Amazon DynamoDB              | Google Cloud Bigtable / Firestore | Azure Cosmos DB                  | NoSQLデータベース                                                      |
| Amazon ElastiCache           | Cloud Memorystore                 | Azure Cache for Redis            | インメモリデータストアおよびキャッシュサービス                          |
| Amazon Redshift              | BigQuery                          | Azure Synapse Analytics          | データウェアハウスおよび大規模データ分析                               |
| AWS Lambda                   | Google Cloud Functions            | Azure Functions                  | サーバーレスのコード実行環境                                           |
| Amazon SNS                   | Google Cloud Pub/Sub              | Azure Notification Hubs          | 通知およびメッセージング                                               |
| Amazon SQS                   | Google Cloud Tasks / Pub/Sub      | Azure Queue Storage / Service Bus| メッセージキューおよび非同期通信                                       |
| AWS CloudWatch               | Google Cloud Monitoring           | Azure Monitor                    | モニタリングおよびログ管理                                             |
| Amazon VPC                   | Google VPC                        | Azure Virtual Network            | 仮想ネットワーク                                                       |
| Amazon CloudFront            | Google Cloud CDN                  | Azure CDN                        | コンテンツ配信ネットワーク（CDN）                                      |
| AWS IAM                      | Google Cloud IAM                  | Azure Active Directory (AAD)     | アイデンティティとアクセス管理                                         |
| AWS CloudFormation           | Google Cloud Deployment Manager   | Azure Resource Manager Templates | インフラストラクチャをコードとして管理（IaC）                          |

## NoSQLデータベースとインメモリデータストアおよびキャッシュサービスの違い

| 特徴                    | NoSQLデータベース                | インメモリデータストア/キャッシュサービス |
|-------------------------|----------------------------------|----------------------------------------|
| データ保存場所          | ディスク（HDD/SSD）              | メモリ（RAM）                           |
| データアクセス速度      | 高速（ただしインメモリには劣る） | 非常に高速                              |
| データモデル            | 多様（ドキュメント、グラフ等）  | 主にキー・バリュー型またはシンプルなデータ構造 |
| 永続性                  | 高い                             | 場合による（永続性なしが一般的）         |
| スケーラビリティ        | 高い（水平スケーリングがしやすい）| 高い                                     |
| 主な用途                | Webアプリケーション、ビッグデータ分析等 | セッション管理、キャッシュ、リアルタイムアプリケーション等 |
