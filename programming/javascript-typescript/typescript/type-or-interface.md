# `Type`と`Interface`の使い分けについて

TypeScript において、`type`と`interface`はどちらもオブジェクトの形状（構造）を定義するために使用されるが、それぞれには得意なユースケースや特定の制限がある。
どちらを選んでも、実際のプロジェクト内での整合性を重視することが重要であり、チームのコーディング規約や実務の流れに従って適切に使い分けること。

## `interface`の特長

1. **宣言的マージ**:

   - 同名のインターフェイスを複数回宣言すると、それらが自動的にマージされる。

   ```typescript
   interface Person {
     name: string;
   }

   interface Person {
     age: number;
   }

   const person: Person = {
     name: "John",
     age: 30,
   };
   ```

2. **クラスとの互換性**:

   - クラスの実装時に使用することが一般的で、クラスのシグネチャを定義するのに便利。

3. **拡張可能**:

   - `extends`キーワードを使用して、他のインターフェイスを拡張できる。

   ```typescript
   interface Animal {
     name: string;
   }

   interface Dog extends Animal {
     bark(): void;
   }
   ```

## `interface`の典型的なユースケース

- 初期設計段階で、オブジェクトの形状が安定し、その後に多くの拡張や変更が加えられる可能性がある時。
- クラスのシグネチャを定義する場合。

## `type`の特長

1. **ユニオン型や交差型のサポート**:

   - ユニオン型 (Union types) や交差型 (Intersection types) を定義できるため、複雑な型定義が可能。

   ```typescript
   type StringOrNumber = string | number;
   type DogOrCat = Dog & Cat;
   ```

2. **プリミティブ型、配列型のラベル付け**:

   - プリミティブな型や配列にも名前をつけることができる。

   ```typescript
   type Name = string;
   type NameArray = string[];
   ```

3. **インライン演算**:
   - インターフェイスよりも柔軟な型定義が可能。

   ```typescript
   type Point = { x: number; y: number };
   type ExtendedPoint = Point & { z: number };
   ```

## `type`の典型的なユースケース

- 複合型（ユニオン型や交差型）が必要な場合。
- 単一リテラル型、ユニオン型、タプル型、またはマップ型などの複雑な型を定義したい場合。
- 柔軟かつ迅速に開発する場合。

## どちらを使うべきか？

- **再利用性と拡張性が必要な場合**:

  - インターフェイス (`interface`) を選ぶと良い。特に、多くの部分で再利用されたり、後に拡張されたりする可能性が高い型定義にはインターフェイスが向いている。

- **複雑な型システムやユニオン型、交差型が必要な場合**:
  - 型エイリアス (`type`) を選ぶのが適切。プリミティブな型やユニオン型、インライン演算が必要な場合には型エイリアスが便利。
