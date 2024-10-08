# Behavioral Design Patterns

## [Strategy Design Pattern](https://refactoring.guru/design-patterns/strategy)

- [Go sample](https://refactoring.guru/design-patterns/strategy/go/example)
- [Strategy Design Pattern in Go](https://golangbyexample.com/strategy-design-pattern-golang/)
- 処理の目的は同じだが、複数のアルゴリズムが存在しており、それを状況に合わせてスイッチしたいようなケースに有効
- 処理の Interface を定義し、異なるアルゴリズム毎に Interface を満たすオブジェクトを用意。DI などによって生成時に使用したいアルゴリズムを設定したり、設定した後に変更可能な set()function を用意する。

## [Chain of Responsibility Design Pattern](https://refactoring.guru/design-patterns/chain-of-responsibility)

- [Go sample](https://refactoring.guru/design-patterns/chain-of-responsibility/go/example)
- 別名、CoR、Chain of Command、責任のチェーン、責任の連鎖、コマンドのチェーン、コマンドの連鎖
- 潜在的なハンドラーの連鎖の上を、 ハンドラーのどれかが処理するまで、 リクエストを回していく
- Web Server のハンドラーメソッドはこのパターンを利用することが多い

## [Command Design Pattern](https://refactoring.guru/design-patterns/command)

- [Go sample](https://refactoring.guru/design-patterns/command/go/example)

## Behavioral Patterns 2

## [Template Design Pattern](https://refactoring.guru/design-patterns/template-method)

- [Go sample](https://refactoring.guru/design-patterns/template-method/go/example)
- [Template Design Pattern in Go](https://golangbyexample.com/template-method-design-pattern-golang/)
- 一連の処理の中に、一部だけ異なる処理が存在するようなコードが複数存在する場合に有効
- 一連の処理を実行するメソッドを持つオブジェクトが、Interface 型のメンバーを持ち、その Interface を満たす実装をパターン事に用意する
- 共通コードが複数ある場合、上記 Sample は筋が悪い気がする。Interface を定義し、その Interface を満たす基本実装をまず用意

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

## Memento Design Pattern

## Interpreter Design Pattern

## Behavioral Patterns 3

## Visitor Design Pattern

## State Design Pattern

## Mediator Design Pattern

## Observer Design Pattern
