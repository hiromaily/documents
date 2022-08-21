# React Context

- `props`では親から子のコンポーネントへ任意のデータを渡せるが、`Context`を使うことで、親から渡すことなくデータを参照できる
- `Context`では、`Provider`と`Consumer`という2つのコンポーネントを使用する。
  - `Provider`にデータを渡す
  - `Consumer`がデータを受け取る
- まず、`createContext()`によってContextを作成する

## Example
```
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
```
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