# Functional Programming

- 関数型プログラミングは`純粋関数`を扱う
  - 引数以外の入力が無い
  - 返り値以外の出力（副作用）が無い
  - 引数が同じなら返り値は常に同じ

## なっとく！関数型プログラミング まとめ

- 関数型プログラミング言語
  - Kotlin, Scala, F#, Rust, Clojure, Haskell
- 関数は本体とシグネチャ(function 名、パラメータ、戻り値の定義)に分けられるが、関数型プログラミングでは本体よりシグネチャに焦点を合わせる傾向になる
- 関数型プログラミングは、次のような関数を使うプログラミング言語
  - シグネチャが嘘をつかない
  - 本体が極力宣言的 (命令的ではない)
- 純粋関数は関数型プログラミングの土台となる
  - 嘘をつかないすべえての関数の中で最も信頼できるもの
- オブジェクト志向プログラミングで Class がメンバを`状態`として扱うとき、その状態の処理が不適切だと予期せぬ挙動をすることになる
  - 参照型の object を返してしまうと、その object を修正することで、元の instance の挙動に影響を与えてしまう
- [重要] 関数型プログラミングでは、データを直接変更するのではなく、データのコピーを渡す

## References

- [こわくない関数型プログラミング](https://zenn.dev/tockri/books/dcaf6c55e64448)
- [仕事で使える TypeScript: 関数型指向のプログラミング](https://future-architect.github.io/typescript-guide/functional.html)
- [「Learning Functional Programming in Go」を読んだ](https://shinharad.hateblo.jp/entry/2018/08/30/172151)
