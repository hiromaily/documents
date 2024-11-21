# AWS Lambda

- [Lambda](https://aws.amazon.com/jp/pm/lambda/)
- [AWS Lambda FAQs](https://aws.amazon.com/lambda/faqs/)

## [Lambda Quota](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/gettingstarted-limits.html)

以下のデータを Markdown のテーブルに変換しました。

| リソース                                              | クォータ                                                                                                                                                                                             |
| ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 関数のメモリ割り当て                                  | 128 MB から 10,240 MB まで、1 MB 単位で増加できます。                                                                                                                                                |
| 注意                                                  | Lambda は、設定されたメモリの量に比例して CPU パワーを割り当てます。[メモリ (MB)] 設定を使用して、関数に割り当てられたメモリと CPU パワーを増減できます。1,769 MB の場合、1 つの vCPU に相当します。 |
| 関数タイムアウト                                      | 900 秒 (15 分)                                                                                                                                                                                       |
| 関数の環境変数                                        | 4 KB (関数に関連付けられたすべての環境変数)                                                                                                                                                          |
| 関数リソースベースのポリシー                          | 20 KB                                                                                                                                                                                                |
| 関数レイヤー                                          | 5 つのレイヤー                                                                                                                                                                                       |
| 関数の同時実行スケーリング制限                        | 各関数について、10 秒ごとに 1,000 の実行環境が必要です。                                                                                                                                             |
| 呼び出しペイロード (リクエストとレスポンス)           | リクエストとレスポンスにそれぞれ 6 MB (同期)                                                                                                                                                         |
|                                                       | ストリーミング応答ごとに 20 MB (同期。ストリーミング応答のペイロードサイズは、デフォルト値から増やすことができます。詳しくは AWS Support にお問い合わせください。)                                   |
|                                                       | 256 KB (非同期)                                                                                                                                                                                      |
|                                                       | リクエスト行とヘッダー値の合計サイズは 1 MB                                                                                                                                                          |
| ストリーミングレスポンスの帯域幅                      | 関数のレスポンスでは、最初の 6 MB には上限がありません                                                                                                                                               |
|                                                       | 6 MB を超えるレスポンスの場合、残りのレスポンスは 2 Mbps です                                                                                                                                        |
| デプロイパッケージ (.zip ファイルアーカイブ) のサイズ | 50 MB (zip 圧縮済み、Lambda API SDK を介してアップロードした場合)。サイズの大きいファイルは Amazon S3 でアップロードしてください。                                                                   |
|                                                       | 50 MB (Lambda コンソール経由でアップロードした場合)                                                                                                                                                  |
|                                                       | 250 MB レイヤーやカスタムランタイムなど、デプロイパッケージの内容の最大サイズ。(解凍済み)                                                                                                            |
| コンテナイメージの設定サイズ                          | 16 KB                                                                                                                                                                                                |
| コンテナイメージのコードパッケージサイズ              | 10 GB (非圧縮のイメージの最大サイズ、すべてのレイヤーを含む)                                                                                                                                         |
| テストイベント (コンソールエディタ)                   | 10                                                                                                                                                                                                   |
| /tmp ディレクトリのストレージ                         | 512 MB〜10,240 MB、1 MB 刻み                                                                                                                                                                         |
| ファイルディスクリプタ                                | 1,024                                                                                                                                                                                                |
| 実行プロセス/スレッド                                 | 1,024                                                                                                                                                                                                |

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

Lambda は、安全で分離された実行環境を提供する実行環境で関数を呼び出す。 実行環境は、関数の実行に必要なリソースを管理する。 実行環境はまた、関数のランタイムと、関数に関連付けられた外部拡張のライフサイクルサポートを提供する。

関数のランタイムは Runtime API を使って Lambda と通信する。 エクステンションは Extensions API を使って Lambda と通信する。 エクステンションは Telemetry API を使って、関数からログメッセージやその他の遠隔測定を受け取ることもできる。

![lambda api concept](https://github.com/hiromaily/documents/raw/main/images/lambda-telemetry-api-concept.png "lambda api concept")

Lambda 関数を作成する際には、利用可能なメモリ量や関数の最大実行時間などの設定情報を指定する。 Lambda はこの情報を使って実行環境を設定する。

関数のランタイムと各外部拡張は、実行環境内で実行されるプロセスのこと。 パーミッション、リソース、認証情報、環境変数は、関数と拡張の間で共有される。

### ラムダ実行環境のライフサイクル

![lambda execution environment lifecycle](https://github.com/hiromaily/documents/raw/main/images/lambda-execution-env-lifecycle.png "lambda execution environment lifecycle")

各フェーズは、Lambda がランタイムと登録されているすべてのエクステンションに送信するイベントで始まる。 ランタイムと各拡張機能は、Next API リクエストを送信することで完了を示す。 ランタイムと各拡張機能が完了し、保留中のイベントがなくなると、Lambda は実行環境をフリーズする。

#### 1. 初期化 / Init phase

Init フェーズでは、Lambda は 3 つのタスクを実行する

- すべてのエクステンションを起動する（Extension init）
- ランタイムをブートストラップする (Runtime init)
- 関数の静的コードを実行する (Function init)
- 任意の beforeCheckpoint ランタイムフックを実行する（Lambda SnapStart のみ）

Init フェーズは、ランタイムとすべてのエクステンションが Next API リクエストを送信して準備ができたことを通知すると終了する。 Init フェーズは 10 秒に制限されている。 3 つのタスクが 10 秒以内に完了しなかった場合、Lambda は設定されたファンクションタイムアウトで最初のファンクション呼び出し時に Init フェーズを再試行する。

#### 2. リストア / Restore phase (Lambda SnapStart only)

SnapStart 関数を最初に呼び出したときと、関数がスケールアップしたときに、Lambda は関数をゼロから初期化する代わりに、永続化されたスナップショットから新しい実行環境を再開する。 afterRestore() ランタイムフックがある場合、コードは Restore フェーズの最後に実行される。 afterRestore()ランタイムフックの期間中は課金される。 ランタイム（JVM）がロードされ、afterRestore()ランタイム・フックがタイムアウト制限（10 秒）内に完了する必要がある。 そうしないと、SnapStartTimeoutException が発生する。 Restore フェーズが完了すると、Lambda は関数ハンドラを呼び出す（Invoke フェーズ）。

#### 3. 起動 / Invoke phase

Next API リクエストに応答して Lambda 関数が呼び出されると、Lambda は Invoke イベントをランタイムと各拡張機能に送信する。

関数のタイムアウト設定は、Invoke フェーズ全体の時間を制限する。 例えば、関数のタイムアウトを 360 秒に設定した場合、関数とすべての拡張機能は 360 秒以内に完了する必要がある。 独立したポスト呼び出しフェーズはないことに注意すること。 持続時間はすべての呼び出し時間（ランタイム＋エクステンション）の合計であり、関数とすべてのエクステンションの実行が終了するまで計算されない。

ランタイムが終了し、すべてのエクステンションが Next API リクエストを送信して終了を知らせると、呼び出しフェーズは終了する。

#### 4. Shutdown phase

Lambda がランタイムをシャットダウンしようとすると、Shutdown イベントを登録された各外部拡張に送信する。 エクステンションは、この時間を最終的なクリーンアップ作業に使うことができる。 Shutdown イベントは、Next API リクエストへの応答となる。

## [Lambda サンプルアプリケーション](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/lambda-samples.html)

- [go-al2](https://github.com/aws-samples/sessions-with-aws-sam/tree/master/go-al2)
  - provided.al2 カスタムランタイムを使用
- [blank-go](https://github.com/awsdocs/aws-lambda-developer-guide/tree/main/sample-apps/blank-go)
  - go1.x ランタイムを使用
