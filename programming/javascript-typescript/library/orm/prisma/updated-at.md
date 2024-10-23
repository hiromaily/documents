# prismaの`updated_at` 自動更新について

[Reference:updatedat](https://www.prisma.io/docs/orm/reference/prisma-schema-reference#updatedat)にある通り、prismaのschemaに`@updatedAt`をつけることで可能となる。
しかし、これにより生成されるDDLに`ON UPDATE CURRENT_TIMESTAMP`が追加されるわけではない。
これは、[Prisma @updatedAt doesn't change on update](https://stackoverflow.com/questions/77015486/prisma-updatedat-doesnt-change-on-update)によると、prismaのclientがその責務を持つことで対応するためらしい

```ts
model Post {
  id        String   @id
  updatedAt DateTime @updatedAt
}
```
