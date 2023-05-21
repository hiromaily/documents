# keyof型演算子
keyofはオブジェクト型からプロパティ名を型として返す型演算子

```ts
type Book = {
  title: string;
  price: number;
  rating: number;
};
type BookKey = keyof Book;
// 上は次と同じ意味になる
type BookKey = "title" | "price" | "rating";
```

## Mapped Types
`keyof`は単体で使うことより`Mapped Types`と組み合わせて使われることが多い。
そして`Mapped Types`は主に`ユニオン型`と組み合わせて使い。

```ts
type SystemSupportLanguage = "en" | "fr" | "it" | "es";
type Butterfly = {
  [key in SystemSupportLanguage]: string;
};
// SystemSupportLanguage型の値のみ、keyとして設定可能
const butterflies: Butterfly = {
  en: "Butterfly",
  fr: "Papillon",
  it: "Farfalla",
  es: "Mariposa",
};  
```

## References
- [サバイバルTypescript keyof型演算子](https://typescriptbook.jp/reference/type-reuse/keyof-type-operator)
- [サバイバルTypescript Mapped Types](https://typescriptbook.jp/reference/type-reuse/mapped-types)
