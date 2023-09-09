# useReducer

- `state`(状態)と`dispatch`(action を送信する関数）を扱うための Hook
- 配列やオブジェクトなどの複数のデータをまとめたものを状態として扱う使い方ができる
- 定義した`action`を`dispatch()`することで、state を更新する
- useContext()と一緒に扱うことで global に扱える
- Redux で実現していた state 管理が、`useContext` & `useReducer`で実現できるようになり、Redux が不要になる？？
  - [React Hooks vs. Redux: Do Hooks and Context replace Redux?](https://blog.logrocket.com/react-hooks-context-redux-state-management/)

```tsx
reducer(現在の状態, action) {
  return 次の状態
}

const [現在の状態, dispatch] = useReducer(reducer, 初期値)
```

## useReducer と useState の使い分け

- `useReducer`の場合、複雑な state を管理しやすくなる
  - state の更新ロジックが reducer に集約される
  - コンポーネントに w 足す state 関数が dispatch だけになる
  - dispatch の同一性が保たれる
    - コンポーネントを再レンダリングしても、dispatch は発生しないため、メモ化したコンポーネントにそのまま dispatch を渡すことができる
    - 尚、通常の関数は再レンダリングする度に再生成される(useCallback で関数をラップする必要がある)

## Example

```tsx
import { useReducer } from "react";

// reducerが受け取るactionの型を定義する
type Action = "DECREMENT" | "INCREMENT" | "DOUBLE" | "RESET";

// 現在の状態とactionにもとづいて次の状態を返す
const reducer = (currentCount: number, action: Action) => {
  switch (action) {
    case "INCREMENT":
      return currentCount + 1;
    case "DECREMENT":
      return currentCount - 1;
    case "DOUBLE":
      return currentCount * 2;
    case "RESET":
      return 0;
    default:
      return currentCount;
  }
};

type CounterProps = {
  initialValue: number;
};

const Counter = (props: CounterProps) => {
  const { initialValue } = props;
  const [count, dispatch] = useReducer(reducer, initialValue);

  return (
    <div>
      <p>Count: {count}</p>
      {/* dispatch関数にactionを渡して、状態を更新する */}
      <button onClick={() => dispatch("DECREMENT")}>-</button>
      <button onClick={() => dispatch("INCREMENT")}>+</button>
      <button onClick={() => dispatch("DOUBLE")}>×2</button>
      <button onClick={() => dispatch("RESET")}>Reset</button>
    </div>
  );
};

export default Counter;
```
