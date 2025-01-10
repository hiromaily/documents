# Web サービスの Deploy

- [内部Docs: CI/CD](../../devops/ci-cd/README.md)

## 1. 手動デプロイ

シンプルなプロジェクト向けだが、スケーラビリティや一貫性に欠ける。

1. **コードのアップロード**: FTP や SCP を使ってコードをサーバーに手動でアップロード。
2. **サーバー設定**: Web サーバー（例えば、Apache や Nginx）の設定を手動で調整。
3. **アプリケーションの起動**: 必要なサービスを手動で起動。

## 2. CI/CD パイプライン (継続的インテグレーション/継続的デプロイ)

GitHub Actions, Jenkins、CircleCI などの CI/CD ツールを利用することで、一貫性と自動化を実現できる。

1. **リポジトリの設定**: ソースコード管理システム（例えば、GitHub や GitLab）にリポジトリを設定。
2. **CI/CD ツールの設定**: Jenkins や GitHub Actions などのツールを使い、ビルド、テスト、デプロイのパイプラインを設定。
3. **自動化スクリプト作成**: ビルド、テスト、デプロイフェーズを自動化するスクリプトを作成。
4. **Webhook の設定**: プッシュやプルリクエストに応じた自動デプロイのトリガーを設定。

## 3. クラウドベースのデプロイ

AWS、Google Cloud Platform、Microsoft Azure などを利用する。

1. **インフラ設定**:
   - AWS: EC2、Lambda、Elastic Beanstalk、ECS（Elastic Container Service）
   - Google Cloud: App Engine、GCE（Google Compute Engine）、Cloud Functions
   - Azure: App Service、Azure Functions
2. **インフラのコード化**: Terraform や CloudFormation を使ってインフラをコード化。
3. **CI/CD ツールの統合**: 上記のような CI/CD ツールとクラウドサービスを統合し、デプロイを自動化。

## 4. コンテナを用いたデプロイ

Docker と Kubernetes を使ったデプロイ方法。これにより、環境の差異を減らし、スケーラブルなサービスを提供できる。

1. **Docker イメージの作成**: アプリケーションを Docker コンテナにパッケージ化。
2. **レジストリへのプッシュ**: Docker Hub や Amazon ECR などのコンテナレジストリにイメージを登録。
3. **Kubernetes の設定**: YAML ファイルを使って Kubernetes クラスタを設定。デプロイメント、サービス、ポッドなどの設定を行う。
4. **デプロイの実行**: `kubectl apply -f your-deployment-file.yaml` などを実行してデプロイ。

## 5. サーバーレスデプロイ

サーバーレスアーキテクチャを採用する方法。これにより、インフラ管理を最小限に抑えることができる。

1. **コードの準備**: Lambda 関数や Cloud Functions を利用するためのコードを準備。
2. **デプロイツールの使用**: サーバーレスフレームワーク（Serverless Framework など）を利用してデプロイ。
3. **クラウド設定**: イベントトリガーや API Gateway の設定を行う。

## References

- [2020: デプロイ今昔](https://developer.hatenastaff.com/entry/2020/06/26/150300)
