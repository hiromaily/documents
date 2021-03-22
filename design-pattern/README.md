# Design Pattern

## Cases
### Switch文
- switch文を使うの初回の1階層のみで、呼び出し先にまでswitch文で伝搬させるべきではない
- 多態オブジェクトを生成するために、`Factory Methodパターン`によって、適切なinstanceを作る
- このFactory Methodによって生成された多態オブジェクトは共通のInterfaceを持つケースが多い


### ソースコードの行は異なるものの、似たようなアルゴリズムを持ったモジュール

- テンプレートメソッド
- ストラテジーパターン

### functionのパラメータの数を減らす
[Go: Reduce function parameters](https://medium.com/@meeusdylan/go-reduce-function-parameters-19b785a87a59)

- まず、そのfunctionが`Single Responsibility Principle: 単一責任の原則` に従っていないのであれば、適切に分割する
  - この段階で意味のあるオブジェクトへの分割を正しく行うことができれば、それ以上は望まないでもいいかも
- Function Currying(カリー化) => 冗長で複雑であり、メリットが感じられない。。。
- 別のアプローチとしては、`Factory Method`によって、適切なinstanceを生成するのもよい

### コマンド・照会の分離原則 (Command Query Segregation)
- 関数は何らかの処理を行うか、何らかの応答を返すかのどちらかを行うべきで、両方を行うべきではない。
- 両方同時に行うと混乱を招く

