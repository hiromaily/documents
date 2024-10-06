# テストダブル

テストダブル (Test Double) とは、ソフトウェアテストにおいて、テスト対象が依存しているコンポーネントを置き換える代用品のこと。ダブルは代役、影武者を意味する。

## テストダブルの種類は以下の通り

- スタブ
- モック
- スパイ
- フェイク
- ダミー

[テストダブルをなんとなく理解する](https://qiita.com/kaleidot725/items/075934e8e6be902a7fe1)

## スタブとモックの違い

- [What's the difference between stub and mock in Go unit testing?](https://stackoverflow.com/questions/53360256/whats-the-difference-between-stub-and-mock-in-go-unit-testing)

```go
type Calculator interface {
    Add(x, y int) int
}

type CalculatorMock struct{}

func (c *CalculatorMock) Add(x, y int) int {
    return x + y
}

type CalculatorStub struct {
    result int
}

func (c *CalculatorStub) Add(x, y int) int {
    return c.result
}
```

## stub:スタブ

- `テスト実行中に使用される、コード内の依存関係を置き換えるもの`。スタブは通常、ある特定のテストのために作られ、期待値や仮定がハードコードされているため、別のテストに再利用することできない。

この例では、`CalculatorStub`は、常にresultフィールドで指定された所定の結果を返すCalculatorインターフェイスのスタブ実装。これは、入力が異なると出力が異なるCalculatorインターフェイスに依存するコード片の動作をテストしたいとき、出力が常に同じである特定のケースをテストしたいときに便利。

## モック

mockは`stubを高機能化したもの`で、設定手段を追加し、テストによって異なる期待値を設定できるようにしたもの。そのため、モックはより複雑になるが、異なるテストに対して再利用することができる。  
Interfaceを満たす別実装という見方もできる？

この例では、`CalculatorMock`は、常に入力パラメータの合計を返すCalculatorインターフェイスのモック実装である。これは、Calculatorインターフェイスに依存するコードの一部の動作を、実際の実装を使用せずにテストしたい場合に便利。
