# AWS Lambda

- [Lambda](https://aws.amazon.com/jp/pm/lambda/)
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
  - 普通の log で良い
- ランタイムは、関数の出力をログに記録するだけでなく、`関数の呼び出しの開始時`と`終了時`にエントリも記録する。
- これには、`リクエスト ID`、`請求期間`、`初期化期間`、およびその他の詳細を含むレポートログが含まれる。
- 関数によりエラーがスローされた場合、そのエラーは、ランタイムにより呼び出し元に返信される。
- Lambda は、需要の増加に応じて追加のインスタンスを実行し、需要の減少に応じてインスタンスを停止することで関数をスケーリングする。
- このモデルは、次のようなアプリケーションアーキテクチャにおいてばらつきが生じる
  - 受信リクエストは、順不同または同時に処理される。
  - 関数のインスタンスが長く存続することを想定せず、アプリケーションの状態を別の場所に保存する
  - ローカルストレージとクラスレベルのオブジェクトを使用することで、パフォーマンスを向上させられる。その場合でも、デプロイパッケージのサイズと実行環境に転送するデータの量は最小限に抑える。

## Lambda のアーキテクチャ

AWS Lambda はシンプルさとスケーラビリティのために`コンテナイメージごとに 1 つの関数を実行するように設計されている`ため、単一の Docker コンテナイメージ内で複数の AWS Lambda 関数を実行することは一般的なユースケースではない。ただし、実行に基づいて同じイメージ内のハンドラーを切り替える必要があるユースケースの場合は、`環境変数`または同様の方法を使用して、呼び出すハンドラーを指定できる。これには次の方法がある。

```sh
# Deploy function1
aws lambda create-function \
    --function-name lambda-function-1 \
    --package-type Image \
    --code ImageUri=your-docker-image-uri \
    --environment Variables={HANDLER=function1} \
    --role arn:aws:iam::your-account-id:role/lambda-role

# Deploy function2
aws lambda create-function \
    --function-name lambda-function-2 \
    --package-type Image \
    --code ImageUri=your-docker-image-uri \
    --environment Variables={HANDLER=function2} \
    --role arn:aws:iam::your-account-id:role/lambda-role
```

とはいえ、`create-function`コマンドの`--image-config`オプションでコンテナの command を変更できる

## [Lambda の実行環境](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtime-environment.html)

WIP

## [Lambda サンプルアプリケーション](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/lambda-samples.html)

- [go-al2](https://github.com/aws-samples/sessions-with-aws-sam/tree/master/go-al2)
  - provided.al2 カスタムランタイムを使用
- [blank-go](https://github.com/awsdocs/aws-lambda-developer-guide/tree/main/sample-apps/blank-go)
  - go1.x ランタイムを使用
