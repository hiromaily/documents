# Architecture

ソフトウェアアーキテクチャのルールとは、プログラムの構成要素をどのように組み立てるかのルール  
優れたアーキテクチャーは、ユースケースを強調し、周辺の関心ごとからユースケースを切り離す  
テスト可能なアーキテクチャーにおいて、テストするために Database の起動も必要ないし、Web サーバーの起動も必要ない  
フレームワーク非依存であるべき  
(CleanArchitecture からの抜粋)

## アーキテクチャの変遷

- [レイヤードアーキテクチャ](./layered-architecture.md)
- [ヘキサゴナルアーキテクチャ](./hexagonal-architecture.md)
- オニオンアーキテクチャ
- [Clean Architecture](./clean-architecture.md)

[ストーリーでわかる！ソフトウェアアーキテクチャ 13 選](https://zenn.dev/mossan_hoshi/books/b2326637fec195)

## アーキテクチャ適用のメリット

- 実装のための指針となるため、コードに規則性が生まれ、可読性が向上する
  - 逆に言えばアーキテクチャの適用抜きに長期的なシステムメンテナンスは不可能
- コードレビュー時に無益な論争が避けられる

## [12 のソフトウェア・アーキテクチャの落とし穴とその避け方](https://www.infoq.com/jp/articles/avoid-architecture-pitfalls/)

- アーキテクチャを構築していない人は、アーキテクチャに関する決定を下すべきではない。アーキテクチャを形成する重要な技術的トレードオフを行うには、アーキテクチャがどのように構築されるかについての知識が不可欠である。
- 品質属性要件（Quality Assurance Requirements: QAR）はアーキテクチャ設計の原動力となる。これらの要件を無視したり、不十分な定義にしたりすることは、失敗のもとである。
- アーキテクチャの決定をベンダーに委ねてはならない。ベンダーはあなたのコンテキストも QAR も知らないし、あなたのためにトレードオフを決めることもできない。
- どんなに成功しているように見えても、他の組織からアーキテクチャをコピーしてはならない。彼らもまた、あなたのコンテキストや QAR を知らない。
- アーキテクチャを評価する唯一の方法は、構築してテストすることだ。設計を完璧にするためにこれを遅らせることは、失敗への道だ。

## 凝集度と結合度

保守性と生産性の高いコードを書くための尺度。
凝集度とは、関数の処理の役割の少なさを表す尺度。凝集度は高いほど良い
結合度とは、関数の独立性を表す尺度。結合度は、低いほど良い

## 開発手法

- Agile Development
- Lean Software Development
- DevOps
- Test-Driven Development
- Waterfall Model
- Spiral Model

## ソフトウェアのシステムコンポーネント設計におけるパターン

- DDD
- MVC (Model-View-Controller)
- MVVM (Model-View-ViewModel)
- Repository Pattern
- Dependency Injection (DI)
- Command Query Responsibility Segregation (CQRS)
- Event Sourcing

## [「Go の父」ロブ・パイクの「プログラミング 5 カ条」](https://gigazine.net/news/20200817-rob-pike-5-rules-programming/)

1. **ルール 1**: プログラムのどこで処理時間がかかるかはわからない。ボトルネックは意外な場所で発生するので、ボトルネックがどこにあるかを証明するまでは、臆測で速度の改善に取り組まないこと。

2. **ルール 2**: 処理速度を測定すること。測定して、コードのある部分が他の部分を圧倒しない限り、速度の調整をしてはいけない。

3. **ルール 3**: 派手なアルゴリズムは、入力値の n が小さいと処理が遅い。そして通常、n は小さい。派手なアルゴリズムは大きな定数を持っている。n が頻繁に大きくなることがないなら、派手なアルゴリズムは使わないようにすること。(n が大きくなっても、まずルール 2 を適用すること)

4. **ルール 4**: 派手なアルゴリズムは単純なアルゴリズムに比べてバグが多く、実装も大変なので、シンプルなアルゴリズムとシンプルなデータ構造を使うようにすること。

5. **ルール 5**: データが支配する。正しいデータ構造を選択し、うまく整理していれば、アルゴリズムはほとんどの場合、自明のものになる。プログラミングの中心はアルゴリズムではなくデータ構造。

## [ソフトウェアアーキテクトのための意思決定術](https://book.impress.co.jp/books/1123101159)

- [『ソフトウェアアーキテクトのための意思決定術』を読んだ](https://blog-dry.com/entry/2025/01/16/083430)

## [10 Common Coding Mistakes That Every Developer Should Avoid](https://dev.to/balrajola/10-common-coding-mistakes-that-every-developer-should-avoid-55e2)

1. Neglecting Code Readability
2. Overcomplicating Logic
3. Ignoring Edge Cases
4. Not Using Version Control Properly
5. Skipping Tests
6. Hardcoding Values
7. Not Handling Errors Properly
8. Not Taking Advantage of Libraries and Frameworks
9. Ignoring Documentation
10. Not Refactoring Code Regularly

## References

- [スライド: これから学ぶ人のための ソフトウェアアーキテクチャ入門](https://speakerdeck.com/snoozer05/20230727-software-architecture-is-a-tool-to-enhance-our-humanity)
- [保守性の高いソフトウェア開発の Tips 集](https://zenn.dev/riku/books/36d9873ee1c0e6)
- [良いコードとは何か - エンジニア新卒研修 スライド公開](https://note.com/cyberz_cto/n/n26f535d6c575)
- [技術選定/アーキテクチャ設計で後悔しないためのガイドライン](https://qiita.com/hirokidaichi/items/a746062917595619720b)
- [複雑さを相手に抽象化を盾にしましょう](https://tech.enigmo.co.jp/entry/2020/12/11/100000)
- [私のよく使うソフトウェアアーキテクチャの雛型](https://zenn.dev/m10maeda/articles/my-favorite-architecture-blueprint)
