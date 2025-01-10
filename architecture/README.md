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

### Agile Development

### Lean Software Development

### DevOps

### Test-Driven Development

### Waterfall Model

### Spiral Model

## ソフトウェアのシステムコンポーネント設計におけるパターン

### DDD

### MVC (Model-View-Controller)

### MVVM (Model-View-ViewModel)

### Repository Pattern

### Dependency Injection (DI)

### Command Query Responsibility Segregation (CQRS)

### Event Sourcing

## References

- [保守性の高いソフトウェア開発のTips集](https://zenn.dev/riku/books/36d9873ee1c0e6)
- [良いコードとは何か - エンジニア新卒研修 スライド公開](https://note.com/cyberz_cto/n/n26f535d6c575)
