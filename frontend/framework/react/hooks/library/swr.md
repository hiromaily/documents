# SWR

- データ取得のための React Hooks ライブラリ
- SWR は、まずキャッシュからデータを返し（stale）、次にフェッチリクエストを送り（revalidate）、最後に最新のデータを持ってくる
- `stale-while-revalidate`に基づいた処理と設計で、`キャッシュをなるべく最新に保つ機能`と解釈できる
  - つまり、SWR を使うメリットを享受できるかどうかは、この機能の恩恵がどれだけあるかとも言える
- Next.js と同様、Vercel によって開発されている

## Note

- hook は if 文による分岐ができないので、useSWR を複数組み合わせて何か算出するといったことには不向き
- reqeust は通常の function で実装し、Global State などで管理したほうがいいと思われる

## References

- [SWR](https://swr.vercel.app/)
- [SWR (ja)](https://swr.vercel.app/ja)
- [github](https://github.com/vercel/swr)
- [Comparison | React Query vs SWR vs Apollo vs RTK Query vs React Router](https://tanstack.com/query/latest/docs/react/comparison)
- [React をシンプルにする SWR](https://zenn.dev/uttk/articles/b3bcbedbc1fd00) (v1.0 の情報のため古い)

## [API](https://swr.vercel.app/docs/api)

### Options

- `fetcher(args)`: fetcher function
- `suspense = false`: [React Suspense](https://react.dev/reference/react/Suspense) mode。React は推奨していない。
-

## [Global Configuration](https://swr.vercel.app/docs/global-configuration)

- `SWRConfig`は全ての SWR hook のための global な configuration(option)となる

```ts
import useSWR, { SWRConfig } from "swr";

function Dashboard() {
  const { data: events } = useSWR("/api/events");
  const { data: projects } = useSWR("/api/projects");
  const { data: user } = useSWR("/api/user", { refreshInterval: 0 }); // override

  // ...
}

function App() {
  return (
    <SWRConfig
      value={{
        refreshInterval: 3000,
        fetcher: (resource, init) =>
          fetch(resource, init).then((res) => res.json()),
      }}
    >
      <Dashboard />
    </SWRConfig>
  );
}
```

## [Data Fetching](https://swr.vercel.app/docs/data-fetching)

- `fetcher`は SWR のキーを受け取り、データを返す非同期関数となる
- fetcher 内の戻り値はデータとして渡され、スローされた場合は`error`としてキャッチされる

```ts
const { data, error } = useSWR(key, fetcher);
```

## [Automatic Revalidation](https://swr.vercel.app/docs/revalidation)

SWR では、データを自動的に re-fetch する option がある

### ケース

- 例として、同じページを異なる tab で開き、一方で変更したデータをもう一方のページ側でも focus をトリガーとして反映させる。
- 複数のデバイス間によるデータ同期の例では、モバイル側でデータを更新し(サーバー側の DB に変更が入る)ページ情報が更新されたとき、PC 側で表示されているページでも最新情報を fetch することで更新されることになる。

### タイミング１: Page が focus により active になる

- Hook に関連づけられたコンポーネントが画面上にある場合にのみ re-fetch が行われる。
- この機能は、 `revalidateOnFocus` option で default で有効

### タイミング２：一定間隔での更新

- また、`refreshInterval` option によって Interval 間隔の調整が可能

```ts
useSWR("/api/todos", fetcher, { refreshInterval: 1000 });
```

### タイミング３：再接続

- ユーザーが端末を Sleep している状態から復旧させたときなど、Offline から Online になったときに、refetch される。
- この機能は、`revalidateOnReconnect` option で default で有効

### その他のタイミング

- `refreshWhenHidden` (default: false)
  - ウィンドウが非表示の場合にポーリングする（refreshInterval が有効になっているときのみ）
- `refreshWhenOffline` (default: false)
  - ブラウザがオフラインのときにポーリングする（navigator.onLine によって決定される）

### この機能を無効化するには？

- `useSWRImmutable`を使う

```ts
import useSWRImmutable from "swr/immutable";
// ...
useSWRImmutable(key, fetcher, options);
```

### マウント時に SWR の再検証を強制的にオーバーライドする

- デフォルトでは、revalidateOnMount の値は undefined
- mount 時の挙動
  - まず、`revalidateOnMount` が定義されているかどうかを確認。
  - `true`の場合はリクエストを開始し
  - `false`の場合はリクエストを停止
- `revalidateIfStale` (default:true) はマウント動作の制御に利用する
  - `revalidateIfStale` が `true` に設定されている場合、キャッシュ データがある場合にのみ再フェッチされ、それ以外の場合は再フェッチされない

## [Arguments](https://swr.vercel.app/docs/arguments)

- default で`key`は`fetcher`に渡される。以下の 3 つの挙動は同じ

```ts
useSWR("/api/user", () => fetcher("/api/user"));
useSWR("/api/user", (url) => fetcher(url));
useSWR("/api/user", fetcher);
```

### 複数の引数

- 以下は cache key を配列として渡している

```ts
const { data: user } = useSWR(["/api/user", token], ([url, token]) =>
  fetchWithToken(url, token)
);
const { data: user } = useSWR(["/api/user", token], fetchWithToken);
// 条件付きfetch
const { data: orders } = useSWR(
  user ? ["/api/orders", user] : null,
  fetchWithUser
);
```

```tsx
const [queryParams, setQueryparams] = useState("");

const queryFetcher = (url: string, queryParams: string = "") => {
  return fetcher(`${url}${queryParams}`);
};

// queryParamsが更新されると、実行される
const { data, error } = useSWR(
  [`http://127.0.0.1:8887/fee.json`, queryParams],
  queryFetcher
);

const onClickConnect = () => {
  const ts = Date.now().toString();
  setQueryparams(`?timestamp=${ts}`);
};
```

## [Mutation & Revalidation](https://swr.vercel.app/docs/mutation)

- 外部の remote データや関連キャッシュを更新するため 2 つの方法がある
  - 任意のキーを変更できるグローバル`mutate` API
  - SWR 2.0 から追加された新機能となる、SWR Hook のデータのみを変更できるバインドされた `useSWRMutation` API

### mutate

#### Global Mutate

- `useSWRConfig` hook によって取得する方法が推奨されている
- key パラメーターのみで global mutator を使用すると、同じ key を使用してマウントされた SWR hook がない限り、キャッシュは更新されず、再検証もトリガーされない

```ts
import { useSWRConfig } from "swr";

function App() {
  const { mutate } = useSWRConfig();
  mutate(key, data, options);
}
```

#### Bound Mutate

- global mutate 関数と機能的に同等だが、key パラメーターは必要ない

```ts
import useSWR from "swr";

function Profile() {
  const { data, mutate } = useSWR("/api/user", fetcher);

  return (
    <div>
      <h1>My name is {data.name}.</h1>
      <button
        onClick={async () => {
          const newName = data.name.toUpperCase();
          // send a request to the API to update the data
          await requestUpdateUsername(newName);
          // update the local data immediately and revalidate (refetch)
          // NOTE: key is not required when using useSWR's mutate as it's pre-bound
          mutate({ ...data, name: newName });
        }}
      >
        Uppercase my name!
      </button>
    </div>
  );
}
```

#### 任意のタイミングで再検証を実行する

- データなしで `mutate(key)` (bind された mutate API の場合は `mutate()` のみ) を呼び出すと、リソースの再検証がトリガーされる
- これは、データに期限切れのマークが付けられ、再フェッチがトリガーされる
- 同じ`cache provider`スコープ内の SWR Hook にブロードキャストされる
- `cache provider`が存在しない場合は、すべての SWR Hook にブロードキャストされます。

```ts
import useSWR, { useSWRConfig } from "swr";

function App() {
  const { mutate } = useSWRConfig();

  return (
    <div>
      <Profile />
      <button
        onClick={() => {
          // set the cookie as expired
          document.cookie =
            "token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";

          // tell all SWRs with this key to revalidate
          mutate("/api/user");
        }}
      >
        Logout
      </button>
    </div>
  );
}
```

### useSWRMutation

- remote update の hook として `useSWRMutation`があり、これは自動的にトリガーされるのではなく、手動でのみトリガーされる
- また、この hook は他の `useSWRMutation` hook と状態を共有しない

```ts
import useSWRMutation from "swr/mutation";

// Fetcher implementation.
// The extra argument will be passed via the `arg` property of the 2nd parameter.
// In the example below, `arg` will be `'my_token'`
async function updateUser(url, { arg }: { arg: string }) {
  await fetch(url, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${arg}`,
    },
  });
}

function Profile() {
  // A useSWR + mutate like API, but it will not start the request automatically.
  const { trigger } = useSWRMutation("/api/user", updateUser, options);

  return (
    <button
      onClick={() => {
        // Trigger `updateUser` with a specific argument.
        trigger("my_token");
      }}
    >
      Update User
    </button>
  );
}
```

## [Error Handling](https://swr.vercel.app/docs/error-handling)

- fetcher 内でエラーがスローされた場合、hook によってエラーとして返される
- データとエラーが同時に存在する可能性があることに注意が必要
- これにより、UI は、今後のリクエストが失敗したことを認識しながら、既存のデータを表示できる

```ts
const fetcher = async (url) => {
  const res = await fetch(url);

  // If the status code is not in the range 200-299,
  // we still try to parse and throw it.
  if (!res.ok) {
    const error = new Error("An error occurred while fetching the data.");
    // Attach extra info to the error object.
    error.info = await res.json();
    error.status = res.status;
    throw error;
  }

  return res.json();
};

// ...
const { data, error } = useSWR("/api/user", fetcher);
// error.info === {
//   message: "You are not authorized to access this resource.",
//   documentation_url: "..."
// }
// error.status === 403
```

### Error Retry

- `onErrorRetry` option によって挙動を上書きできる
- option `shouldRetryOnError: true`が default の設定となる

```ts
useSWR("/api/user", fetcher, {
  onErrorRetry: (error, key, config, revalidate, { retryCount }) => {
    // Never retry on 404.
    if (error.status === 404) return;

    // Never retry for a specific key.
    if (key === "/api/user") return;

    // Only retry up to 10 times.
    if (retryCount >= 10) return;

    // Retry after 5 seconds.
    setTimeout(() => revalidate({ retryCount }), 5000);
  },
});
```

## [Conditional Fetching](https://swr.vercel.app/docs/conditional-fetching)

- 条件付きでデータをフェッチするには、`null` を使用するか、キーとして関数を渡す。 関数が`false`の値をスローまたは返した場合、SWR はリクエストしない

```ts
// conditionally fetch
const { data } = useSWR(shouldFetch ? "/api/data" : null, fetcher);

// ...or return a falsy value
const { data } = useSWR(() => (shouldFetch ? "/api/data" : null), fetcher);

// ...or throw an error when user.id is not defined
const { data } = useSWR(() => "/api/data?uid=" + user.id, fetcher);
```

### 依存

- 他のデータに依存するデータをフェッチすることもできる
- 可能な限り最大限の並列処理が保証される
- 次のデータ fetch の実行に動的データの一部が必要な場合には連続的な fetch も可能

```ts
function MyProjects() {
  const { data: user } = useSWR("/api/user");
  const { data: projects } = useSWR(() => "/api/projects?uid=" + user.id);
  // When passing a function, SWR will use the return
  // value as `key`. If the function throws or returns
  // falsy, SWR will know that some dependencies are not
  // ready. In this case `user.id` throws when `user`
  // isn't loaded.

  if (!projects) return "loading...";
  return "You have " + projects.length + " projects";
}
```

## [Subscription](https://swr.vercel.app/docs/subscription) (version: 2.1.0 以上)

### useSWRSubscription

- SWR を使用してリアルタイムデータソースを subscribe できるようにする React Hook
- 提供されている subscribe function を使用してリアルタイムデータソースを subscribe し、受信した最新のデータと発生したエラーを返す
- 新しいイベントが受信されると、フックは返されたデータを自動的に更新する
- Data Source の例としては、Firestore や WebSocket が挙げられる

### useSWRSubscription: Deduplication 重複排除

- 同じ key を使っている限り、重複排除が働く

## [Prefetching Data](https://swr.vercel.app/docs/prefetching)

- SWR のための`prefetch`はいくつかの方法があるが、`rel="preload"`による HTML の`head`タグ内の Top Level でのリクエストが推奨されている

```html
<link rel="preload" href="/api/data" as="fetch" crossorigin="anonymous" />
```

- HTML のロード時にデータが prefetch される。同じ URL を持つ fetch リクエストはすべて、結果を再利用する

### `preload` function による prefetch

```ts
import { useState } from 'react'
import useSWR, { preload } from 'swr'

const fetcher = (url) => fetch(url).then((res) => res.json())

// Preload the resource before rendering the User component below,
// this prevents potential waterfalls in your application.
// You can also start preloading when hovering the button or link, too.
preload('/api/user', fetcher)

function User() {
  const { data } = useSWR('/api/user', fetcher)
  ...
}

export default function App() {
  const [show, setShow] = useState(false)
  return (
    <div>
      <button onClick={() => setShow(true)}>Show User</button>
      {show ? <User /> : null}
    </div>
  )
}
```

- useEffect 内での実行

```ts
function App({ userId }) {
  const [show, setShow] = useState(false)

  // preload in effects
  useEffect(() => {
    preload('/api/user?id=' + userId, fetcher)
  }, [userId])

  return (
    <div>
      <button
        onClick={() => setShow(true)}
        {/* preload in event callbacks */}
        onHover={() => preload('/api/user?id=' + userId, fetcher)}
      >
        Show User
      </button>
      {show ? <User /> : null}
    </div>
  )
}
```

- Next.js の[page prefetching](https://nextjs.org/docs/pages/api-reference/functions/use-router#routerprefetch)などのテクニックと併用すると、次のページとデータの両方を瞬時に読み込むことができる

### Pre-fill Data

- 既存のデータを SWR キャッシュに事前に入力したい場合は、`fallbackData` オプションを使用する

```ts
useSWR("/api/data", fetcher, { fallbackData: prefetchedData });
```

## [Next.js SSG and SSR](https://swr.vercel.app/docs/with-nextjs)

### Client Side Data Fetching

- ページに頻繁に更新されるデータが含まれており、データを事前レンダリングする必要がない場合は、SWR が最適であり、特別な設定は必要ない
- useSWR を import し、データを使用するコンポーネント内のフックを使用するだけ

### Pre レンダリング with デフォルト Data

- SSG や SSR によって Pre レンダリングを利用する場合、`SWRConfig` の`fallback` option を使用して、プリフェッチされたデータをすべての SWR フックの初期値として渡すことができる
- 以下の例では、Article コンポーネントは、まず事前に生成されたデータをレンダリングし、Page が hydrate された後、最新のデータを再度フェッチして更新を維持する

```ts
export async function getStaticProps() {
  // `getStaticProps` is executed on the server side.
  const article = await getArticleFromAPI();
  return {
    props: {
      fallback: {
        "/api/article": article,
      },
    },
  };
}

function Article() {
  // `data` will always be available as it's in `fallback`.
  const { data } = useSWR("/api/article", fetcher);
  return <h1>{data.title}</h1>;
}

export default function Page({ fallback }) {
  // SWR hooks inside the `SWRConfig` boundary will use those values.
  return (
    <SWRConfig value={{ fallback }}>
      <Article />
    </SWRConfig>
  );
}
```

## [TypeScript](https://swr.vercel.app/docs/typescript)

## [Middleware](https://swr.vercel.app/docs/middleware)

- SWR Hook の前後でロジックを実行できるようになる
- Middleware は SWR Hook を受け取り、実行の前後にロジックを実行できる
- 複数の Middleware がある場合、各 Middleware は次の Middleware をラップする
- リストの最後の Middleware は、元の SWR Hook である useSWR を受け取る

```ts
function myMiddleware(useSWRNext) {
  return (key, fetcher, config) => {
    // Before hook runs...

    // Handle the next middleware, or the `useSWR` hook if this is the last one.
    const swr = useSWRNext(key, fetcher, config);

    // After hook runs...
    return swr;
  };
}
```

- Middleware は配列として渡す

```ts
<SWRConfig value={{ use: [myMiddleware] }}>

// or...
useSWR(key, fetcher, { use: [myMiddleware] })

// a → b → c の順にMiddlewareは実行される
useSWR(key, fetcher, { use: [a, b, c] })
```

### Middleware の例

#### Request Logger

```ts
function logger(useSWRNext) {
  return (key, fetcher, config) => {
    // Add logger to the original fetcher.
    const extendedFetcher = (...args) => {
      console.log("SWR Request:", key);
      return fetcher(...args);
    };

    // Execute the hook with the new fetcher.
    return useSWRNext(key, extendedFetcher, config);
  };
}

// ... inside your component
useSWR(key, fetcher, { use: [logger] });
```

#### Dynamic Endpoint Key

- useSWR の key に必要なエンドポイントを追加するミドルウェアは有用かもしれない
  - TODO: 以下のコードは未確認

```tsx
const endpoint = (useSWRNext) => {
  return (key, fetcher, config) => {
    let newKey = key;
    if (process.env.API_ENDPOINT) newKey = `${process.env.API_ENDPOINT}${key}`;
    return useSWRNext(newKey, fetcher, config);
  };
};

// ... コンポーネント内
useSWR(key, fetcher, { use: [endpoint] });
```

## [Understanding SWR](https://swr.vercel.app/docs/advanced/understanding)

## [Cache](https://swr.vercel.app/docs/advanced/cache)

- ほとんどの場合、キャッシュに直接書き込むべきではない。これにより、SWR の未定義の動作が発生する可能性がある。
- key を手動で変更する必要がある場合は、SWR API の使用を検討すべき
- デフォルトでは、SWR は global キャッシュを使用してデータを保存および共有する

### Cache Provider

- キャッシュ プロバイダーは、次の TypeScript 定義 (swr からインポート可能) に一致する Map のようなオブジェクト

```ts
interface Cache<Data> {
  get(key: string): Data | undefined;
  set(key: string, value: Data): void;
  delete(key: string): void;
  keys(): IterableIterator<string>;
}
```

### Cache Provider の作成

- SWRConfig の`provider` option は、Cache Provider を返す関数を受け取る。 この provider は、SWRConfig 境界内のすべての SWR Hook によって使用される。

```ts
import useSWR, { SWRConfig } from "swr";

function App() {
  return (
    <SWRConfig value={{ provider: () => new Map() }}>
      <Page />
    </SWRConfig>
  );
}
```

## [Performance](https://swr.vercel.app/docs/advanced/performance)

### Performance 観点での Deduplication 重複排除

- useSWR を複数定義していても、同じ key であれば重複リクエストは行わない
- `dedupingInterval = 2000` option: この期間内に同じキーを持つ重複排除リクエスト (ミリ秒単位)

### Deep Comparison

- SWR はデフォルトでデータの変更を詳細に比較し、データ値が変更されていない場合、再レンダリングはトリガーされない
- 動作を変更したい場合は、比較オプションを使用して`compare` option をカスタマイズすることもできる
  - たとえば、一部の API 応答は、データ差分から除外したいサーバータイムスタンプを返すなど

### Dependency Collection

以下は A と B でレンダリング回数が異なる。取得する値が多いと、それだけレンダリング回数も増えるので要注意

```tsx
// A: レンダリングは少ない
const { data } = useSWR("/api", fetcher);

// B: レンダリングが多くなる
const { data, error, isValidating } = useSWR("/api", fetcher);
```

## DevTools

- [SWR DevTools](https://swr-devtools.vercel.app/)という Browser の Extension によって、key ごとの cache 情報を確認できる

## WIP: ここから下の情報は更新が必要

## 特徴

- hook として利用可能で、処理を簡潔に記述可能
  - ただし、hook なので React function の Top Level からの呼び出しが必要
- データ取得における状態管理が容易
- ポーリングによるデータの自動再フェッチを行う (default は無効)
- SWR で取得したデータは、第一引数で渡した文字列をキーとしてデータを Cache する
  - つまり、複数のコンポーネントで useSWR()でデータを取得しても、Cache があれば、それを利用することになる
- エラーが発生しても自動で再取得を行う (`shouldRetryOnError: true`の設定が必要)
- useSWR()の戻り値の `mutate` はキャッシュされたデータを更新する関数となる

## Sample Code

```tsx
export const useNetwork = () => {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  // call after mounted
  const fetcher = (url: string) => fetch(url).then((res) => res.json());
  const { data, isValidating, error } = useSWR(
    mounted ? `/api/v1/network` : null,
    fetcher
  );

  if (isValidating) {
    console.error(`this request is Revalidation`);
  }

  // type check
  if (!isNetwork(data)) {
    console.error(`invalid response`);
  }

  return {
    network: data,
    isLoading: !error && !data,
    error: error,
  };
};
```
