# Task Runner

代表的なタスクランナーやビルドシステムについて

## Unix 系システム

1. **Makefile**:

   - 最も伝統的なビルドシステムで、C や C++などのコンパイルでよく使われる。
   - GNU Make が一般的です。

2. **CMake**:
   - マルチプラットフォームのビルドシステムで、生成される Makefile や Ninja ファイルを使って実際のビルドを行う。
   - 複雑なプロジェクト構成を簡単に管理できる。

## 汎用タスクランナー

1. **Taskfile (Go)**:
   - YAML 形式で定義する軽量のタスクランナー。
2. **Invoke (Python)**:

   - Python コードでタスクを定義するタスクランナー。Fabric の後継と見なされている。

3. **Just (Rust)**:
   - シェルコマンドを使ってタスクを記述するクイックで簡単なタスクランナー。

## JavaScript 系

1. **npm scripts**:
   - `package.json`に定義する形で簡単なタスクを実行できる。
2. **Webpack**:
   - 主にフロントエンドのモジュールバンドラーだが、カスタムタスクも設定できる。
   - 複雑な依存関係を管理することができる。

3. **Grunt**:

   - JavaScript ベースのタスクランナーで、設定ファイル(`Gruntfile.js`)を使ってタスクを定義。

4. **Gulp**:

   - ストリームを使ったビルドシステムで、設定ファイル(`gulpfile.js`)でタスクを定義。
   - 宣言的であり、パイプでつなぐようにタスクを定義できる。

## Java 系

1. **Maven**:

   - プロジェクト管理とビルドのためのツールで、XML 形式の設定ファイル(`pom.xml`)を使う。
   - 依存関係の管理が強力です。

2. **Gradle**:
   - Groovy や Kotlin で設定を記述するモダンなビルドシステム。
   - 柔軟な設定が可能で、Maven の代替として広く使われている。

## その他の言語やフレームワーク

1. **Rake (Ruby)**:

   - Ruby ベースのビルドプログラムで、`Rakefile`を使ってタスクを定義する。

2. **Ant (Java)**:

   - XML 形式の設定ファイルでタスクを定義するビルドツールです。Maven の前身的存在。

3. **Buildr (Ruby で書かれた Java ビルドツール)**:

   - 巻き返しの構文を使いながら、複数ファイルを管理できる。

4. **Ninja**:
   - 小規模で高効率なビルドシステムで、ビルド速度が速い。
   - CMake から生成されることが多い。