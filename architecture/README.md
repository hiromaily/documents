# Architecture

ソフトウェアアーキテクチャのルールとは、プログラムの構成要素をどのように組み立てるかのルール  
優れたアーキテクチャーは、ユースケースを強調し、周辺の関心ごとからユースケースを切り離す  
テスト可能なアーキテクチャーにおいて、テストするために Database の起動も必要ないし、Web サーバーの起動も必要ない  
フレームワーク非依存であるべき  
(CleanArchitecture からの抜粋)

## アーキテクチャの変遷

- [レイヤードアーキテクチャ](./layered-architecture.md)
- [ヘキサゴナルアーキテクチャ](./hexagonal-architecture.md)
- オニオンアーキテクチャ
- [Clean Architecture](./clean-architecture.md)

## [12 のソフトウェア・アーキテクチャの落とし穴とその避け方](https://www.infoq.com/jp/articles/avoid-architecture-pitfalls/)

- アーキテクチャを構築していない人は、アーキテクチャに関する決定を下すべきではない。アーキテクチャを形成する重要な技術的トレードオフを行うには、アーキテクチャがどのように構築されるかについての知識が不可欠である。
- 品質属性要件（Quality Assurance Requirements: QAR）はアーキテクチャ設計の原動力となる。これらの要件を無視したり、不十分な定義にしたりすることは、失敗のもとである。
- アーキテクチャの決定をベンダーに委ねてはならない。ベンダーはあなたのコンテキストも QAR も知らないし、あなたのためにトレードオフを決めることもできない。
- どんなに成功しているように見えても、他の組織からアーキテクチャをコピーしてはならない。彼らもまた、あなたのコンテキストや QAR を知らない。
- アーキテクチャを評価する唯一の方法は、構築してテストすることだ。設計を完璧にするためにこれを遅らせることは、失敗への道だ。
