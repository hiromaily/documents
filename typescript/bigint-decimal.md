# Bigint and Decimal

## BigInt

[mdn web docs: BigInt](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt)

```js
// いずれの書き方でもよい
const sampleBigIntOne = 234n;

const sampleBigIntTwo = BigInt(567);

const sampleBigIntThree = BigInt("123");

// 型の確認
typeof 1n === "bigint"; // true
typeof BigInt("1") === "bigint"; // true
```

## BigInt の注意点

- Javascript の JSON.stringify は BigInt をエンコードできない

## 様々なライブラリ

ES2020 では`Bigint`型が存在するが、ブラウザ間での挙動に差異が存在するため、Polyfill があったほうが安全かもしれない

### [jsbi](https://www.npmjs.com/package/jsbi)

- [github: jsbi](https://github.com/GoogleChromeLabs/jsbi)
- `JSBI`` は ECMAScript BigInt 提案の JavaScript 実装であり、ES2020 で正式に 取り込まれた

### [big.js](https://www.npmjs.com/package/big.js?activeTab=readme)

- [github: big.js](https://github.com/MikeMcl/big.js)
- 任意精度の 10 進数演算用のライブラリ
- 2022 年から更新されていない

### [decimal.js](https://www.npmjs.com/package/decimal.js?activeTab=readme)

- [github: decimal.js](https://github.com/MikeMcl/decimal.js)
- 任意精度の Decimal 型 ライブラリ

#### [toformat](https://www.npmjs.com/package/toformat)

- big.js や decimal.js のインスタンスに、`toFormat`を追加するライブラリ

```js
x = new Big(9876.54321);
x.toFormat(2); // '9,876.54'
```

- `toFormat`は実際不要で、decimal.js では以下のようなコードが書ける

```ts
const d = new Decimal("258.866710");
      .toDP(2, Decimal.ROUND_DOWN)
      .toString();
      // 258.86
```

- 他のメソッドの挙動については、
  - toFixed(2): // 258.87
  - toPrecision(): // 258

#### [What is the difference between big.js, bignumber.js and decimal.js?](https://github.com/MikeMcl/big.js/wiki)

- 3 つのライブラリはいずれも Number 型の`toExponential`、`toFixed`、`toPrecision`を含んでいる
- `big.js` はサイズが`bignumber.js`の半分以下であり、メソッドも半分しかない
- `bignumber.js`と `decimal.js`は、`big.js`よりも大きな底で値を格納するので、桁数の多い値に対して演算を行う場合、より高速になる可能性がある
- `bignumber.js`と `decimal.js`は、他の基数の値を扱うことができ、16 進数の'0x'のような接頭辞をサポートしている
- `bignumber.js`は、除算を含む演算を使わない限り、ユーザーが精度の低下を心配する必要がない
- `decimal.js`はまた、2 進数、8 進数、16 進数の値を、2 進数の指数表記で扱うことができる
- `decimal.js`では精度が小数点以下の桁数ではなく有効桁数で指定されることと、すべての計算が除算を含むものだけでなくその精度で丸められること
- `decimal.js`は、非常に小さい値や大きい値をより効率的に扱える。
  - `bignumber.js`では、指数が小さい値を指数が大きい値に加算する際に、完全な精度で演算を行おうとするため、演算にかかる時間が長くなってしまう可能性がある

### [millify](https://www.npmjs.com/package/millify)

長い long 値を読みやすい String に変換するフォーマットのためのライブラリ

- 2000 => '2K'
- 10000 => '10k'
- 42500 => '42.5 kg'
- 1250000 => '1.25 MB'
- 2700000000 => '2.7 bil'

### [numeral](https://www.npmjs.com/package/numeral)

- 数値データを加工するもので、3 桁のカンマ区切りを与えたり、小数点の桁調整などができる
- 2017 年から更新されていない
