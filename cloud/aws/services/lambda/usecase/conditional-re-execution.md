# ある条件下でLambda functionを再度実行する

1. **AWS SDKを使用して自分自身の関数を呼び出す**
2. **EventBridgeと組み合わせる**
3. **Step Functionsを使う**

## 1. AWS SDKを使用して自分自身の関数を呼び出す例

[Go V2 のSDKのInvoke()メソッド](https://docs.aws.amazon.com/ja_jp/code-library/latest/ug/go_2_lambda_code_examples.html)

```go
import (
    "bytes"
    "context"
    "encoding/json"
    "errors"
    "log"
    "time"

    "github.com/aws/aws-sdk-go-v2/aws"
    "github.com/aws/aws-sdk-go-v2/service/lambda"
    "github.com/aws/aws-sdk-go-v2/service/lambda/types"
)

// FunctionWrapper encapsulates function actions used in the examples.
// It contains an AWS Lambda service client that is used to perform user actions.
type LambdaClient struct {
    client *lambda.Client
}

// Invoke invokes the Lambda function specified by functionName, passing the parameters
// as a JSON payload. When getLog is true, types.LogTypeTail is specified, which tells
// Lambda to include the last few log lines in the returned result.
func (l *LambdaClient) Invoke(ctx context.Context, functionName string, parameters any, getLog bool) *lambda.InvokeOutput {
    logType := types.LogTypeNone
    if getLog {
        logType = types.LogTypeTail
    }
    payload, err := json.Marshal(parameters)
    if err != nil {
        log.Panicf("Couldn't marshal parameters to JSON. Here's why %v\n", err)
    }
    invokeOutput, err := l.client.Invoke(ctx, &lambda.InvokeInput{
        FunctionName: aws.String(functionName),
        LogType:      logType,
        Payload:      payload,
    })
    if err != nil {
        log.Panicf("Couldn't invoke function %v. Here's why: %v\n", functionName, err)
    }
    return invokeOutput
}
```

## 2. EventBridgeと組み合わせる例

[Go V2 のSDKのeventbridge package](https://pkg.go.dev/github.com/aws/aws-sdk-go-v2/service/eventbridge)

### 1. Lambda関数の作成

イベントを受け取り、特定の条件を満たす場合にEventBridgeを介して再度実行する処理を書く

```go
package main

import (
    "context"
    "encoding/json"
    "fmt"
    "log"

    "github.com/aws/aws-sdk-go-v2/aws"
    "github.com/aws/aws-sdk-go-v2/config"
    "github.com/aws/aws-sdk-go-v2/service/eventbridge"
)

func main() {
    // AWS SDKの設定をロード
    cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithRegion("us-west-2"))
    if err != nil {
        log.Fatalf("Unable to load SDK config, %v", err)
    }

    // EventBridgeクライアントを作成
    svc := eventbridge.NewFromConfig(cfg)

    // カスタムイベントのデータを作成
    eventDetail := map[string]string{
        "key1": "value1",
        "key2": "value2",
    }

    eventDetailJson, err := json.Marshal(eventDetail)
    if err != nil {
        log.Fatalf("Error marshaling event detail: %v", err)
    }

    // PutEventsInput を作成
    input := &eventbridge.PutEventsInput{
        Entries: []eventbridge.PutEventsRequestEntry{
            {
                Detail:       aws.String(string(eventDetailJson)),
                DetailType:   aws.String("myDetailType"),
                EventBusName: aws.String("default"),
                Source:       aws.String("mySource"),
            },
        },
    }

    // EventBridgeにイベントを送信
    result, err := svc.PutEvents(context.Background(), input)
    if err != nil {
        log.Fatalf("Error sending event to EventBridge: %v", err)
    }
}
```

### 2. EventBridgeルールの作成

Lambda関数をトリガーするEventBridgeルールを設定。

```sh
aws events put-rule --name "MyEventRule" --event-pattern '{"source": ["my.event.source"], "detail-type": ["MyEvent"]}' --state ENABLED

aws lambda add-permission --function-name your-lambda-function-name --statement-id MyEventRulePermission --action 'lambda:InvokeFunction' --principal events.amazonaws.com --source-arn arn:aws:events:your-region:your-account-id:rule/MyEventRule
```

ここでは、`your-region`、`your-account-id`、および`your-lambda-function-name`を適切な値に置き換えること。

### 3. ルールにターゲットを追加

EventBridgeルールにターゲット（Lambda関数）を追加。

```sh
aws events put-targets --rule "MyEventRule" --targets "Id"="1","Arn"="arn:aws:lambda:your-region:your-account-id:function:your-lambda-function-name"
```
