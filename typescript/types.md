# Types

## unknown

- any, unknown 型はどのような値も代入できる
- ちなみに、どの値も代入できない`never`という型も存在する
- `any`型に代入したオブジェクトのプロパティ、メソッドは使用することができる
- 一方、`unknown`型に代入したオブジェクトのプロパティ、メソッドは使用することができない
- `tsconfig`にはこの any 型の使用を防ぐためのオプションとして`noImplicitAny`がある
- `unknown`型の場合、型を特定する必要がある。(type-guard など)

### References

- [any と unknown の違い](https://typescriptbook.jp/reference/statements/any-vs-unknown)

## 型アサーション / Type Assertion

- 型アサーション（Type Assertion）は TypeScript によって推論された型を上書きする機能
- 型アサーションの定義: `as 指定したい型`
- 問題点として、型変換に問題があってもコンパイルエラーとして検知されず、実行時にエラーが発生する可能性がある

### 型ガード Type Guard

- プリミティブ型の場合、`typeof`による Type Guard で型を推定する

```ts
if (typeof unknownValue === 'string') {
```

- オブジェクト型の場合、`in`を利用したプロパティの有無で判定が可能だが、プロパティの存在のみでその型まではわからない

```ts
const isHumanType = (target: unknown): animal is CatType => {
  const human = target as HumanType;

  // trueならHumanType型と推定される
  return (
    "name" in human &&
    "age" in human &&
    typeof human.name === "string" &&
    typeof human.age === "number"
  );
};
```

## const アサーション

- オブジェクトリテラルの末尾に`as const`を記述すればプロパティが `readonly`` でリテラルタイプで指定した物と同等の扱いになる
- `readonly`と宣言されているプロパティを書き換えようとするとコンパイルエラーになる

```ts
const movie = {
  name: "good one",
  no: 25,
  genre: "action",
  height: 0.4,
  weight: 6.0,
} as const;
```

## indexed access operator `[]`

以下の`requestConfigMap`を`requestConfigMap[key]`のようにアクセスしたい場合、`requestConfigMap`内の key を`[]`で囲む必要がある

```ts
export const KEY_CONFIG: string = "api_config";
export const KEY_CONTRACTS: string = "api_contracts";

export interface APIConfig {
  method: string;
  options: any;
}

export interface APIConfigMap {
  [name: string]: APIConfig;
}

// WIP: add or modify as needed
// For now, only backendAPI is expected
export const requestConfigMap: RequestConfigMap = {
  [KEY_CONFIG]: {
    method: "config",
    options: [],
  },
  [KEY_CONTRACTS]: {
    method: "contract",
    options: [],
  },
};

function callSomething(key: string) {
  requestConfigMap[key];
}
```

## undefined の扱い

- [How to solve TypeScript possibly undefined value](https://linguinecode.com/post/how-to-solve-typescript-possibly-undefined-value)
