# Typescript Object

## [オブジェクトの分割代入 (destructuring assignment)](https://typescriptbook.jp/reference/values-types-variables/object/destructuring-assignment-from-objects)

これは、object からプロパティーを取り出す機能
英語では、`object destructuring and assign different variable` などと説明される

- 分割代入は、中カッコ{}に取り出したいプロパティを指定することで、プロパティ名と同じ名前の変数が作れる

```ts
const item = { price: 100 };
const { price } = item; // priceプロパティのみを変数としてセット
// 上は const price = item.price; と同等の処理
```

- もちろん複数のプロパティを取り出すこともできる

```ts
const obj = { a: 1, b: 2 };
const { a, b } = obj;

const color = { r: 0, g: 122, b: 204, a: 1 };
const { r, g, b, a } = color;
```

- 代入する変数名を指定する
  - これは、React Hook など、変数名が被るケースなどでよく使われる

```ts
const color = { r: 0, g: 122, b: 204, a: 1 };
const { r: red, g: green, b: blue, a: alpha } = color;
console.log(green);
// 変数 greenの値は 122
```

- 入れ子構造の分割代入も可能

```ts
const continent = {
  name: '北アメリカ',
  us: {
    name: 'アメリカ合衆国',
    capitalCity: 'ワシントンD.C.',
  },
};

const {
  us: { name, capitalCity },
} = continent;

console.log(name);
// name は "アメリカ合衆国"
console.log(capitalCity);
// capitalCity は "ワシントンD.C."
```

- 入れ子構造の分割代入と、変数名の指定

```ts
const continent = {
  name: '北アメリカ',
  us: {
    name: 'アメリカ合衆国',
    capitalCity: 'ワシントンD.C.',
  },
};

const {
  name: continentName,
  us: { name: countryName },
} = continent;

console.log(continentName);
('北アメリカ');
console.log(countryName);
('アメリカ合衆国');
```
