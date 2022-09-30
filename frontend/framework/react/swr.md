# SWR
- データ取得のための React Hooks ライブラリ
- SWR は、まずキャッシュからデータを返し（stale）、次にフェッチリクエストを送り（revalidate）、最後に最新のデータを持ってくる
- `stale-while-revalidate`に基づいた処理と設計で、`キャッシュをなるべく最新に保つ機能`と解釈できる
- Next.jsと同様、Vercelによって開発されている

## References
- [SWR](https://swr.vercel.app/)
- [SWR (ja)](https://swr.vercel.app/ja)
- [github](https://github.com/vercel/swr)
- [Comparison | React Query vs SWR vs Apollo vs RTK Query vs React Router](https://react-query-v3.tanstack.com/comparison)
- [ReactをシンプルにするSWR](https://zenn.dev/uttk/articles/b3bcbedbc1fd00)

## 特徴
- hookとして利用可能で、処理を簡潔に記述可能
  - ただし、hookなのでReact functionのTop Levelからの呼び出しが必要
- データ取得における状態管理が容易
- ポーリングによるデータの自動再フェッチを行う (defaultは無効)
  - [Automatic Revalidation](https://swr.vercel.app/docs/revalidation)
  - [自動再検証](https://swr.vercel.app/ja/docs/revalidation)
  - ページにフォーカスを合わせるかタブを切りかえると、SWR は自動的にデータを再検証する(この機能はdefaultで有効)
    - useSWR()の第三引数に[Option](https://swr.vercel.app/docs/options#options)の設定が可能で、`revalidateOnFocus`を設定する
```tsx
useSWR('/api/user', fetcher, { revalidateOnFocus: false });

// 全てoff
// データがキャッシュされると、二度とリクエストされなくなる
import useSWRImmutable from 'swr/immutable'
useSWR(key, fetcher, {
  revalidateIfStale: false,
  revalidateOnFocus: false,
  revalidateOnReconnect: false
})

// 上記に相当する
useSWRImmutable(key, fetcher)
```

- SWRで取得したデータは、第一引数で渡した文字列をキーとしてデータをCacheする
  - つまり、複数のコンポーネントでuseSWR()でデータを取得しても、Cacheがあれば、それを利用することになる
- エラーが発生しても自動で再取得を行う (`shouldRetryOnError: true`の設定が必要)
- useSWR()の戻り値の`mutate`はキャッシュされたデータを更新する関数となる
-　条件付きFetchが可能で、stateの状態に応じてリクエストする/しないといった制御が可能
  - 変数だけでなく、関数にて設定することも可能
```tsx
const { data } = useSWR(shouldFetch ? '/api/data' : null, fetcher)

const { data } = useSWR(() => shouldFetch ? '/api/data' : null, fetcher)
```

## 複数の引数
- key毎にcacheされるので、同一キーで新しい情報を取得することができない。


## TODO: 手動による再取得(mutate)
- [Mutation](https://swr.vercel.app/ja/docs/mutation)

- これは一度取得した情報(Cache)を更新するために使われる。
- `mutate()`に渡すkeyに該当するCacheを更新することができる

```tsx
import useSWR, { useSWRConfig } from 'swr'

function App () {
  const { mutate } = useSWRConfig()

  return (
    <div>
      <Profile />
      <button onClick={() => {
        // クッキーを期限切れとして設定します
        document.cookie = 'token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;'

        // このキーを使用してすべての SWR に再検証するように指示します
        mutate('/api/user')
      }}>
        Logout
      </button>
    </div>
  )
}
```
## Sample Code
```tsx
export const useNetwork = () => {
  const [mounted, setMounted] = useState(false)

  useEffect(() => {
    setMounted(true)
  }, [])

  // call after mounted
  const fetcher = (url: string) => fetch(url).then((res) => res.json())
  const { data, isValidating, error } = useSWR(mounted ? `/api/v1/network` : null, fetcher)

  if (isValidating) {
    console.error(`this request is Revalidation`)
  }

  // type check
  if (!isNetwork(data)) {
    console.error(`invalid response`)
  }

  return {
    network: data,
    isLoading: !error && !data,
    error: error,
  }
}
```

## TODO: [Options](https://swr.vercel.app/docs/options#options)
- 再検証やポーリングに伴う設定が多い
- リクエスト終了後のcallbackもある

- `revalidateOnFocus: true`
  - ブラウザのウィンドウがフォーカスされたときに自動で再取得する
- `revalidateOnReconnect: true`
  - ネットワーク接続が切れて、回復したときに自動的に再取得する