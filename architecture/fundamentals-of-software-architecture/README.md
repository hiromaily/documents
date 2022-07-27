# Fundamentals of Software Architecture

- [Oreilly](https://www.oreilly.com/library/view/fundamentals-of-software/9781492043447/)
- [ソフトウェアアーキテクチャ：知っておく必要のある最も重要なアーキテクチャパターン](https://ichi.pro/sofutowhea-a-kitekucha-shitteoku-hitsuyo-no-aru-mottomo-juyona-a-kitekucha-pata-n-178077573205565)

## はじめに：公理を疑う

- アーキテクトはすべての選択の良し悪しを冷静に評価しなくてはならない
- すべてはトレードオフ

## 1. Introduction 序章

- ソフトウェアアーキテクトの役割が非常に広範囲にわたり、拡大を続けている
- (有益な図の記載あり)
- ソフトウェアアーキテクチャが常に変化する対象となっている
- ソフトウェアアーキテクトは、そうした刻々と変化するエコシステムの中で意思決定をしなければならない

### 1.1 Defining Software Architecture ソフトウェアアーキテクトの定義

- ソフトウェアアーキテクチャは以下の組み合わせで構成される

  - システムの構造
    - そのシステムを実装するアーキテクチャスタイルの種類(マイクロサービス、レイヤード etc)
  - システムがサポートしなければならないアーキテクチャ特性
    - システムの成功基準を定めるもの(システムの機能とは直接関係しない)
    - システムがサポートしなくてはならない(-ility)を指す
      - Availability(可用性)
      - Reliability(信頼性)
      - Testability(テスト用意性)
      - Scalability(スケーラビリティ)
      - Security(セキュリティ)
      - Agility(機敏性)
      - Fault Tolerance(耐障害性)
      - Elasticity(弾力性)
      - Recoverability(回復性)
      - Performance(パフォーマンス)
      - Deployability(デプロイ容易性)
      - Learnability(学習容易性)
  - アーキテクチャ決定
    - システムをどのように構築すべきかのルールを定めるもの
    - システムの制約を形作り、何が許されて何が許されないかに関する開発チームの指針となる
    - 何らかの条件や制約からこの決定をシステムの一部に実装できない場合には、その決定は特例によって破られる
    - 例外は分析され、その正当性やトレードオフに基づいて承認または否認される
  - 設計指針
    - 堅苦しいルールではなく、ガイドラインであるという点で、アーキテクチャ決定とは異なる
    - 望ましいアプローチ(技術的手法)に関するガイドを提供する

### 1.2 Expectations of an Architect アーキテクトの期待

- 主に 8 つが期待される
  - アーキテクチャ決定を下す
  - アーキテクチャを継続的に分析する
  - 最新のトレンドを把握し続ける
  - 決定の遵守を徹底する
  - 多様なものに触れ、経験している
  - 事業ドメインの知識を持っている
  - 対人スキルを持っている
  - 政治を理解し、舵取りする

#### 1.2.1 Make Architecture Decisions アーキテクチャの決定を行う

- アーキテクトには、チームや部門、あるいは企業全体の技術的な決定を導くために使用される、アーキテクチャ決定や設計指針を定義することが期待されている。
- ここで重要なのは「ガイドする」こと

#### 1.2.2 Continually Analyze the Architecture アーキテクチャの継続的な分析

- アーキテクトには、アーキテクチャや現在の技術環境を継続的に分析し、その上で改善策を提案することが期待されている
- 「アーキテクチャの存続力」に目を向けたもの
- アーキテクトには、3 年以上前に定義されたアーキテクチャの今日時点でどれくらい存続力があるのかを、ビジネスと技術、両方の変化から評価することが期待されている

#### 1.2.3 Keep Current with Latest Trends 最新のトレンドを常に把握する

- アーキテクトには、最新の技術や業界の動向を常に把握し続けることが求められる

#### Ensure Compliance with Decisions 意思決定を確実に遵守する

#### Diverse Exposure and Experience 多様な露出と経験

#### Have Business Domain Knowledge ビジネスドメインの知識を持つ

#### Possess Interpersonal Skills 対人スキルを持っている

#### Understand and Navigate Politics 政治を理解し、ナビゲートする

### Intersection of Architecture and… アーキテクチャの交差点と

#### Engineering Practices エンジニアリング実践

#### Operations/DevOps

#### Process 過程

#### Data

### Laws of Software Architecture ソフトウェアアーキテクチャの法

## I. Foundations 基礎

## 2. Architectural Thinking アーキテクチャ的思考

### Architecture Versus Design アーキテクチャ VS 設計

### Technical Breadth 技術的幅

### Analyzing Trade-Offs トレードオフの分析

### Understanding Business Drivers ビジネスドライバーの理解

### Balancing Architecture and Hands-On Coding アーキテクチャーと Hands-On コーディングのバランス

## 3. Modularity モジュール性

### Definition 定義

### Measuring Modularity モジュール性の測定

#### Cohesion 凝縮度

#### Coupling 結合

#### Abstractness, Instability, and Distance from the Main Sequence 抽象性、不安定性、および Main シーケンスからの距離

#### Distance from the Main Sequence Main シーケンスからの距離

#### Connascence 他のものと同時に作られるもの

- [Connascence：コードの結合度を測るもうひとつの指標](https://snoozer05.hatenablog.jp/entry/2020/12/11/150913)

#### Unifying Coupling and Connascence Metrics 結合度と結合度のメトリックスを統合する

### From Modules to Components モジュールからコンポーネントへ

## 4. Architecture Characteristics Defined 定義されたアーキテクチャ特性

### Architectural Characteristics (Partially) Listed 部分的にリストされたアーキテクチャの特徴

#### Operational Architecture Characteristics 運用アーキテクチャの特徴

#### Structural Architecture Characteristics 構造アーキテクチャの特徴

#### Cross-Cutting Architecture Characteristics 分野横断的なアーキテクチャの特徴

### Trade-Offs and Least Worst Architecture トレードオフと最悪のアーキテクチャ

## 5. Identifying Architectural Characteristics アーキテクチャの特徴を特定する

### Extracting Architecture Characteristics from Domain Concerns ドメインの懸念からアーキテクチャの特性の抽出

### Extracting Architecture Characteristics from Requirements 要件からのアーキテクチャ特性の抽出

### Case Study: Silicon Sandwiches

#### Explicit Characteristics 明示的な特性

#### Implicit Characteristics 暗黙の特性

## 6. Measuring and Governing Architecture Characteristics アーキテクチャ特性の測定と管理

### Measuring Architecture Characteristics アーキテクチャ特性の測定

#### Operational Measures 運用上の対策

#### Structural Measures 構造的対策

#### Process Measures プロセス対策

### Governance and Fitness Functions ガバナンスと適応度関数

#### Governing Architecture Characteristics アーキテクチャの特性を管理する

#### Fitness Functions 適応度関数

## 7. Scope of Architecture Characteristics アーキテクチャ特性の範囲

### Coupling and Connascence 結合と結合

### Architectural Quanta and Granularity アーキテクチャ的 量と粒度

#### Case Study: Going, Going, Gone

## 8. Component-Based Thinking コンポーネントベースの考え方

### Component Scope コンポーネントスコープ

### Architect Role アーキテクトの役割

#### Architecture Partitioning アーキテクチャの分割/領域確保

#### Case Study: Silicon Sandwiches: Partitioning

### Developer Role 開発者の役割

### Component Identification Flow コンポーネント識別フロー

#### Identifying Initial Components 初期コンポーネントの特定

#### Assign Requirements to Components コンポーネントに要件を割り当てる

#### Analyze Roles and Responsibilities 役割と責任を分析する

#### Analyze Architecture Characteristics アーキテクチャの特性を分析する

#### Restructure Components コンポーネントの再構築

### Component Granularity コンポーネントの粒度

### Component Design コンポーネント設計

#### Discovering Components コンポーネントの発見

### Case Study: Going, Going, Gone: Discovering Components

### Architecture Quantum Redux: Choosing Between Monolithic Versus Distributed Architectures モノリス VS 分散アーキテクチャー

## II. Architecture Styles

## 9. Foundations 基礎

### Fundamental Patterns 基本的パターン

#### Big Ball of Mud [大きな泥団子](https://ja.wikipedia.org/wiki/%E5%A4%A7%E3%81%8D%E3%81%AA%E6%B3%A5%E3%81%A0%E3%82%93%E3%81%94)

- 理解可能なアーキテクチャが欠けている ソフトウェアシステム のこと

#### Unitary Architecture 単一のアーキテクチャー

#### Client/Server

### Monolithic Versus Distributed Architectures モノリス VS 分散アーキテクチャー

#### Fallacy #1: The Network Is Reliable 間違った考え#1 ネットワークは信頼できる

#### Fallacy #2: Latency Is Zero 間違った考え#2 レイテンシーはゼロ

#### Fallacy #3: Bandwidth Is Infinite 間違った考え#3 帯域幅は無限大

#### Fallacy #4: The Network Is Secure 間違った考え#4 ネットワークは安全

#### Fallacy #5: The Topology Never Changes 間違った考え#5 トポロジーは決して変わらない

#### Fallacy #6: There Is Only One Administrator 間違った考え#6 管理者は 1 人だけ

#### Fallacy #7: Transport Cost Is Zero 間違った考え#7 輸送コストはゼロ

#### Fallacy #8: The Network Is Homogeneous 間違った考え#8 ネットワークは均質

#### Other Distributed Considerations その他の分散システムに関する考慮事項

## 10. Layered Architecture Style レイヤードアーキテクチャー

- [Multitier architecture](https://en.wikipedia.org/wiki/Multitier_architecture)
- [レイヤードアーキテクチャの視点](https://qiita.com/kichion/items/aca19765cb16e7e65946)

### Topology

### Layers of Isolation 分離のレイヤー

### Adding Layers レイヤーの追加

### Other Considerations その他の考慮事項

### Why Use This Architecture Style なぜこのアーキテクチャーを使うのか？

### Architecture Characteristics Ratings アーキテクチャ特性の評価

## 11. Pipeline Architecture Style パイプライン アーキテクチャー

- [Pipes and Filters pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/pipes-and-filters)
- [Pipes and Filters pattern(ja)](https://docs.microsoft.com/ja-jp/azure/architecture/patterns/pipes-and-filters)

### Topology

#### Pipes

#### Filters

### Example

### Architecture Characteristics Ratings アーキテクチャ特性の評価

## 12. Microkernel Architecture Style マイクロカーネル アーキテクチャー

- [Software Architecture Patterns — Microkernel Architecture](https://priyalwalpita.medium.com/software-architecture-patterns-microkernel-architecture-97cee200264e)
- [Microkernel アーキテクチャパターン](https://yusuke-ujitoko.hatenablog.com/entry/2016/11/19/105525)

### Topology

#### Core System

#### Plug-In Components

### Registry

### Contracts

### Examples and Use Cases

### Architecture Characteristics Ratings アーキテクチャ特性の評価

## 13. Service-Based Architecture Style サービス指向アーキテクチャー

- [Service-oriented architecture](https://en.wikipedia.org/wiki/Service-oriented_architecture)
- [Service-Based Architecture as an Alternative to Microservice Architecture](https://www.infoq.com/news/2016/10/service-based-architecture/)
- [SOA（サービス指向アーキテクチャー）](https://www.ibm.com/jp-ja/cloud/learn/soa)

### Topology

### Topology Variants

### Service Design and Granularity サービス設計と粒度

### Database Partitioning

### Example Architecture

### Architecture Characteristics Ratings アーキテクチャ特性の評価

### When to Use This Architecture Style

## 14. Event-Driven Architecture Style イベント駆動アーキテクチャー

- [Event-driven architecture](https://en.wikipedia.org/wiki/Event-driven_architecture)
- [What is an Event-Driven Architecture?](https://aws.amazon.com/event-driven-architecture/)
- [イベント駆動アーキテクチャとは?](https://aws.amazon.com/jp/serverless/patterns/eda/)
- [イベント駆動型アーキテクチャとは](https://www.redhat.com/ja/topics/integration/what-is-event-driven-architecture)

### Topology

### Broker Topology 仲介者トポロジー

### Mediator Topology 仲介者トポロジー (上記との違いは??)

### Asynchronous Capabilities 非同期機能

### Error Handling エラーハンドリング

### Preventing Data Loss データ損失の防止

### Broadcast Capabilities ブロードキャスト機能

### Request-Reply

### Choosing Between Request-Based and Event-Based リクエストベースとイベントベースのどちらを選択するか

### Hybrid Event-Driven Architectures ハイブリッドイベント駆動アーキテクチャー

### Architecture Characteristics Ratings アーキテクチャ特性の評価

## 15. Space-Based Architecture Style

- [Space-based architecture](https://en.wikipedia.org/wiki/Space-based_architecture)
- [Space-Based Architecture](https://docs.gigaspaces.com/latest/overview/space-based-architecture.html)
- [スペースベースアーキテクチャ](https://www.jpan.wiki/wiki/en/Space-based_architecture)

### General Topology

#### Processing Unit 処理装置

#### Virtualized Middleware 仮想化ミドルウェア

#### Data Pumps データポンプ

#### Data Writers データライター

#### Data Readers データリーダー

### Data Collisions データの衝突

### Cloud Versus On-Premises Implementations クラウド VS オンプレ

### Replicated Versus Distributed Caching 複製キャッシングと分散キャッシング

### Near-Cache Considerations キャッシュに近い考慮事項

### Implementation Examples

#### Concert Ticketing System コンサートチケットシステム

#### Online Auction System オンラインオークションシステム

### Architecture Characteristics Ratings アーキテクチャ特性の評価

## 16. Orchestration-Driven Service-Oriented Architecture オーケストレーション駆動 サービス指向アーキテクチャ

### History and Philosophy 歴史と哲学

### Topology

### Taxonomy 分類法

#### Business Services

#### Enterprise Services

#### Application Services

#### Infrastructure Services

#### Orchestration Engine

#### Message Flow

### Reuse…and Coupling 再利用、そして結合

### Architecture Characteristics Ratings アーキテクチャ特性の評価

## 17. Microservices Architecture マイクロサービスアーキテクチャー

### History

### Topology

### Distributed 分散システム

### Bounded Context

#### Granularity 粒度

#### Data Isolation データの分離

### API Layer

### Operational Reuse 運用上の再利用

### Frontends

### Communication

#### Choreography and Orchestration 振り付けとオーケストレーション(調整)

#### Transactions and Sagas

### Architecture Characteristics Ratings アーキテクチャ特性の評価

### Additional References

## 18. Choosing the Appropriate Architecture Style

### Shifting “Fashion” in Architecture

### Decision Criteria 決定基準

### Monolith Case Study: Silicon Sandwiches

#### Modular Monolith

#### Microkernel

### Distributed Case Study: Going, Going, Gone

## III. Techniques and Soft Skills

## 19. Architecture Decisions アーキテクチャの決定

### Architecture Decision Anti-Patterns アーキテクチャ決定のアンチパターン

#### Covering Your Assets Anti-Pattern あなたのアセットのアンチパターンをカバーする

#### Groundhog Day Anti-Pattern

#### Email-Driven Architecture Anti-Pattern Email 駆動アーキテクチャ アンチパターン

### Architecturally Significant アーキテクチャー的に重要

### Architecture Decision Records アーキテクチャ決定記録

#### Basic Structure 基本的構造

#### Storing ADRs ADRs の保存 (a form of equity security??)

#### ADRs as Documentation

#### Using ADRs for Standards

#### Example

## 20. Analyzing Architecture Risk アーキテクチャリスクの分析

### Risk Matrix リスク行列

### Risk Assessments リスク評価

### Risk Storming リスクストーミング?? ブレスト的な??

#### Identification 識別

#### Consensus 合意

### Agile Story Risk Analysis アジャイルストーリーのリスク分析

### Risk Storming Examples

#### Availability

#### Elasticity 弾性

#### Security

## 21. Diagramming and Presenting Architecture アーキテクチャの図表化と提示

### Diagramming 図表化

#### Tools

#### Diagramming Standards: UML, C4, and ArchiMate

#### Diagram Guidelines

### Presenting

#### Manipulating Time

#### Incremental Builds

#### Infodecks Versus Presentations Infodecks はスライド?

#### Slides Are Half of the Story

#### Invisibility 不可視

## 22. Making Teams Effective チームを効果的にする

### Team Boundaries チームの境界

### Architect Personalities

#### Control Freak 支配欲が強い人

#### Armchair Architect 机上のアーキテクト

#### Effective Architect 効果的なアーキテクト

### How Much Control? どのくらいの制御？

### Team Warning Signs チームの警告サイン

### Leveraging Checklists チェックリストの活用

#### Developer Code Completion Checklist 開発者コード補完チェックリスト

#### Unit and Functional Testing Checklist ユニットおよび機能テストのチェックリスト

#### Software Release Checklist

### Providing Guidance ガイダンスの提供

### Summary

## 23. Negotiation and Leadership Skills 交渉とリーダーシップのスキル

### Negotiation and Facilitation 交渉と円滑化

#### Negotiating with Business Stakeholders ビジネスの利害関係者との交渉

#### Negotiating with Other Architects 他のアーキテクトとの交渉

#### Negotiating with Developers 開発者との交渉

### The Software Architect as a Leader リーダーとしてのソフトウェアアーキテクト

#### The 4 C’s of Architecture

- [The four C’s of software architecture](https://medium.com/devlix-blog/the-four-cs-of-software-architecture-58a784bdb19)

#### Be Pragmatic, Yet Visionary 実用的でありながら先見性がある

#### Leading Teams by Example

### Integrating with the Development Team 開発チームとの統合

### Summary

## 24. Developing a Career Path キャリアパスの開発

### The 20-Minute Rule 20 分のルール

### Developing a Personal Radar

#### The ThoughtWorks Technology Radar

#### Open Source Visualization Bits オープンソース視覚化

### Using Social Media

### Parting Words of Advice 別れのアドバイス

## Self-Assessment Questions 自己評価の質問

### Chapter 1: Introduction

### Chapter 2: Architectural Thinking

### Chapter 3: Modularity

### Chapter 4: Architecture Characteristics Defined

### Chapter 5: Identifying Architecture Characteristics

### Chapter 6: Measuring and Governing Architecture Characteristics

### Chapter 7: Scope of Architecture Characteristics

### Chapter 8: Component-Based Thinking

### Chapter 9: Architecture Styles

### Chapter 10: Layered Architecture Style

### Chapter 11: Pipeline Architecture

### Chapter 12: Microkernel Architecture

### Chapter 13: Service-Based Architecture

### Chapter 14: Event-Driven Architecture Style

### Chapter 15: Space-Based Architecture

### Chapter 16: Orchestration-Driven Service-Oriented Architecture

### Chapter 17: Microservices Architecture

### Chapter 18: Choosing the Appropriate Architecture Style

### Chapter 19: Architecture Decisions

### Chapter 20: Analyzing Architecture Risk

### Chapter 21: Diagramming and Presenting Architecture

### Chapter 22: Making Teams Effective

### Chapter 23: Negotiation and Leadership Skills

### Chapter 24: Developing a Career Path
