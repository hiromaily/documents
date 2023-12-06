# React Custom Hooks

- [Building Your Own Hooks](https://legacy.reactjs.org/docs/hooks-custom.html)
- [Reusing Logic with Custom Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks)

## 使用する場面

- コンポーネント間でロジックを共有する
- コンポーネントから独自のカスタム Hook を抽出する

## 気を付けるポイント

- custom hook 内のコードは、コンポーネントを再レンダリングするたびに再実行される
- そのため、常に最新の Props と状態を受け取ることになる
- hook 名は`use`で始まる
- 関数は useCallback()でラップする
- hooks への arguments は`Props`オブジェクトで渡すべき？
  - [example: wagmi:useToken](https://github.com/wevm/wagmi/blob/83810c1adf893553edb7c9ba97590820257c0350/packages/react/src/hooks/contracts/useToken.ts#L33-L45C4)

```ts
// 定義側
export type UseTokenArgs = Partial<FetchTokenArgs>
export type UseTokenConfig = QueryConfig<FetchTokenResult, Error>
export type FetchTokenArgs = {
  /** Address of ERC-20 token */
  address: Address
  /** Chain id to use for Public Client. */
  chainId?: number
  /** Units for formatting output */
  formatUnits?: Unit
}

export type FetchTokenResult = {
  address: Address
  decimals: number
  name: string
  symbol: string
  totalSupply: {
    formatted: string
    value: bigint
  }
}

export function useToken({
  address,
  chainId: chainId_,
  formatUnits = 'ether',
  cacheTime,
  enabled = true,
  scopeKey,
  staleTime = 1_000 * 60 * 60 * 24, // 24 hours
  suspense,
  onError,
  onSettled,
  onSuccess,
}: UseTokenArgs & UseTokenConfig = {}) {...}

// 呼び出し側
const { data, isError, isLoading, refetch } = useToken({ address })
```
