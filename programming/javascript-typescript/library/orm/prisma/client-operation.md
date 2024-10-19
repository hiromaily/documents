# Client による操作方法

## レコード作成

```ts
await prisma.users.create({
  data: {
    name: name,
    email: email,
  },
});
```

## レコード全件取得

```ts
// テーブルのレコードを全件取得
await prisma.users.findMany();

// 特定の条件に該当するレコードを全件取得
await prisma.user.findMany({
  where: {
    email: email,
  },
});
```

## レコード 1 件取得

```ts
// ユニークなレコードを取得
await prisma.users.findUnique({
  where: {
    id: Number(req.params.id),
  },
});

// 最初に一致したレコードを取得
await prisma.users.findFirst({
  where: {
    name: name,
  },
});
```

## レコード更新

```ts
await prisma.users.update({
  where: {
    id: Number(req.params.id),
  },
  data: {
    name: updatedName,
    email: updatedEmail,
  },
});
```

## レコード削除

```ts
await prisma.users.delete({
  where: {
    id: Number(req.params.id),
  },
});
```
