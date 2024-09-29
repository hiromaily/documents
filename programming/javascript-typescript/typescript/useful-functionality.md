# Useful functionalities

2024/7 現在、version は`5.5.4`

## TypeScript v5.x

### Performance Improvements

- コンパイラのパフォーマンスが大幅に向上し、大規模なプロジェクトでもより高速にコンパイルできるようになった
- 生産性を向上させるために、開発者が待ち時間を減少させる

### Improved Type Inference for Generics

- ジェネリクスの型推論が強化され、より正確な推論を行う
- ジェネリクスを使ったコードが簡潔になり、型安全性が向上する

### Better Support for Inferred Type Aliases

- 型エイリアスの推論が改善された
- 型エイリアスを使用することで、コードの再利用性が向上し、保守性が向上する

## TypeScript v5.0

### Decorators (正式サポート)

- クラス、メソッド、プロパティ、アクセサ、パラメータにアノテーションを追加できる機能
- デコレーターを使って、コードのリーダビリティと再利用性を高めることが可能

### Enhanced Enums

- Enum 型の改善により、より柔軟な使い方ができるようになった
- Enum を使った型安全なコードが書きやすくなり、Enum の操作性が向上する

#### Pending: `これによりUnion型による代替え手段を使わなくてもよい？`

### Satisfies Operator

- `satisfies` 演算子を使用して、型が特定の構造を満たすことを保証する
- 型安全性を強化するために使われ、型チェックがより厳格になる

### Auto-Accessors in Classes

- クラスフィールドに自動的なアクセサ（getter/setter）を追加できる機能
- クラスの設計が簡略化され、煩雑なコードを減らすことができる

### Improved Intersection Types

- 交差型の扱いが向上し、より複雑な型に対しても正確な推論が可能になった
- 型安全性が向上し、柔軟な型システムを実現できる

### Efficient Tuple Intersection

- タプル型の交差を効率的に処理する機能
- パフォーマンスの改善と、より正確な型推論が可能になる

## TypeScript v4.5

### TypeScript Compiler API

- タイプ定義に関する新しい API が公開された
- より詳細なカスタマイズが可能になり、ツールの開発や型推論の強化に役立つ

### Awaited Type

- Awaited 型が導入され、Promise の結果型を簡単に取得できる
- 利点: 非同期コードの型推論が簡略化される

## TypeScript v4.4

### Control Flow Analysis for Destructured Discriminated Unions

- Union 型の要素をデストラクチャリングする際の型推論が強化された
- 型の安全性が強化され、デストラクチャリングがより直感的になる

### Exact Optional Property Types

- オプショナルプロパティの型推論がより厳密になった
- 型の正確性が向上し、意図しない型ミスを防ぎやすくなる

## TypeScript v4.3

### Override Keyword

- オーバーライドするメソッドに override キーワードを明示的に指定できるようになった
- オーバーライドミスを防ぎ、コードの安全性が向上する

### Template String Types as Discriminants

- テンプレートリテラル型を使って、型の絞り込みを行うことができる
- 型安全性の高い、より豊かな表現が可能

## TypeScript v4.2

### Smarter Type Alias Preservation

- 型エイリアスがより賢く扱われ、タイプチェッカーが型エイリアスをより正確に推論する
- リファクタリングや型の再利用がしやすくなる。

### Leading/Middle Rest Elements in Tuple Types

- タプル型内で先頭または中間に位置するリスト要素がサポートされる
- 型の精度が高まり、タプル操作がさらに柔軟に行える

## Typescript v4.1

### Template Literal Types

- テンプレート文字列リテラルの型推論をサポートする
- 型安全な動的プロパティ名や関数エンティティの生成が可能になる

### Key Remapping in Mapped Types

- マップド型内でキーのリマッピングが可能になった
- 型操作の柔軟性が向上し、複雑な型変換が容易になる

## Typescript v4.0

### Variadic Tuple Types

- タプルの長さや型を配列のように動的に操作できる機能
- より複雑な型操作が可能になり、高度な型安全性が実現できる

### Labeled Tuple Elements

- タプル型の各要素にラベル（名前）を付けることができる
- コードの可読性が向上し、タプルの意味が明確になる。

### Short-circuiting Assignment Operators

- `&&=`, `||=`, `??=` といったショートサーキット評価を利用した代入演算子が導入された
- より簡潔に条件付き代入が書けるようになる

## Typescript v3.7

### Optional Chaining

- `?.演算子`を使用して、対象が null または undefined の場合でもエラーを起こさずにプロパティを安全にアクセスする
- ネストされたオブジェクトのプロパティアクセ調整が簡単にできる

### Nullish Coalescing Operator

- `??演算子`を使って、null または undefined の場合にデフォルト値を提供する
- 意図したデフォルト値を簡単に設定できる

## Typescript v3.0

### Unknown Type

- any の代わりに使用することで、型安全な方法で任意の値を扱うことができる。
- 型チェックを強化することで、ランタイムエラーを防ぎます。

## Typescript v2.8

### Conditional Types

- 型に条件を付けて別の型を生成することができる
- 柔軟で再利用可能な型定義が可能になる

## Typescript v2.0

### Strict Null Checks

- null と undefined の扱いを厳格にし、これらが意図せず利用されるのを防ぐ
- バグの原因となる null 参照エラーを減少させる

### Non-null Assertion Operator

- `!演算子`を使用して、明示的に null や undefined ではないことをアサートする
- コードがよりクリーンになると共に、信頼できる型安全性を提供する

## Typescript v1.0

### Type Assertions (`as` and `<type>`)

- 任意の値を特定の型であると明示的に指定することができる。
- 型推論が正確でない場合に使用して、意図した型情報を提供できる。
