# Type-fest
重要な TypeScript 型のコレクション。
Type定義を強化し、TypeScriptの型推論能力を向上させ、コードをより表現豊かで簡潔にする。

## 機能

- `Except`, `Merge`: 
  - `Except` ユーティリティは、指定されたプロパティを型から除外するためのもの
  - `Merge` は2つの型を結合するためのもの
  - TypeScriptの組み込みユーティリティである `Partial` に似ている

- `UnwrapPromise`:
  - このユーティリティは、Promise をアンラップして解決された値を提供する
  - 非同期コードの処理や、Promise の型注釈を簡略化するのに役立つ
- `SetOptional`, `SetRequired`:
  - これらのユーティリティを使用すると、型の特定のプロパティを簡単にオプショナルまたは必須にできる
- `Promisable`:
  - `Promisable` 型は、Promise の解決値を手動でアンラップせずに解決値を推論するのに役立つ
- `Omit`:
  - TypeScript の組み込みの `Omit` と同様に、このユーティリティは他の型から特定のプロパティを省略して新しい型を作成する
- `Mutable`:
  - `Mutable` ユーティリティは、オブジェクト型のミュータブルなバージョンを作成するのに役立つ
  - これにより、型の制約を破ることなくプロパティを変更できる
- `DeepReadonly`:
  - このユーティリティは、オブジェクトのすべてのプロパティに `Readonly` を再帰的に適用し、型のディープなイミュータブルバージョンを作成する
- `RequireAtLeastOne`:
  - このユーティリティは、オブジェクト型に指定したプロパティの少なくとも1つが存在することを確認する
- `AsyncReturnType`:
  - 非同期関数の戻り値の型を推論することができる
- `Tuple`:
  - 固定サイズのタプル型を作成するためのユーティリティ型を提供する


## References
- [github](https://github.com/sindresorhus/type-fest)