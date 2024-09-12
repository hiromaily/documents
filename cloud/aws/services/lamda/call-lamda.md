# [Lambda 関数の呼び出しメソッドについて](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/lambda-invocation.html)

「Lambda 関数をデプロイ」した後、いくつかの方法で呼び出すことができる

- Lambda コンソール
  - Lambda コンソールを使用し、テストイベントをすばやく作成して関数を呼び出す
- AWS SDK
  - AWS SDK を使用して関数をプログラムによって呼び出す
- 「呼び出し」 API
  - Lambda 呼び出し API を使用して関数を直接呼び出す
- AWS Command Line Interface (AWS CLI)
  - `aws lambda invoke AWS CLI` コマンドを使用して、コマンドラインから関数を直接呼び出す
- 関数 URL の HTTP(S) エンドポイント
  - 関数 URL を使用し、関数を呼び出すために使用できる専用の HTTP(S) エンドポイントを作成する

## [Lambda 関数を同期的に呼び出す](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/invocation-sync.html)

```sh
aws lambda invoke --function-name my-function \
    --cli-binary-format raw-in-base64-out \
    --payload '{ "key": "value" }' response.json
```

- payload は、JSON 形式のイベントを含む文字列
