# DSL (Domain Specific Language)

- ドメイン固有言語（domain-specific language、DSL）とは、特定のタスク向けに設計されたコンピュータ言語
- `ドメイン特化言語`あるいは単に`ドメイン言語`とも呼ばれる
- C言語やJavaのような汎用のプログラミング言語の対照とされる

## DSLの分類
### 外部DSL
- 外部DSLとは汎用プログラミング言語とはまったく別の構文を持ち、既存の言語とは無関係に独立に定義されたもの
  - SQL, VBA, XMLなど

### 内部DSL
- 内部DSLとは汎用プログラミング言語の記述ルールを工夫し、見かけ上の構文を自然言語に近づけたもの
- 作成方法は以下の通り
  - 必要となる処理のルールを決定する
  - そのルールを定義する構造を作成する
  - 使用する言語で、処理をする



## メタプログラミングとは
- プログラミング技法の一種で、ロジックを直接コーディングするのではなく、あるパターンをもったロジックを生成する高位ロジックによってプログラミングを行う方法、またその高位ロジックを定義する方法のこと
- 主に対象言語に埋め込まれたマクロ言語によって行われる
- コードを自動生成するためのコード
- プログラミング言語の持つ、GenericやTemplate機能など

### メタプログラミングの用途
- コード生成
- コード埋め込み
- 動作の差し替え