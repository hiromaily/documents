# Design Pattern

## Cases

### システムを使うことと、構築することを分離する

- 関心事の分離
- main()における構築作業を分離する
  - `Builderパターン`
  - main 関数が、システムに必要なオブジェクトを生成し、それをアプリケーションに渡す
- オブジェクトの生成に対して、アプリケーションが責任を持たないと行けない場合
  - `Abstract Factory`によって、生成に関する詳細をアプリケーションから分離する
- 依存性注入(Dependency Injection, DI)
  - どの依存オブジェクトが実際に使われるかは、設定ファイルに記述する
  - コンストラクタ引数を通じて依存性の注入を受け付ける

### Switch 文, IF 文の連鎖

- switch 文を使うの初回の 1 階層のみで、呼び出し先にまで switch 文で伝搬させるべきではない
- 多態オブジェクトを生成するために、`Factory Method`によって、適切な instance を生成する
- この Factory Method によって生成された多態オブジェクトは共通の Interface を持つケースが多い

### ソースコードの行は異なるものの、似たようなアルゴリズムを持ったモジュール

- テンプレートメソッド
- ストラテジーパターン

### function のパラメータの数を減らす

[Go: Reduce function parameters](https://medium.com/@meeusdylan/go-reduce-function-parameters-19b785a87a59)

- まず、その function が`Single Responsibility Principle: 単一責任の原則` に従っていないのであれば、適切に分割する
  - この段階で意味のあるオブジェクトへの分割を正しく行うことができれば、それ以上は望まないでもいいかも
- Function Currying(カリー化) => 冗長で複雑であり、メリットが感じられない。。。
- 別のアプローチとしては、`Factory Method`によって、適切な instance を生成するのもよい

### 外部 API の呼び出しにおける、API の仕様変更の吸収

- `Adapter Design Pattern`
  - これにより、API とのやり取りをカプセル化し、API の進化に伴う変更を 1 箇所に局所化する
  - 自分の制御化にないコードを制御するのに有用

### 横断的関心事に対してモジュール構造を取り出すためのアプローチ

- 永続化、セキュリティ、トランザクションの扱いなど
- アスペクト指向プログラミング(AOP)
- AOP では、特定の関心事を実現するために、システム内の振る舞いのどの点に対し、整合性を維持したままで変更を加えるかをアスペクトと呼ばれるモジュールで指定する。この指定は、簡潔な宣言的、あるいは手続き的な構造を使って行われる
- `Decorator Design Pattern`によって、データアクセスオブジェクト(DAO)に振る舞いを拡張するデコレータだったり、トンランザクション、キャッシュといったデコレータを追加していく

### コマンド・照会の分離原則 (Command Query Segregation)

- 関数は何らかの処理を行うか、何らかの応答を返すかのどちらかを行うべきで、両方を行うべきではない。
- 両方同時に行うと混乱を招く

## Design Pattern

### Creational Patterns

1. Singleton Design Pattern
2. Builder Design Pattern

- Builder Pattern is a creational design pattern used for constructing complex objects.
- [Builder Pattern in GoLang](https://golangbyexample.com/builder-pattern-golang/)

3. Factory Method

- This pattern provides a way to hide the creation logic of the instances being created.
- [Factory Design Pattern in Go](https://golangbyexample.com/golang-factory-design-pattern/)

4. Abstract Factory

- Abstract Factory Design Pattern is a creational design pattern that lets you create a family of related objects.
- [Abstract Factory Design Pattern in Go
  ](https://golangbyexample.com/abstract-factory-design-pattern-go/)

5. Prototype Design Patten

### Structual Patterns 1

1. Composite Design Pattern
2. Adapter Design Pattern

- [Adapter Design Pattern in Go](https://golangbyexample.com/adapter-design-pattern-go/)

3. Bridge Design Pattern

### Structual Patterns 2

1. Proxy Design Pattern
2. Decorator Design Pattern
3. Facade Design Pattern
4. Flyweight Design Pattern

### Behavioral Patterns 1

1. Strategy Design Pattern
2. Chain of Responsibility Design Pattern
3. Command Design Pattern

### Behavioral Patterns 2

1. Template Design Pattern
2. Memento Design Pattern
3. Interpreter Design Pattern

### Behavioral Patterns 3

1. Visitor Design Pattern
2. State Design Pattern
3. Mediator Design Pattern
4. Observer Design Pattern
