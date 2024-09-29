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

Lambdaは、安全で分離された実行環境を提供する実行環境で関数を呼び出す。 実行環境は、関数の実行に必要なリソースを管理する。 実行環境はまた、関数のランタイムと、関数に関連付けられた外部拡張のライフサイクルサポートを提供する。

関数のランタイムは Runtime API を使って Lambda と通信する。 エクステンションは Extensions API を使って Lambda と通信する。 エクステンションは Telemetry API を使って、関数からログメッセージやその他の遠隔測定を受け取ることもできる。

![lambda api concept](https://github.com/hiromaily/documents/raw/main/images/lambda-telemetry-api-concept.png "lambda api concept")

Lambda関数を作成する際には、利用可能なメモリ量や関数の最大実行時間などの設定情報を指定する。 Lambdaはこの情報を使って実行環境を設定する。

関数のランタイムと各外部拡張は、実行環境内で実行されるプロセスのこと。 パーミッション、リソース、認証情報、環境変数は、関数と拡張の間で共有される。

### ラムダ実行環境のライフサイクル

![lambda execution environment lifecycle](https://github.com/hiromaily/documents/raw/main/images/lambda-execution-env-lifecycle.png "lambda execution environment lifecycle")

各フェーズは、Lambdaがランタイムと登録されているすべてのエクステンションに送信するイベントで始まる。 ランタイムと各拡張機能は、Next APIリクエストを送信することで完了を示す。 ランタイムと各拡張機能が完了し、保留中のイベントがなくなると、Lambdaは実行環境をフリーズする。

#### 1. 初期化 / Init phase

Initフェーズでは、Lambdaは3つのタスクを実行する

- すべてのエクステンションを起動する（Extension init）
- ランタイムをブートストラップする (Runtime init)
- 関数の静的コードを実行する (Function init)
- 任意のbeforeCheckpoint ランタイムフックを実行する（Lambda SnapStartのみ）

Initフェーズは、ランタイムとすべてのエクステンションがNext APIリクエストを送信して準備ができたことを通知すると終了する。 Initフェーズは10秒に制限されている。 3つのタスクが10秒以内に完了しなかった場合、Lambdaは設定されたファンクションタイムアウトで最初のファンクション呼び出し時にInitフェーズを再試行する。

#### 2. リストア / Restore phase (Lambda SnapStart only)

SnapStart関数を最初に呼び出したときと、関数がスケールアップしたときに、Lambdaは関数をゼロから初期化する代わりに、永続化されたスナップショットから新しい実行環境を再開する。 afterRestore() ランタイムフックがある場合、コードはRestoreフェーズの最後に実行される。 afterRestore()ランタイムフックの期間中は課金される。 ランタイム（JVM）がロードされ、afterRestore()ランタイム・フックがタイムアウト制限（10秒）内に完了する必要がある。 そうしないと、SnapStartTimeoutExceptionが発生する。 Restoreフェーズが完了すると、Lambdaは関数ハンドラを呼び出す（Invokeフェーズ）。

#### 3. 起動 / Invoke phase

Next APIリクエストに応答してLambda関数が呼び出されると、LambdaはInvokeイベントをランタイムと各拡張機能に送信する。

関数のタイムアウト設定は、Invokeフェーズ全体の時間を制限する。 例えば、関数のタイムアウトを360秒に設定した場合、関数とすべての拡張機能は360秒以内に完了する必要がある。 独立したポスト呼び出しフェーズはないことに注意すること。 持続時間はすべての呼び出し時間（ランタイム＋エクステンション）の合計であり、関数とすべてのエクステンションの実行が終了するまで計算されない。

ランタイムが終了し、すべてのエクステンションがNext APIリクエストを送信して終了を知らせると、呼び出しフェーズは終了する。

#### 4. Shutdown phase

Lambdaがランタイムをシャットダウンしようとすると、Shutdownイベントを登録された各外部拡張に送信する。 エクステンションは、この時間を最終的なクリーンアップ作業に使うことができる。 Shutdown イベントは、Next API リクエストへの応答となる。

## [Lambda サンプルアプリケーション](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/lambda-samples.html)

- [go-al2](https://github.com/aws-samples/sessions-with-aws-sam/tree/master/go-al2)
  - provided.al2 カスタムランタイムを使用
- [blank-go](https://github.com/awsdocs/aws-lambda-developer-guide/tree/main/sample-apps/blank-go)
  - go1.x ランタイムを使用
