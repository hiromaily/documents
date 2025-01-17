# AWS Lambda Destinations / Lambda function への`送信先の追加`

Lambda 送信先（AWS Lambda Destinations）の機能は、Lambda 関数の実行結果（成功または失敗）に基づいて後続のアクションを自動的にトリガーするために使用される。この機能を使用することで、特定のユースケースに対して実行結果に応じた処理を設定することができる。

この機能設定の送信先として以下の 4 つのタイプがサポートされている

1. **Amazon SNS トピック**
2. **Amazon SQS キュー**
3. **別の Lambda 関数**
4. **Amazon EventBridge**

## 利用ケース

1. **成功時の通知**: Lambda 関数が正常に実行されたときに通知を送信することができる。例えば、SNS トピックを使って管理者に通知を送る。
2. **失敗時のアクション**: Lambda 関数が失敗した場合に別の処理を実行するために利用することができる。例えば、失敗レコードを SQS キューに送って後続の処理を待つ。
3. **リトライの処理**: Lambda 関数が失敗したときに、特定の条件に基づいて再実行するように設計できる。

### ユースケース：Lambda 関数の失敗による再実行

「Lambda 関数が実行に失敗したときに、特にタイムアウトが原因であれば再実行する」という処理は、Lambda 送信先の機能で実現するために以下のようなアプローチが考えられる

1. **ステップ 1：送信先を設定**

   - 関数が失敗した場合に通知を`別のLambda関数`に送信する。

2. **ステップ 2：失敗通知を処理**

   - 失敗通知を受け取った`別のLambda関数`で、イベント内容を確認し、失敗の理由（エラーの種類がタイムアウトであるか）をチェックする。
   - タイムアウトである場合、その関数を再実行する。再実行するためには、呼び出しを別の Lambda 関数、または Amazon EventBridge を使ってスケジュールすることができる。

3. **失敗通知で再実行する仕組みの Lambda 関数**:

```python
import boto3
import json

client = boto3.client('lambda')

def lambda_handler(event, context):
    # ログのためイベントを印刷
    print(json.dumps(event))

    # 失敗イベントから経過情報を取得
    error_message = event['detail']['responseErrorMessage']

    # 失敗がタイムアウトによるものであることを確認
    if 'Task timed out' in error_message:
        response = client.invoke(
            FunctionName='MyFunction',
            InvocationType='Event'
        )
        return {
            'statusCode': 200,
            'body': json.dumps('Re-invoked MyFunction due to timeout')
        }
    else:
        return {
            'statusCode': 200,
            'body': json.dumps('Not a timeout error, no action taken')
        }
```

## 設定項目

Lambda の任意の function を選択し、`Configuration` > `Destinations`を選択

### Source

Lambda 関数をトリガーする方法。
非同期処理とイベントソースマッピングの違いを理解することで、適切なトリガー設定を行い、Lambda 関数を効果的に使用することが可能。

#### Source: 非同期呼び出し

非同期呼び出しでは、Lambda 関数がイベントソースからのイベントを非同期で受け取る。これは、呼び出し元が関数の実行終了を待たずに処理を引き続き行える方式。

以下のようなサービスからの呼び出しが含まれる。

1. **Amazon S3**: バケットに新しいオブジェクトが作成されたときなど。
2. **Amazon SNS (Simple Notification Service)**: SNS トピックにメッセージが公開されたとき。
3. **Amazon SES (Simple Email Service)**: E メール受信時のトリガー。
4. **AWS CloudFormation**: スタックのイベントに応じてトリガー。
5. **Amazon CloudWatch Events (イベントブリッジ)**: 特定の条件に基づくイベント。
6. **AWS CodeCommit**: リポジトリでのプッシュイベントやブランチ作成時など。
7. **Amazon Cognito**: 特定の ID イベント（例：プールユーザーが作成されたとき）など。

#### Source: イベントソースマッピングの呼び出し

イベントソースマッピングを使用すると、特定のデータストリームやメッセージキューからイベントをポーリングして、Lambda 関数を自動的に呼び出すことができる。以下のようなサービスからの呼び出しが含まれる。
これらのイベントソースマッピングは、Lambda 関数が設定されたデータストリームやキューから直接イベントを取得し、対応する Lambda 関数を呼び出す。

1. **Amazon DynamoDB Streams**: テーブルデータの変更があったとき。
2. **Amazon Kinesis Data Streams**: ストリームデータに新しいレコードが追加されたとき。
3. **Amazon SQS (Simple Queue Service)**: キューに新しいメッセージが追加されたとき。
4. **Amazon Managed Streaming for Apache Kafka (MSK)**: Kafka ブローカーに新しいレコードが追加されたとき。

## References

- [Invoking a Lambda function asynchronously](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html)
