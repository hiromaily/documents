# Programming

[Learn X in Y minutes](https://learnxinyminutes.com/)

## Interpreted Language (Interpretive Language)

- Python
- JavaScript
- Ruby
- PHP
- Perl
- Bash
- Lua
- R

## Compiler Language

- C
- C++
- Java
- Swift
- Objective-C
- Rust
- Go
- Pascal
- Ada
- Fortran

## プログラミングの Paradigms

- オブジェクト指向プログラミング（OOP）
  - Java、C++、Python、Ruby
- 手続き指向プログラミング（POP）
  - C、Pascal、BASIC
- 関数型プログラミング（FP）
  - Haskell、Erlang、Scala、F#
- 論理型プログラミング
  - Prolog
- 宣言型プログラミング
  - SQL、HTML、CSS
- 並行プログラミング
  - Go、Concurrent ML、Erlang
- イベント駆動型プログラミング
  - JavaScript、C#
- リアクティブプログラミング
  - ReactiveX、Elm、Akka Streams

### Object-Oriented (OOP)

- オブジェクトの定義と、オブジェクト間の関係、相互作用を記述することによりプログラムを構築していく
- オブジェクトにはそれぞれ固有のデータ（属性/プロパティ）と手続き（メソッド）があり、外部からのメッセージを受けてメソッドを実行し、データを操作する

### Data-Oriented (DOP)

- データは不変
- ロジックはデータから独立させる (コードとデータを分離する)
- 汎用的なデータ構造でデータを表現する
- データスキーマ(構造定義)とデータ表現を分離する
- OOP の代わりになるものではなく、共存して利用することになる

#### DOP が有効な状況

- OOP では、各オブジェクトの責務が肥大化していくなど
- OOP の複雑性を解消するために生まれた

#### DOP References

- [オブジェクト指向の複雑性を軽減する、データ指向プログラミング入門](https://zenn.dev/chillnn_tech/articles/e78a76f94ad45a)

### Functional-Oriented Programming (FOP) 関数型プログラミング

- 最古のプログラミング手法
- 関数を主軸とするソフトウェア開発プロセスを指す
- モジュール間で状態を共有したり、データが変更されること(可変性) を気にしたりしなくても済むように、関数を組み合わせることで新しい関数を作成し、アプリケーションを開発する
- 関数は FP における “第一級オブジェクト” であり、他のすべての値と同じように扱われるので、 引数として渡すことができる
- 関数を返す関数のことを(返す値の抽象度が高いことから)高階関数という
- 不変性という概念が重要になる。FP の原則ではすべての値を不変として扱る
- 値を変更するには、作成済みの値を基本値やコピーとして使用するなどして、新しい値を作成するしかない
- React ライブラリにおいて、宣言的で扱いやすくすることを目的として FP の原則が採用されている

## プログラムの実行パターン

- [ランタイムシステム](https://ja.wikipedia.org/wiki/%E3%83%A9%E3%83%B3%E3%82%BF%E3%82%A4%E3%83%A0%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0)
- [実行ファイル](https://ja.wikipedia.org/wiki/%E5%AE%9F%E8%A1%8C%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB)
- [インタプリタ](https://ja.wikipedia.org/wiki/%E3%82%A4%E3%83%B3%E3%82%BF%E3%83%97%E3%83%AA%E3%82%BF)
- [バーチャルマシン](https://ja.wikipedia.org/wiki/%E4%BB%AE%E6%83%B3%E6%A9%9F%E6%A2%B0)

## 人気のある言語

- [Ranking Programming Languages by GitHub Users](https://www.benfrederickson.com/ranking-programming-languages-by-github-users/)
  - 少し古い
