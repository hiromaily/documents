# RxJS

Reactive Extensions Library for JavaScript

## リアクティブプログラミング

- データストリームとその変更の伝搬を関心事とする宣言的プログラミングパラダイム

## References

- [Official](https://rxjs.dev/)
- [github](https://github.com/ReactiveX/rxjs)

## Observer と Subscribe の連携

### Observer

- `next`, `error`, `complete` の 3 つの関数をまとめて 1 つのオブジェクトにしたもの

### Subscribe

- Subscribe は関数であり、Observer を受け取って、Observer の中にある関数(next,error,complete)を実行する

## Observable と Subscribe の連携

### Observable

- `Observerオブジェクト`とはまったく異なるオブジェクトであり、注意
- subscribe という名前のメソッドを持つ
- `create`か`Creation Operator`を使って作る
- Observable の subscribe には関数を直接渡すことができる
