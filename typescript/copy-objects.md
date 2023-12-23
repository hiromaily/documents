# Copy Objects

まず、Typescript で Object を普通にコピーすると参照渡しとなる

```ts
let obj1 = { name: "Foo", age: 20 };
let obj2 = obj1;
obj2.name = "Bar";

console.log(obj1.name);
// Bar
```

## Shallow Copy

```ts
let obj1 = { name: "Foo", age: 20 };
let obj2 = { ...obj1 };
obj2.name = "Bar";

console.log(obj1.name);
// Foo
```

### Shallow Copy の問題点

オブジェクトがネストされている場合（オブジェクトの中にオブジェクトがある場合）には、この方法だけでは完全なコピーを作成することができない

## Deep Copy

ネストされたオブジェクトもコピーする

```ts
let obj1 = {
  name: "Foo",
  age: 20,
  address: { country: "Japan", city: "Tokyo" },
};
let obj2 = JSON.parse(JSON.stringify(obj1));
obj2.address.city = "Osaka";

console.log(obj1.address.city);
// Tokyo
```

### HTML DOM API: [structuredClone()](https://developer.mozilla.org/ja/docs/Web/API/structuredClone)

### Deep Copy が可能なライブラリ

#### [lodash.clonedeep](https://www.npmjs.com/package/lodash.clonedeep)

- Weekly Downloads: 9,876,451

```ts
import * as _ from "lodash";

let obj1 = {
  name: "Foo",
  age: 20,
  address: { country: "Japan", city: "Tokyo" },
};
let obj2 = _.cloneDeep(obj1); // lodash.clonedeep
obj2.address.city = "Osaka";

console.log(obj1.address.city);
// Tokyo
```

#### [clone-deep](https://www.npmjs.com/package/clone-deep)

- Weekly Downloads: 14,506,938

```ts
import * as _ from "clone-deep";

let obj1 = {
  name: "Foo",
  age: 20,
  address: { country: "Japan", city: "Tokyo" },
};
let obj2 = _.cloneDeep(obj1); // clone-deep
obj2.address.city = "Osaka";

console.log(obj1.address.city);
// Tokyo
```

#### [rfdc](https://www.npmjs.com/package/rfdc)

- Weekly Downloads: 12,516,027

```ts
const clone = require("rfdc")();
clone({ a: 1, b: { c: 2 } }); // => {a: 1, b: {c: 2}}
```
