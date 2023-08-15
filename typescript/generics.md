# Generics / ジェネリクス
- `型も変数のように扱えるようにする` というもので、型の安全性を保ちながらコードの共通化が可能
- 型引数に使われる`T`は慣例的なもので、Type, Elementを表す `T`や`E`がよく使われる

## 型引数の慣例
- T：Type
- K：Key
- U：Unknown
- E：Element

## Sample Code
- Genericsがない場合
```ts
function identity(arg: number): number {
  return arg;
}
function identity(arg: string): string {
  return arg;
}
```

- Genericsを使う場合 (Generics function)
```ts
// 定義
function identity<T>(arg: T): T {
  return arg;
}

// Usage
let output1 = identity<string>("myString");
// 明示的な指定がなくても型推論が走る
let output2 = identity("myString");
```

## 配列を使う
```ts
function loggingIdentity<T>(arg: Array<T>): Array<T> {
  console.log(arg.length);
  return arg;
}
// Or
function loggingIdentity<T>(arg: T[]): T[] {
  console.log(arg.length);
  return arg;
}

// Usage
const vals = [1,2,3,4,5];
loggingIdentity<number>(vals);
```

## Generics 型
```ts
type Foo<T> = {
	value: T;
};

// Usage
const foo: Foo<number> = {
	value: 0,
};
```

## Generics クラス
```ts
class Queue<T> {
  private data: T[] = []; // Initialize data as an array of type T
  push(item: T) { this.data.push(item); }
  pop(): T | undefined { return this.data.shift(); }
}

// Usage
const queue = new Queue<number>();
queue.push(0);   // OK
queue.push(1);   // OK
queue.push("1"); // Error
```

## 型引数は複数与えることも可能
```ts
class MyGenerics<T,R> {}

let mg = new MyClass<string, number>();
```

## 型引数に規定値を与える
```ts
class MyGenerics<T=string> {}

let mg = new MyClass();
g.value = 'String';
```

## 型引数に制約をつける
以下の意味は、型`T`は必ず`HTMLElement`またはそのサブタイプ(派生クラスのようなもの)の`HTMLButtonElement`や`HTMLDivElement`でなくてはならない

```ts
function changeBackgroundColor<T extends HTMLElement>(element: T) {
  element.style.backgroundColor = "red";
  return element;
}
```

### Typescriptsの`extends`について
- [Typescriptsの`extends`について](https://zenn.dev/nbr41to/articles/7d2e7c4e31c54c)

#### interfaceを用いた型の継承（拡張）
```ts
interface User {
  name: string;
}

interface Admin extends User {
  isMaster: boolean;
}
// interface Admin {
// 	name: string;
//  isMaster: boolean;
// }
```

#### Genericsの型を限定する
```ts
type User = {
  name: string;
  age: number;
};

const f = <T extends User>(arg: T): string => arg.name;
```

#### Conditional Typeとしてのextends
Conditional Typeは `T extends U ? A : B` と書くことで型の条件分岐をすることができる

```ts
type A<T> = T extends string ? string : number;

type B = A<string>;  // string
type C = A<boolean>; // number
type D = A<'hello'>; // string
type E = A<123>;     // number
```

#### Conditional Typeとしてのextendsの中でinferを使う
inferを使うことで型を取り出すことができる

```ts
type UserA = {
  name: string;
  role: 'admin' | 'user'; // ここの型を抽出する
};
type UserB = {
  name: string;
  age:number
};

type A<T> = T extends { role: infer U } ? U : null;

type B = A<UserA>; // "admin" | "user" 抽出された
type C = A<UserB>; // null
```

## References
- [Typescript Generics](https://www.typescriptlang.org/docs/handbook/2/generics.html)
- [Typescript Deep Dive 日本語版 ジェネリック型](https://typescript-jp.gitbook.io/deep-dive/type-system/generics)
- [サバイバルTypescript ジェネリクス](https://typescriptbook.jp/reference/generics)