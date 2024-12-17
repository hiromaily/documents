# Lambda レイヤー

AWS Lambdaレイヤーは、Lambda関数と共に使用するライブラリ、カスタムランタイム、および他の依存関係の集合体を簡単に共有および管理するための仕組み

## レイヤーの用途

1. **ライブラリやフレームワークの共有**：PythonのライブラリやNode.jsのモジュールなど、よく使うライブラリやフレームワークをレイヤーにまとめることで、複数のLambda関数から簡単に利用できる。
2. **カスタムランタイムの提供**：AWS Lambdaが標準でサポートしていない言語やランタイムを使用したい場合、カスタムランタイムをレイヤーとして提供できる。
3. **コードの再利用性**：共通のロジックやビジネスルールをレイヤー化することで、コードの再利用が促進され、メンテナンスが簡単になる。

## レイヤーの作成

レイヤーは、依存関係やコードを含む.zipファイルでパッケージ化する。このパッケージは、特定のディレクトリ構造に従う必要がある。たとえば、Pythonのライブラリを含むレイヤーの場合、次のようなディレクトリ構造になる

```txt
python/
  └── lib/
       └── python3.8/
            └── site-packages/
                 └── <ライブラリ>
```

こうした構造で作成した.zipファイルをAWS Lambdaレイヤーとしてアップロードする

## レイヤーのデプロイ

AWS Management Console、AWS CLI、またはインフラストラクチャーコードツールを使用してレイヤーを作成・デプロイできる。
以下は、AWS CLIを使用してレイヤーを作成する例

```sh
aws lambda publish-layer-version \
    --layer-name my-layer \
    --description "A description for my layer" \
    --content S3Bucket=my-bucket,S3Key=my-layer.zip \
    --compatible-runtimes python3.8 nodejs12.x
```

このコマンドは、「my-bucket」というS3バケットの「my-layer.zip」ファイルを使用して新しいレイヤーを作成する

## レイヤーの使用

Lambda関数にレイヤーを追加するには、`Lambda Management Console`で該当の関数を選んで「レイヤー」セクションに進み、「レイヤーを追加」ボタンをクリックしてレイヤーを選択する。AWS CLI を使ってもレイヤーを追加できる

```sh
aws lambda update-function-configuration \
    --function-name my-function \
    --layers arn:aws:lambda:us-west-2:123456789012:layer:my-layer:1
```

## ベストプラクティス

1. **レイヤーのバージョン管理**：レイヤーはバージョン管理されているので、新しいバージョンを作成して関数に反映すると、以前のバージョンのコードを影響を与えることなくアップデートできる。
2. **最適なレイヤーサイズ**：レイヤーのサイズには制限がある（現在は250MBまで）。
3. **セキュリティ**：デプロイするレイヤーには、含まれるコードやライブラリのセキュリティについても注意することが重要

AWS Lambdaレイヤーは、アプリケーションのデプロイと管理を効率化する強力な機能です。これを活用することで、コードの再利用性を高め、管理の手間を減らすことができる

## References

- [レイヤーによる Lambda 依存関係の管理](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/chapter-layers.html)
