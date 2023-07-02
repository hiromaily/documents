# Array
TypescriptではなくJavascriptに備わっている機能ではあるが、こちらに記述

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