# Blockchain Indexer

Blockchain Indexer は、ブロックチェーン上のデータをオフチェーンの DB に保存するシステム。ブロックチェーンのノードへ毎回直接データをフェッチする場合、ノードプロバイダーへの高額なコストが発生する。さらにブロックチェーンノードはデータ検索のパフォーマンスは高く設計されていない。
そのため、よく使用されるデータは DB に保存することで、パフォーマンスを向上させることができる。

## 必要な機能

- Index の作成
- クエリ処理サービスの提供

## Blockchain indexer の課題

### 難しさ

サーバーがダウンした場合などにデータの ​ 整合性を保つには高度な技術が必要になる。さらに、効率よくノードからデータを取得したり、あるデータを含んだ特定のトランザクションを取得するのは簡単ではない。

### 高コスト

データを正しく同期するシステムを構築するには高い費用と時間が必要となる

### 既存の解決策

既存の API が存在すればよいが、欲しいエンドポイントが存在しない場合や、何度も API へリクエストを送信する必要があったりなど、コストがかかる上にパフォーマンスにも影響する。

### スケーラビリティ

ブロックチェーンネットワークが成長し続ける中、Indexer のスケーラビリティは重要な課題となる。ネットワークの拡大に伴い、データ量が増加し、処理能力に高い要求が生じる。効率的なインデックス作成とデータ処理のスケーリングには、専門的な技術と設計が必要となる。

## [What is a blockchain indexer?](https://www.alchemy.com/overviews/blockchain-indexer)

### What is an indexer?

- Blockchain の data を query し、analyze する
- Smart Contract の event の indexing, filtering する機能も持つ
- Indexer を利用する Dapps は、Transaction のトラッキングや、Smart Contract のモニタリング、network の activity の分析などに利用する

### What are the components of an indexer?

#### 1. Data Source

indexer は Data Source として blockchain の full node にアクセスする必要がある

#### 2. Database

indexer は Blockchain から抽出したデータを外部の Database に保存する必要がある。これは Off-chain 上の Database で RDB や NoSQL が一般的に使われる

#### 3. Indexing Engine

indexer の Blockchain からデータを効率的に抽出し、保存する責務を持つもの

#### 4. Search API

indexer を使う側に提供するための、API

#### 5. User Interface
