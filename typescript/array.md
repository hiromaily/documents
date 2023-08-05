# Array
TypescriptではなくJavascriptに備わっている機能ではあるが、こちらに記述

## map
### 基本
```ts
const numbers: number[] = [1, 2, 3, 4, 5];

// value
const doubled: number[] = numbers.map((value: number) => {
  return value * 2;
});
console.log(doubled); // [ 2, 4, 6, 8, 10 ]

// value, index
const multiplied: number[] = numbers.map((value: number, index: number) => {
  return value * index;
});
console.log(multiplied); // [ 0, 2, 6, 12, 20 ]
```

### objectを拡張する
```ts
interface Month {
  month: string;
  days: number;
}

const months: Month[] = [
  { month: 'Jan', days: 31 },
  { month: 'Feb', days: 28 },
  { month: 'Mar', days: 31 },
  { month: 'Apr', days: 30 },
  { month: 'May', days: 31 },
  { month: 'Jun', days: 30 },
  { month: 'Jul', days: 31 },
];

const customMonth = months.map((value: Month) => {
  return {
    ...value,
    isBirthday: value.month == 'Jun' ? true : false,
  };
});
console.log(customMonth);
// [
//   { month: 'Jan', days: 31, isBirthday: false },
//   { month: 'Feb', days: 28, isBirthday: false },
//   { month: 'Mar', days: 31, isBirthday: false },
//   { month: 'Apr', days: 30, isBirthday: false },
//   { month: 'May', days: 31, isBirthday: false },
//   { month: 'Jun', days: 30, isBirthday: true },
//   { month: 'Jul', days: 31, isBirthday: false }
// ]
```

## filter
### 基本
```ts
const files = ['foobar.gif', 'bob.html', 'mike.mp3'];

const mp3Files = files.filter((file) => {
  return file.includes('.mp3');
});
console.log(mp3Files);
// [ 'mike.mp3' ]
```

### Array.filter(Boolean)
```ts
interface Month {
  month: string;
  days: number;
}
interface ExtMonth {
  month: string;
  days: number;
  isBirthday: boolean;
}

const months: Month[] = [
  { month: 'Jan', days: 31 },
  { month: 'Feb', days: 28 },
  { month: 'Mar', days: 31 },
  { month: 'Apr', days: 30 },
  { month: 'May', days: 31 },
  { month: 'Jun', days: 30 },
  { month: 'Jul', days: 31 },
];

const customMonth = months
  .map((value: Month) => {
    if (value.month == 'Jun') {
      return {
        ...value,
        isBirthday: value.month == 'Jun' ? true : false,
      };
    }
    return undefined;
  })
  .filter(Boolean);
console.log(customMonth);
// [ { month: 'Jun', days: 30, isBirthday: true } ]

// 問題点
// 戻り値の型に、`undefined` が含まれてしまう
// (ExtMonth | undefined)[]

// 修正後
const customMonth2 = months
  .map((value: Month) => {
    if (value.month == 'Jun') {
      return {
        ...value,
        isBirthday: value.month == 'Jun' ? true : false,
      };
    }
    return undefined;
  })
  .filter((month): month is ExtMonth => month !== undefined);
```
- Falsy な値は Boolean() で false になるので、.filter(Boolean) で除外できる
- 問題点として、型推論がうまく行かないケースがある

## every
- everyは配列が条件をすべて満たす場合にtrueを返す
```ts
const arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.every(value => value > 0)
// return true
arr.every(value => value < 5)
```

## some
- someは配列が条件を一つでも満たしていればtrueを返す
```ts
const arr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.some(value => value < 10)
// return true
arr.every(value => value > 11)
// return false
```