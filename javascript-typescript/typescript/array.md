# Array
TypescriptではなくJavascriptに備わっている機能ではあるが、こちらに記述

## map
新しい配列を作る
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
特定の要素のみ取得する
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

## find
特定の要素のみ取得する

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

const birthMonth = months.find((month: Month): boolean => {
  return month.month === 'Jun';
});
// { month: 'Jun', days: 30 }
```

## reduce
配列から新しい単一要素を返す

### 例: object配列から一部の要素を使ってKey Value型のオブジェクトを返す
```ts
interface genreInfo {
  id: number;
  name?: string;
  genreId?: number;
}

interface GenreIdNameMap {
  [key: number]: string;
}

const mapGenreIdName = (genreData: genreInfo[]): GenreIdNameMap => {
  return genreData.reduce((result, item) => {
    if (item.name !== undefined && item.genreId !== undefined && !result[item.genreId]) {
      result[item.genreId] = item.name;
    }
    return result;
  }, {} as GenreIdNameMap);
};

const genreData: genreInfo[] = [
  { id: 1, name: 'Rock', genreId: 101 },
  { id: 2, name: 'Classical music', genreId: 105 },
  { id: 3, name: 'Folk music', genreId: 204 },
  { id: 4, name: 'Jazz', genreId: 303 },
  { id: 5, name: 'Electronic music', genreId: 95 },
  { id: 6, genreId: 99 },
  { id: 7, name: 'Blues' },
];

const genreMap = mapGenreIdName(genreData);
console.log(genreMap);
// {
//   '95': 'Electronic music',
//   '101': 'Rock',
//   '105': 'Classical music',
//   '204': 'Folk music',
//   '303': 'Jazz'
// }
```

## concat
配列と配列を結合する

### 組み合わせ例
- 配列名.concat(配列)
- 配列名.concat(配列, 配列, ...)
- 配列名.concat(値, 値, ...)

```ts
let fruit = ['Apple', 'Melon', 'Orange'];
let fruitAll = fruit.concat('Peach', ['Grapes', 'Strawberry']);
```
### concatメソッドを使った配列のコピー
```ts
let fruit = ['Apple', 'Melon', 'Orange'];
let copyFruit = fruit.concat();
```

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