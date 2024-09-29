# Clean Architecture

- [The Clean Architecture from The Clean Code Blog](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [The Clean Architecture 翻訳](https://blog.tai2.net/the_clean_architecture.html)

![clean architecture](https://github.com/hiromaily/documents/raw/main/images/clean-architecture-origin.jpg "clean architecture")

`依存性のルール`として、`ソースコードは、内側に向かってのみ依存することができる`

## このアーキテクチャーによって実現したいこと

- フレームワーク独立
- テスト可能
  - ビジネスルールは、UI、データベース、ウェブサーバー、その他外部の要素なしにテストできる
- UI 独立
  - UI は、容易に変更できる
- データベース独立
- 外部機能独立

## Layer

- 上位レベルの方針(入出力から遠い方針)は、下位レベルの方針よりも変更の頻度が低い
- 上位レベルのコンセプトは下位レベルのコンセプトのことを知らないが、下位レベルは上位レベルのことを知っている

### Enterprise Business Rules (Entities)

- エンティティは、メソッドを持ったオブジェクトかもしれないし、データ構造と関数の集合かもしれない
- 最重要ビジネスデータを操作する最重要ビネジスルールをいくつか含んだもの
- 複数のアプリケーションで使用できるように一般化されている

### Application Business Rules (Use Cases)

- アプリケーション固有のビジネスルールを含む
- アプリケーション固有のため、システムの入出力に近くなる
- ユースケースを見ただけでは、それが Web アプリケーションなのか CUI アプリケーションなのか判断はつかない
- これらのユースケースは、エンティティからの、あるいはエンティティーへのデータの流れを組み立てる
- そして、エンティティ、プロジェクトレベルのビジネスルールを使って、ユースケースの目的を達成する

### Interface Adapter (Controllers, Presenters, Gateways)

- アダプターの集合
- ユースケースとエンティティにもっとも便利な形式から、データベースやウェブのような外部の機能にもっとも便利な形式に、データを変換する
- そのため特定の Device のために、必ず存在するわけではない
- たとえば、このレイヤーは、GUI の MVC アーキテクチャを完全に内包する ([Blog](https://blog.tai2.net/the_clean_architecture.html) によると)

### Framework & Device (Web, UI, DB, Devices)

- 一般に、このレイヤーには、多くのコードは書かない

## 重要なルール

### 依存性のルール

- 最上部の図において、ソースコードは、内側に向かってのみ依存することができる
- 外側の円で宣言されたものの名前を、内側の円から言及してはならない

### 関心の分離

ソフトウェアをレイヤーに分けることによって、関心の分離を達成する

### 依存関係逆転の法則 (Dependency Inversion Principle:DIP)

最上部の図の右下の図の「コントローラーからはじまり、ユースケースを抜けて、プレゼンターで実行される」という矛盾は `依存関係逆転の原則(Dependency Inversion Principle)` で解決される

![dip](https://github.com/hiromaily/documents/raw/main/images/dip.png "dip")

## 図解による依存関係の整理

`Application Business Rules(UseCases)`レイヤー及び、`Interface Adapter` レイヤーは抽象に依存することで、`依存関係逆転の法則(DIP)`によって`依存性のルール`を満たす

![依存関係の整理1](https://github.com/hiromaily/documents/raw/main/images/clean-architecture1.png "依存関係の整理2")

実際にコードを書くことによって見えたことだが、システムの Usecase 部となる Handler を持つ`WebFramework`だったり、`UI`は`依存関係逆転の法則(DIP)`によって`UseCases`の Interface に依存せずとも、直接`UseCases`に依存すればよいのではないか？つまり、GUI や CUI といった UI 部の数と Usecase は 1:1 である必要はなく、ただその UI 部のコンポーネントが存在するかどうかのみで、WebFramework や UI は変更せずとも追加可能であり、入力の数に制限はない(CUI も GUI も備えるシステムでもよい)。ただし、Usecase 部に渡ってくるデータを統一するための Interface は必要となる。

![依存関係の整理2](https://github.com/hiromaily/documents/raw/main/images/clean-architecture2.png "依存関係の整理2")

Device には Adapter が必要なく、`依存関係逆転の法則(DIP)`によって UseCases に直接依存可能なケースも存在するはず。これは UseCases のためにデータの最適化が不要な場合がこれに該当する

![依存関係の整理3](https://github.com/hiromaily/documents/raw/main/images/clean-architecture3.png "依存関係の整理3")

## Clean Architecture と相性のいいデザインパターン

依存の解決が必要となる

- DI (Dependency Injection)
  - 具象への依存を無くし、抽象へ依存することでオブジェクト間をゆるく結合することを目的としたもので、オブジェクトの生成タイミングで、Config や環境変数の値などによって依存関係を適切に組み立てる。
  - この概念は非常にシンプルなものなので、間違っても DI フレームワークなどは不要
- Creational Patterns
  - [Abstract Factory](https://github.com/hiromaily/documents/tree/main/architecture/design-pattern#abstract-factory)
    - DI の概念はこのデザインパターンによって解決できる

## Clean Architecture でよく勘違いされていること

Clean Architecture の文脈で `Domain-Driven Design (DDD)` がよく語られるが、DDD は Clean Architecture の一部ではなくこれは `Layered-Architecture` や他のアーキテクチャーにも適用できる。
この認識の齟齬が `Clean Architecture = 実装が大変、難しい` につながっていると感じる。
