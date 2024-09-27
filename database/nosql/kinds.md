# NoSQL データベースの種類

## 性能を比較するための機能

- パフォーマンス
- 一貫性のあるトランザクションサポート
  - 結果整合性のみかどうか
- 書き込みのスケーリング
- SQL インタフェースがあるかどうか
- single region / multi region (global 企業の場合)

## 1. [Key-value DB](https://aws.amazon.com/jp/nosql/key-value/)

`分割可能性`に優れており、他の NoSQL データベースタイプでは実現できないレベルでの`水平スケーリング`が可能。key-value データベースは、データを、キーと値のペアのコレクションとして格納する。ここでキーは、一意の識別子として機能する。キーと値は、単純なオブジェクトから複雑な複合オブジェクトまで、何でもよい。ゲーム、広告技術、IoT などのユースケースは、Key-value ストアデータ設計に特に適している。

- [Redis](https://redis.io/)
  - Redis はメモリ上で動作するキーバリューストア型のデータベース
- [Aerospike](https://aerospike.com/)
- [Memcached](https://memcached.org/)
  - Redis と比べると down trend 感がある
- [Riak](https://riak.com/index.html)
  - 検索すると記事が古い。。。

## 2. [Key-value DB: ワイドカラムストア型](https://aws.amazon.com/jp/nosql/key-value/)

- キーバリュー型の「値」の部分が 1 つ以上のカラム（列）になったもの
- 各行に同じ列がなくても良い
- 列を動的に追加できる
- すべての列に値がない状態も許容される

- AWS: DynamoDB
- [Apache Cassandra](https://cassandra.apache.org/_/index.html)
- [Apache HBase](https://hbase.apache.org/)
- [GCP: BigTable](https://cloud.google.com/bigtable)

## WIP: 列志向型

上記に分類したCassandra, HBaseが分類されるはず

## WIP: Time Series Databases

時間に基づいてデータを格納し、タイムスタンプデータの効率的なクエリ処理を提供するもので、InfluxDB, TimescaleDBなど

## WIP: Object-Oriented Databases

オブジェクト指向プログラミングの概念を使用してデータを格納するもので、db4o, ObjectDBなど

## WIP: Multimodel Databases

複数のデータモデル（ドキュメント、グラフ、キー・バリューなど）をサポートするもので、ArangoDB, OrientDBなど

### [AWS: Amazon DynamoDB](https://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/developerguide/Introduction.html)

- あらゆる規模のワークロードに対して、ミリ秒単位のレイテンシーで一貫したパフォーマンスを提供するように設計されている

## 3. [Document DB](https://aws.amazon.com/jp/documentdb/) / ドキュメント型

開発者がアプリケーションコードで使用するのと同じドキュメントモデル形式で、データを JSON オブジェクトとして格納する。これらのオブジェクトは、柔軟性があり、半構造化され、階層化されている。ドキュメントおよびドキュメントデータベースは柔軟性があり、半構造化され、階層的な性質を持つため、アプリケーションのニーズに合わせて進化させることができる。ドキュメントデータベースモデルは、カタログ、ユーザープロファイル、コンテンツ管理システムなど、各ドキュメント固有のものであり、時間の経過とともに進化する場合うまく機能する。

- [Amazon DocumentDB (MongoDB 互換)](https://aws.amazon.com/jp/documentdb/)
- [MongoDB](https://www.mongodb.com/)
- [Couchbase](https://www.couchbase.com/)
- [Apache CouchDB](https://couchdb.apache.org/)
- [Elasticsearch](https://www.elastic.co/)

## 4. Graph DB / グラフ型

高度に接続されたデータセットを扱うアプリケーションの構築と実行を容易にすることを目的として構築されている。ノードを使用してデータエンティティを格納し、エッジを使用してエンティティ間のリレーションシップを格納する。エッジには常に`開始ノード`、`終了ノード`、`タイプ`および`方向`がある。親子関係、アクション、所有権などを記述できる。1 つのノードが持つことができるリレーションシップの数や種類に制限は存在しない。グラフデータベースを使用して、密接に連結されたデータセットで動作するアプリケーションの構築と実行ができる。

グラフデータベースの典型的な`ユースケース`には、`ソーシャルネットワーキング`、`レコメンデーションエンジン`、`不正行為検出`、`ナレッジグラフ`などがある。

- [Neo4j](https://neo4j.com/)

### [Amazon Neptune](https://aws.amazon.com/neptune/)

フルマネージド型のグラフデータベースサービスで、プロパティグラフモデルとリソース記述フレームワーク (RDF) の両方をサポートし、2 つのグラフ API (TinkerPop と RDF/SPARQL) を選択できる

## 5. [In-memory DB](https://aws.amazon.com/jp/nosql/in-memory/)

他の非リレーショナルデータベースはデータをディスクや SSD に保存するが、インメモリデータストアはディスクにアクセスする必要がないように設計されている。マイクロ秒の応答時間を必要とするアプリケーションや、トラフィックが急増するアプリケーションに最適。
`ユースケース`には、リーダーボード、セッションストア、`リアルタイム分析などの機能を提供するゲーム`や`アドテクアプリケーション`など

### [Amazon MemoryDB for Redis](https://aws.amazon.com/memorydb/)

Redis と互換性があり、耐久性のあるインメモリデータベースサービスで、ミリ秒の読み取りレイテンシー、数ミリ秒台の書き込みレイテンシーと、マルチ AZ の耐久性を提供する。

### [Amazon ElastiCache](https://aws.amazon.com/jp/elasticache/)

Redis と Memcached の両方と互換性のある、フルマネージドインメモリーキャッシングサービスで、低レイテンシーで高スループットのワークロードに対応する。

### [Amazon DynamoDB Accelerator (DAX)](https://aws.amazon.com/jp/dynamodbaccelerator/)

DynamoDB の読み取りを桁違いに高速化する専用データストアのもう 1 つの例

## 6. [Search-engine DB](https://aws.amazon.com/jp/nosql/search/)

検索エンジンデータベースは、開発者が問題のトラブルシューティングに使用するアプリケーション出力ログなどのデータコンテンツの検索専用の非リレーショナルデータベースの一種。インデックスを使用してデータ間の類似した特徴を分類し、検索機能を容易にする。検索エンジンデータベースは、`画像`や`動画`などの非構造化データの分類に最適化されている。

### [Amazon OpenSearch Service](https://aws.amazon.com/opensearch-service/)

半構造化されたログおよび指標のインデックス作成、集約、検索により、機械が生成したデータをほぼリアルタイムで可視化し、分析できるようにする専用サービス
