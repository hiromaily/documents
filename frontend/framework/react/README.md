# React

## React v18.0

- [React v18.0](https://reactjs.org/blog/2022/03/29/react-v18.html)

### Automatic Batching

- 関数内のすべての処理をひとかたまりにして一度にレンダリングを行う

### Transitions

- タイプ・クリック・プレスといった緊急性の高いユーザ操作と区別し、段階的に画面を推移させるあらたな考え方

### Suspense

- コンポーネントをより宣言的に利用するために実装
- メリットは、サスペンスがロード後のコンポーネントを返すので、待機時のページ処理が軽くなる

### New Hooks

- useTransition
- useDeferredValue
- useSyncExternalStore
- useInsertionEffect

## Basics 様々な概念

### [Fragments](https://react.dev/reference/react/Fragment)

`<Fragment>`, often used via `<>...</>` syntax, lets you group elements without a wrapper node.

```jsx
<>
  <OneChild />
  <AnotherChild />
</>
```

### [JSX](https://react.dev/learn/writing-markup-with-jsx#jsx-putting-markup-into-javascript)

JSX is a syntax extension for JavaScript that lets you write HTML-like markup inside a JavaScript file. Although there are other ways to write components, most React developers prefer the conciseness of JSX, and most codebases use it.
