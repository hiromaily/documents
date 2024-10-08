# Data Ware House(DWH) データウェアハウス

複数のソースから集められた`大量の構造化データ`や`非構造化データ`を保存する集中型リポジトリで、`大規模なクエリやデータ分析を効率的に処理するように設計`されており、企業は過去のデータや現在のデータから洞察を得ることができる

## データウェアハウスの主な目的

- データ分析
- レポート作成
- 意思決定をサポートする形でデータを統合すること

## データウェアハウスの主な特徴

### 1. 主題志向型

データは、販売、財務、顧客行動などの特定のビジネス主題や分野を中心に整理される。

### 2. 統合型

さまざまなソース(データベース、スプレッドシート、外部データフィードなど)からのデータは、統合され、一貫性のあるフォーマットに標準化される

### 3. 不揮発性

データがデータウェアハウスに入力されると、通常は`変更や削除は行われず`、分析用の履歴データが保存される

### 4. 時間変動

データウェアハウスは時間軸とともにデータを保存するため、`時間の経過に伴う傾向を分析することが可能`

## データウェアハウスの構成要素

### 1. データソース

さまざまな`データベース`、`アプリケーション`、`外部システム`から送られてくる生データ。

### 2. ETL プロセス

`抽出(Extract)`、`変換(Transform)`、`ロード(Load)` を意味する、`ETL`は、ソースシステムからデータを抽出し、希望するフォーマットに変換し、データウェアハウスにロードするプロセス

### 3. データストレージ

処理済みのデータを実際に保存するリポジトリ。これは、クエリーのパフォーマンスを最適化するテーブル、列、その他の構造で構成することができる

### 4. メタデータ

データに関するデータ。データウェアハウス内のデータの構造、内容、使用方法を理解するのに役立つ

### 5. データアクセスツール

ユーザーがデータウェアハウスに保存されたデータをクエリー、レポート、分析するためのツールおよびインターフェース

## DWH ソリューション

これらのデータウェアハウスはそれぞれ、`規模`、`複雑さ`、`コスト`、他のツールやサービスとの統合などの要因によって、強みを持っている。 **Amazon Redshift、Google BigQuery、Snowflake**は、特に最近のクラウドベースの分析で人気があり、その理由は`スケーラビリティ`、`使いやすさ`、`統合機能`となる

### 1. [Amazon Redshift](https://aws.amazon.com/redshift/)

クラウド上で完全に管理されたスケーラブルなデータウェアハウスサービス。大規模なデータセットと複雑なクエリ用に設計されている

### 2. [Google BigQuery](https://cloud.google.com/bigquery)

サーバーレスで、高いスケーラビリティとコスト効率性を備えたマルチクラウドデータウェアハウス。ビジネスの俊敏性を重視して設計されている

### 3. [Snowflake](https://www.snowflake.com/ja/)

柔軟性、拡張性、使いやすさを備えたクラウドベースのデータウェアハウス。これにより、企業は大量のデータを保存し、分析することができる

### 4. [Azure Synapse Analytics](https://azure.microsoft.com/ja-jp/products/synapse-analytics/)

ビッグデータとデータウェアハウスを組み合わせた統合分析サービス

### 5. [Oracle Exadata](https://www.oracle.com/jp/engineered-systems/exadata/)

Oracle が提供する高性能で拡張性の高いデータウェアハウスソリューション。多くの企業で使用されている

## 6. [Teradata](https://www.teradata.com/)

大規模な分析処理能力で知られる超並列処理(MPP)データウェアハウスソリューション
