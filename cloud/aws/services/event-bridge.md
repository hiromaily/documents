# Amazon EventBridge

Amazon EventBridge は、Amazon Web Services（AWS）が提供するサーバーレスのイベントバスサービス。EventBridge は、アプリケーション間でのイベントデータのルーティングと処理を簡単にし、異なる AWS サービスや SaaS アプリケーション間での統合をサポートする。

EventBridge の主要な機能と特長は以下の通り

## 1. **イベントソースの統合：**

EventBridge は、以下のような複数のイベントソースからのデータを取り扱うことができる

- **AWS サービス**：例えば、Amazon S3、Amazon EC2、AWS Lambda など。
- **SaaS アプリケーション**：例えば、Zendesk、Shopify、Stripe などのサードパーティサービス。
- **カスタムイベント**：独自のアプリケーションやサービスから送信されるイベント。

## 2. **ルールベースのルーティング：**

イベントルールを定義することで、特定の条件に基づいてイベントをターゲットにルーティングできる。ルールはイベントの内容に基づいて評価され、複数のターゲットにイベントを送信できる。

## 3. **ターゲットの多様性：**

EventBridge は多種多様なターゲットをサポートしている。例えば：

- AWS Lambda 関数
- Amazon SNS トピック
- Amazon SQS キュー
- AWS Step Functions ステートマシン
- Kinesis Streams や Firehose
- AWS Batch ジョブ

## 4. **スキーマディスカバリ：**

EventBridge はイベントのスキーマを自動的に検出して登録することができる。この機能により、イベントデータの構造を理解しやすくなり、アプリケーションの開発とテストが簡単になる。

## 5. **セキュリティとコンプライアンス：**

EventBridge は AWS のその他のサービスと同様に、セキュリティとコンプライアンスのベストプラクティスをサポートしている。例えば、IAM ロールやポリシーを使ったアクセス制御の設定が行える。

## 6. **可観測性：**

EventBridge は CloudWatch と統合しており、イベントのルーティング状況やパフォーマンスメトリクスをモニタリングすることができる。また、CloudTrail によりイベントアクティビティの監査を行うこともできる。

## 7. **スケーラビリティと高可用性：**

EventBridge は完全マネージドサービスであり、自動的にスケールし、冗長性が確保されている。このため、大量のイベントデータを低レイテンシで処理することが可能。

## 使用例

- **マイクロサービスアーキテクチャ**：異なるマイクロサービス間でのイベント駆動型の通信を実現。
- **リアルタイムデータ処理**：センサーデータやユーザーアクティビティログのリアルタイム処理。
- **自動アクション**：特定の出来事に応じた自動化されたアクションのトリガー。