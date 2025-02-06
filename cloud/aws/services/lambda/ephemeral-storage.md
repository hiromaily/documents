# Lambda 関数のエフェメラルストレージ

[Lambda 関数のエフェメラルストレージを設定する](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/configuration-ephemeral-storage.html)

AWS Lambda では、**一時フォルダ（エフェメラルストレージ）** が提供されており、これは `/tmp` ディレクトリが該当する。
デフォルトで利用可能。

## 特徴

- **容量**: 512 MB から 10,240 MB（最大 10 GB）まで、1 MB 単位で設定可能。
- **特性**: 一時的なストレージであり、各実行環境に固有のもの。データは AWS によって管理されるキーを使用して暗号化される。
- **用途**: データ処理、ETLジョブ、ML推論、コンテンツ生成ワークフローなどで使用できる。
- **設定方法**: AWS Lambda コンソールの「一般設定」セクションや AWS CLI の `update-function-configuration` コマンドを使用して設定する。
