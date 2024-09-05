# GoでGlobal変数を使うべきではない理由

- `access controll`が効かないため、予期せぬ挙動につながる可能性が生まれる
  - bugを引き起こしやすい
  - scopeを絞る意味として、ユースケースありきでその`global object`が使われることになる
- `global object`の変更は、それに依存する全てのコードに影響を与える
- コードが大きくなればなるほど、`global object`の使われ方が理解しづらくなる
  - どこで`write`され、どこで`read`されているのか理解しづらい
- 異なるコンテキストにおける再利用性が低くなる
- [Single-responsibility principle](https://en.wikipedia.org/wiki/Single-responsibility_principle)に反する
  - [Docs: Solid Principle](../../architecture/principle/solid-go-design.md)
- 並列処理における`Race Condition`が起きやすい

##　例外

- 変更を許さない値
  - 定数
  - Staticな構成情報

## Global変数の防ぎ方

### Complete-Function Approach

グローバル変数を使用して関数とその呼び出し元の間でデータを共有する代わりに、関数が入力時に必要なすべての情報を受け取り、すべての結果を呼び出し元に返すように関数を記述する

### Dependency Injection

### カプセル化

データはできる限りカプセル化する

### The Singleton Design Pattern

オブジェクトを一度だけ初期化し、コンテキスト内でのみ使用する。
