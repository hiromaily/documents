# Clean Architecture

- [The Clean Architecture from The Clean Code Blog](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [The Clean Architecture 翻訳](https://blog.tai2.net/the_clean_architecture.html)

![clean architecture](../../images/clean-architecture.jpg 'clean architecture')

`依存性のルール`として、`ソースコードは、内側に向かってのみ依存することができる`

## このアーキテクチャーによって実現したいこと

1. フレームワーク独立
2. テスト可能

- ビジネスルールは、UI、データベース、ウェブサーバー、その他外部の要素なしにテストできる

3. UI 独立

- UI は、容易に変更できる

4. データベース独立
5. 外部機能独立

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

![dip](../../images/dip.png 'dip')

## 図解による依存関係の整理

<img src="https://raw.githubusercontent.com/hiromaily/documents/main/images/clean-architecture2.png"  width="50%" height="50%">

`Application Business Rules(UseCases)`レイヤー及び、`Interface Adapter` レイヤーは抽象に依存することで、`依存関係逆転の法則(DIP)`によって`依存性のルール`を満たす

<img src="https://raw.githubusercontent.com/hiromaily/documents/main/images/clean-architecture3.png"  width="50%" height="50%">

実際にコードを書くことによって見えたことだが、システムの起点となる Handler を持つ`WebFramework`だったり、`UI`は`依存関係逆転の法則(DIP)`によって`UseCases`に依存する必要はなく、直接`UseCases`に依存することができる。ただそのコンポーネントが存在するかどうかのみで、WebFramework や UI は変更可能であり、入力の数に制限はない(CUI も GUI も備えるシステムでもよい)

## 考察

- Clean Architecture の中核は`Entities`層ではあるが、`Application Business Rules (Use Cases)`層を中心に各レイヤーとの関係を俯瞰したほうがわかりやすい
- そのため、`Application Business Rules (Use Cases)`層のオブジェクトの構造と依存関係の構築手法が重要であると考える
- `Application Business Rules (Use Cases)`層の構造体がもつメンバーはそれぞれが`Interface Adapter`の抽象に依存するが、`Interface Adapter`層の不要な`Device`層(logger やクラウドサービスへのエンドポイント)に直接依存するケースもあり得る
- `Application Business Rules (Use Cases)`層構築については`関心の分離`の観点から`システムを使うこと`と、`構築すること`を分離する
- 依存関係は DI(Dependency injection)によって、環境変数や Config ファイルの値から適切なコンポーネント切り替える。
- Web フレームワークへの依存をいかに plugable にするか？と同時に可読性を優先するという観点でその必要性がないシステム（もしくはトレードオフ）もあるように思う。この場合、Handler の各エンドポイントをユースケースとして見立てることになる。

## Clean Architecture を採用している企業

- Uber
- Netflix
- Zalando
- Sound Cloud

## Github References

- [Go-Clean-Architecture-REST-API](https://github.com/AleksK1NG/Go-Clean-Architecture-REST-API)

- [Clean Architecture using Golang](https://eminetto.medium.com/clean-architecture-using-golang-b63587aa5e3f)
  - example のディレクトリ構成は整っている
  ```
  pkg/user
  - entity.go ...userモデルの構造体を定義
  - mongodb.go ...DB操作の実装
  - repository.go　...DB操作のinterface
  - service.go ...ビジネスロジックを担うベースとなる構造体を定義
  ```
- [bxcodec/go-clean-arch](https://github.com/bxcodec/go-clean-arch)
  - 多くのレビュアーの意見を取り入れてブラッシュアップされてきた感があるので、良い Model かもしれないが、分割の概念がディレクトリ名として表現されているのが、golang の思想に反する気がする。
- [Trying Clean Architecture on Golang](https://hackernoon.com/golang-clean-archithecture-efd6d7c43047)
