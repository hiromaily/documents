# Functional Programming

- 関数型プログラミングは`純粋関数`を扱う
  - 引数以外の入力が無い
  - 返り値以外の出力（副作用）が無い
  - 引数が同じなら返り値は常に同じ

## なっとく！関数型プログラミング まとめ

- 関数型プログラミング言語
  - Kotlin, Scala, F#, Rust, Clojure, Haskell
- 関数は`本体`と`シグネチャ`(function 名、パラメータ、戻り値の定義)に分けられるが、関数型プログラミングでは本体より`シグネチャ`に焦点を合わせる傾向になる
- 関数型プログラミングは、次のような関数を使うプログラミング言語
  - シグネチャが嘘をつかない。つまり、関数ができることはすべてシグネチャに書かれているべき
    - つまり、関数は引数を受け取り、値を返す。それ以外は何もしない。
  - 本体が極力`宣言的` (命令的ではない)。宣言的とは`どのように行うか`ではなく`何を行う必要があるか`になる
  - `データを直接変更するのではなく、データのコピーを渡す` (可変性を回避すること)
  - `イミュータブル`な値を操作する`純粋関数`を使うプログラミング
  - 状態を引数として渡す
  - 関心事を別々の関数に分離する。`関心の分離`
  - 関数を値として渡す方法は広く使われている
  - 関数型プログラミングではすべてが`式`となる
- `純粋関数`は関数型プログラミングの土台となる
  - 嘘をつかないすべての関数の中で最も信頼できるもの
  - `関数の戻り値は１つだけ`
  - `関数は引数のみに基づいて戻り値を計算する`
  - `関数は既存の値を変更しない`
  - とはいえ、純粋関数じゃなくてもうまくいくケースは多い
  - `単一責任`
  - 戻り値を返す以外に関数が行うことはすべて副作用であり、純粋関数は`副作用がない`
  - `参照透過性`。同じパラメータであれば何回呼び出しても常に同じ値が返る
  - メリットの１つは、`テストの容易性`
- オブジェクト志向プログラミングで Class がメンバを`状態`として扱うとき、その状態の処理が不適切だと予期せぬ挙動をすることになる
  - そのため、状態は持たず必要になる度に`再計算`するようにする
  - 参照型の object を返してしまうと、その object を修正することで、元の instance の挙動に影響を与えてしまう
- 共有ミュータブル状態
  - 要素
    - 共有: プログラムの様々な部分からこの値にアクセスできる
    - ミュータブル: この値を直接変更できる
    - 状態: この値は 1 つの場所に格納され、アクセス可能
  - プログラミング中に注意を払わなければならない可動部分。これはすべてプログラムの複雑さを増大させる
  - 関数型アプローチでは、イミュータブルな状態を使うことで対処する
  - オブジェクト指向アプローチでは、カプセル化によって変化するデータを保護する
- `for 内包表記`

```scala
for {
  x <- List(1, 2, 3)
  y <- Set(2)
} yield x * y
// -> List(2, 4, 6)

// for {
//   a <- as
//   b <- bs
//   ...
//   z <- zs
// } yield function (a, b, ..., z)
```

- Option 型で null を回避

### [For TypeScript](https://www.typescriptlang.org/docs/handbook/typescript-in-5-minutes-func.html)

TypeScript は、JavaScript に伝統的な`オブジェクト指向の型`を持ち込もうとしたことから始まった。それが発展するにつれて、TypeScript の型システムはネイティブの JavaScript 者によって書かれたコードをモデル化するために進化してきた。
実際には、TypeScript のオブジェクト指向プログラムは、OO 機能を持つ他の一般的な言語のものと似ている。

- FP 用のライブラリが出ている: [gcanti/fp-ts](https://github.com/gcanti/fp-ts)
  - Star は 10k を超える

#### Immutable

プリミティブ型である、`boolean`, `number`, `bigint`, `string`, `symbol`, `null`, `undefined` を関数に渡したとき、に不変な振る舞いをするため、副作用はない。しかし、`object`は参照情報が渡されるため、内部の状態が変化する。そのため、object は deepCopy などで渡された値をコピーし、それに変更を加えた結果を返す必要がある。
配列の場合、元のデータはそのままに、複製しつつ変化させたバージョンを作るには、配列メソッドである、`map()`, `forEach()`, `filter()`が使える。

#### Typescript で FP の Option 型を扱う場合

- [【typescript で関数型】fp-ts の Option 型を使って undefined と戦う](https://aknow2.hatenablog.com/entry/2019/03/26/142409)
- [gcanti/fp-ts](https://github.com/gcanti/fp-ts)を使う必要があるが、複雑になりがち

### [仕事で使える TypeScript: 関数型指向のプログラミング](https://future-architect.github.io/typescript-guide/functional.html)

## For Golang

- [「Learning Functional Programming in Go」を読んだ](https://shinharad.hateblo.jp/entry/2018/08/30/172151)
- [Functional Programming in Go 読書メモ](https://zenn.dev/ta_toshio/scraps/7b3e66fd311a70)

## References

- [関数型プログラミングはまず考え方から理解しよう](https://qiita.com/stkdev/items/5c021d4e5d54d56b927c)
- [こわくない関数型プログラミング](https://zenn.dev/tockri/books/dcaf6c55e64448)
- [A Guide to Functional Programming](https://dev.to/dhanush9952/a-guide-to-functional-programming-18h9)
- [スライド: 関数型プログラミングの設計テクニック](https://speakerdeck.com/matarillo/guan-shu-xing-puroguramingunoshe-ji-tekunituku)
