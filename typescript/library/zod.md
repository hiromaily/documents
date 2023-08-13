# zod
静的型推論による TypeScript ファーストのスキーマValidation。
スキーマを宣言し、スキーマに沿っているか値を検証する。

## References
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

## zodを使ってtype guard functionsを作成する

- [Typescript: Type guards with zod](https://dev.to/sachitsac/typescript-type-guards-with-zod-1m12)

```ts
import z from "zod";
import { invalidUser, invalidUserUuid, logisUesr, mockedCorrectUser } from "./test_data"

const userSchema = z.object({
  uuid: z.string().uuid(),
  name: z.string().optional(),
  email: z.string().email(),
  verified: z.boolean().default(false),
})

type User = z.infer<typeof userSchema>;
// interface User {
//   name: string;
//   email: string;
//   uuid: string;
//   verified: boolean;
// }

const isUser = (obj: any): obj is User => {
  if (!userSchema.safeParse(obj).success) return false;
  return true;
}

logIsUser(mockedCorrectUser, isUser);
logIsUser(invalidUser, isUser);
logIsUser(invalidUserUuid, isUser);
```

## 既存のtypeからschemaを作成する

### [Custom schemas](https://zod.dev/?id=custom-schemas)
```ts
z.custom<ExistingType>()
```
- stack overflowの[Zod: create a schema using an existing type](https://stackoverflow.com/questions/71782572/zod-create-a-schema-using-an-existing-type)にて、これが動くと言及されている。要検証

### schemeForType Utility functionを定義する
[Typecheck schemas against existing types](https://github.com/colinhacks/zod/issues/372)のissueで議論されているが、既存の型とZodSchemaの型の整合性をチェックする関数を定義する。

```ts
const schemaForType = <T>() => <S extends z.ZodType<T, any, any>>(arg: S) => {
  return arg;
};

type User {
  name: string
  zipCode: string // <- new
}

// zipCodeがなのでTSエラー
const UserZodSchema = schemaForType<User>()(
  z.objecct({
    name: z.string()
  })
)
```

### 自動生成パターン
[Generating Zod schema from TS type definitions](https://github.com/colinhacks/zod/issues/53)

#### [ts-to-zod](https://github.com/fabien0102/ts-to-zod)を使う
tsの型情報からvalidatorを自動生成する

#### [Online: Typescript to zod](https://transform.tools/typescript-to-zod)


### References
- [Zod: create a schema using an existing type](https://stackoverflow.com/questions/71782572/zod-create-a-schema-using-an-existing-type)
- [Typecheck schemas against existing types](https://github.com/colinhacks/zod/issues/372)
- [Zodで真のTypeScript firstを手にする](https://zenn.dev/ynakamura/articles/65d58863563fbc)
