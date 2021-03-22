# Design Pattern

## Cases

### Switch 文

- switch 文を使うの初回の 1 階層のみで、呼び出し先にまで switch 文で伝搬させるべきではない
- 多態オブジェクトを生成するために、`Factory Methodパターン`によって、適切な instance を作る
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

- アダプタパターン
  - これにより、API とのやり取りをカプセル化し、API の進化に伴う変更を 1 箇所に局所化する
  - 自分の制御化にないコードを制御するのに有用

### コマンド・照会の分離原則 (Command Query Segregation)

- 関数は何らかの処理を行うか、何らかの応答を返すかのどちらかを行うべきで、両方を行うべきではない。
- 両方同時に行うと混乱を招く
