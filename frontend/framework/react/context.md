# React Context

- `props`では親から子のコンポーネントへ任意のデータを渡せるが、`Context`を使うことで、親から渡すことなくデータを参照できる
- `Context`によってglobalなstateを作成できる。またProp drilling問題を解消できる。
- `Context`では、`Provider`と`Consumer`という2つのコンポーネントを使用する。
  - `Provider`にデータを渡す
  - `Consumer`がデータを受け取る
  - これは値をセットするための`Provider`によってラップされたコンポーネントから、`useContext`か、`Consumer`によって値を参照できる
- まず、`createContext()`によってContextを作成する

## データフローの原則
単方向データフロー(高い階層のコンポーネントから低い階層のコンポーネントにデータを一方向に流す)という原則がある。  
子コンポーネントでデータを変更して、そのデータを親要素が使いたい場合、データを変更するためのfunctionを親から子に渡す必要がある。

## Example
```tsx
import React from 'react'

// Titleを渡すためのContextを作成します
const TitleContext = React.createContext('')

// Titleコンポーネントの中でContextの値を参照します
const Title = () => {
  // Consumerを使って、Contextの値を参照します
  return (
    <TitleContext.Consumer>
      {/* Consumer直下に関数を置いて、Contextの値を参照します */}
      {(title) => {
        return <h1>{title}</h1>
      }}
    </TitleContext.Consumer>
  )
}

const Header = () => {
  return (
    <div>
      {/* HeaderからTitleへは何もデータを渡しません */}
      <Title />
    </div>
  )
}

// Pageコンポーネントの中でContextに値を渡します
const Page = () => {
  const title = 'React Book'

  // Providerを使いContextに値をセットします。
  // Provider以下のコンポーネントから値を参照できます
  return (
    <TitleContext.Provider value={title}>
      <Header />
    </TitleContext.Provider>
  )
}

export default Page
```

## Example2
- [How to pass Multiple Values in React Context?]()
```tsx
const CounterContext = React.createContext("counter")

export default function MultiValueContextDemo() {
    const [counter1, setCounter1] = useState(0);
    const [counter2, setCounter2] = useState(0);

    return(
        <CounterContext.Provider value={{ counter1, setCounter1, counter2, setCounter2 }}>
            <CounterComponent />
        </CounterContext.Provider>
    )
}

const CounterComponent = () => {
    const {counter1, setCounter1, counter2, setCounter2 } = useContext(CounterContext)

    return(
        <React.Fragment>
            <button onClick={() => setCounter1((counter) => counter + 1)}>Click Counter {counter1}</button>
            <button onClick={() => setCounter2((counter) => counter + 1)}>Click Counter {counter2}</button>
        </React.Fragment>
    )
}
```
- Note:
  - [React Fragment](https://reactjs.org/docs/fragments.html)

## Context利用時の注意点
- Provider内の全てのConsumerは、Providerのvalueプロパティが更新される度に再レンダリングされる
- 上記を防ぐ方法
  - Contextオブジェクトを分割する
  - React.memoを利用する (コンポーネントのメモ化)
  - useMemoを利用する (値のメモ化)

### Example
```tsx
import React, { createContext, useContext, useReducer, useMemo } from 'react';

const CountContext = createContext();

function countReducer(state, action) {
  switch (action.type) {
    case 'INCREMENT': {
      return { count: state.count + 1 };
    }
    case 'DECREMENT': {
      return { count: state.count - 1 };
    }
    default: {
      return state;
    }
  }
}

function CountProvider({ children }) {
  const [state, dispatch] = useReducer(countReducer, { count: 0 });
  const value = {
    state,
    dispatch
  };

  return (
    // value（state か dispatch のどちらか）が更新したら、
    // CountContext.Provider 内のすべての Consumer が再レンダーされる。
    <CountContext.Provider value={value}>{children}</CountContext.Provider>
  );
}

function Count() {
  console.log('render Count');
  // CountContext からは state のみを取得しているが、
  // dispatch が更新されても再レンダーされる
  const { state } = useContext(CountContext);

  return <h1>{state.count}</h1>;
}

function Counter() {
  console.log('render Counter');
  // CountContext からは dispatch のみを取得しているが、
  // state が更新されても再レンダーされる
  const { dispatch } = useContext(CountContext);

  // CountContext.Provider の value の更新による Counter コンポーネントの
  // 再レンダーは避けられない。そのため dispatch を利用するレンダリング結果（計算結果）を
  // メモ化し、不要な再レンダーを防ぐ。
  return useMemo(() => {
    console.log('rerender Counter');
    return (
      <>
        <button onClick={() => dispatch({ type: 'DECREMENT' })}>-</button>
        <button onClick={() => dispatch({ type: 'INCREMENT' })}>+</button>
      </>
    );
  }, [dispatch]);
}

export default function App() {
  return (
    <CountProvider>
      <Count />
      <Counter />
    </CountProvider>
  );
}
```
