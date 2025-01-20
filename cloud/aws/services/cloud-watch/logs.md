# Amazon CloudWatch Logs

Amazon CloudWatch Logsは、AWSのサービスやアプリケーションからログデータを収集し、保存して監視する機能。
以下の機能により、CloudWatch Logsは、ログデータを効率的に監視し、問題を特定し、トラブルシューティングするための強力なツールを提供する。

1. **ログの集約**: すべてのシステム、AWSサービス、アプリケーションのログを単一の、スケーラブルなサービスに集中する。
2. **ログの監視**: リアルタイムでログを監視し、問題を迅速に特定できる。
3. **ログの検索と分析**: 強力なクエリ言語を使用してログを検索し、特定のエラーやパターンを特定する。
4. **ログのフィルタリングと保存**: ログをフィルタリングして保存し、将来の分析のために安全にアーカイブする。

## CloudWatch Logsの各機能

1. **Log groups**:
   - **説明**: ログを組織化するために使用される。
   - **機能**: ログをグループに分類し、管理する。

2. **Log Anomalies**:
   - **説明**: ログデータの異常を検出する機能。
   - **機能**: ログデータの異常を自動的に検出して通知する。

3. **Live Tail**:
   - **説明**: リアルタイムでログを監視する機能。
   - **機能**: ログのリアルタイム監視が可能で、迅速に問題を特定できるようになる.

4. **Logs Insights**:
   - **説明**: ログデータをインタラクティブに検索し、分析する機能。
   - **機能**: ログデータを分析し、クエリを使用して問題を特定し、解決できるようにする

5. **Contributor Insights**:
   - **説明**: 時系列データを分析してシステムとアプリケーションのパフォーマンスを影響する要因を特定する機能。
   - **機能**: Top contributors、異常値、トラフィックパターンを特定し、問題を迅速に解決できるようにする

## Log groups

CloudFormationテンプレート例

```yaml
Resources:
  Function:
    Type: AWS::Lambda::Function
    Properties:
      FunctionName: MyFunction
      LoggingConfig:
        LogGroup: !Ref LogGroup
      # ...
  
  LogGroup:
    Type: AWS::Logs::LogGroup
    Properties:
      LogGroupName: !Sub /aws/lambda/${Function}
      RetentionInDays: 14  # ログの保留期間を14日に設定
```

### Log events

[Log groups] > [任意のLog group] > [Log streams] > [任意のLog stream] > [Log events]

このLog eventは、`Time stamp`と`Message`からなる

## 検索方法

例えば、responsePayloadのerrorMessage内に、`Task timed out`という文言が含まれているlog eventを、特定のlog streamから全て抽出したい。

`/aws/lambda/HealthCheckBatch` log group内に

```json
{
    "time": "2025-01-17T05:45:04.564600688Z",
    "event": {
        "timestamp": "2025-01-17T05:45:02.030Z",
        "requestPayload": {
            "version": "0",
            "id": "86626bc9-c744-9250-507c-927558b9d494"
        },
        "responsePayload": {
            "errorMessage": "2025-01-17T05:45:01.903Z cfa4a43b-c066-442e-b3cc-a11785e0041c Task timed out after 32.01 seconds"
        }
    }
}
```

### `Logs Insights`

`Query generator`では、`prompt`を使って英語でやりたいことを伝えることで、queryが生成される。

```prompt
# prompt
message is complex json and sometimes that includes `Task timed out after` in message.
```

```query
# ヒットしないquery
filter @message like /"Task timed out"/
```

```query
# ヒットした
fields @timestamp, @message 
| filter @message like /(?i)Task timed out after/
```

```prompt
#prompt
and message have to include specific id `cfa4a43b-c066-442e-b3cc-a11785e0041c`
```

```query
# requestIdをさらに指定
fields @timestamp, @message 
| filter @message like /(?i)Task timed out after/ and @message like /(?i)cfa4a43b-c066-442e-b3cc-a11785e0041c/
```
