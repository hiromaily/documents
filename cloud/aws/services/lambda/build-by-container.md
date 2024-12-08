# [コンテナイメージを使用した Lambda 関数の作成](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/images-create.html)

- [AWS Lambda の新機能 – コンテナイメージのサポート (古い)](https://aws.amazon.com/jp/blogs/news/new-for-aws-lambda-container-image-support/)

- AWS Lambda 関数のコードは、`スクリプトまたはコンパイルされたプログラム`、さらに`それらの依存関係`で構成される
- デプロイパッケージを使用して、Lambda に関数コードをデプロイする。
- Lambda は、`コンテナイメージ`と `.zip ファイルアーカイブ`の 2 種類のデプロイパッケージをサポート

## Lambda 関数のコンテナイメージを構築する 3 つの方法

### 1. Lambda の AWS ベースイメージを使用する

AWS ベースイメージには、言語ランタイム、Lambda と関数コード間のやり取りを管理するランタイムインターフェイスクライアント、ローカルテスト用のランタイムインターフェイスエミュレーターがプリロードされている

### 2. [AWS の OS 専用ベースイメージを使用する](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/images-create.html#runtimes-images-provided)

AWS OS 専用ベースイメージには、Amazon Linux ディストリビューションおよびランタイムインターフェイスエミュレータが含まれている。これらのイメージは、`Go` や `Rust` などのコンパイル済み言語や、Lambda がベースイメージを提供していない言語または言語バージョン (Node.js 19 など) のコンテナイメージの作成によく使用される。OS 専用のベースイメージを使用してカスタムランタイムを実装することもできる。イメージに Lambda との互換性を持たせるには、当該言語のランタイムインターフェイスクライアントをイメージに含める必要がある。

### 3. 非 AWS ベースイメージを使用する

Alpine Linux や Debian など、別のコンテナレジストリの代替ベースイメージを使用することもできる。組織が作成したカスタムイメージを使用することもできる。イメージに Lambda との互換性を持たせるには、当該言語のランタイムインターフェイスクライアントをイメージに含める必要がある。
