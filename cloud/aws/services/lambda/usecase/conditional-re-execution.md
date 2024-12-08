# ある条件下でLambda functionを再度実行する

1. **AWS SDKを使用して自分自身の関数を呼び出す**
2. **EventBridgeと組み合わせる**
3. **Step Functionsを使う**

## 1. AWS SDKを使用して自分自身の関数を呼び出す例

```go
package main

import (
    "context"
    "encoding/json"
    "fmt"
    "os"

    "github.com/aws/aws-lambda-go/events"
    "github.com/aws/aws-lambda-go/lambda"
    "github.com/aws/aws-sdk-go/aws"
    "github.com/aws/aws-sdk-go/aws/session"
    "github.com/aws/aws-sdk-go/service/lambda"
)

func handler(ctx context.Context, event events.CloudWatchEvent) error {
    // Lambdaの実行ロジック

    // 条件をチェック（例としてイベントのDetailに特定のフィールドがあるか確認）
    if checkCondition(event) {
        // 再実行
        err := reinvokeFunction(event)
        if err != nil {
            return fmt.Errorf("failed to re-invoke function: %v", err)
        }
        fmt.Println("Function will be re-invoked")
    }

    return nil
}

// 条件判別
func checkCondition(event events.CloudWatchEvent) bool {
    // ここで条件を確認
    // 例：特定のフィールドが存在するかどうか
    return true
}

// 再実行
func reinvokeFunction(event events.CloudWatchEvent) error {
    svc := lambda.New(session.Must(session.NewSession()))
    
    payload, err := json.Marshal(event)
    if err != nil {
        return fmt.Errorf("failed to marshal event: %v", err)
    }

    _, err = svc.Invoke(&lambda.InvokeInput{
        FunctionName: aws.String(os.Getenv("AWS_LAMBDA_FUNCTION_NAME")), // 環境変数から関数名を取得
        InvocationType: aws.String("Event"), // 非同期実行
        Payload: payload,
    })
    if err != nil {
        return fmt.Errorf("failed to invoke function: %v", err)
    }

    return nil
}

func main() {
    lambda.Start(handler)
}
```

## 2. EventBridgeと組み合わせる例

### 1. Lambda関数の作成

イベントを受け取り、特定の条件を満たす場合にEventBridgeを介して再度実行する処理を書く

```go
package main

import (
    "context"
    "encoding/json"
    "fmt"

    "github.com/aws/aws-lambda-go/lambda"
    "github.com/aws/aws-sdk-go/aws"
    "github.com/aws/aws-sdk-go/aws/session"
    "github.com/aws/aws-sdk-go/service/eventbridge"
)

type MyEvent struct {
    Detail string `json:"detail"`
}

func handler(ctx context.Context, event MyEvent) error {
    // Lambdaの実行ロジック
    fmt.Println("Function executed")

    // 条件をチェック
    if event.Detail == "reinvoke" {
        err := triggerEventBridge()
        if err != nil {
            return fmt.Errorf("failed to trigger EventBridge: %v", err)
        }
        fmt.Println("EventBridge triggered for reinvocation")
    }

    return nil
}

// Eventを発火
func triggerEventBridge() error {
    svc := eventbridge.New(session.Must(session.NewSession()))

    detail := map[string]string{"detail": "reinvoke"}
    detailJson, err := json.Marshal(detail)
    if err != nil {
        return err
    }

    input := &eventbridge.PutEventsInput{
        Entries: []*eventbridge.PutEventsRequestEntry{
            {
                Detail:       aws.String(string(detailJson)),
                DetailType:   aws.String("MyEvent"),
                Source:       aws.String("my.event.source"),
                EventBusName: aws.String("default"),
            },
        },
    }

    _, err = svc.PutEvents(input)
    if err != nil {
        return err
    }

    return nil
}

func main() {
    lambda.Start(handler)
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
