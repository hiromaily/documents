# 既存のtypeからschemaを作成する

## [Custom schemas](https://zod.dev/?id=custom-schemas)

```ts
z.custom<ExistingType>()
```

- stack overflowの[Zod: create a schema using an existing type](https://stackoverflow.com/questions/71782572/zod-create-a-schema-using-an-existing-type)にて、これが動くと言及されている。要検証

## [z.ZodSchema](https://github.com/colinhacks/zod/blob/1ecd6241ef97b33ce229b49f1346ffeee5d0ba74/src/types.ts#L4804)

```ts
export { ZodType as Schema, ZodType as ZodSchema };
```

[ZodType](https://zod.dev/?id=zodtype-with-zodeffects)

## schemeForType Utility functionを定義する

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

## 自動生成パターン

- [Generating Zod schema from TS type definitions](https://github.com/colinhacks/zod/issues/53)
- [Zod: create a schema using an existing type](https://stackoverflow.com/questions/71782572/zod-create-a-schema-using-an-existing-type)
- [Typecheck schemas against existing types](https://github.com/colinhacks/zod/issues/372)
- [Zodで真のTypeScript firstを手にする](https://zenn.dev/ynakamura/articles/65d58863563fbc)

### [ts-to-zod](https://github.com/fabien0102/ts-to-zod)を使う

tsの型情報からvalidatorを自動生成する

### [Online: Typescript to zod](https://transform.tools/typescript-to-zod)
