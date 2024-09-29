# Data Fetching

- [Data Fetching](https://nextjs.org/docs/app/building-your-application/data-fetching)
- [詳細](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching)

## 推奨される方法は

- Server Components を使用してサーバー上のデータを取得する
- ウォーターフォールを最小化し、読み込み時間を短縮するために、並列にデータを取得する
- Layouts と Pages では、 fetch()する場所でデータを使用する。Next.js は、ツリー内のリクエストを自動的に推定する。
- Loding UI、Streaming と Suspense を使用して、ページを徐々にレンダリングし、残りのコンテンツが読みこまれる間にユーザーに結果を表示する

## fetch() API

- ネイティブの`fetch()` Web API の上に構築され、Server Components の async と await を利用している
- Next.js は Fetch option オブジェクトを拡張し、各リクエストに独自の[Cache ルール](https://nextjs.org/docs/app/building-your-application/data-fetching/caching)と再検証ルールを設定できる

## Fetching Data on the Server

- 可能な限り、Server Components でデータを取得することが推奨されている
- Server Components は、常に Server 上のデータを取得する。これにより、以下のことが可能になる
  - Backend のデータリソース（データベースなど）に直接アクセスできる
  - アクセストークンや API キーなどの機密情報が Client に公開されないようにすることで、アプリケーションをより安全に保つことができる
  - データの取得とレンダリングを同じ環境で行うことによって、Client と Server 間の往復通信と、Client 上のメインスレッドでの作業の両方が削減される
  - Client への複数の個別リクエストの代わりに、1 回のラウンドトリップで複数のデータ取得を実行する
  - Client-Server モデルのウォーターフォールを減らす
  - Region によっては、Data fetching はデータ・ソースに近い場所で行われるため、レイテンシーが短縮され、パフォーマンスが向上する

## コンポーネントレベルでのデータ取得

- App Router では、`layouts`、`pages`、components 内部でデータをフェッチできる
- データ取得は[Streaming と Suspense](https://nextjs.org/docs/app/building-your-application/data-fetching#streaming-and-suspense)にも対応している

## Parallel and Sequential Data Fetching

[実装方法](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching#data-fetching-patterns)

### Parallel

Route 内のリクエスト同時にデータを読み込むことによって、Client と Server のウォーターフォールが減り、データのロードにかかる総時間が短縮される

### Sequential

- Route 内のリクエストは互いに依存し、ウォーターフォールが発生する。
- 1 つの fetch が他の fetch の結果に依存するため、あるいはリソースを節約するために次のフェッチの前に条件を満たす必要がある場合に利用する
- これは読み込み時間の延長につながる

## 自動 fetch()リクエストの推定

- ツリー内の複数のコンポーネントで同じデータを fetch する必要がある場合、Next.js は同じ入力を持つ fetch request（GET）を一時キャッシュに自動的に Cache する。この最適化により、レンダリングパス中に同じデータが複数回 fetch されることを防ぐ。
- [Pending] POST メソッドの場合の挙動は？？
- Server 上 では、レンダリング処理が完了するまで、Cache は Server リクエストの有効期間を持続する
  - この最適化は、`Layouts`、`Pages`、`Server Components`、`generateMetadata`、および `generateStaticParams` で行われた fetch 要求に適用される
  - この最適化は、[static generation](https://nextjs.org/docs/app/building-your-application/rendering#static-rendering)中にも適用される
- Client 上では、Cache は、ページが完全にリロードされる前のセッションの間（複数のクライアント側の再レンダリングを含む可能性がある）持続する
- fetch リクエストは自動的に推測されるが、その条件は[Caching のセクション](https://nextjs.org/docs/app/building-your-application/data-fetching/caching)にて

## Static and Dynamic Data Fetching

- Static Data: 頻繁に変化しないデータのこと。例えば、ブログ記事
- Dynamic Data: 頻繁に変更されるデータのこと。例えばユーザー固有のショッピングデータなど

![dynamic-and-static-data](https://github.com/hiromaily/documents/raw/main/images/nextjs-dynamic-and-static-data-fetching.png 'dynamic-and-static-data')

- Default では、Next.js は自動的に`Static Fetch`を行う。つまり、データはビルド時に fetch され、cache され、リクエストごとに再利用される。開発者であれば、Static データをどのように cache し、再検証するかをコントロールできる。
- [Static Data Fetching と Dynamic Data Fetching のデータ取得方法](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching#static-data-fetching)

### Static Data Fetching

```js
fetch('https://...'); // cache: 'force-cache' is the default

// cache期間は10秒
fetch('https://...', { next: { revalidate: 10 } });
```

### 並列で fetch することが推奨されている

```ts
import Albums from './albums';

async function getArtist(username: string) {
  const res = await fetch(`https://api.example.com/artist/${username}`);
  return res.json();
}

async function getArtistAlbums(username: string) {
  const res = await fetch(`https://api.example.com/artist/${username}/albums`);
  return res.json();
}

export default async function Page({
  params: { username },
}: {
  params: { username: string };
}) {
  // Initiate both requests in parallel
  const artistData = getArtist(username);
  const albumsData = getArtistAlbums(username);

  // Wait for the promises to resolve
  const [artist, albums] = await Promise.all([artistData, albumsData]);

  return (
    <>
      <h1>{artist.name}</h1>
      <Albums list={albums}></Albums>
    </>
  );
}
```

### Dynamic Data Fetching

```js
fetch('https://...', { cache: 'no-store' });
```

### fetch()を使わない場合の cache の制御

- セグメントのデフォルトのキャッシュ動作に依存する
- セグメントキャッシュ設定を使用する
- セグメントが動的な場合は、リクエストの出力はキャッシュされず、 セグメントがレンダリングされるたびに再 fetch される

### [Route Segment Config](https://nextjs.org/docs/app/api-reference/file-conventions/route-segment-config)

- Route Segment オプションを使用すると、以下の変数を直接 export して、Pages、Layouts、または Route Handler(API)の動作を設定できる

#### dynamic option

- `Layouts`や`Pages`の動的な動作を、完全に Static または完全に Dynamic に変更する。
  - App Router において、`getServerSideProps`や`getStaticProps`による制御に変わる方法となる
- type: 'auto' | 'force-dynamic' | 'error' | 'force-static'
  - `auto`: 可能な限り cache する
  - `force-dynamic`: fetch request の cache を全て無効にし、 dynamic rendering される
  - `error`: dynamic function や dynamic fetch を使用しているコンポーネントがある場合、エラーを発生させることで、Layouts や Pages の static rendring と static data fetch を強制する
  - `force-static`: `cookies()`、`headers()`、`useSearchParams()`が空の値を返すように強制することで、レイアウトやページの static レンダリングと dynamic データフェッチを強制する
- default: 'auto'

#### dynamicParams option

- [generateStaticParams](https://nextjs.org/docs/app/api-reference/functions/generate-static-params) で生成されなかったダイナミックセグメントにアクセスしたときの動作を制御する
  - generateStaticParams()を動的な Route セグメントと組み合わせて使うことで、リクエスト時にオンデマンドで Route を生成するのではなく、ビルド時に静的に Route を生成することができる
- type: boolean
  - true: generateStaticParams に含まれない動的セグメントは、オンデマンドで生成される
  - false: generateStaticParams に含まれていない動的セグメントは 404 を返す
- default: true

#### revalidate option

- Layouts または Pages のデフォルトの再検証時間を設定する。このオプションは、個々の fetch request によって設定された revalidate 値を上書きしない
- false | 'force-cache' | 0 | number
- default: false

`revalidate = 600`という書き方は OK だが、`revalidate = 60 * 10`という書き方は NG

#### fetchCache option

- Layouts または Pages 内のすべての fetch request の default の chache option を上書きする
- 'auto' | 'default-cache' | 'only-cache' | 'force-cache' | 'force-no-store' | 'default-no-store' | 'only-no-store'
  - auto: dynamic function の前に、その関数が提供する cache option で fetch request を cache し、dynamic function の後に fetch request を cache しない
- default: 'auto'

#### runtime option

- [Edge and Node.js Runtimes](https://nextjs.org/docs/app/building-your-application/rendering/edge-and-nodejs-runtimes)
  - nodejs: Node.js ランタイムを使用すると、すべての Node.js API と、それに依存するすべての npm パッケージにアクセスできる。ただし、Edge ランタイムを使用する Route ほど起動が速くない。
  - edge: Edge ランタイムは、ダイナミックでパーソナライズされたコンテンツを、小さくシンプルな機能で低遅延に配信する必要がある場合に最適。Edge ランタイムのスピードは、リソースの使用を最小限に抑えていることから生まれますが、多くのシナリオではそれが制限になる可能性がある。
- 'nodejs' | 'edge'
- default: 'nodejs'

#### preferredRegion option

- `preferredRegion`のサポートおよびサポートされる地域は、使用する deployment platform に依存する
- 'auto' | 'global' | 'home' | string | string[]
- default: 'auto'

### 設定方法 (e.g. page.tsx)

```tsx
export const dynamic = 'auto';
export const dynamicParams = true;
export const revalidate = false;
export const fetchCache = 'auto';
export const runtime = 'nodejs';
export const preferredRegion = 'auto';

export default function MyComponent() {}
```

## Caching Data

- [Caching Data 詳細](https://nextjs.org/docs/app/building-your-application/data-fetching/caching)

![cache](https://github.com/hiromaily/documents/raw/main/images/nextjs-caching.png 'cache')

- ここでいう Cache とは、データをある CDN に保存して、リクエストのたびに元のソースから再フェッチする必要がないようにするプロセスを指す
- Next.js Cache は、グローバルに分散可能な永続的[HTTP キャッシュ](https://developer.mozilla.org/ja/docs/Web/HTTP/Caching)
- これは、キャッシュが自動的にスケールし、プラットフォームに応じて複数の Region で共有できることを意味する
  - ただし、cache サーバーへのリクエストは発生する
- Next.js は、`fetch()`の[options オブジェクト](https://developer.mozilla.org/en-US/docs/Web/API/fetch)を拡張し、サーバー上の各リクエストに独自の永続キャッシュ動作を設定できるようにしている。コンポーネントレベルのデータ取得と合わせて、データが使用されるアプリケーションコード内で直接キャッシュを設定できる。
- Server のレンダリング中、Next.js が fetch に遭遇すると、cache をチェックしてデータがすでに利用可能かどうかを確認する。利用可能であれば、cache されたデータを返す。そうでない場合は、将来のリクエストのためにデータを fetch して保存する。

### [Cache 詳細](https://nextjs.org/docs/app/building-your-application/data-fetching/caching)

#### fetch()

- request は default で cache されるが、以下の条件では cache されない
  - dynamic function を使っている
  - POST request の fetch
  - fetchCache option で、cache を skip する場合
  - revalidate option で`0`を設定しているとき
  - fetch の cache option で、`no-store`をしているとき

#### React cache()

- React では cache()でラップされた関数呼び出しの結果をメモして、リクエストを cache し、重複排除することができる
- 同じ引数で呼び出された同じ関数は、関数を再実行する代わりに cache された値を再利用する
- fetch() はリクエストを自動的にキャッシュするので、fetch() を使う関数を cache() でラップする必要はない
- この新しいモデルでは、複数のコンポーネントで同じデータを要求する場合でも、props としてコンポーネント間でデータを渡すのではなく、データを必要とするコンポーネントで直接データを取得することが推奨されている

```ts
import { cache } from 'react';

export const getUser = cache(async (id: string) => {
  const user = await db.user.findUnique({ id });
  return user;
});
```

#### POST requests and cache()

- POST リクエストは、POST Route Handler 内にあるか、headers(),cookies() を読み込んだ後でない限り、fetch を使用すると自動的に重複排除される
- たとえば、上記のようなケースで GraphQL と POST リクエストを使用している場合、cache を使用してリクエストを重複排除することができる
- cache の引数はフラットで、プリミティブのみでなければならない
- Deep objects は重複排除にはマッチしない

```ts
import { cache } from 'react';

export const getUser = cache(async (id: string) => {
  const res = await fetch('...', { method: 'POST', body: '...' });
  // ...
});
```

#### Preload pattern with cache()

- 以下の方法で preload を実装できる

```tsx
// components/User.tsx
import { getUser } from '@utils/getUser';

export const preload = (id: string) => {
  // void evaluates the given expression and returns undefined
  // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/void
  void getUser(id);
};
export default async function User({ id }: { id: string }) {
  const result = await getUser(id);
  // ...
}

// app/user/{id}/page.tsx
import User, { preload } from '@components/User';

export default async function Page({
  params: { id },
}: {
  params: { id: string };
}) {
  preload(id); // starting loading the user data now
  const condition = await fetchCondition();
  return condition ? <User id={id} /> : null;
}
```

- preload()関数はどんな名前でもいい。これはパターンであって、API ではない

#### Combining cache, preload, and server-only

## データの再検証

- 再検証とは、キャッシュを削除して最新のデータを再取得するプロセス
- 2 種類のデータの再検証が存在する
  - Backgroujd: 特定の時間間隔でデータを再検証する
  - On-demand: 更新があるたびにデータを再検証する

### [Revalidating Data 詳細](https://nextjs.org/docs/app/building-your-application/data-fetching/revalidating)

#### Background Revalidation

- 特定の間隔で cache data を再検証するには、`fetch()`の`next.revalidate`オプションを使用して、リソースのキャッシュ有効期間 (秒単位) を設定する

```js
fetch('https://...', { next: { revalidate: 60 } });
```

- 他の package などを使い fetch()を使用しない場合にデータを再検証したい場合は、[Route セグメント設定](https://nextjs.org/docs/app/api-reference/file-conventions/route-segment-config#revalidate)を使用できる

```js
export const revalidate = 60; // revalidate this page every 60 seconds
```

- ただし、upstream data provider の設定に影響されるので注意が必要 (あくまで CDN 上に Cache される)

#### On-demand Revalidation

[revalidatePath](https://nextjs.org/docs/app/api-reference/functions/revalidatePath)や、[revalidateTag](https://nextjs.org/docs/app/api-reference/functions/revalidateTag)によって実現可能

```ts
// app/page.tsx
export default async function Page() {
  const res = await fetch('https://...', { next: { tags: ['collection'] } });
  const data = await res.json();
  // ...
}
```

```ts
// app/api/revalidate/route.ts
import { NextRequest, NextResponse } from 'next/server';
import { revalidateTag } from 'next/cache';

export async function GET(request: NextRequest) {
  const tag = request.nextUrl.searchParams.get('tag');
  revalidateTag(tag);
  return NextResponse.json({ revalidated: true, now: Date.now() });
}
```

## Streaming and Suspense

- これらは React の新機能で、UI のレンダリングを徐々にレンダリングして Client にストリームすることができる
- Server Components とネストされた Layouts を使用すると、特にデータを必要としないページの部分を即座にレンダリングし、データを fetch しているページの部分についてはロード状態を表示することができる
  これにより、ユーザーはページ全体の読み込みを待たずに、ページの操作を開始することができる

## Old Methods

- 以前の Next.js のデータ取得のための以下メソッドは App Router ではサポートされていないが、Pages Router でのみ利用可能
  - getServerSideProps、
  - getStaticProps、
  - getInitialProps

## Client Components 内での`use`の使用

- こちらではなく、SWR や React Query を使うことが推奨されている

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
