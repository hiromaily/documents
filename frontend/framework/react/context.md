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

## Contextの使い所
- 複数のコンポーネントで共通利用したいデータがあるが、コンポーネントの数が多かったり、階層が深いのでPropsで渡すのが困難な場合

## Context利用のユースケース
- 認証情報
- コンポーネントに適用するスタイルを制御するためのテーマ
- 言語情報 (i18n)
## Contextのデメリット
- コンポーネントがContextに依存するため、コンポーネントの再利用性が低下する
- Contextオブジェクトの値はグローバルなstateなので、値がどこで利用されているか管理するのが大変
- 以上の理由からContext以外の問題解決の手段も検討すべき

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

// 1. Contextは1つにまとめるのではなく、分割する
//const CountContext = createContext();
const CountStateContext = createContext();
const CountDispatchContext = createContext();


// reducer
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

// ラップするコンポーネントをパラメーターに渡す、providerとしてのfunction
function CountProvider({ children }) {
  const [state, dispatch] = useReducer(countReducer, { count: 0 });
  // const value = {
  //   state,
  //   dispatch
  // };

  return (
    // value（state か dispatch のどちらか）が更新したら、
    // CountContext.Provider 内のすべての Consumer が再レンダーされる。
    // <CountContext.Provider value={value}>{children}</CountContext.Provider>
    // そのため、以下のように分割する
    <CountStateContext.Provider value={state}>
      <CountDispatchContext.Provider value={dispatch}>
        {children}
      </CountDispatchContext.Provider>
    </CountStateContext.Provider>
  );
}

// Count コンポーネント
function Count() {
  console.log('render Count');
  // CountContext からは state のみを取得しているが、
  // dispatch が更新されても再レンダーされる
  // => これはContextを分割したことによって解決
  const { state } = useContext(CountStateContext);

  return <h1>{state.count}</h1>;
}

// Counter コンポーネント
function Counter() {
  console.log('render Counter');
  // CountContext からは dispatch のみを取得しているが、
  // state が更新されても再レンダーされる
  // => これはContextを分割したことによって解決
  const { dispatch } = useContext(CountDispatchContext);

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
// もしくは、以下のようなメモ化したコンポーネントを用意し、Counter()内で、
// return <DispatchButton dispatch={dispatch} />;
// とする方法もある
// const DispatchButton = React.memo(({ dispatch }) => {
//   console.log("render DispatchButton");
//   return (
//     <>
//       <button onClick={() => dispatch({ type: 'DECREMENT' })}>-</button>
//       <button onClick={() => dispatch({ type: 'INCREMENT' })}>+</button>
//     </>
//   );
// })

export default function App() {
  return (
    <CountProvider>
      <Count />
      <Counter />
    </CountProvider>
  );
}
```

## Contextを利用せずにProp drilling問題を解決する
- [コンテクストを使用する前に](https://ja.reactjs.org/docs/context.html#before-you-use-context)

