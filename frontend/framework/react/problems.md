# React/Next.js Problems

## Next.jsでの`window is not defined`の問題

- レンダリング後に window オブジェクトを使う必要がある

- `useEffect()`はレンダリング後に実行されるので、この中であれば実行できる

```tsx
  useEffect(() => {

  }, [])
```

- if文で判定する

```ts
if (typeof window === "undefined") {
  console.log("Oops, `window` is not defined")
}
```

- [Dynamic Import](https://nextjs.org/docs/advanced-features/dynamic-import)を使用する
  - これにより、動的にコンポーネントを読み込むことができる
  1. window オブジェクトを含むコンポーネントを xxx.tsx を作成
  2. xxx.tsx を dynamic import ( ssr: false ) する

```tsx
const Component = dynamic(() => import('@components/.../Xxx'), {
  ssr: false, // <- ここで ssr を無効にするオプションを渡す
})
```
