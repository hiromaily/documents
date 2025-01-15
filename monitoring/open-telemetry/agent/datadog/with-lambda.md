# LambdaからDatadog を利用する

## [Datadog Lambda Extenstionについて](https://docs.datadoghq.com/serverless/libraries_integrations/extension/)

`Datadog Lambda Extension` は、AWS Lambda 関数のメトリクス収集、トレース、ログの収集を簡単に行うための拡張機能。Datadog は総合的な監視およびセキュリティプラットフォームであり、この拡張機能を使用することで、サーバーレスアプリケーションのパフォーマンスと信頼性をリアルタイムでモニタリングできるようになる。

1. **メトリクス収集**：Lambda 関数の実行に関する詳細なメトリクス（例：実行時間、エラー率、コールドスタートの頻度など）を収集し、Datadog に送信できり。
2. **トレース**：分散トレースを有効にすることで、エンドツーエンドの要求を追跡し、パフォーマンスボトルネックや障害点を特定できる。
3. **ログ収集**：Lambda 関数のログを Datadog に自動的に送信し、集中管理および分析が可能。

Dockerfileを使ったExtensionのInstall 例

```dockerfile
FROM public.ecr.aws/lambda/provided:al2023 AS lambda-base

# Datadog APMインストール
COPY --from=public.ecr.aws/datadog/lambda-extension:latest /opt/. /opt/
```

## Client側の実装

1. `DatadogのAgentを利用する`
2. `OTEL Collectorを利用する`

### 1. `DatadogのAgentを利用する`

- AWS Lambda関数にDatadog Lambda Layerを追加する
  - [Datadog-Extension](https://docs.datadoghq.com/serverless/libraries_integrations/extension/)レイヤーのARNを追加する
- Lambda上で動作するアプリケーション側に環境変数を設定

    ```env
    DD_API_KEY=<YOUR_DATADOG_API_KEY>
    DD_SITE=datadoghq.com
    DD_TRACE_ENABLED=true
    DD_TRACE_OTEL_ENABLED # goだとサポートされていない様子
    ```

[datadog/system-tests](https://github.com/DataDog/system-tests/blob/1d4c6e90ad262c1abca7f90bb3de311ca955b289/utils/build/docker/golang/parametric/datadog.go#L295)を見る限り、コメントから、`DD_TRACE_OTEL_ENABLED`がgoでサポートされていないことが確認できる。

#### `DD_TRACE_AGENT_URL`の設定について

Amazon Lambda上で利用した時のlogを見ると、`agent_url`は自動で設定されていた。`http://localhost:8126/v0.4/traces`

### 2. `OTEL Collectorを利用するパターン`

[Lambda Collector Configuration](https://opentelemetry.io/docs/faas/lambda-collector/)

- LambdaにCollector Lambdaレイヤーを追加して設定する
- OTel Collector LambdaレイヤーのARNを追加する (Amazon Resource Name)
  - [opentelemetry-lambda](https://github.com/open-telemetry/opentelemetry-lambda)

## [AWS Lambda と OpenTelemetry](https://docs.datadoghq.com/ja/serverless/aws_lambda/opentelemetry/)まとめ

AWS の Lambda 関数を OpenTelemetry で測定し、Datadog にデータを送信する方法は複数ある

1. Datadog トレーサーでの OpenTelemetry API サポート (推奨)
   - Lambda 関数内で環境変数 `DD_TRACE_OTEL_ENABLED` を `true` に設定するとある
     - しかし、goではこの環境変数がサポートされていない可能性がある
     - [参考: OpenTelemetry API を使ったカスタムインスツルメンテーション](https://docs.datadoghq.com/ja/tracing/trace_collection/custom_instrumentation/otel_instrumentation/)
       - [参考: Go Custom Instrumentation using the OpenTelemetry API](https://docs.datadoghq.com/ja/tracing/trace_collection/custom_instrumentation/go/otel/)
2. 任意の OpenTelemetry SDK から Datadog Lambda 拡張機能を通して OpenTelemetry トレースを送信する (プレビュー)
   - pythonとNode.jsのサンプルしか記載がない

## Datadog with AWS Lambda References

Datadog 

- [AWS Lambda](https://docs.datadoghq.com/integrations/amazon_lambda/)
- [Datadog Lambda Extension](https://docs.datadoghq.com/serverless/libraries_integrations/extension/)
- [Instrumenting Go Serverless Applications](https://docs.datadoghq.com/serverless/aws_lambda/installation/go/?tab=serverlessframework)
- [AWS Lambda と OpenTelemetry](https://docs.datadoghq.com/ja/serverless/aws_lambda/opentelemetry/)

Github

- [github: DataDog/datadog-lambda-go](https://github.com/DataDog/datadog-lambda-go)
- [datadogのserverlessのgo sample code](https://github.com/DataDog/serverless-sample-app/tree/main/src/go)
