# 演算子

## 論理演算子

### `&&`

```ts
const x = a && b;
```

- a の真偽値が true であれば、a && b の真偽は b に託されるため、b を返す
- a の真偽値が false であれば、a && b の真偽は a に託されるため、a を返す

#### 真偽値が false となるもの

- false
- 0
- 空文字列
- null
- undefined

### `||`

```ts
const y = a || b;
```

- a の真偽値が true であれば、a || b の真偽は a に託されるため、a を返す
- a の真偽値が false であれば、a || b の真偽は b に託されるため、b を返す

#### `||`で、真偽値が false となるもの

- null
- undefined
- false
- 0
- 空文字列

### `??`

```ts
const z = a ?? b;
```

- a の真偽値が true であれば、a ?? b の真偽は a に託されるため、a を返す
- a の真偽値が false であれば、a ?? b の真偽は b に託されるため、b を返す

#### `??`で、真偽値が false となるもの

- null
- undefined

## `??`と`||`の使い分け

- `null`, `undefined`のみのチェックで十分の場合は、`??`
- false, 0, 空文字も含めてチェックしたい場合は、`||`

## Double Negation `!!` (二重否定)

- `!!` は、値をブール値（true または false）に変換することを確実にするために使用される

```ts
const enabled: boolean = !!amount?.quotient;
```

## Non-Null Assertion Operator `!`

- `!` は、オペランドが`non-null`かつ`non-undefined`` であることを assert するもの
- しかし、あまり使うことは推奨されていない

```ts
export class MySubClassedDexie extends Dexie {
  friends!: Table<Friend>; // こちら`friend`メンバの後ろに`!`をつけている

  constructor() {
    super(DB_NAME);
    this.version(1).stores({
      friends: "++id, name, age", // Primary key and indexed props
    });
  }
}
```

```ts
const txData: FooBar = {
  foo: input.foo,
  bar: bar.id!, //
};
```

## array object の存在確認

```ts
const data: string[] = ["one", "two", "three"];
// if (data && data.length !== 0) {...};
if (!data?.length) {...};
```
