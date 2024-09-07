# AWS Service

## コンピューティング関連

1. **Amazon EC2 (Elastic Compute Cloud)**
   - 可変サイズの仮想マシン（インスタンス）を提供するサービス。スケーラブルかつ弾力的なコンピューティングリソースを使用可能。

2. **AWS Lambda**
   - サーバーレスアーキテクチャの基盤。コードをアップロードするだけで、自動的にスケーリングし、イベントに応じて実行される。

3. **Amazon ECS (Elastic Container Service)**
   - コンテナの管理とオーケストレーションを行う。Dockerコンテナを効率的に運用できる。

4. **Amazon EKS (Elastic Kubernetes Service)**
   - Kubernetesをフルマネージドで利用できるサービス。Kubernetesクラスターの管理が容易に。

## ストレージ関連

1. **Amazon S3 (Simple Storage Service)**
   - 高スケーラビリティ、高耐久性、および高可用性を持つオブジェクトストレージ。データのバックアップやアーカイブに最適。

2. **Amazon EBS (Elastic Block Store)**
   - EC2インスタンス用の永続ブロックストレージ。データベースやファイルシステムストレージに適している。

3. **Amazon Glacier**
   - 長期的なデータアーカイブとバックアップ用の低コストストレージ。数分から数時間でデータの取り出しが可能。

## データベース関連

1. **Amazon RDS (Relational Database Service)**
   - フルマネージドのリレーショナルデータベースサービス。MySQL、PostgreSQL、MariaDB、Oracle、SQL Server、そしてAuroraをサポート。

2. **Amazon DynamoDB**
   - フルマネージドのNoSQLデータベースサービス。高スループットでスケーラブル。

3. **Amazon Aurora**
   - 高性能かつ高可用性のリレーショナルデータベース。MySQLおよびPostgreSQL互換。

## ネットワーキング関連

1. **Amazon VPC (Virtual Private Cloud)**
   - AWS内で論理的に隔離されたネットワークを構築するためのサービス。セキュリティグループやネットワークACLでアクセス制御が可能。

2. **AWS Direct Connect**
   - オンプレミスとAWS間の専用ネットワーク接続を提供。高帯域幅・低レイテンシーでの通信が可能。

3. **AWS CloudFront**
   - グローバルなコンテンツ配信ネットワーク（CDN）。低レイテンシーでコンテンツをユーザーに提供。

## 開発者ツール関連

1. **AWS CodeBuild**
   - フルマネージドのビルドサービス。コードのコンパイルとテストを自動化し、アーティファクトの生成まで行う。

2. **AWS CodePipeline**
   - 持続的インテグレーションと持続的デリバリー（CI/CD）を自動化するサービス。コードのリリースプロセスを効率化。

3. **AWS Cloud9**
   - フル機能のクラウドベースのIDE。ブラウザーから直接コードを記述、デバッグ、実行できる。

## モニタリングおよび管理

1. **Amazon CloudWatch**
   - AWSリソースとアプリケーションのモニタリング。メトリクスの収集・追跡、ログ管理、およびアラームの設定が可能。

2. **AWS CloudFormation**
   - インフラストラクチャをコードとして管理・デプロイ。テンプレートを使用してAWSリソースを一括で設定。

3. **AWS Config**
   - AWSリソースの設定変更を追跡し、リソースのコンプライアンス状態を評価。変更があった場合にアラートを発行。
