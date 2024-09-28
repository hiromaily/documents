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

## undefined と null の違い

### [undefined と null の違い](https://typescriptbook.jp/reference/values-types-variables/undefined-vs-null)

- 多くのプログラミング言語で「値がない」を表現する方法は、`null`など 1 通り
- しかし、JavaScript では「値がない」に相当する表現に`null`と`undefined`の 2 通り存在する
- `undefined`: 「値が代入されていないため、値がない」
- `null`: 「代入すべき値が存在しないため、値がない」
- もしどちらを使うべきか迷ったら `undefined` を使っておくほうが無難
- `undefined`と違って、`null`は自然発生しない
- 変数を宣言したときに初期値がなければ JavaScript はその変数に`undefined`を設定する
- オブジェクトに存在しないプロパティや配列にない要素にアクセスしたときも、自動的に`undefined`になる
- 一部の DOM 系の API は`null`を返すこともあるため、ライブラリによっては`null`が発生する
- `undefined`は typeof の結果がプリミティブ名を指す"undefined"になるのに対し、`null`は"null"ではなく"object"になる

```ts
typeof undefined;
//"undefined"

typeof null;
//"object"
```

- JSON オブジェクトにおいて
  - オブジェクトプロパティの値に`undefined`を用いたとき、そのオブジェクトを JSON.stringify で JSON 化したときに、オブジェクトプロパティは削除される
  - 一方、プロパティの値が`null`のときは、JSON 化したときに値が保持される

### 使い分け

- 特にこだわりがないのなら、TypeScript では`null`は使わずに`undefined`をもっぱら使うようにするのがお勧め
- 使い分け意識を育てる労力は、それに見合うメリットが少ない
- TypeScript 開発チームの[コーディングガイド](https://github.com/Microsoft/TypeScript/wiki/Coding-guidelines#null-and-undefined)では、`undefined`を使用するよう記載されている

### Reference

- [Typescript: Coding guidelines](https://github.com/Microsoft/TypeScript/wiki/Coding-guidelines#null-and-undefined)
- [TypeScript null と undefined どちらを使う？](https://zenn.dev/saki/articles/48425da2f1e8a0)
- [How to solve TypeScript possibly undefined value](https://linguinecode.com/post/how-to-solve-typescript-possibly-undefined-value)
