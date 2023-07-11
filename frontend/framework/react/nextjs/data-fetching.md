# Data Fetching

[Data Fetching](https://nextjs.org/docs/app/building-your-application/data-fetching)

## [SWR Docs: Usage with Next.js](https://swr.vercel.app/docs/with-nextjs)

### App Router

#### Server Components

- React Server Components(RSC)がデフォルトとなっているが、RSC では SWR の`key serialization APIs`しか import できない

```tsx
// ✅ サーバーコンポーネントで利用可能
import { unstable_serialize } from 'swr';
import { unstable_serialize as infinite_unstable_serialize } from 'swr/infinite';

// ❌ これはサーバー・コンポーネントでは利用できない。
import useSWR from 'swr';
```

#### Client Components

- `use client`ディレクティブが宣言された Client Components 内であれば、SWR を import することで、SWR クライアントのデータ取得フックを使うことができる
- Server Components の layout や page で `SWRConfig`を使用してグローバルな設定を行う必要がある場合は、Provider と設定を行う provider client component を別途作成し、Server Component のページで使用する

```tsx
// app/swr-provider.tsx
'use client';
import { SWRConfig } from 'swr'
export const SWRProvider = ({ children }) => {
  return <SWRConfig>{children}</SWRConfig>
};

// app/page.tsx
// This is still a server component
import { SWRProvider } from './swr-provider'
export default Page() {
  return (
    <SWRProvider>
      <h1>hello SWR</h1>
    </SWRProvider>
  )
}
```

### Client Side Data Fetching

- そのデータの pre-rendering の必要性がない場合、特別な設定は不要
- 挙動は
  - まず、データのないページをすぐに表示する。データがない場合は、ローディング状態を表示することができる。
  - その後、クライアント側でデータを取得し、準備ができたら表示する。

### Pre-rendering with Default Data

- Next.js は SSG と SSR の[2 種類の Pre-rendering](https://nextjs.org/docs/pages/building-your-application/data-fetching)をサポートする
- `SWRConfig`の `fallback` option を使えば、すべての SWR フックの初期値として、あらかじめフェッチされたデータを渡すことができる

### Complex Keys

- useSWR は Array type や function type の key を使えるが、これらの key で pre-fetch されたデータを使用するには、fallback key を`unstable_seriablize`でシリアライズする必要がある
