# 自作プログラミング言語

新しいプログラミング言語を作成するためには、以下のステップや要素を考慮することが重要。
新しいプログラミング言語を作ることは非常に挑戦的だが、それだけに達成感も大きなものとなる。よく知られたプログラミング言語がどのように設計・実装されているかを研究することも、非常に有用な手助けとなる。

## 1. 言語の目的と設計目標の設定

まず、どのような目的で新しいプログラミング言語を作成するのかを明確にする必要がある。例えば、特定のタスクを簡素化する、高性能な計算を可能にする、学習しやすい言語にするなどの目標を設定する。

## 2. 言語の構文とセマンティクスの設計

- **構文（Syntax）**:
  言語の文法やキーワードを設計する。どのような形でプログラムを書くかを決定し、定式化する。
- **セマンティクス（Semantics）**:
  各構文がどのような意味を持つかを定義する。構文に従ったコードが実行される際にどのような動作をするかを詳細に規定する。

## 3. パーサーとトークナイザーの実装

- **トークナイザー（Lexical Analyzer）**:
  ソースコードをトークン（単語や記号）に分解するコンポーネント。
- **パーサー（Parser）**:
  生成されたトークンを解析して、構文木または抽象構文木（AST：Abstract Syntax Tree）を生成する。

## 4. インタプリタまたはコンパイラの実装

- **インタプリタ（Interpreter）**:
  コードをその場で実行するタイプの実装。
- **コンパイラ（Compiler）**:
  ソースコードを他の言語（通常は機械語または中間表現）に変換し、その後実行されるバイナリを生成する。

## 5. ランタイム環境とライブラリの構築

言語が実行される際に必要な標準ライブラリやサポートする機能（メモリ管理、入出力処理など）を整備する。

## 6. デバッグとテスト

- **単体テスト（Unit Testing）**:
  各コンポーネントや機能が正しく動作することを確認する。
- **統合テスト（Integration Testing）**:
  言語全体としてプログラムが期待通りに動作することを検証する。

## 7. ドキュメントの作成

- **言語仕様書**:
  言語の文法、ライブラリ、使用方法などを詳細に記述する。
- **ユーザーガイド**:
  ユーザーが言語を使い始めるためのガイドを作成する。チュートリアルやサンプルコードを含めると良い。

## 8. コミュニティの形成

オープンソースとして公開し、ユーザーや開発者のコミュニティを形成すると、フィードバックや貢献が得られやすくなる。

## どのような言語で開発するか

新しいプログラミング言語を開発する際に、既存の言語とエコシステムの強みを活かすのが一般的です。高校プラットフォームの互換性、高い性能、メモリ管理といった要素を考慮して選定することが重要。

### C 言語

- **利点**: 高速で低レベルのシステム操作が可能。メモリ管理やポインタ操作が直接行えるため、効率性を高めることができる。
- **使用例**: 古典的なコンパイラやインタプリタにおいてよく使用されており、例えば Python の初期の実装（CPython）や Ruby の初期の実装は C で書かれている。

### C++

- **利点**: C 言語の特性を引き継ぎつつ、オブジェクト指向やテンプレート機能などが追加されている。高パフォーマンスのアプリケーション開発に適している。
- **使用例**: LLVM（Low-Level Virtual Machine）や Clang コンパイラなどのプロジェクトで使用されている。

### Rust

- **利点**: メモリ安全性と並行処理の制御が強化されている。性能が高く、かつ安全性が重視されるプロジェクトに適している。
- **使用例**: Servo ブラウザエンジンや、様々なコンパイラ関連のプロジェクトで使用されています。

### Java

- **利点**: クロスプラットフォームの互換性を持ち、ガベージコレクション（自動メモリ管理）機能がある。Java 仮想マシン（JVM）上で動作するため、移植性が高い。
- **使用例**: Groovy や Scala など、Java で実装された高レベルのプログラミング言語の一部は、JVM を利用している。

### Python

- **利点**: 簡潔で学びやすい文法が特徴。多くのライブラリやフレームワークが存在し、プロトタイピングに適している。
- **使用例**: Python 自身が新しい DSL（ドメイン固有言語）や教育用言語などの実装に使用されることがある。

### Haskell

- **利点**: 関数型言語であり、抽象度が高いプログラムを書きやすい。純粋関数型で副作用をコントロールしやすい。
- **使用例**: GHC（Glasgow Haskell Compiler）などの言語処理系の実装に使用されている。

### その他

- **OCaml**: 形式手法やコンパイラの研究・開発においてよく使用される。
- **Lisp**: 高度なメタプログラミングや DSL の実装に向いている。

### 実際の例

- **LLVM**: コンパイラのフレームワークで、C++で実装されている。
- **GCC**: GNU Compiler Collection は C と C++で実装されている。
- **CPython**: Python のリファレンス実装で、C で書かれている。

## References

- [How I wrote my own "proper" programming language](https://mukulrathi.com/create-your-own-programming-language/intro-to-compiler/)
