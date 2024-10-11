# `localstack`でDynamoDBを使う

初期化スクリプトの例

```sh
# something_notification
awslocal dynamodb create-table \
  --table-name something_notification \
  --attribute-definitions \
  AttributeName=chat_room_id,AttributeType=S \
  AttributeName=notification_type,AttributeType=S \
  --key-schema \
  AttributeName=chat_room_id,KeyType=HASH \
  AttributeName=notification_type,KeyType=RANGE \
  --provisioned-throughput \
  ReadCapacityUnits=100,WriteCapacityUnits=100 \
  --table-class STANDARD
awslocal dynamodb update-time-to-live \
  --table-name delay_notification \
  --time-to-live-specification \
  "Enabled=true, AttributeName=ttl"

# table一覧
awslocal dynamodb list-tables
```

## References

- [DynamoDB local](https://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/developerguide/DynamoDBLocal.html)を使うことができる。
- [LocalStack](https://github.com/localstack/localstack)
