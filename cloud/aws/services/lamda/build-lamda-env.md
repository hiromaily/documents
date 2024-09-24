# Lambda 環境構築の流れ

[参考: コンテナイメージを使用して Go Lambda 関数をデプロイする](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/go-image.html)

## 前提条件

- Go
- AWS の OS 専用ベースイメージ (provided.al2023)を使用

## 手順

### 1. Lambda 環境で実行可能な`handler()`を備えた`main.go`を実装

```go
package main

import (
 "context"
 "github.com/aws/aws-lambda-go/events"
 "github.com/aws/aws-lambda-go/lambda"
)

func handler(ctx context.Context, event events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
 response := events.APIGatewayProxyResponse{
  StatusCode: 200,
  Body:       "\"Hello from Lambda!\"",
 }
 return response, nil
}

func main() {
 lambda.Start(handler)
}
```

### 2. Dockerfile の作成

```dockerfile
FROM golang:1.23 as build
WORKDIR /helloworld
# Copy dependencies list
COPY go.mod go.sum ./
# Build with optional lambda.norpc tag
COPY main.go .
RUN go build -tags lambda.norpc -o main main.go

# Copy artifacts to a clean image
FROM public.ecr.aws/lambda/provided:al2023
COPY --from=build /helloworld/main ./main
ENTRYPOINT [ "./main" ]
```

### 3. Image のビルド + 任意の tag をセット

```sh
docker build --platform linux/amd64 -t docker-image:test .
```

### 4. Image を Local で実行できるかどうか、確認する

```sh
docker run -d -p 9000:8080 \
--entrypoint /usr/local/bin/aws-lambda-rie \
docker-image:test ./main
```

- endpoint にイベントを post

```sh
curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```

### 5. イメージのデプロイ

Amazon ECR にイメージをアップロードして Lambda 関数を作成する

- `get-login-password` コマンドを実行して Amazon ECR レジストリに Docker CLI を認証

```sh
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 111122223333.dkr.ecr.us-east-1.amazonaws.com
```

- `create-repository` コマンドを使用して Amazon ECR にリポジトリを作成する

```sh
aws ecr create-repository --repository-name hello-world --region us-east-1 --image-scanning-configuration scanOnPush=true --image-tag-mutability MUTABLE
```

- `docker tag`コマンドを実行して、最新バージョンとしてローカルイメージを Amazon ECR リポジトリにタグ付けする

```sh
docker tag docker-image:test <ECRrepositoryUri>:latest
```

- `docker push` コマンドを実行して Amazon ECR リポジトリにローカルイメージをデプロイ

```sh
docker push 111122223333.dkr.ecr.us-east-1.amazonaws.com/hello-world:latest
```

- Lambda 関数を作成 (create-function)

```sh
aws lambda create-function \
  --function-name hello-world \
  --package-type Image \
  --code ImageUri=111122223333.dkr.ecr.us-east-1.amazonaws.com/hello-world:latest \
  --image-config='{"Command": ["subcommand", "--flag", "flag-value"]}' \
  --role arn:aws:iam::111122223333:role/lambda-ex
```

- Lambda 関数のアップデート

### 6. 関数を呼び出す

```sh
aws lambda invoke --function-name hello-world response.json
```
