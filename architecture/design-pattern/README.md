# Design Pattern

- [Refactoring Guru](<https://refactoring.guru/ja/design-patterns>_
- [Good Refactoring vs Bad Refactoring](https://www.builder.io/blog/good-vs-bad-refactoring)

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
  - コンストラクタの Interface 型の引数を通じて依存性の注入を受け付ける
- [Registry Pattern](https://medium.com/@david.s.qian/design-pattern-registry-f6bacdf39882)

### 2. Switch 文, IF 文の連鎖

- switch 文を使うの初回の 1 階層のみで、呼び出し先にまで switch 文で伝搬させるべきではない
- 多態オブジェクトを生成するために、`Factory Method`によって、適切な instance を生成する
  - Interface 型への実装ロジックの挿入、ここでは`DI`によっても実現できる
- この Factory Method によって生成された多態オブジェクトは共通の Interface を持つケースが多い

### 3. ソースコードの行は異なるものの、似たようなアルゴリズムを持ったモジュール

- 一連の処理の中で、一部のみ処理方法が異なるものなどに適用できる
- [Template method pattern](./behavioral-patterns.md#template-design-pattern)
- [Strategy pattern](./behavioral-patterns.md#strategy-design-pattern)

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
