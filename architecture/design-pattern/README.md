# Design Pattern

## Cases

### 1. システムを使うことと、構築することを分離する

- 関心事の分離
- main()における構築作業を分離する
  - main 関数が、システムに必要なオブジェクトを生成し、それをアプリケーションに渡す
  - `Builderパターン`
- オブジェクトの生成に対して、アプリケーションが責任を持たないと行けない場合
  - `Abstract Factory`によって、生成に関する詳細をアプリケーションから分離する
- `依存性注入(Dependency Injection, DI)`
  - どの依存オブジェクトが実際に使われるかは、設定ファイルに記述する
  - コンストラクタのInterface型の引数を通じて依存性の注入を受け付ける
- [Registry Pattern](https://medium.com/@david.s.qian/design-pattern-registry-f6bacdf39882)

### 2. Switch 文, IF 文の連鎖

- switch 文を使うの初回の 1 階層のみで、呼び出し先にまで switch 文で伝搬させるべきではない
- 多態オブジェクトを生成するために、`Factory Method`によって、適切な instance を生成する
  - Interface型への実装ロジックの挿入、ここでは`DI`によっても実現できる
- この Factory Method によって生成された多態オブジェクトは共通の Interface を持つケースが多い

### 3. ソースコードの行は異なるものの、似たようなアルゴリズムを持ったモジュール
- 一連の処理の中で、一部のみ処理方法が異なるものなどに適用できる
- [Template method pattern](https://github.com/hiromaily/documents/tree/main/architecture/design-pattern#template-design-pattern)
- [Strategy pattern](https://github.com/hiromaily/documents/tree/main/architecture/design-pattern#strategy-design-pattern)

### 4. function のパラメータの数を減らす

- まず、その function が`Single Responsibility Principle: 単一責任の原則` に従っていないのであれば、適切に分割する
  - この段階で意味のあるオブジェクトへの分割を正しく行うことができれば、それ以上は望まないでもいいかも
- [Function Currying(カリー化)](https://en.wikipedia.org/wiki/Currying) => 冗長で複雑であり、メリットが感じられない。。。
- 別のアプローチとしては、`Factory Method`によって、適切な instance を生成するのもよい
- [Go: Reduce function parameters](https://medium.com/@meeusdylan/go-reduce-function-parameters-19b785a87a59)

### 5. 外部 API の呼び出しにおける、API の仕様変更の吸収

- `Adapter Design Pattern`
  - これにより、API とのやり取りをカプセル化し、API の進化に伴う変更を 1 箇所に局所化する
  - 自分の制御化にないコードを制御するのに有用

### 6. 横断的関心事に対してモジュール構造を取り出すためのアプローチ

- 永続化、セキュリティ、トランザクションの扱いなど
- アスペクト指向プログラミング(AOP)
  - AOP では、特定の関心事を実現するために、システム内の振る舞いのどの点に対し、整合性を維持したままで変更を加えるかをアスペクトと呼ばれるモジュールで指定する。この指定は、簡潔な宣言的、あるいは手続き的な構造を使って行われる
- `Decorator Design Pattern`によって、データアクセスオブジェクト(DAO)に振る舞いを拡張するデコレータだったり、トンランザクション、キャッシュといったデコレータを追加していく

### 7. コマンド・照会の分離原則 (Command Query Segregation)

- 関数は何らかの処理を行うか、何らかの応答を返すかのどちらかを行うべきで、両方を行うべきではない。
- 両方同時に行うと混乱を招く

## Design Pattern

### Creational Patterns

#### Singleton Design Pattern
#### [Abstract Factory](https://refactoring.guru/design-patterns/abstract-factory)
- [Go sample](https://refactoring.guru/design-patterns/abstract-factory/go/example)  
- [Abstract Factory Design Pattern in Go](https://golangbyexample.com/abstract-factory-design-pattern-go/)
- 関連するオブジェクトのFamilyを、その具体的なクラスを指定することなく生成することができる創造的なデザインパターン
- 椅子を作ると仮定すると、椅子の種類毎にクラスが存在するが、それぞれの椅子Classはベースとなる椅子のInterfaceを満たすようにする
##### 考察
- DIの概念はこのデザインパターンによって解決できる。そのため抽象への依存が重要となる`Clean Architecture`などで有用
- 同じInterfaceを持つ同一グループのオブジェクトの切り替え

#### [Factory Method](https://refactoring.guru/design-patterns/factory-method)
- [Go sample](https://refactoring.guru/design-patterns/factory-method/go/example)
- [Factory Design Pattern in Go](https://golangbyexample.com/golang-factory-design-pattern/)
- スーパークラスでオブジェクトを生成するためのインターフェースを提供しながら、サブクラスで生成されるオブジェクトの種類を変更できるようにする創造的デザインパターン
##### 考察
- Abstract Factoryとの使い分けについては、スーパークラス/サブクラスを使う構造によって、同じInterfaceを持つ同一グループのオブジェクトが同時に存在する場合に有効

#### [Builder Design Pattern](https://refactoring.guru/design-patterns/builder)
- [Go sample](https://refactoring.guru/design-patterns/builder/go/example)
- [Builder Pattern in GoLang](https://golangbyexample.com/builder-pattern-golang/)
- Builderは、複雑なオブジェクトを段階的に構築することができる創造的なデザインパターンで、同じ構築コードを使用して、オブジェクトの異なるタイプや表現を作成することができる。
##### 考察
- 多くのパラメータを持つコンストラクトの解決を目的としているので、そのようなケースには検討できる。
- しかし、そのようなオブジェクトはそもそも構造として良くない可能性があり、オブジェクトの最適化によってこのパターンは必要ないと考える

#### Prototype Design Patten

### Structual Patterns 1


#### [Composite Design Pattern](https://refactoring.guru/design-patterns/composite)
- [Go sample](https://refactoring.guru/design-patterns/composite/go/example)
- [Composite Design Pattern in Go](https://golangbyexample.com/composite-design-pattern-golang/)
- Compositeパターンの使用は、ApplicationのCore Modelが`Tree`として表現できる場合にのみ意味がある
- 例えば、2種類のオブジェクトがあるケース、「Product」と「Box」。Boxには、いくつかの`Product`と、いくつかの小さな`Box`を入れることができる。この小さな`Box`には、いくつかの`Product`と、さらに小さな`Box`を入れることができる。
- これは[Sample](https://golangbyexample.com/composite-design-pattern-golang/)を見るのが早いが、このようなデータ構造をJSONで作成し、Key Valueの1つの値として保持することで、データの取得コストを削減することもできる。

#### [Adapter Design Pattern](https://refactoring.guru/design-patterns/adapter)
- [Go sample](https://refactoring.guru/design-patterns/adapter/go/example)
- [Adapter Design Pattern in Go](https://golangbyexample.com/adapter-design-pattern-go/)
- 互換性のないインタフェースを持つオブジェクトを連携させるための構造的なデザインパターン
- Adapterは、データを様々な形式に変換するだけでなく、異なるインターフェースを持つオブジェクトの連携を支援することができる。
  - アダプタは、既存のオブジェクトの1つと互換性のあるインターフェイスを取得する。 
  - このインターフェイスを使用することで、既存のオブジェクトは安全にアダプタのメソッドを呼び出すことができる。 
  - 呼び出しを受けたアダプタは、リクエストを第2のオブジェクトに渡すが、第2のオブジェクトが期待する形式と順序で渡す。
- 双方向の通話を変換できるアダプターを作成することも可能

#### [Bridge Design Pattern](https://refactoring.guru/design-patterns/bridge)
- [Go sample](https://refactoring.guru/design-patterns/bridge/go/example)
- [Bridge Design Pattern in Go](https://golangbyexample.com/bridge-design-pattern-in-go/)

### Structual Patterns 2


#### Proxy Design Pattern

#### [Decorator Design Pattern](https://refactoring.guru/design-patterns/decorator)
- [Go sample](https://refactoring.guru/design-patterns/decorator/go/example)
- [Decorator design pattern in Go](https://golangbyexample.com/decorator-pattern-golang/)


#### [Facade Design Pattern](https://refactoring.guru/design-patterns/facade)
- [Go sample](https://refactoring.guru/design-patterns/facade/go/example)
- [Facade Design Pattern in Go](https://golangbyexample.com/facade-design-pattern-in-golang/)
- Facade Pattern is classified as a structural design pattern. This design pattern is meant to hide the complexities of the underlying system and provide a simple interface to the client. It provides a unified interface to underlying many interfaces in the system so that from the client perspective it is easier to use. Basically it provides a higher level abstraction over a complicated system.

#### Flyweight Design Pattern

### Behavioral Patterns 1


#### Strategy Design Pattern

#### Chain of Responsibility Design Pattern

#### Command Design Pattern

### Behavioral Patterns 2


#### [Template Design Pattern](https://refactoring.guru/design-patterns/template-method)
- [Go sample](https://refactoring.guru/design-patterns/template-method/go/example)
- [Template Design Pattern in Go](https://golangbyexample.com/template-method-design-pattern-golang/)
- 一連の処理を実行するメソッドを持つオブジェクトが、Interface型のメンバーを持ち、そのInterfaceを満たす実装をパターン事に用意する
- 共通コードが複数ある場合、上記Sampleは筋が悪い気がする。Interfaceを定義し、そのInterfaceを満たす基本実装をまず用意
```go
type DoSomethinger interface {
  DoSomething1()
  DoSomething2()
  DoSomething3()
}  

type DoSomethinger struct {
	Object            *object1
	Object2           *object2
	someInterface     someinterface
	number            uint64
}

type DoSomethingA struct {
	foobar.DoSomethingBase //embed
}


func (d *DoSomethingA) DoSomething3() (error) {
  // Override DoSomething3 on DoSomethinger's DoSomething3
}
```

#### Memento Design Pattern

#### Interpreter Design Pattern

### Behavioral Patterns 3


#### Visitor Design Pattern

#### State Design Pattern

#### Mediator Design Pattern

#### Observer Design Pattern
