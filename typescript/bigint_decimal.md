# Bigint and Decimal

## BigInt
[mdn web docs: BigInt](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt)

```js
// いずれの書き方でもよい
const sampleBigIntOne = 234n;

const sampleBigIntTwo = BigInt(567)

const sampleBigIntThree = BigInt("123")

// 型の確認
typeof 1n === "bigint"; // true
typeof BigInt("1") === "bigint"; // true
```

## 様々なライブラリ
ES2020では`Bigint`型が存在するが、ブラウザ間での挙動に差異が存在するため、Polyfillがあったほうが安全かもしれない

### [jsbi](https://www.npmjs.com/package/jsbi)
- [github: jsbi](https://github.com/GoogleChromeLabs/jsbi)
- `JSBI`` は ECMAScript BigInt 提案のJavaScript 実装であり、ES2020 で正式に 取り込まれた


### [big.js](https://www.npmjs.com/package/big.js?activeTab=readme)
- [github: big.js](https://github.com/MikeMcl/big.js)
- 任意精度の 10進数演算用のライブラリ
- 2022年から更新されていない

### [decimal.js](https://www.npmjs.com/package/decimal.js?activeTab=readme)
- [github: decimal.js](https://github.com/MikeMcl/decimal.js)
- 任意精度の Decimal型 ライブラリ

#### [toformat](https://www.npmjs.com/package/toformat)
- big.jsやdecimal.jsのインスタンスに、`toFormat`を追加するライブラリ
```js
x = new Big(9876.54321)
x.toFormat(2)  // '9,876.54'
```

#### [What is the difference between big.js, bignumber.js and decimal.js?](https://github.com/MikeMcl/big.js/wiki)
- 3つのライブラリはいずれもNumber型の`toExponential`、`toFixed`、`toPrecision`を含んでいる
- `big.js` はサイズが`bignumber.js`の半分以下であり、メソッドも半分しかない
- `bignumber.js`と `decimal.js`は、`big.js`よりも大きな底で値を格納するので、桁数の多い値に対して演算を行う場合、より高速になる可能性がある
- `bignumber.js`と `decimal.js`は、他の基数の値を扱うことができ、16進数の'0x'のような接頭辞をサポートしている
- `bignumber.js`は、除算を含む演算を使わない限り、ユーザーが精度の低下を心配する必要がない
- `decimal.js`はまた、2進数、8進数、16進数の値を、2進数の指数表記で扱うことができる
- `decimal.js`では精度が小数点以下の桁数ではなく有効桁数で指定されることと、すべての計算が除算を含むものだけでなくその精度で丸められること
- `decimal.js`は、非常に小さい値や大きい値をより効率的に扱える。
  - `bignumber.js`では、指数が小さい値を指数が大きい値に加算する際に、完全な精度で演算を行おうとするため、演算にかかる時間が長くなってしまう可能性がある


### [millify](https://www.npmjs.com/package/millify)
長いlong値を読みやすいStringに変換するフォーマットのためのライブラリ

- 2000 => '2K'
- 10000 => '10k'
- 42500 => '42.5 kg'
- 1250000 => '1.25 MB'
- 2700000000 => '2.7 bil'

### [numeral](https://www.npmjs.com/package/numeral)
- 数値データを加工するもので、3桁のカンマ区切りを与えたり、小数点の桁調整などができる
- 2017年から更新されていない