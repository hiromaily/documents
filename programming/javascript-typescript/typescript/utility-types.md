# Utility Types

## `Record<Keys, Type>`

Record<Keys, Type>はプロパティのキーがKeysであり、プロパティの値がTypeであるオブジェクト型を作るユーティリティ型

```ts
type StringNumber = Record<string, number>;
const value: StringNumber = { a: 1, b: 2, c: 3 };
```

### `Record<Keys, Type>` References

[サバイバルTypescript Record](https://typescriptbook.jp/reference/type-reuse/utility-types/record)

## `Partial<T>`

`Partial<T>`は、オブジェクト型Tのすべてのプロパティをオプションプロパティにするユーティリティ型

```ts
type Person = {
  surname: string;
  middleName?: string;
  givenName: string;
};
type PartialPerson = Partial<Person>;
       
// type PartialPerson = {
//     surname?: string | undefined;
//     middleName?: string | undefined;
//     givenName?: string | undefined;
// }
```

### `Partial<T>` References

[サバイバルTypescript Partial](https://typescriptbook.jp/reference/type-reuse/utility-types/partial)

## `Readonly<T>`

`Readonly<T>`は、オブジェクト型Tのプロパティをすべて読み取り専用にするユーティリティ型

```ts
type Person = {
  surname: string;
  middleName?: string;
  givenName: string;
};
type ReadonlyPerson = Readonly<Person>;
           
// type ReadonlyPerson = {
//     readonly surname: string;
//     readonly middleName?: string | undefined;
//     readonly givenName: string;
// }
```

## `Pick<T, Keys>`

`Pick<T, Keys>`は、型TからKeysに指定したキーだけを含むオブジェクト型を返すユーティリティ型

T: オブジェクト型
Keys: オブジェクト型Tのプロパティキーを指定

```ts
type User = {
  surname: string;
  middleName?: string;
  givenName: string;
  age: number;
  address?: string;
  nationality: string;
  createdAt: string;
  updatedAt: string;
};
type Person = Pick<User, "surname" | "middleName" | "givenName">;

// type Person = {
//   surname: string;
//   middleName?: string;
//   givenName: string;
// };
```

### `Pick<T, Keys>` References

[サバイバルTypescript Pick](https://typescriptbook.jp/reference/type-reuse/utility-types/pick)

## `Omit<T, Keys>`

`Omit<T, Keys>`は、オブジェクト型TからKeysで指定したプロパティを除いたオブジェクト型を返すユーティリティ型

T: オブジェクト型
Keys: 引数Tのプロパティキーを指定

```ts
type User = {
  surname: string;
  middleName?: string;
  givenName: string;
  age: number;
  address?: string;
  nationality: string;
  createdAt: string;
  updatedAt: string;
};
type Optional = "age" | "address" | "nationality" | "createdAt" | "updatedAt";
type Person = Omit<User, Optional>;

// type Person = {
//   surname: string;
//   middleName?: string;
//   givenName: string;
// };
```

### `Omit<T, Keys>` References

[サバイバルTypescript Omit](https://typescriptbook.jp/reference/type-reuse/utility-types/omit)

## `Exclude<T, U>`

`Exclude<T, U>`は、ユニオン型TからUで指定した型を取り除いたユニオン型を返すユーティリティ型

T: ユニオン型
U: Tから取り除きたい型

```ts
type Grade = "A" | "B" | "C" | "D" | "E";
type PassGrade = Exclude<Grade, "E">;
// type PassGrade = "A" | "B" | "C" | "D";

type PassGrade2 = Exclude<Grade, "D" | "E">;
// type PassGrade = "A" | "B" | "C"
```

## `Extract<T, U>`

`Extract<T, U>`は、ユニオン型TからUで指定した型だけを抽出した型を返すユーティリティ型

T: 抽出されるほうのユニオン型
U: 抽出したい型

```ts
type Grade = "A" | "B" | "C" | "D" | "E";
type FailGrade = Extract<Grade, "D" | "E">;
// type FailGrade = "D" | "E"
```

## 合併型(Union Types)と交差型(Intersection Types)

```ts
type Dog = {
  cute: boolean;
  bark: boolean;
};

type Cat = {
  cute: boolean;
  meow : boolean;
};

type DogOrCat = Dog | Cat;  // 型 Dog と Cat の合併型
type DogAndCat = Dog & Cat; // 型 Dog と Cat の交差型
```

### 合併型(Union Types)の特徴 `|`

```ts
// 合併型なので、Dog, Cat型両方のプロパティが使える
const SuperPet1: DogOrCat = {
  cute: true;
  bark: true;
  meow : true;
};

// 合併型なため、どちらかの型ということを表せれば良い
const SuperPet2: DogOrCat = {
  cute: true;
  bark: true;
};
```

### 交差型(Intersection Types)の特徴 `&`

```ts
// 交差型なので、合併型同様Dog, Cat型両方のプロパティが使える
const doubleAtack: KickAndPunch = {
  cute: true;
  bark: true;
  meow : true;
};

// 交差型は集合元の型全てのプロパティを使わなくてはならない
const errorNormalAtack: KickAndPunch = {
  cute: true;
  bark: true;
};
// Error: Cat型のmeowプロパティが必要
```
