# [Go による Lambda 関数の構築](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/lambda-golang.html)

- Go は、他のマネージドランタイムとは異なる方法で実装されている
- Go は実行可能バイナリにネイティブにコンパイルするため、専用の言語ランタイムは必要ない。
- Go 関数を Lambda にデプロイするには、[OS 専用ランタイム](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/runtimes-provided.html)の`provided` を使用する

## Go ランタイムのサポート

- Lambda の `Go 1.x` マネージドランタイムは非奨励
- Go 1.x ランタイムを使用する関数がある場合は、関数を `provided.al2023` または `provided.al2` に移行する必要がある。
- `provided.al2023` および `provided.al2` ランタイムには、以下の利点がある
  - arm64 アーキテクチャのサポート (AWS Graviton2 プロセッサー)
  - バイナリの小型化
  - 若干の呼び出し時間短縮化など

## ツールとライブラリ

- [github: AWS SDK for Go](https://github.com/aws/aws-sdk-go)
  - Go プログラミング言語用の公式の AWS SDK
- [github.com/aws/aws-lambda-go/lambda](https://github.com/aws/aws-lambda-go/tree/main/lambda)
  - Go 用の Lambda プログラミングモデルの実装
  - このパッケージは、ハンドラーを呼び出すために AWS Lambda で使用される
  - [lambdacontext](https://github.com/aws/aws-lambda-go/tree/main/lambdacontext)
    - コンテキストオブジェクトからコンテキスト情報にアクセスするためのヘルパー
  - [events](https://github.com/aws/aws-lambda-go/tree/main/events)
    - 一般的なイベントソース統合のタイプの定義を提供する

## [Go の Lambda 関数ハンドラーの定義](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/golang-handler.html)

- Lambda で実行されるアプリケーション実装時に必要な Docs

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

### Lambda Handler の疑問

- `lambda.Start`は何も戻り値を受け取らないが、`HandleRequest()`の戻り値は何によって処理されるのか？また、その I/F はどうなっているのか？
- Event はおそらく Lambda 起動時に設定するもの

## [コンテナイメージを使用して Go Lambda 関数をデプロイする](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/go-image.html)

- まず、[AWS の OS 専用ベースイメージを使用する](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/images-create.html#runtimes-images-provided) こちらの方法で構築することになるはず

### provided.al2023 ベースイメージからイメージを作成する

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
