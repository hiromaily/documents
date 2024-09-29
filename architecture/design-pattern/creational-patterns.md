# Creational Design Patterns

## [Singleton Design Pattern](https://refactoring.guru/design-patterns/singleton)

- [Go sample](https://refactoring.guru/design-patterns/singleton/go/example)
- 1 つのインスタンスのみを生成し、共有する仕組み。これはグローバルオブジェクトとなり得る。
- 並列プログラムにおいては排他制御を考慮する必要がある
- ユースケースは、Data cache, DB, log ファイルへのアクセスといったケース

## [Abstract Factory](https://refactoring.guru/design-patterns/abstract-factory)

- [Go sample](https://refactoring.guru/design-patterns/abstract-factory/go/example)
- [Abstract Factory Design Pattern in Go](https://golangbyexample.com/abstract-factory-design-pattern-go/)
- 関連するオブジェクトの Family を、その具体的なクラス(実装クラス)を指定することなく生成することができる創造のためのデザインパターン
- ユーザーは使い方だけを知っており、どんな instance を受け取っても Interface が同じため同じ操作ができる
- 多態性の仕組み
- 椅子を作ると仮定すると、椅子の種類毎にクラスが存在するが、それぞれの椅子 Class はベースとなる椅子の Interface を満たすようにする

### Abstract Factory 考察

- DI の概念はこのデザインパターンによって解決できる。そのため抽象への依存が重要となる`Clean Architecture`などで有用
- 同じ Interface を持つ同一グループのオブジェクトの切り替え

## [Factory Method](https://refactoring.guru/design-patterns/factory-method)

- [Go sample](https://refactoring.guru/design-patterns/factory-method/go/example)
- [Factory Design Pattern in Go](https://golangbyexample.com/golang-factory-design-pattern/)
- スーパークラスでオブジェクトを生成するためのインターフェースを提供しながら、サブクラスで生成されるオブジェクトの種類を変更できるようにする創造的デザインパターン
- これは上位クラスによる Template 化
- ユースケースは、生成手順が複雑な場合や、Product インスタンスが事前に決まらない場合など
- ConcreteCreator と ConcreteProduct が 1:1 で対応している
- Creator クラスの抽象メソッドである factory を使って create メソッドを template 化することで factory メソッドも隠蔽できる
- インスタンス生成だけをクラスとして分離する手法を Factory と呼ぶこともある

### Abstract Factory と Factory Method の違いについて

- [What are the differences between Abstract Factory and Factory design patterns?](https://stackoverflow.com/questions/5739611/what-are-the-differences-between-abstract-factory-and-factory-design-patterns)
- `Abstract Factory`は`Object`であり、`Factory Method`は`Method`である
- `Factory Method`はサブクラスで Override することが可能
- `Abstract Factory`は、複数の`Factory Method`を持つ`Object`
- `Abstract Factory`は、オブジェクトの生成の責任を他のクラスに委ねるコンポジション方式を採用し、`Factory Method`は、オブジェクトの生成を派生クラスまたはサブクラスに依存する継承方式を採用している。

## [Builder Design Pattern](https://refactoring.guru/design-patterns/builder)

- [Go sample](https://refactoring.guru/design-patterns/builder/go/example)
- [Builder Pattern in GoLang](https://golangbyexample.com/builder-pattern-golang/)
- Builder は、複雑なオブジェクトを段階的に構築することができる創造のためのデザインパターンで、同じ構築コードを使用して、オブジェクトの異なるタイプや表現を作成することができる。

```go
// 一度に作ろうとすると
new House(param1, param2, param3, param4 ...)

// これを段階的に構築する
house = new House()
house = house.withFancyDoor()
house = house.withKitchen()

// 以下のように、builderパターンは、チェーンメソッドを利用して構築することもできる
house = new House().withFancyDoor().withKitchen()

// そして、この組み合わせ毎にDirectorクラスを用意し、さまざまな組み合わせを定義する
```

### Builder Design Pattern 考察

- 多くのパラメータを持つコンストラクトの解決を目的としているので、そのようなケースには検討できる。
- しかし、そのようなオブジェクトはそもそも構造として良くない可能性があり、オブジェクトの最適化によってこのパターンは必要ないと考える

## [Prototype Design Patten](https://refactoring.guru/design-patterns/prototype)

- [Go sample](https://refactoring.guru/design-patterns/prototype/go/example)
- 既存のインスタンスをコピーして新しいインスタンスを作る
