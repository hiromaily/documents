# Structual Design Patterns

## [Composite Design Pattern](https://refactoring.guru/design-patterns/composite)
- [Go sample](https://refactoring.guru/design-patterns/composite/go/example)
- [Composite Design Pattern in Go](https://golangbyexample.com/composite-design-pattern-golang/)
- Compositeパターンの使用は、ApplicationのCore Modelが`Tree`として表現できる場合にのみ意味がある
- 例えば、2種類のオブジェクトがあるケース、「Product」と「Box」。Boxには、いくつかの`Product`と、いくつかの小さな`Box`を入れることができる。この小さな`Box`には、いくつかの`Product`と、さらに小さな`Box`を入れることができる。
- これは[Sample](https://golangbyexample.com/composite-design-pattern-golang/)を見るのが早いが、このようなデータ構造をJSONで作成し、Key Valueの1つの値として保持することで、データの取得コストを削減することもできる。

## [Adapter Design Pattern](https://refactoring.guru/design-patterns/adapter)
- [Go sample](https://refactoring.guru/design-patterns/adapter/go/example)
- [Adapter Design Pattern in Go](https://golangbyexample.com/adapter-design-pattern-go/)
- 互換性のないインタフェースを持つオブジェクトを連携させるための構造的なデザインパターン
- Adapterは、データを様々な形式に変換するだけでなく、異なるインターフェースを持つオブジェクトの連携を支援することができる。
  - アダプタは、既存のオブジェクトの1つと互換性のあるインターフェイスを取得する。 
  - このインターフェイスを使用することで、既存のオブジェクトは安全にアダプタのメソッドを呼び出すことができる。 
  - 呼び出しを受けたアダプタは、リクエストを第2のオブジェクトに渡すが、第2のオブジェクトが期待する形式と順序で渡す。
- 双方向の通話を変換できるアダプターを作成することも可能

## [Bridge Design Pattern](https://refactoring.guru/design-patterns/bridge)
- [Go sample](https://refactoring.guru/design-patterns/bridge/go/example)
- [Bridge Design Pattern in Go](https://golangbyexample.com/bridge-design-pattern-in-go/)
- 実装から抽象を切り離すことで、巨大なクラスを分割し、変更の容易性を与えることを目的としている

### 考察
- デザインパターンと呼べるものではないような？

## [Proxy Design Pattern](https://refactoring.guru/design-patterns/proxy)
- [Go sample](https://refactoring.guru/design-patterns/proxy/go/example)
- ユースケースとしては、実際に使うサービスをラップすることで、前後に処理を差し込む場合に有効

## [Decorator Design Pattern](https://refactoring.guru/design-patterns/decorator)
- [Go sample](https://refactoring.guru/design-patterns/decorator/go/example)
- [Decorator design pattern in Go](https://golangbyexample.com/decorator-pattern-golang/)
- 別名で、Wrapperとも言われる
- Interfaceを併せ持つオブジェクトをラップすることで、処理に加え内包するオブジェクトを実行し処理をまとめる

## [Facade Design Pattern](https://refactoring.guru/design-patterns/facade)
- [Go sample](https://refactoring.guru/design-patterns/facade/go/example)
- [Facade Design Pattern in Go](https://golangbyexample.com/facade-design-pattern-in-golang/)
- `Facade`は`ファサード`と読むので注意。正面、上部といった意味を持つ
- 構造デザインパターンであり、基礎となるシステムの複雑さを隠し、クライアントにシンプルなInterfaceを提供することを目的としている。 これは、システム内の基礎となる多くのインターフェイスに統一されたインターフェイスを提供するため、クライアントの観点からは使いやすくなる。 基本的に、複雑なシステムに対してより高いレベルの抽象化を提供する。
- つまり、複雑なライブラリやClassに対して機能制限はあるものの、簡単に操作するためのラッパーオブジェクトとなる
- 内部のクラスを使いこなすもので、独自の機能を実装するものではない

## [Flyweight Design Pattern](https://refactoring.guru/design-patterns/flyweight)
- [Go sample](https://refactoring.guru/design-patterns/flyweight/go/example)
- メモリ消費量を低く抑えることでプログラムが膨大な数のオブジェクトを支えることが可能になる
- 異なるオブジェクトによって使われる同じデータをキャッシュすることにより、 RAM を節約する
- 該当する既存のインスタンスがあれば、それを共用する
