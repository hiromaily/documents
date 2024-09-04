# AWS Lamda

- [Lamda](https://aws.amazon.com/jp/pm/lambda/)
- [AWS Lambda FAQs](https://aws.amazon.com/lambda/faqs/)

## [Lambda プログラミングモデル](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/foundation-progmodel.html)

- コードと Lambda システムとの間のインターフェイスを定義するもの。
- 関数設定のハンドラを定義して、関数へのエントリポイントを Lambda に伝える。
- ランタイムは、`呼び出しイベント`、および`関数名`や`リクエスト ID` などのコンテキストを含むオブジェクトを`ハンドラー`に渡す。
- ハンドラーが最初のイベントの処理を終了すると、ランタイムは`別のイベントを送信する`。
- 関数のクラスはメモリ内にとどまるため、初期化コードにおいて、ハンドラーメソッドの外部で宣言されたクライアントおよび変数は再利用が可能。
- 後続のイベントの処理時間を短縮するには、初期化中に AWS SDK クライアントなどの再利用可能なリソースを作成する。
- 初期化されると、関数の各インスタンスは数千件のリクエストを処理できる。
- 関数は、`/tmp` ディレクトリ内のローカルストレージにもアクセスできる。
- ディレクトリのコンテンツは、実行環境が停止された際に維持され、複数の呼び出しに使用できる一時的なキャッシュとなる
- ランタイムは、関数からのログ出力をキャプチャし、`Amazon CloudWatch Logs` に送信する。
  - 普通のlogで良い
- ランタイムは、関数の出力をログに記録するだけでなく、`関数の呼び出しの開始時`と`終了時`にエントリも記録する。
- これには、`リクエスト ID`、`請求期間`、`初期化期間`、およびその他の詳細を含むレポートログが含まれる。
- 関数によりエラーがスローされた場合、そのエラーは、ランタイムにより呼び出し元に返信される。
- Lambda は、需要の増加に応じて追加のインスタンスを実行し、需要の減少に応じてインスタンスを停止することで関数をスケーリングする。
- このモデルは、次のようなアプリケーションアーキテクチャにおいてばらつきが生じる
  - 受信リクエストは、順不同または同時に処理される。
  - 関数のインスタンスが長く存続することを想定せず、アプリケーションの状態を別の場所に保存する
  - ローカルストレージとクラスレベルのオブジェクトを使用することで、パフォーマンスを向上させられる。その場合でも、デプロイパッケージのサイズと実行環境に転送するデータの量は最小限に抑える。

## 環境構築の流れ

[参考: コンテナイメージを使用して Go Lambda 関数をデプロイする](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/go-image.html)

### 前提条件

- Go
- AWS の OS 専用ベースイメージ (provided.al2023)を使用

### 手順

#### 1. lamda環境で実行可能な`handler()`を備えた`main.go`を実装

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

#### 2. Dockerfileの作成

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

#### 3. Imageのビルド + 任意のtagをセット

```sh
docker build --platform linux/amd64 -t docker-image:test .
```

#### 4. ImageをLocalで実行できるかどうか、確認する

```sh
docker run -d -p 9000:8080 \
--entrypoint /usr/local/bin/aws-lambda-rie \
docker-image:test ./main
```

- endpointにイベントをpost

```sh
curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```

#### 5. イメージのデプロイ

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
  --role arn:aws:iam::111122223333:role/lambda-ex
```

#### 6. 関数を呼び出す

```sh
aws lambda invoke --function-name hello-world response.json
```

## [AWS Lamdaコマンド](https://docs.aws.amazon.com/cli/latest/reference/lambda/)

### [create-function](https://docs.aws.amazon.com/cli/latest/reference/lambda/create-function.html)

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

#### このとき、docker imageのコマンドラインパラメータをどうやって付与するか？

- `--cli-input-json` (string)

提供された JSON 文字列に基づいてサービス操作を実行する。JSON 文字列は、`--generate-cli-skeleton` で提供される形式に従う。コマンド ラインで他の引数が指定された場合、CLI 値は JSON で提供される値を上書きする。文字列は文字通りに解釈されるため、JSON で提供される値を使用して任意のバイナリ値を渡すことはできない。 
`--generate-cli-skeleton`を確認してみたが、これは用途が異なるようだ。  

[結論: 参照: Lamdaのアーキテクチャ](./lambda.md#lamdaのアーキテクチャ)

### [invoke](https://docs.aws.amazon.com/cli/latest/reference/lambda/invoke.html)

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

## Lamdaのアーキテクチャ

AWS Lambda はシンプルさとスケーラビリティのために`コンテナイメージごとに 1 つの関数を実行するように設計されている`ため、単一の Docker コンテナイメージ内で複数の AWS Lambda 関数を実行することは一般的なユースケースではない。ただし、実行に基づいて同じイメージ内のハンドラーを切り替える必要があるユースケースの場合は、`環境変数`または同様の方法を使用して、呼び出すハンドラーを指定できる。これには次の方法がある。


```sh
# Deploy function1
aws lambda create-function \
    --function-name lambda-function-1 \
    --package-type Image \
    --code ImageUri=your-docker-image-uri \
    --environment Variables={HANDLER=function1} \
    --role arn:aws:iam::your-account-id:role/your-lambda-role

# Deploy function2
aws lambda create-function \
    --function-name lambda-function-2 \
    --package-type Image \
    --code ImageUri=your-docker-image-uri \
    --environment Variables={HANDLER=function2} \
    --role arn:aws:iam::your-account-id:role/your-lambda-role
```

## [Lamdaの実行環境](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtime-environment.html)

WIP

## [Go による Lambda 関数の構築](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/lambda-golang.html)

- Go は、他のマネージドランタイムとは異なる方法で実装されている
- Go は実行可能バイナリにネイティブにコンパイルするため、専用の言語ランタイムは必要ない。
- Go 関数を Lambda にデプロイするには、[OS 専用ランタイム](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/runtimes-provided.html)の`provided` を使用する

### Go ランタイムのサポート

- Lambda の `Go 1.x` マネージドランタイムは非奨励
- Go 1.x ランタイムを使用する関数がある場合は、関数を `provided.al2023` または `provided.al2` に移行する必要がある。
- `provided.al2023` および `provided.al2` ランタイムには、以下の利点がある
  - arm64 アーキテクチャのサポート (AWS Graviton2 プロセッサー)
  - バイナリの小型化
  - 若干の呼び出し時間短縮化など

### ツールとライブラリ

- [github: AWS SDK for Go](https://github.com/aws/aws-sdk-go)
  - Go プログラミング言語用の公式の AWS SDK
- [github.com/aws/aws-lambda-go/lambda](https://github.com/aws/aws-lambda-go/tree/main/lambda)
  - Go 用の Lambda プログラミングモデルの実装
  - このパッケージは、ハンドラーを呼び出すために AWS Lambda で使用される
  - [lambdacontext](https://github.com/aws/aws-lambda-go/tree/main/lambdacontext)
    - コンテキストオブジェクトからコンテキスト情報にアクセスするためのヘルパー
  - [events](https://github.com/aws/aws-lambda-go/tree/main/events)
    - 一般的なイベントソース統合のタイプの定義を提供する

### [Go の Lambda 関数ハンドラーの定義](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/golang-handler.html)

- Lamdaで実行されるアプリケーション実装時に必要なDocs

```go
package main

import (
	"context"
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
)

type MyEvent struct {
	Name string `json:"name"`
}

// Lambda 関数のエントリポイント
// 関数が呼び出されたときに実行されるロジック
// - ctx context.Context: Lambda 関数呼び出しへのランタイム情報
// - event *MyEvent: これは MyEvent をポイントする event という名前のパラメータです。Lambda 関数への入力を表す
// - 戻り値
//   - *string: Lambda 関数の結果を含む文字列へのポインタ
//   - error:   エラータイプで、エラーがない場合は nil となり、何か問題が発生した場合は標準的なエラー情報 を含む
func HandleRequest(ctx context.Context, event *MyEvent) (*string, error) {
	if event == nil {
		return nil, fmt.Errorf("received nil event")
	}
	message := fmt.Sprintf("Hello %s!", event.Name)
	return &message, nil
}

func main() {
	lambda.Start(HandleRequest)
}
```

#### Lamda Handlerの疑問

- `lambda.Start`は何も戻り値を受け取らないが、`HandleRequest()`の戻り値は何によって処理されるのか？また、そのI/Fはどうなっているのか？
- EventはおそらくLamda起動時に設定するもの

### [コンテナイメージを使用して Go Lambda 関数をデプロイする](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/go-image.html)

- まず、[AWS の OS 専用ベースイメージを使用する](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/images-create.html#runtimes-images-provided) こちらの方法で構築することになるはず


#### provided.al2023 ベースイメージからイメージを作成する

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

## [Lambda サンプルアプリケーション](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/lambda-samples.html)

- [go-al2](https://github.com/aws-samples/sessions-with-aws-sam/tree/master/go-al2)
  - provided.al2 カスタムランタイムを使用
- [blank-go](https://github.com/awsdocs/aws-lambda-developer-guide/tree/main/sample-apps/blank-go)
  - go1.x ランタイムを使用


## [コンテナイメージを使用した Lambda 関数の作成](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/images-create.html)

- [AWS Lambda の新機能 – コンテナイメージのサポート (古い)](https://aws.amazon.com/jp/blogs/news/new-for-aws-lambda-container-image-support/)

- AWS Lambda 関数のコードは、`スクリプトまたはコンパイルされたプログラム`、さらに`それらの依存関係`で構成される
- デプロイパッケージを使用して、Lambda に関数コードをデプロイする。
- Lambda は、`コンテナイメージ`と `.zip ファイルアーカイブ`の 2 種類のデプロイパッケージをサポート

### Lambda 関数のコンテナイメージを構築する 3 つの方法

#### Lambda の AWS ベースイメージを使用する

AWS ベースイメージには、言語ランタイム、Lambda と関数コード間のやり取りを管理するランタイムインターフェイスクライアント、ローカルテスト用のランタイムインターフェイスエミュレーターがプリロードされている

#### [AWS の OS 専用ベースイメージを使用する](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/images-create.html#runtimes-images-provided)

AWS OS 専用ベースイメージには、Amazon Linux ディストリビューションおよびランタイムインターフェイスエミュレータが含まれている。これらのイメージは、`Go` や `Rust` などのコンパイル済み言語や、Lambda がベースイメージを提供していない言語または言語バージョン (Node.js 19 など) のコンテナイメージの作成によく使用される。OS 専用のベースイメージを使用してカスタムランタイムを実装することもできる。イメージに Lambda との互換性を持たせるには、当該言語のランタイムインターフェイスクライアントをイメージに含める必要がある。

#### 非 AWS ベースイメージを使用する

Alpine Linux や Debian など、別のコンテナレジストリの代替ベースイメージを使用することもできる。組織が作成したカスタムイメージを使用することもできる。イメージに Lambda との互換性を持たせるには、当該言語のランタイムインターフェイスクライアントをイメージに含める必要がある。


## [Lambda 関数の呼び出しメソッドについて](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/lambda-invocation.html)

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

### [Lambda 関数を同期的に呼び出す](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/invocation-sync.html)

```sh
aws lambda invoke --function-name my-function \
    --cli-binary-format raw-in-base64-out \
    --payload '{ "key": "value" }' response.json
```

- payload は、JSON 形式のイベントを含む文字列


## 対応している言語

- [Go](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/lambda-golang.html)
- [Rust](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/lambda-rust.html)
- Node.js
- Python
- Java
- Ruby
- C#
- PowerShell


## WIP: 使い分け

処理量が少なかったり、15 分といった長い時間実行するようなものでなければ、container 上に deploy した batch プログラムより`lamda`を使った方がよい
