# AWS Fargate と Amazon ECS on Fargate の違い

`AWS Fargate`と`Amazon ECS on Fargate`は、基本的には同じサービスの異なる側面を指しているが、その違いについて説明する

## AWS Fargate

**AWS Fargate**は、Amazon ECS および Amazon EKS（Elastic Kubernetes Service）のための`サーバレスコンピューティングエンジン`。Fargate を使用すると、ユーザーは基盤となるインフラストラクチャを管理することなく、コンテナを直接実行できる。

## Amazon ECS on Fargate

**Amazon ECS on Fargate**は、具体的に AWS Fargate を使用して Amazon Elastic Container Service（ECS）上でコンテナを実行する構成を指す。主に、Fargate を ECS の環境で使う場合に言及される。

## 主な違いは？

1. **文脈と使用事例**:

   - **AWS Fargate**: コンテナオーケストレーションエンジンや ECS や EKS の基盤として機能する。Fargate は、インフラ管理を抽象化し、コンテナを容易に実行するための基盤技術。
   - **Amazon ECS on Fargate**: Fargate を特定のコンテナオーケストレーションサービス（ECS）において使用することを示す。つまり、Fargate を使って ECS クラスタ内でコンテナを実行することを指す。

2. **対応するオーケストレーションツール**:
   - **AWS Fargate**: ECS もしくは EKS のどちらでも利用可能。
   - **Amazon ECS on Fargate**: 具体的には ECS 上で Fargate を使う構成を指す。

## それぞれの役割

### AWS Fargate の役割

- **サーバレス**: インフラを完全に抽象化する。ユーザーは EC2 インスタンスの管理から解放され、コンテナのリソース定義のみに集中できる。
- **リソース管理**: コンテナごとに CPU とメモリを設定し、実行する。従来の ECS のようにインスタンス管理が不要。
- **スケーラビリティ**: 自動でタスクのスケーリングを実施。特定のリソースに対する需要に応じて動的にスケーリングする。
- **コスト効率**: 任意のリソース単位で計算されるため、EC2 インスタンスをプロビジョニングする必要がない分、使用量に基づいたコストで済む。

### Amazon ECS on Fargate の役割

- **ECS クラスター内での運用**: ECS のタスクとして Fargate を使用する場合、Fargate は ECS クラスターの一部として機能する。作成されるタスクは Fargate ランタイムで実行され、インフラは完全に管理される。
- **フルマネージドオーケストレーション**: クラスターの管理やタスクのスケーリングは ECS が行い、その基盤に Fargate が使われる。これによりオンプレミスでの EC2 管理を取り除く。
- **設定と管理**: 通常の ECS タスクと同様に、タスク定義、ネットワーク設定、セキュリティグループなどを設定できる。

## 具体的にどちらを使うかの選択基準

1. **コンテナオーケストレーションエンジンの選択**:

   - **ECS**を利用している場合: **Amazon ECS on Fargate**が典型的な選択肢。
   - **EKS**を利用している場合: **AWS Fargate**（EKS 上で利用）を選択。

2. **既存のツールとの互換性**:
   - 既に**ECS**を使用している場合、Amazon Fargate on ECS が自然な拡張。
   - 既に**Kubernetes**を使用している場合、AWS Fargate on EKS が適している。

### まとめ

- **AWS Fargate**は、ECS および EKS で利用可能なサーバレスコンピューティングエンジンであり、インフラ管理を抽象化してコンテナの実行を簡素化する。
- **Amazon ECS on Fargate**は、特に ECS で Fargate を使ってタスクを実行する構成を指し、ECS クラスター内で完全にインフラを抽象化したコンテナ運用を可能にする。
