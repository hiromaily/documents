# Generics / ジェネリクス
- `型も変数のように扱えるようにする` というもので、型の安全性を保ちながらコードの共通化が可能
- 型引数に使われる`T`は慣例的なもので、Type, Elementを表す `T`や`E`がよく使われる

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

- Genericsを使う場合
```ts
// 定義
function identity<T>(arg: T): T {
  return arg;
}

// 呼び出し側
let output = identity<string>("myString");
// 明示的な指定がなくても型推論が走る
let output = identity("myString");
```

## 配列を使う
```ts
function loggingIdentity<T>(arg: Array<T>): Array<T> {
  console.log(arg.length);
  return arg;
}
//もしくは
function loggingIdentity<T>(arg: T[]): T[] {
  console.log(arg.length);
  return arg;
}
```

## Generics クラス
```ts
class Queue<T> {
  private data = [];
  push(item: T) { this.data.push(item); }
  pop(): T | undefined { return this.data.shift(); }
}

// 呼び出し
const queue = new Queue<number>();
queue.push(0);   // OK
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

## References
- [Typescript Generics](https://www.typescriptlang.org/docs/handbook/2/generics.html)
- [Typescript Deep Dive 日本語版 ジェネリック型](https://typescript-jp.gitbook.io/deep-dive/type-system/generics)
- [サバイバルTypescript ジェネリクス](https://typescriptbook.jp/reference/generics)