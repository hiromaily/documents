# 列挙型 (enum)
[Enums](https://www.typescriptlang.org/docs/handbook/enums.html)

Typescriptではenum の利用は推奨されない。  
[挙型(enum)の問題点と代替手段 by サバイバルTypeScript](https://typescriptbook.jp/reference/values-types-variables/enum/enum-problems-and-alternatives-to-enums)  


2023年の時点でも使うべきではないという記事が多数Postされている
- [Nine terrible ways to use TypeScript enums, and one good way](https://bluepnume.medium.com/nine-terrible-ways-to-use-typescript-enums-and-one-good-way-f9c7ec68bf15)
- [Don't use Enums in Typescript, they are very dangerous](https://dev.to/ivanzm123/dont-use-enums-in-typescript-they-are-very-dangerous-57bh)
- [Are Typecript Enums Really Harmful?](https://blog.theodo.com/2023/03/are-typescript-enums-really-harmful/)

しかし、Typescript5.0によって改善されている様子
- [TypeScript enums in 5.0 (are they still bad?)](https://blog.graphqleditor.com/enums-are-still-bad)

## 問題点
### 数値列挙型には型安全上の問題があるため、不用意なアクセスを防ぐことができない
```ts
enum ZeroOrOne {
  Zero = 0,
  One = 1,
}
const zeroOrOne: ZeroOrOne = 9; // コンパイルエラーにならない

console.log(ZeroOrOne[0]); // OK
// >> "Zero"
console.log(ZeroOrOne[10]); // コンパイルエラーにならない
// >> undefined
```

### 文字列列挙型だけ公称型になる
`公称型`とは、型の互換性はオブジェクト同士の継承関係(is-a関係)に着目して判断するというもので、継承関係が求められる。  
TypeScriptの型システムは、`構造的部分型`を採用しているが、文字列列挙型は例外的に`公称型`になる。

```ts
enum StringEnum {
  Foo = "foo",
}
const foo1: StringEnum = StringEnum.Foo; // コンパイルOK
const foo2: StringEnum = "foo";          // コンパイルエラー
```

### `--isolatedModules`コンパイルオプションによるエラー
`--isolatedModules` コンパイルオプションは、ファイルごとに単一のモジュールとしてコンパイルを行えるようにするオプション
で、これを利用するとコンパイルエラーになる


## 代替え案
### ユニオン型を使う
```ts
type YesNo = "yes" | "no";
 
function toJapanese(yesno: YesNo) {
  switch (yesno) {
    case "yes":
      return "はい";
    case "no":
      return "いいえ";
  }
}
```

### オブジェクトリテラル
```ts
const Position = {
  Top: 0,
  Right: 1,
  Bottom: 2,
  Left: 3,
} as const;
 
type Position = typeof Position[keyof typeof Position];
// 上は type Position = 0 | 1 | 2 | 3 と同じ意味
 
function toJapanese(position: Position) {
  switch (position) {
    case Position.Top:
      return "上";
    case Position.Right:
      return "右";
    case Position.Bottom:
      return "下";
    case Position.Left:
      return "左";
  }
}
```