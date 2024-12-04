# AWS Xray のTracingについて

## References

- [Getting started with X-Ray](https://docs.aws.amazon.com/xray/latest/devguide/xray-gettingstarted.html)
- [AWS Distro for OpenTelemetry Go](https://docs.aws.amazon.com/xray/latest/devguide/xray-go-opentel-sdk.html)
- [AWS X-Ray SDK for Go](https://docs.aws.amazon.com/xray/latest/devguide/xray-sdk-go.html)
- [AWS Distro for OpenTelemetry (ADOT) technical docs](https://aws-otel.github.io/docs/introduction)
  - [Getting Started with the AWS Distro for OpenTelemetry Collector](https://aws-otel.github.io/docs/getting-started/collector)
  - [Go-SDK](https://aws-otel.github.io/docs/getting-started/go-sdk)
    - [Using the AWS Distro for OpenTelemetry Go SDK](https://aws-otel.github.io/docs/getting-started/go-sdk/manual-instr)
      - サンプルコードがわかりやすい
    - [github: aws-otel-community / Go Opentelemetry Sample App](https://github.com/aws-observability/aws-otel-community/tree/master/sample-apps/go-sample-app)
- [コンテナでデプロイした Lambda から OpenTelemetry でトレースを X-Ray に送る](https://aws.amazon.com/jp/blogs/news/sending-traces-from-containerized-lambda-to-xray/)
  - [github: Sending Traces to AWS X-Ray Using OpenTelemetry SDK from Containerized Lambda](https://github.com/aws-samples/opentelemetry-lambda-container) -> Rustで書かれていた
