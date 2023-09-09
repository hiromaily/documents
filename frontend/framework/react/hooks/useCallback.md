# useCallback

- メモ化(ある関数の計算結果を保持し、同一の呼出があった場合は保持しておいた結果を返すといった計算結果を再利用する手法)用の Hook の 1 つ
- `useCallback`は`関数`をメモ化するためのフック
- `useCallback(コールバック関数, 依存配列)`
  - 依存している値がない場合は、`[]`をセット
- `useCallback`は`React.memo`と併用するもの

## React.memo

- `コンポーネント`のレンダリング結果をメモ化する React の API
- 以下のようなコンポーネントでは効果が表れやすい。全てにやる必要はない。
  - レンダリングコストが高いコンポーネント
  - 頻繁に再レンダリングが発生するコンポーネントの Child コンポーネント
- `React.memo(関数コンポーネント);`
- しかし、コールバック関数を Props として受け取ったコンポーネントは再レンダリングされる。
  - これを防ぐために、関数を`useCallback`でメモ化する必要がある
- 関数コンポーネント内で`React.memo`を利用してもメモ化はできない

## Example

```tsx
import React, { useState, useCallback } from "react";

type ButtonProps = {
  onClick: () => void;
};

// DecrementButtonは通常の関数コンポーネントでボタンを表示する
const DecrementButton = (props: ButtonProps) => {
  const { onClick } = props;

  console.log("DecrementButtonが再描画されました");

  return <button onClick={onClick}>Decrement</button>;
};

// IncrementButtonはメモ化した関数コンポーネントでボタンを表示する
const IncrementButton = React.memo((props: ButtonProps) => {
  const { onClick } = props;

  console.log("IncrementButtonが再描画されました");

  return <button onClick={onClick}>Increment</button>;
});

// DoubleButtonはメモ化した関数コンポーネントでボタンを表示する
const DoubleButton = React.memo((props: ButtonProps) => {
  const { onClick } = props;

  console.log("DoubleButtonが再描画されました");

  return <button onClick={onClick}>Double</button>;
});

const Parent = () => {
  const [count, setCount] = useState(0);

  const decrement = () => {
    setCount((c) => c - 1);
  };
  const increment = () => {
    setCount((c) => c + 1);
  };
  // useCallbackを使って関数をメモ化する
  const double = useCallback(() => {
    setCount((c) => c * 2);
    // 第2引数は空配列なので、useCallbackは常に同じ関数を返す
  }, []);

  return (
    <div>
      <p>Count: {count}</p>
      {/* コンポーネントに関数を渡す */}
      <DecrementButton onClick={decrement} />
      {/* メモ化コンポーネントに関数を渡す */}
      <IncrementButton onClick={increment} />
      {/* メモ化コンポーネントにメモ化した関数を渡す。この場合のみ再描画されない */}
      <DoubleButton onClick={double} />
    </div>
  );
};

export default Parent;
```
