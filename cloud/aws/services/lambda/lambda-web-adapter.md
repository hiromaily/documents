# Lambda Web Adapter (LWA)

AWS Lambda Web Adapter は、AWS Lambda と他のウェブサービス（特に RESTful API や HTTP エンドポイント）間の連携を簡単にするためのツール。
AWS Lambda 上で従来のウェブアプリフレームワークをそのまま動かすための Lambda Extension

## 主な機能と特徴

1. **HTTP/HTTPS エンドポイントの簡単な作成**: Lambda 関数を HTTP/HTTPS リクエストに応答するエンドポイントとして動作させる。これにより、ウェブベースのサービスを簡単に構築できる。

2. **RESTful API のサポート**: Lambda 関数を RESTful API のエンドポイントとして設定し、CRUD 操作（Create, Read, Update, Delete）を実装するのに便利。

3. **シームレスな統合**: 他の AWS サービス（API Gateway、Application Load Balancer など）と簡単に統合できるため、拡張性があり、複雑なアーキテクチャを構成可能。

4. **スケーラビリティと自動管理**: AWS Lambda 自体のスケーラビリティと管理の手間削減機能を活用できるため、トラフィックに応じて自動的にスケールする。

5. **低コスト運用**: 利用するリクエストに対してのみコストが発生するため、コスト効率が良い。

## 実装の例

1. **API Gateway とのセットアップ**:
   AWS API Gateway を使用して Lambda 関数の Web エンドポイントを作成するのが一般的。API Gateway で HTTP API を作成し、エンドポイントとメソッド（GET, POST など）を定義した後、対応する Lambda 関数を設定する。

2. **Application Load Balancer とのセットアップ**:
   Application Load Balancer（ALB）を使用して、より高いスループットを持つシナリオに対応することも可能。ALB のターゲットグループに Lambda 関数を追加することで、HTTP(S)リクエストを処理できる。

### API Gateway を使用する例

1. **Lambda 関数の作成**:

   ```python
   import json

   def lambda_handler(event, context):
       return {
           'statusCode': 200,
           'body': json.dumps('Hello from Lambda!')
       }
   ```

   AWS Management Console で新しい Lambda 関数を作成し、上記コードをデプロイする。

2. **API Gateway の設定**:

   - AWS Management Console で API Gateway を開き、新しい HTTP API を作成する。
   - ルートリソースを追加し、HTTP メソッド（例: GET）を設定する。
   - 該当する Lambda 関数をインテグレーションエンドポイントとして設定する。

3. **デプロイとテスト**:
   - エンドポイントの設定が完了したら、API をデプロイする。
   - エンドポイント URL に対してブラウザもしくは HTTP クライアント（例: Postman）を使用してリクエストを送信し、Lambda 関数のレスポンスを確認する。

AWS Lambda Web Adapter を使用すれば、サーバレスアーキテクチャの利点を活用し、迅速に可用性の高い Web サービスや API を構築できる。

## References

- [github](https://github.com/awslabs/aws-lambda-web-adapter)
- [AWS Lambda Web Adapter を活用する新しいサーバーレスの実装パターン](https://speakerdeck.com/tmokmss/aws-lambda-web-adapterwohuo-yong-suruxin-siisabaresunoshi-zhuang-patan)
