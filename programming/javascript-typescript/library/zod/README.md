# zod

静的型推論による TypeScript ファーストのスキーマValidation。
スキーマを宣言し、スキーマに沿っているか値を検証する。

## zod References

- [Docs](https://zod.dev/)
- [github](https://github.com/colinhacks/zod)

## 使い方

```ts
import { z } from 'zod';

// string 型のスキーマを宣言
const schemeName = z.string();
// スキーマから型定義する
type Name = z.infer<typeof name>

// 条件を持つ型: 5桁以上11桁未満の string 型
const schemePassWord = z.string().min(5).max(10);

// 条件を持つ型: 5桁
const schema5length = z.string().length(5);

// emailアドレス
const email = z.string().email();

// オブジェクト型
const schemeUser = z.object({
 name: z.string(),
 age: z.number(),
})

// オブジェクト型のネストも可能
const schemaNestedObject = z.object({
  key1: z.string(),
  key2: z.number().optional(),
  key3: z.object({ nestKey: z.boolean() })
);

// 関数型
const schemeFunc = z.function().args(z.number(), z.string()).returns(z.boolean());

// validation by parsing
name.parse('Foo'); // return "Foo"
name.parse(10); // throw Error

// つまり、parseする場合はtry-catch構文を使う
try {
  person.parse({
    name: 1234,
    age: "31"
  });
} catch (err) {
  if (err instanceof z.ZodError) {
    // エラーは配列のobject
    console.log(err.issues);
    // [
    //    {
    //      "code": "invalid_type", // エラータイプ
    //      "expected": "string",   // 期待した型
    //      "received": "number",   // 受け取った値の型
    //      "path": [],      // エラーが発生したプロパティへのパス
    //      "message": "Expected string, received number" // エラー内容（schema定義の段階でカスタマイズ可能）
    //    }
    //  ]

  }
}

// safeParse
// バリデーション結果には成功、失敗を問わずオブジェクトが入る
const validateValue = (value: string) => {
  const result = schema.safeParse(value);
  // 成功時{ success: true, data: "foo-bar" }
  // 失敗時{ success: false, data: ZodError }
  return result;
}

```
