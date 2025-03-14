# Amazon CloudWatch

監視サービスであり、AWSのリソースとアプリケーションのパフォーマンスと運用データを収集、分析、可視化するためのツール。Amazon CloudWatchは、インフラストラクチャやアプリケーションの健康状態とパフォーマンスをリアルタイムで監視するためのさまざまな機能を提供する。

## 主な機能

1. **メトリクスの収集とモニタリング**:
   - AWSリソース（EC2インスタンス、RDSデータベース、DynamoDBテーブルなど）やアプリケーションのメトリクスを収集。
   - 重要なパフォーマンス指標（CPU使用率、ディスクI/O、ネットワークトラフィックなど）をモニタリング。

2. **ログ管理**:
   - Amazon CloudWatch Logsを使用して、アプリケーションとシステムのログデータを収集、モニター、保存。
   - ログインサイトのフィルタリングやリアルタイムのログ分析が可能。

3. **アラートとアクション**:
   - CloudWatch Alarmsを設定して、特定の条件が満たされたときに通知を受け取る。
   - SNS通知、オートスケーリング、Lambda関数のトリガー、EC2の停止・再起動など、様々なアクションを設定可能。

4. **ダッシュボード**:
   - カスタマイズされたダッシュボードを作成し、複数のメトリクスを一元的に視覚化。
   - メトリクスをグラフ形式で表示したり、ステータスの概要を確認したりすることができる。

5. **イベントのトリガー**:
   - `Amazon EventBridge`を使用して、状態の変化や時間ベースのスケジュールに応じて特定のアクションを自動的に実行。
   - インフラの自動管理やリソースの自動オーケストレーションに役立つ。

### 各機能の説明

1. **Alarms (アラーム)**:
   - **説明**: CloudWatchのメトリクスを監視し、設定したしきい値を超えた場合に通知を送信したり、自動的にリソースを操作することができる。
   - **例**: CPU使用率が一定の時間一定の割合を超えた場合に通知を送信する、またはインスタンスを自動的に停止する。

2. **Logs (ログ)**:
   - **説明**: アプリケーションとシステムのログデータをリアルタイムで監視し、保存する機能。特定のパターンを検索し、リソースの問題を特定するのに使用できる。
   - **構成**: ロググループ、ログストリーム、ログイベントから構成される.

3. **Metrics (メトリクス)**:
   - **説明**: AWSリソースとアプリケーションのパフォーマンスデータを収集し、監視する機能。メトリクスを使用してリソースの使用率、アプリケーションのパフォーマンスを監視し、アラートを設定できる。
   - **使用例**: CPU使用率、ディスク読み取り/書き込みの監視など

4. **X-Ray traces (X-Rayトレース)**:
   - **説明**: AWS X-Rayは、CloudWatch Application Signals、CloudWatch RUM、CloudWatch Syntheticsと統合して、アプリケーションのパフォーマンスを監視し、トラブルシューティングする機能。
   - **機能**: リクエストパスを分析し、エンドユーザーのパフォーマンスを監視する

5. **Events (イベント)**:
   - **説明**: AWSリソースの変更を示すシステムイベントのストリームをほぼリアルタイムで提供する。簡単なルールを使用して、イベントをターゲット関数やストリームに振り分けることができる。
   - **使用例**: EC2インスタンスの状態遷移、スケジュール、API呼び出し、コンソールのログインをトリガーとして処理を行うなど

6. **Application Signals**:
   - **説明**: アプリケーションのオペレーショナルヘルスを監視し、トラブルシューティングする機能。CloudWatch Application Signalsは、X-Ray、CloudWatch RUM、CloudWatch Syntheticsと統合されている。
   - **機能**: クライアントページ、Syntheticsカナリア、サービス依存性の監視

7. **Network Monitoring (ネットワークモニタリング)**:
   - **説明**: AWSのネットワークトラフィックを監視する機能。Datasourceにより、トラフィックのパターンや異常を検出することができる。

8. **Insights**:
   - **説明**: CloudWatch Insightsは、ログデータを分析し、特定のパターンや異常を検出する機能。ユーザーは、Insightsを使用してデータのトレンドやパターンを視覚的に確認することができる

## 主なユースケース

1. **インフラストラクチャの監視**:
   - AWSリソースのパフォーマンスと健康状態の監視。
   - 異常なリソース使用を早期に検出し、問題発生前に対応。

2. **アプリケーションのパフォーマンス監視**:
   - エンドユーザーの体験を監視し、SLI/SLO（Service Level Indicators/Objectives）を確保。
   - レスポンスタイムの分析、エラートラッキング。

3. **セキュリティの強化**:
   - ログデータを継続的に監視して、セキュリティの異常検出やコンプライアンスの確保に利用。

4. **スケーラビリティの向上**:
   - アラームとオートスケーリングの連携により、自動的にリソースをスケールアップ/ダウン。
