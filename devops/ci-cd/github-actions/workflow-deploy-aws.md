# Github Actions Workflow Deploy on AWS

1. **Amazon ECS (Elastic Container Service) にデプロイ**
2. **AWS Lambda を使ったサーバーレスデプロイ**
3. **AWS Elastic Beanstalk を使った簡単デプロイ**
4. **Amazon EC2 (Elastic Compute Cloud) にデプロイ**
5. **Amazon EKS (Elastic Kubernetes Service) にデプロイ**

## 1. AWS ECS にデプロイ

### ECS にデプロイする前提条件

1. **Docker イメージを作成する**: アプリケーションを Docker イメージとしてビルドしておく必要がある。これは Docker Hub、`AWS ECR (Elastic Container Registry)`、または他のコンテナレジストリにプッシュする。
2. **ECS クラスターを作成する**: AWS Management Console で ECS クラスターを作成する。
3. **タスク定義を作成する**: ECS タスク定義を作成して、どの Docker イメージを使用するか、必要なリソースや環境変数などを定義する。
4. **サービスを作成する**: ECS クラスター内にサービスを作成して、指定したタスク定義を使用してコンテナを実行する。

### シークレットの設定

まず、GitHub リポジトリのシークレットに必要な情報を設定する。以下のシークレットを追加

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `ECR_REGISTRY`: AWS のアカウント ID とリージョン（例：`123456789012.dkr.ecr.us-west-1.amazonaws.com`）
- `ECR_REPOSITORY`: ECR のリポジトリ名（例：`my-app`）
- `ECS_CLUSTER`: ECS クラスター名
- `ECS_SERVICE`: ECS サービス名

### GitHub Actions ワークフロー for ECS

```yaml
name: Deploy to Amazon ECS

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Check out code
        uses: actions/checkout@v2

      - name: Log in to Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v1

      - name: Build, tag, and push Docker image
        env:
          ECR_REGISTRY: ${{ secrets.ECR_REGISTRY }}
          ECR_REPOSITORY: ${{ secrets.ECR_REPOSITORY }}
          IMAGE_TAG: ${{ github.sha }}
        run: |
          docker build -t $ECR_REPOSITORY:$IMAGE_TAG .
          docker tag $ECR_REPOSITORY:$IMAGE_TAG $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
          docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG

      - name: Deploy to Amazon ECS
        env:
          AWS_REGION: ${{ secrets.AWS_REGION }}
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          ECS_CLUSTER: ${{ secrets.ECS_CLUSTER }}
          ECS_SERVICE: ${{ secrets.ECS_SERVICE }}
          ECR_REGISTRY: ${{ secrets.ECR_REGISTRY }}
          ECR_REPOSITORY: ${{ secrets.ECR_REPOSITORY }}
          IMAGE_TAG: ${{ github.sha }}
        run: |
          aws ecs update-service --cluster $ECS_CLUSTER --service $ECS_SERVICE --force-new-deployment \
            --desired-count 1 --region $AWS_REGION
```

### 上記 ECS への Deploy の Workflow の説明

1. **Check out code**:

   - リポジトリのソースコードをチェックアウトする。

2. **Log in to Amazon ECR**:

   - Amazon ECR にログイン。`aws-actions/amazon-ecr-login@v1`アクションを使用する。

3. **Build, tag, and push Docker image**:

   - Docker イメージをビルドし、ECR にプッシュする。GitHub のコミット SHA をタグとして使用してバージョン管理を行う。

4. **Deploy to Amazon ECS**:
   - ECS にデプロイする。このステップでは、既存のサービスを更新し、最新の Docker イメージを使用して新しいデプロイメントを開始する。

## 2. AWS Lambda にデプロイ (Docker イメージを使う場合)

### AWS Lambda の前提条件

1. AWS アカウントがあること。
2. AWS CLI がインストールされていること。
3. Docker がインストールされていること。
4. GitHub リポジトリに必要なシークレットが設定されていること（例えば、AWS の認証情報など）。

### 1. シークレットの設定

GitHub リポジトリのシークレットに以下を追加：

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `ECR_REGISTRY`（例：`123456789012.dkr.ecr.us-west-2.amazonaws.com`）
- `ECR_REPOSITORY`（例：`my-lambda-repo`）

### 2. Lambda 関数の作成

まず、Golang で AWS Lambda 関数を作成

```go
package main

import (
    "context"
    "github.com/aws/aws-lambda-go/lambda"
)

type MyEvent struct {
    Name string `json:"name"`
}

func HandleRequest(ctx context.Context, event MyEvent) (string, error) {
    return "Hello, " + event.Name, nil
}

func main() {
    lambda.Start(HandleRequest)
}
```

### 2. Dockerfile の作成

Lambda 関数を実行するための`Dockerfile`を作成する

```dockerfile
FROM golang:1.23 as builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN GOARCH=amd64 GOOS=linux go build -o /main

FROM public.ecr.aws/lambda/go:1

COPY --from=builder /main ${LAMBDA_TASK_ROOT}

CMD [ "main" ]
```

