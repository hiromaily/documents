# [AWS Lambda コマンド](https://docs.aws.amazon.com/cli/latest/reference/lambda/)

## [create-function](https://docs.aws.amazon.com/cli/latest/reference/lambda/create-function.html)

```
  create-function
--function-name <value>
[--runtime <value>]
--role <value>
[--handler <value>]
[--code <value>]
[--description <value>]
[--timeout <value>]
[--memory-size <value>]
[--publish | --no-publish]
[--vpc-config <value>]
[--package-type <value>]
[--dead-letter-config <value>]
[--environment <value>]
[--kms-key-arn <value>]
[--tracing-config <value>]
[--tags <value>]
[--layers <value>]
[--file-system-configs <value>]
[--image-config <value>]
[--code-signing-config-arn <value>]
[--architectures <value>]
[--ephemeral-storage <value>]
[--snap-start <value>]
[--logging-config <value>]
[--zip-file <value>]
[--cli-input-json <value>]
[--generate-cli-skeleton <value>]
[--debug]
[--endpoint-url <value>]
[--no-verify-ssl]
[--no-paginate]
[--output <value>]
[--query <value>]
[--profile <value>]
[--region <value>]
[--version <value>]
[--color <value>]
[--no-sign-request]
[--ca-bundle <value>]
[--cli-read-timeout <value>]
[--cli-connect-timeout <value>]
```

### このとき、docker image のコマンドラインパラメータをどうやって付与するか？

- `--cli-input-json` (string)

提供された JSON 文字列に基づいてサービス操作を実行する。JSON 文字列は、`--generate-cli-skeleton` で提供される形式に従う。コマンド ラインで他の引数が指定された場合、CLI 値は JSON で提供される値を上書きする。文字列は文字通りに解釈されるため、JSON で提供される値を使用して任意のバイナリ値を渡すことはできない。
`--generate-cli-skeleton`を確認してみたが、これは用途が異なるようだ。

- `--image-config` (structure)

コンテナ イメージ Dockerfile 内の値をオーバーライドするコンテナ イメージ構成値

```json
{
  "EntryPoint": ["string", ...],
  "Command": ["string", ...],
  "WorkingDirectory": "string"
}
```

## [invoke](https://docs.aws.amazon.com/cli/latest/reference/lambda/invoke.html)

```
--function-name <value>
[--invocation-type <value>]
[--log-type <value>]
[--client-context <value>]
[--payload <value>]
[--qualifier <value>]
<outfile>
[--debug]
[--endpoint-url <value>]
[--no-verify-ssl]
[--no-paginate]
[--output <value>]
[--query <value>]
[--profile <value>]
[--region <value>]
[--version <value>]
[--color <value>]
[--no-sign-request]
[--ca-bundle <value>]
[--cli-read-timeout <value>]
[--cli-connect-timeout <value>]
```

## [update-function-code](https://docs.aws.amazon.com/cli/latest/reference/lambda/update-function-code.html)

```
 update-function-code
--function-name <value>
[--zip-file <value>]
[--s3-bucket <value>]
[--s3-key <value>]
[--s3-object-version <value>]
[--image-uri <value>]
[--publish | --no-publish]
[--dry-run | --no-dry-run]
[--revision-id <value>]
[--architectures <value>]
[--cli-input-json <value>]
[--generate-cli-skeleton <value>]
[--debug]
[--endpoint-url <value>]
[--no-verify-ssl]
[--no-paginate]
[--output <value>]
[--query <value>]
[--profile <value>]
[--region <value>]
[--version <value>]
[--color <value>]
[--no-sign-request]
[--ca-bundle <value>]
[--cli-read-timeout <value>]
[--cli-connect-timeout <value>]
```

## [update-function-configuration](https://docs.aws.amazon.com/cli/latest/reference/lambda/update-function-configuration.html)

```
  update-function-configuration
--function-name <value>
[--role <value>]
[--handler <value>]
[--description <value>]
[--timeout <value>]
[--memory-size <value>]
[--vpc-config <value>]
[--environment <value>]
[--runtime <value>]
[--dead-letter-config <value>]
[--kms-key-arn <value>]
[--tracing-config <value>]
[--revision-id <value>]
[--layers <value>]
[--file-system-configs <value>]
[--image-config <value>]
[--ephemeral-storage <value>]
[--snap-start <value>]
[--logging-config <value>]
[--cli-input-json <value>]
[--generate-cli-skeleton <value>]
[--debug]
[--endpoint-url <value>]
[--no-verify-ssl]
[--no-paginate]
[--output <value>]
[--query <value>]
[--profile <value>]
[--region <value>]
[--version <value>]
[--color <value>]
[--no-sign-request]
[--ca-bundle <value>]
[--cli-read-timeout <value>]
[--cli-connect-timeout <value>]
```
