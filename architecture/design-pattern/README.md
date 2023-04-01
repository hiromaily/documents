# Design Pattern

## Cases

### 1. システムを使うことと、構築することを分離する

- 関心事の分離
- main()における構築作業を分離する
  - `Builderパターン`
  - main 関数が、システムに必要なオブジェクトを生成し、それをアプリケーションに渡す
- オブジェクトの生成に対して、アプリケーションが責任を持たないと行けない場合
  - `Abstract Factory`によって、生成に関する詳細をアプリケーションから分離する
- `依存性注入(Dependency Injection, DI)`
  - どの依存オブジェクトが実際に使われるかは、設定ファイルに記述する
  - コンストラクタのInterface型の引数を通じて依存性の注入を受け付ける

### 2. Switch 文, IF 文の連鎖

- switch 文を使うの初回の 1 階層のみで、呼び出し先にまで switch 文で伝搬させるべきではない
- 多態オブジェクトを生成するために、`Factory Method`によって、適切な instance を生成する
- この Factory Method によって生成された多態オブジェクトは共通の Interface を持つケースが多い

### 3. ソースコードの行は異なるものの、似たようなアルゴリズムを持ったモジュール

- [Template method pattern](https://en.wikipedia.org/wiki/Template_method_pattern)
- [Strategy pattern](https://en.wikipedia.org/wiki/Strategy_pattern)

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

#### Builder Design Pattern

   - Builder Pattern is a creational design pattern used for constructing complex objects.
   - [Builder Pattern in GoLang](https://golangbyexample.com/builder-pattern-golang/)


#### Factory Method

   - This pattern provides a way to hide the creation logic of the instances being created.
   - [Factory Design Pattern in Go](https://golangbyexample.com/golang-factory-design-pattern/)


#### [Abstract Factory](https://refactoring.guru/design-patterns/abstract-factory)
   - [Abstract Factory Design Pattern in Go](https://golangbyexample.com/abstract-factory-design-pattern-go/)
   - 関連するオブジェクトのFamilyを、その具体的なクラスを指定することなく生成することができる創造的なデザインパターン
   - 椅子を作ると仮定すると、椅子の種類毎にクラスが存在するが、それぞれの椅子Classはベースとなる椅子のInterfaceを満たすようにする


#### Prototype Design Patten

### Structual Patterns 1


#### Composite Design Pattern
   - This is a structural design pattern. Composition design pattern is used when we want a Group of objects called ‘composite’ is treated in a similar way as a single object. It comes under structural design pattern as it allows you to compose objects into a tree structure. Each of the individual objects in the tree structure can be treated in the same way irrespective of whether they are Complex or Primitive.
   - Let’s try to understand it with an example of a file system of OS. In the file system, there are two types of objects File and Folder. There are cases when File and Folder are treated to be the same way. It will be more clear as we go along.
   - [Composite Design Pattern in Go](https://golangbyexample.com/composite-design-pattern-golang/)

#### Adapter Design Pattern

   - [Adapter Design Pattern in Go](https://golangbyexample.com/adapter-design-pattern-go/)


#### Bridge Design Pattern
   - [Bridge Design Pattern in Go](https://golangbyexample.com/bridge-design-pattern-in-go/)

### Structual Patterns 2


#### Proxy Design Pattern

#### Decorator Design Pattern

   - It lets you provide additional functionality or decorates an object without altering that object
   - [Decorator design pattern in Go](https://golangbyexample.com/decorator-pattern-golang/)


#### Facade Design Pattern
   - Facade Pattern is classified as a structural design pattern. This design pattern is meant to hide the complexities of the underlying system and provide a simple interface to the client. It provides a unified interface to underlying many interfaces in the system so that from the client perspective it is easier to use. Basically it provides a higher level abstraction over a complicated system.
   - [Facade Design Pattern in Go](https://golangbyexample.com/facade-design-pattern-in-golang/)

#### Flyweight Design Pattern

### Behavioral Patterns 1


#### Strategy Design Pattern

#### Chain of Responsibility Design Pattern

#### Command Design Pattern

### Behavioral Patterns 2


#### Template Design Pattern

#### Memento Design Pattern

#### Interpreter Design Pattern

### Behavioral Patterns 3


#### Visitor Design Pattern

#### State Design Pattern

#### Mediator Design Pattern

#### Observer Design Pattern