### 3. ECR リポジトリの作成とイメージのプッシュ

AWS CLI を使用して、ECR リポジトリを作成し、Docker イメージをプッシュする

```bash
# ECRリポジトリ作成
aws ecr create-repository --repository-name my-lambda-repo

# Dockerログイン
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-west-2.amazonaws.com

# Dockerビルド
docker build -t my-lambda-repo .

# タグ付け
docker tag my-lambda-repo:latest 123456789012.dkr.ecr.us-west-2.amazonaws.com/my-lambda-repo:latest

# イメージをECRにプッシュ
docker push 123456789012.dkr.ecr.us-west-2.amazonaws.com/my-lambda-repo:latest
```

### 4. Lambda 関数の作成または更新

AWS CLI を使用して、Lambda 関数を作成または更新する

```bash
# Lambda関数の作成
aws lambda create-function \
    --function-name my-function \
    --package-type Image \
    --code ImageUri=123456789012.dkr.ecr.us-west-2.amazonaws.com/my-lambda-repo:latest \
    --role arn:aws:iam::123456789012:role/lambda-execution-role

# Lambda関数の更新（既存の関数を更新する場合）
aws lambda update-function-code \
    --function-name my-function \
    --image-uri 123456789012.dkr.ecr.us-west-2.amazonaws.com/my-lambda-repo:latest
```

### GitHub Actions ワークフロー for Lambda

```yaml
name: Deploy to AWS Lambda

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Check out code
        uses: actions/checkout@v2

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1

      - name: Log in to Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v1

      - name: Build, tag, and push Docker image
        env:
          ECR_REGISTRY: ${{ secrets.ECR_REGISTRY }}
          ECR_REPOSITORY: ${{ secrets.ECR_REPOSITORY }}
          IMAGE_TAG: ${{ github.sha }}
        run: |
          docker buildx build --platform linux/amd64 --push -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG .

      - name: Deploy to AWS Lambda
        env:
          AWS_REGION: ${{ secrets.AWS_REGION }}
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          ECR_REGISTRY: ${{ secrets.ECR_REGISTRY }}
          ECR_REPOSITORY: ${{ secrets.ECR_REPOSITORY }}
          IMAGE_TAG: ${{ github.sha }}
        run: |
          aws lambda update-function-code \
            --region $AWS_REGION \
            --function-name my-function \
            --image-uri $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
```

## 3. AWS Elastic Beanstalk にデプロイ

AWS Elastic Beanstalk は、アプリケーションデプロイと管理を自動化するフルマネージドサービス。

### 手順 for Elastic Beanstalk

1. **Elastic Beanstalk の設定**

   - AWS Management Console から新しい Elastic Beanstalk アプリケーションを作成する。

2. **コードのパッケージ**

   - アプリケーションのコードを ZIP ファイルにパッケージする。

3. **ベースイメージの設定**
   - Elastic Beanstalk は様々なランタイムをサポートしているため、使用する言語やフレームワークに応じたベースイメージを選択する。

### GitHub Actions ワークフロー for Elastic Beanstalk

```yaml
name: Deploy to Elastic Beanstalk

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Check out code
        uses: actions/checkout@v2

      - name: Set up Node.js (if needed)
        uses: actions/setup-node@v2
        with:
          node-version: "14"

      - name: Install dependencies (if needed)
        run: npm install

      - name: Zip the source code
        run: zip -r app.zip .

      - name: Deploy to Elastic Beanstalk
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_REGION: "us-west-2"
        run: |
          aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
          aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
          aws configure set region $AWS_REGION

          aws elasticbeanstalk create-application-version --application-name my-app \
            --version-label v1 --source-bundle S3Bucket=my-bucket,S3Key=app.zip
          aws elasticbeanstalk update-environment --environment-name my-env --version-label v1
```

## 4. Amazon EC2 にデプロイ

### 手順 for EC2

1. **EC2 インスタンスの作成**

   - AWS Management Console にログインし、EC2 ダッシュボードから新しいインスタンスを作成。
   - インスタンスに SSH でアクセスできるようにキーペアを設定。

2. **必要なソフトウェアのインストール**

   - インスタンスに SSH で接続し、必要なソフトウェア（例：Apache、Nginx、Go ランタイムなど）をインストール。

3. **コードのデプロイ**
   - コードを EC2 インスタンスに転送し（例：`scp`コマンドや`rsync`を使用）、ビルドして実行。

### GitHub Actions ワークフロー for EC2

```yaml
name: Deploy to EC2

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Check out code
        uses: actions/checkout@v2

      - name: Build the Go app
        run: go build -v -o main .

  deploy:
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Check out code
        uses: actions/checkout@v2

      - name: Deploy to EC2
        env:
          SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
          EC2_HOST: ${{ secrets.EC2_HOST }}
          EC2_USER: ${{ secrets.EC2_USER }}
        run: |
          echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add - > /dev/null
          scp -o StrictHostKeyChecking=no -r ./main $EC2_USER@$EC2_HOST:/home/$EC2_USER/app/main
          ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST "pkill main || true && nohup /home/$EC2_USER/app/main &"
```
