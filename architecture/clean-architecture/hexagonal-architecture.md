# Hexagonal Architecture

- `Ports And Adapters Architecture`とも言われ、ポートやアダプタによってソフトウェア環境と容易に接続できる疎結合のアプリケーションコンポーネントを作成することを目的としている。これにより、コンポーネントはあらゆるレベルで交換可能になり、テストの自動化が容易になる
- レイヤードアーキテクチャーに見られるような、レイヤー間の望ましくない依存関係や UI コードの ビジネスロジックへの混入など、オブジェクト指向ソフトウェア設計における構造上の既知の問題を回避する試みとして発表された
- `Hexagonal`という言葉は、アプリケーション・コンポーネントを六角形のセルのように見せる図式的な慣例に由来する

<img src="https://raw.githubusercontent.com/hiromaily/documents/main/images/Hexagonal-Architecture.svg.png"  width="50%" height="50%">

## Principle: 原理

- システムを、`アプリケーションコア`、`データベース`、`UI`、`テストスクリプト`、`他のシステムとのインターフェース`など、いくつかの疎結合の交換可能なコンポーネントに分割する。このアプローチは、従来のレイヤードアーキテクチャに代わるもの。
- 各コンポーネントは、露出したいくつかの `ポート` を介して他のコンポーネントと接続されている。これらのポートを介した通信は、その目的に応じて所定のプロトコルに従う。
- ポートやプロトコルは、適切な技術手段（オブジェクト指向言語での メソッド呼び出し、リモートプロシージャコール、Web サービスなど）で実装可能な`抽象的なAPI`を定義している。
- ポートの数に制約はなく、1 つでも良い。一般的には、`UI`、`通知`や`logging`、`Database`、`Admin`機能といったポートを持つ
- アダプターはコンポーネントと外部を結ぶ接着剤となる。
  - 例えば、入力データは GUI や CUI を通じてユーザーから提供されたり、TestScript から提供されたり、1 つのポートに対して複数のアダプターが存在する可能性がある。

## その他のアーキテクチャーとの比較

- `Onion Architecture`は Hexagonal Architecture とよく似ており、Application と Database を疎結合に保つために Interface で Infra レイヤーを外部化している
- `Clean Architecture`は`Hexagonal Architecture`や`Onion Architecture`を組み合わせたもので、コンポーネントの詳細レベルを追加している。

## 採用している企業例

- [Netflix: Ready for changes with Hexagonal Architecture](https://netflixtechblog.com/ready-for-changes-with-hexagonal-architecture-b315ec967749)
  - Data への endpoint として、gRPC, JSON API, GrapshQL と多くのサービスに分散されていたため、最初から高度に統合する必要があったとのこと
  - システムが肥大化するにあたってモノリスで作られたシステムの Data source を交換する必要があった
  - これらの理由よりビジネスロジックの独立性が重要であった

### Netflix で使われているコアコンセプト

ビジネスロジックを定義する 3 つの主要なコンセプトがある

- Entities
  - domain オブジェクト
- Repositories
  - entity の取得や変更のための Interface であり、Datasource との通信に使用されるメソッドのリストを保持する
- Interactors
  - domain action を編成して実行するクラスで、サービスオブジェクトやユースケースオブジェクトとなる

そして、ビジネスロジックの外側に、`Data source`と`Transport`レイヤーが存在する

- Data source
  - Database, Search Adapter, REST API など、データの fetch と push の実装を保持する
- Transport レイヤー

## 目的まとめ

- ユースケースを実現するためのロジックが完全に独立した状態で実行できるようにする
- 外部技術を抽象化し、テスト容易性を高くする
