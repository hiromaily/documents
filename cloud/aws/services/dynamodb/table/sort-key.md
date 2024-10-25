# DynamoDBで使われる ソートキー（Sort Key）

## 概要

- **ソートキー**とは、DynamoDBテーブルにおいてパーティションキーと共に使用される二次的なキー。データが特定のパーティションに存在する場合、そのパーティション内でソートキーによってデータが並べ替えられる。
- **複合プライマリキー**（Composite Primary Key）の一部を構成し、パーティションキーとの組み合わせで一意なエントリを確定する。

## パーティションキーとソートキーの例

```json
{
    "partition_key": "user123",
    "sort_key": "2023-01-01T00:00:00Z",
    "data": "action1"
},
{
    "partition_key": "user123",
    "sort_key": "2023-01-02T00:00:00Z",
    "data": "action2"
}
```

- **パーティションキー**: `user123`
- **ソートキー**: タイムスタンプ（`2023-01-01T00:00:00Z`, `2023-01-02T00:00:00Z`）

この例では、同じユーザー（`user123`）に対して異なる時系列データがソートキーによって整理されている。

## ソートキーのクエリ利便性

### データのOrdering

ソートキーを使用することで、同じパーティション内のデータがソートキーに基づいて自動的に並べ替えられる。これにより、特定の範囲や条件に基づく効率的なクエリが可能。

### クエリ条件の柔軟性

ソートキーを使用したクエリには以下のような条件がサポートされてる

- **等しい**（Equality）: `sort_key = value`
- **範囲**（Range）: `sort_key BETWEEN value1 AND value2`
- **プレフィックス**（Prefix）: `begins_with(sort_key, 'prefix')`
- **比較**（Comparison）: `sort_key > value`, `sort_key < value`, `sort_key >= value`, `sort_key <= value`

## 実際のクエリ例

例えば、特定のユーザーの指定された期間内のアクションを取得する場合：

```go
package main

import (
    "context"
    "fmt"
    "log"
    "time"

    "github.com/aws/aws-sdk-go-v2/aws"
    "github.com/aws/aws-sdk-go-v2/config"
    "github.com/aws/aws-sdk-go-v2/service/dynamodb"
    "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
)

func main() {
    cfg, err := config.LoadDefaultConfig(context.TODO())
    if err != nil {
        log.Fatalf("unable to load SDK config, %v", err)
    }

    svc := dynamodb.NewFromConfig(cfg)
    tableName := "example-table"
    partitionKey := "user123"
    startTimestamp := "2023-01-01T00:00:00Z"
    endTimestamp := "2023-01-10T00:00:00Z"

    queryInput := &dynamodb.QueryInput{
        TableName:              aws.String(tableName),
        KeyConditionExpression: aws.String("#pk = :pk AND #sk BETWEEN :start AND :end"),
        ExpressionAttributeNames: map[string]string{
            "#pk": "partition_key",
            "#sk": "sort_key",
        },
        ExpressionAttributeValues: map[string]types.AttributeValue{
            ":pk":    &types.AttributeValueMemberS{Value: partitionKey},
            ":start": &types.AttributeValueMemberS{Value: startTimestamp},
            ":end":   &types.AttributeValueMemberS{Value: endTimestamp},
        },
    }

    result, err := svc.Query(context.TODO(), queryInput)
    if err != nil {
        log.Fatalf("failed to query items, %v", err)
    }

    if len(result.Items) > 0 {
        for _, item := range result.Items {
            fmt.Printf("Item: %v\n", item)
        }
    } else {
        fmt.Println("No items found.")
    }
}
```

上記のコードは、指定されたユーザー (`partitionKey`) に対して特定の期間内 (`startTimestamp` から `endTimestamp`) のデータをクエリしている。

## テーブル設計の具体例

### テーブル定義

特定のユーザーの特定日時のアクションデータを保存する場合の例：

- **パーティションキー**: `partition_key`（例: `userID`）
- **ソートキー**: `sort_key`（例: `timestamp`）

```hcl
resource "aws_dynamodb_table" "example" {
  name         = "example-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "partition_key"
  range_key    = "sort_key"

  attribute {
    name = "partition_key"
    type = "S"
  }

  attribute {
    name = "sort_key"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }
  
  stream_enabled = true
  stream_view_type = "NEW_IMAGE"
}
```

## ソートキー まとめ

ソートキーを用いることで、DynamoDBテーブル内の特定のパーティション内でデータを効率的に整理し、様々なクエリ操作を行うことが可能となる。これにより、特定の範囲や条件に基づいたデータ取得が容易になり、全体的なパフォーマンスを向上させることができる。

- **パーティションキー + ソートキー**: パーティションキーに基づいてデータを分割し、同じパーティション内のデータをソートキーで一意に識別・整理する。
- **クエリの利便性**: ソートキーを使うことで、範囲クエリや条件付クエリが効率的に実行できる。
