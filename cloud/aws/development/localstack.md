# LocalStack

LocalStackは、AWSのクラウドサービスをローカル環境で模倣するためのツール。これにより、ローカル環境でAWSのサービスを使用することができ、開発やテストに利用できる。

## LocalStackの基本情報

1. **目的**:
   - ローカル環境でAWSの様々なサービス（S3, DynamoDB, SQS, SNSなど）を模擬し、開発およびテストを容易にすること。

2. **主な利点**:
   - **コスト削減**: 本物のAWSサービスを使わないため料金が発生しない。
   - **スピード**: ローカルで動作するため、通信速度が高速。
   - **オフライン開発**: インターネット接続がなくてもAWSサービスの使用が可能。
   - **テスト容易化**: 定義された環境で一貫したテストが可能。

## MacOS上でのセットアップ方法

[LocalStack: github: DOCKER.md](https://github.com/localstack/localstack/blob/master/DOCKER.md)

1. **DockerのExtensionをインストール**
   LocalStackは、Dockerコンテナとして提供されている

   ![docker localstack](https://github.com/hiromaily/documents/raw/main/images/docker-localstack.png "docker localstack")

2. **LocalStackのインストールと起動**:

   `compose.yaml`ファイル

   ```yaml
    volumes:
        localstack-data:

   services:
     localstack:
       image: localstack/localstack:latest
       container_name: localstack
       ports:
         - "4566:4566"  # Edge port
         #- "4571:4571"
         - "4510-4559:4510-4559"
       environment:
         - SERVICES=s3,dynamodb,lambda  # 使用するサービスを指定
         - DEBUG=1
         - PERSISTENCE=1
         #- DATA_DIR=/tmp/localstack/data
         #- LAMBDA_EXECUTOR=docker-reuse
       volumes:
         - localstack-data:/var/lib/localstack
         #- "${TMPDIR:-/tmp}/localstack:/tmp/localstack"
   ```

   ```sh
   docker-compose up -d
   ```

3. **AWS CLIを設定**:
   LocalStackのエンドポイントを指定するために、AWS CLIのプロファイルを設定する。

   ```sh
   aws configure --profile localstack
   # AWS Access Key ID [None]: test
   # AWS Secret Access Key [None]: test
   # Default region name [None]: us-east-1
   # Default output format [None]: json

   export AWS_PROFILE=localstack
   export AWS_ENDPOINT_URL=http://127.0.0.1:4566
   ```

## LocalStackで利用されるPort

1. **4566 (Edge Port)**
   - **概要**: LocalStackの主要なエッジポート。ほとんどのAWSサービスがこの単一のポートを通じてアクセス可能。
   - **目的**: サービスのリクエストを一つのエンドポイントで受け取るため。

[DOCKER.md](https://github.com/localstack/localstack/blob/master/DOCKER.md)を見ると、`-p 4566:4566 -p 4510-4559:4510-4559`が使われている

## LocalStackの使い方

LocalStackを使用する際、基本的なAWS CLIコマンドにエンドポイントを指定して実行する必要がある。
[AWS CLIの最新バージョンのインストールまたは更新](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/getting-started-install.html)

※ [LocalStack AWS CLI (awelocal)](https://docs.localstack.cloud/user-guide/integrations/aws-cli/#localstack-aws-cli-awslocal) というものが存在するが、これは不要？

1. **S3バケットの作成**:

   ```sh
   aws --endpoint-url=$AWS_ENDPOINT_URL s3 mb s3://my-test-bucket
   ```

2. **DynamoDBテーブルの作成**:

   ```sh
   aws --endpoint-url=$AWS_ENDPOINT_URL dynamodb create-table \
       --table-name MyTable \
       --attribute-definitions AttributeName=Id,AttributeType=S \
       --key-schema AttributeName=Id,KeyType=HASH \
       --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
   ```

### Dockerコンテナ+Goによる、Lambda functionのデプロイ

Note: `無料版ではコンテナイメージを使用したAWS Lambda関数の実行はサポートされていない`

まず、local環境用のimageのregistryを用意する

compose.yaml

```yaml
services:
  localstack:
    ...

  # local docker image registry for lambda on localstack
  registry:
    image: registry:2
    ports:
      - "5000:5000"
    restart: always
    container_name: registry
```

次に、imageをビルドし、tag付してpushする

```sh
docker build --progress=plain --build-arg COMMIT_ID=$(COMMIT_ID) --build-arg ENV_FILE=.env.local -t my-program:latest -f ./Dockerfile .
docker tag communication-hub-batch:local localhost:5000/my-program:latest
docker push localhost:5000/my-program:latest
```

次に、`create function`を実行する

```sh
# Goのプログラムを書いて、ImageでDeployしている前提
# Docker Imageは、通常、Docker HubもしくはECRだが、先ほど指定したlocal環境に向ける
# --roleはdummyでもセットしておく必要がある
aws --endpoint-url=$AWS_ENDPOINT_URL lambda create-function \
      --function-name my-function \
      --package-type Image \
      --code ImageUri=localhost:5000/my-program:latest \
      --role arn:aws:iam::000000000000:role/lambda-ex \
      --image-config '{"Command":["health"]}'
```

実行するには、

```sh
aws --endpoint-url=$AWS_ENDPOINT_URL lambda invoke \
    --function-name my-function \
    --payload '{"name": "World"}' \
    output.txt
```

## docker起動時に初期化する

[Initialization Hooks](https://docs.localstack.cloud/references/init-hooks/)

```txt
/etc
└── localstack
    └── init
        ├── boot.d           <-- executed in the container before localstack starts
        ├── ready.d          <-- executed when localstack becomes ready
        ├── shutdown.d       <-- executed when localstack shuts down
        └── start.d          <-- executed when localstack starts up
```

1. **boot.d**:
   - **概要**: LocalStackのコンテナ内でLocalStackが起動する前に実行されるスクリプトを配置するディレクトリ。
   - **用途**: 環境設定や依存関係のインストール、ネットワーク設定の調整など、LocalStack自体が開始する前に行いたい準備を記述できる。

2. **ready.d**:
   - **概要**: LocalStackが完全に起動し、準備ができた状態になったときに実行されるスクリプトを配置するディレクトリ。
   - **用途**: サービスの起動確認や初期データのロード、APIのモック設定など、LocalStackが使用可能になったタイミングで実行したいタスクを記述できる。

3. **shutdown.d**:
   - **概要**: LocalStackがシャットダウンする際に実行されるスクリプトを配置するディレクトリ。
   - **用途**: ログの保存、リソースのクリーンアップ、セッションの終了処理など、シャットダウン前に行いたい後処理を記述できる。

4. **start.d**:
   - **概要**: LocalStackのプロセスが開始するタイミングで実行されるスクリプトを配置するディレクトリ。
   - **用途**: サービスのヘルスチェックや初期設定、デバッグ用の設定など、LocalStackが稼働し始めたタイミングで実行したいタスクを記述できる。

### スクリプト実行順序

1. boot.d内のスクリプトが順に実行される。
   LocalStackのメインプロセスが開始。
2. start.d内のスクリプトが順に実行される。
   LocalStackの全サービスが「準備完了」状態になる。
3. ready.d内のスクリプトが順に実行される。
   LocalStackがシャットダウンされるタイミングでshutdown.d内のスクリプトが順に実行される。

### 初期化処理のための `compose.yaml` の書き方

```yaml
services:
  localstack:
    container_name: "${LOCALSTACK_DOCKER_NAME:-localstack-main}"
    image: localstack/localstack
    ports:
      - "127.0.0.1:4566:4566"
    environment:
      - DEBUG=1
    volumes:
      - "/path/to/init-aws.sh:/etc/localstack/init/ready.d/init-aws.sh"  # ready hook
      - "${LOCALSTACK_VOLUME_DIR:-./volume}:/var/lib/localstack"
      - "/var/run/docker.sock:/var/run/docker.sock"

  # local docker image registry for lambda on localstack
  registry:
    image: registry:2
    ports:
      - "5000:5000"
    restart: always
    container_name: registry
```

init-aws.sh

```sh
#!/bin/bash

awslocal s3 mb s3://my-buckets
```

## [localstackのディレクトリ構成](https://docs.localstack.cloud/references/filesystem/)

## S3のコマンド

```sh
# バケットの作成
aws --endpoint-url=${AWS_ENDPOINT_URL} s3 mb s3://my-bucket


# ファイルのアップロード
aws --endpoint-url=${AWS_ENDPOINT_URL} s3 cp ./tmp/dummy.txt s3://my-bucket/example/dummy

# ファイルのダウンロード
aws --endpoint-url=${AWS_ENDPOINT_URL} s3 cp s3://my-bucket/example/dummy ./tmp/dummy-dl.txt

# ファイルの確認
aws --endpoint-url=${AWS_ENDPOINT_URL} s3 ls s3://my-bucket --recursive
aws --endpoint-url=${AWS_ENDPOINT_URL} s3api get-object --bucket my-bucket --key example/dummy /dev/stdout
```

## 注意点

- 本番環境とは異なる動作をすることがあるため、本番前に必ずAWS実環境でのテストを行うことが推奨される
- LocalStackの無料バージョンには、一部制限があり、もし高度な機能が必要な場合は、LocalStack有料版を検討する
- Makefileで`AWS_ENDPOINT_URL`という名前のlocal変数を定義したら、target内で実行されるgoのコードにも影響を与えたので注意が必要

## References

- [LocalStack Docs](https://docs.localstack.cloud/overview/)
- [LocalStack Docker Extension](https://docs.localstack.cloud/user-guide/tools/localstack-docker-extension/)
- [LocalStack Lambda](https://docs.localstack.cloud/user-guide/aws/lambda/)
- [LocalStack: github](https://github.com/localstack/localstack)
  - [LocalStack: github: DOCKER.md](https://github.com/localstack/localstack/blob/master/DOCKER.md)
