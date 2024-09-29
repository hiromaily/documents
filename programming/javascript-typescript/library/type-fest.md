# Type-fest

重要な TypeScript 型のコレクション。
Type 定義を強化し、TypeScript の型推論能力を向上させ、コードをより表現豊かで簡潔にする。

Type-fest は、TypeScript を使用する開発者にとって非常に便利なツールキットで、TypeScript の型を強化し、より複雑な型操作を簡単にするためのユーティリティ型を提供する。Type-fest は特に、TypeScript の学習曲線を緩和し、より強力でリーダブルな型定義を可能にする。

Type-fest は、TypeScript の型システムをさらに強化し、開発者がより柔軟で強力な型定義を作成する手助けをする。これにより、コードのリーダブルさと保守性が向上し、型安全なコードを書くことが容易になる。

## 主なユーティリティ型

Type-fest には多くの有用な型が含まれています。以下にいくつかの例を挙げる。

1. **`PartialDeep`**

   - オブジェクトツリーのすべてのプロパティを再帰的にオプショナルにする。

   ```ts
   import { PartialDeep } from "type-fest";

   interface User {
     id: number;
     name: string;
     address: {
       street: string;
       city: string;
     };
   }

   const user: PartialDeep<User> = {
     id: 1,
     address: {
       city: "New York",
     },
   };
   // オプショナルなプロパティのため、上記の定義でエラーは発生しない。
   ```

2. **`Except`**

   - 特定のプロパティを除外した型を作成する。

   ```ts
   import { Except } from "type-fest";

   interface User {
     id: string;
     name: string;
     age: number;
   }

   type UserWithoutAge = Except<User, "age">;

   const userWithoutAge: UserWithoutAge = {
     id: "123",
     name: "John Doe",
   };
   ```

3. **`RequiredKeysOf`**

   - オブジェクト型から必須プロパティのキーを取得する。

   ```ts
   import { RequiredKeysOf } from "type-fest";

   interface User {
     id: number;
     name?: string;
     age: number;
   }

   type RequiredKeys = RequiredKeysOf<User>; // 'id' | 'age'
   ```

4. **`Writable`**

   - プロパティを読み取り専用から書き込み可能に変換する。

   ```ts
   import { Writable } from "type-fest";

   interface ReadOnlyUser {
     readonly id: string;
     readonly name: string;
   }

   type WritableUser = Writable<ReadOnlyUser>;

   const user: WritableUser = {
     id: "123",
     name: "John Doe",
   };

   user.id = "456"; // エラーが発生しない。
   ```

## 機能

- `Except`, `Merge`:

  - `Except` ユーティリティは、指定されたプロパティを型から除外するためのもの
  - `Merge` は 2 つの型を結合するためのもの
  - TypeScript の組み込みユーティリティである `Partial` に似ている

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
  - このユーティリティは、オブジェクト型に指定したプロパティの少なくとも 1 つが存在することを確認する
- `AsyncReturnType`:
  - 非同期関数の戻り値の型を推論することができる
- `Tuple`:
  - 固定サイズのタプル型を作成するためのユーティリティ型を提供する

## References

- [github](https://github.com/sindresorhus/type-fest)
