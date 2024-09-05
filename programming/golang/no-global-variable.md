# GoでGlobal変数を使うべきではない理由

- `access controll`が効かないため、予期せぬ挙動につながる可能性が生まれる
  - scopeを絞る意味として、ユースケースありきでその`global object`が使われることになる
- `global object`の変更は、それに依存する全てのコードに影響を与える
- コードが大きくなればなるほど、`global object`の使われ方が理解しづらくなる
