# JSON Library

## [JSON.stringify()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify)

object を string 文字列に変換する。この逆は JSON.parse()

```js
console.log(JSON.stringify({ x: 5, y: 6 }));
// Expected output: '{"x":5,"y":6}'

console.log(
  JSON.stringify([new Number(3), new String("false"), new Boolean(false)])
);
// Expected output: '[3,"false",false]'

console.log(JSON.stringify({ x: [10, undefined, function () {}, Symbol("")] }));
// Expected output: '{"x":[10,null,null,null]}'

console.log(JSON.stringify(new Date(2006, 0, 2, 15, 4, 5)));
// Expected output: '"2006-01-02T15:04:05.000Z"'
```

### Performance for JSON.stringify()

```js
function measureJSONStringifyPerformance() {
  const data = {
    // Your sample data
    name: "John Doe",
    age: 30,
    email: "johndoe@example.com",
    // ... add more sample data as needed
  };

  const iterations = 10000; // Adjust the number of iterations as needed

  let totalTime = 0;

  for (let i = 0; i < iterations; i++) {
    const startTime = performance.now();
    JSON.stringify(data);
    const endTime = performance.now();
    totalTime += endTime - startTime;
  }

  const averageTime = totalTime / iterations;
  console.log(
    `Average time for JSON.stringify(): ${averageTime.toFixed(4)} milliseconds`
  );
}

// Call the function to measure performance
measureJSONStringifyPerformance();
// => Average time for JSON.stringify(): 0.0009 milliseconds
```

### [Performance API](https://developer.mozilla.org/en-US/docs/Web/API/Performance_API)

## [fastify/fast-json-stringify](https://github.com/fastify/fast-json-stringify)

`fast-json-stringify is significantly faster than JSON.stringify() for small payloads` とあるので、大きな object では効果を発揮しない可能性がある。

```js
const fastJson = require("fast-json-stringify");
const stringify = fastJson({
  title: "Example Schema",
  type: "object",
  properties: {
    firstName: {
      type: "string",
    },
    lastName: {
      type: "string",
    },
    age: {
      description: "Age in years",
      type: "integer",
    },
    reg: {
      type: "string",
    },
  },
});

console.log(
  stringify({
    firstName: "Matteo",
    lastName: "Collina",
    age: 32,
    reg: /"([^"]|\\")*"/,
  })
);
```

## [typia aka typescript-json](https://github.com/samchon/typia)

- [I made 10x faster JSON.stringify() functions, even type safe](https://dev.to/samchon/i-made-10x-faster-jsonstringify-functions-even-type-safe-2eme)

```ts
import typia, { tags } from "typia";

interface IMember {
  id: string & tags.Format<"uuid">;
  email: string & tags.Format<"email">;
  age: number &
    tags.Type<"uint32"> &
    tags.Minimum<20> &
    tags.ExclusiveMaximum<100>;
  parent: IMember | null;
  children: IMember[];
}

//----
// VALIDATION
//----
typia.createIs<IMember>();

//----
// RANDOM
//----
typia.createRandom<IMember>();

//----
// JSON
//----
typia.json.createStringify<IMember>();

//----
// PROTOCOL BUFFER
//----
typia.protobuf.createEncode<IMember>();
```

## [Class の instance を文字列化する方法](https://adamcoster.com/blog/how-to-stringify-class-instances-in-javascript-and-express-js)

- `JSON.stringify()`は Class の instance には使えない
- JavaScript の組み込み関数である`JSON.stringify()`をオブジェクトに対して呼び出すと、そのオブジェクトの`toJSON()`関数を探し、もしそのような関数があれば、その関数の戻り値の結果を文字列化する
- そのため、クラスに`toJSON()`メソッドを追加して、文字列化用のプレーン・オブジェクトを出力することができる。
