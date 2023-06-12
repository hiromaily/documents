# Query

Powerful asynchronous state management for TS/JS, React, Solid, Vue and Svelte

- [Official](https://tanstack.com/query/v4)
- [github](https://github.com/tanstack/query)
  - [example](https://github.com/TanStack/query/tree/main/examples)
- [TkDodo's Blog](https://tanstack.com/query/v4/docs/react/community/tkdodos-blog)
  - [React Queryの内部](https://www.makotot.dev/posts/inside-react-query-translation-ja)


## [Mutations](https://tanstack.com/query/v4/docs/react/guides/mutations)

## refetchInterval
- [example](https://github.com/TanStack/query/blob/main/examples/react/auto-refetching/pages/index.js)
```ts
  const { status, data, error, isFetching } = useQuery({
    queryKey: ['todos'],
    queryFn: async () => {
      const res = await axios.get('/api/data')
      return res.data
    },
    // Refetch the data every second
    refetchInterval: intervalMs,
  })
```

## Cache
- Cache Persistence
- Cache Manipulation
- General Cache

## [QueryCache](https://tanstack.com/query/v4/docs/react/reference/QueryCache)

### 利用可能なメソッド
- find
- findAll
- subscribe
- clear

### Options
- `onError?: (error: unknown, query: Query) => void`
- `onSuccess?: (data: unknown, query: Query) => void`
- `onSettled?: (data: unknown | undefined, error: unknown | null, query: Query) => void`



## [Comparison](https://tanstack.com/query/v4/docs/react/comparison)
- React Query
- SWR
- Apollo Client
- RTK-Query
- React Router

## [How can I use react query outside of react or other framework](https://github.com/TanStack/query/discussions/4771)
- use `@tanstack/query-core` package