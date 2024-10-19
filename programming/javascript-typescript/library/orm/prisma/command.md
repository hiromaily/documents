# Prisma コマンド

- ローカルで schema を DB へ反映させる (prisma schema first)

```sh
npx prisma migrate dev
```

- 本番/Staging で schema を DB へ反映させる

```sh
npx prisma migrate deploy
```

- schema を format する

```sh
npx prisma format
```

- マスタデータの流し込み

```sh
npx prisma db seed
```

- 既存 DB から schema を生成 (おそらく最初のみ)

```sh
#npx prisma introspect # outdated
npx prisma db pull
```

- DB の変更を schema へ反映

```sh
npx prisma db pull
```

- GUI 上でデータを確認

```sh
npx prisma studio
```

- schema での error を確認

```sh
npx prisma validate
```
