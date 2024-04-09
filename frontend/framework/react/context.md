# React Context

- `props`では親から子のコンポーネントへ任意のデータを渡せるが、`Context`を使うことで、親から渡すことなくデータを参照できる
- `Context`によって global な state を作成できる。また Prop drilling 問題を解消できる。
- `Context`では、`Provider`と`Consumer`という 2 つのコンポーネントを使用する。
  - `Provider`にデータを渡す
  - `Consumer`がデータを受け取る
  - これは値をセットするための`Provider`によってラップされたコンポーネントから、`useContext`か、`Consumer`によって値を参照できる
- まず、`createContext()`によって Context を作成する

## データフローの原則

単方向データフロー(高い階層のコンポーネントから低い階層のコンポーネントにデータを一方向に流す)という原則がある。  
子コンポーネントでデータを変更して、そのデータを親要素が使いたい場合、データを変更するための function を親から子に渡す必要がある。

## Context の使い所

- 複数のコンポーネントで共通利用したいデータがあるが、コンポーネントの数が多かったり、階層が深いので Props で渡すのが困難な場合

## Context 利用のユースケース

- 認証情報
- コンポーネントに適用するスタイルを制御するためのテーマ
- 言語情報 (i18n)

## Context のデメリット

- コンポーネントが Context に依存するため、コンポーネントの再利用性が低下する
- Context オブジェクトの値はグローバルな state なので、値がどこで利用されているか管理するのが大変
- 以上の理由から Context 以外の問題解決の手段も検討すべき

## Example

```tsx
import React from "react";

// Titleを渡すためのContextを作成します
const TitleContext = React.createContext("");

// Titleコンポーネントの中でContextの値を参照します
const Title = () => {
  // Consumerを使って、Contextの値を参照します
  return (
    <TitleContext.Consumer>
      {/* Consumer直下に関数を置いて、Contextの値を参照します */}
      {(title) => {
        return <h1>{title}</h1>;
      }}
    </TitleContext.Consumer>
  );
};

const Header = () => {
  return (
    <div>
      {/* HeaderからTitleへは何もデータを渡しません */}
      <Title />
    </div>
  );
};

// Pageコンポーネントの中でContextに値を渡します
const Page = () => {
  const title = "React Book";

  // Providerを使いContextに値をセットします。
  // Provider以下のコンポーネントから値を参照できます
  return (
    <TitleContext.Provider value={title}>
      <Header />
    </TitleContext.Provider>
  );
};

export default Page;
```

## Example2

- [How to pass Multiple Values in React Context?]()

```tsx
const CounterContext = React.createContext("counter");

export default function MultiValueContextDemo() {
  const [counter1, setCounter1] = useState(0);
  const [counter2, setCounter2] = useState(0);

  return (
    <CounterContext.Provider
      value={{ counter1, setCounter1, counter2, setCounter2 }}
    >
      <CounterComponent />
    </CounterContext.Provider>
  );
}

const CounterComponent = () => {
  const { counter1, setCounter1, counter2, setCounter2 } =
    useContext(CounterContext);

  return (
    <React.Fragment>
      <button onClick={() => setCounter1((counter) => counter + 1)}>
        Click Counter {counter1}
      </button>
      <button onClick={() => setCounter2((counter) => counter + 1)}>
        Click Counter {counter2}
      </button>
    </React.Fragment>
  );
};
```

- Note:
  - [React Fragment](https://reactjs.org/docs/fragments.html)

## Context 利用時の注意点

- Provider 内の全ての Consumer は、Provider の value プロパティが更新される度に再レンダリングされる
- 上記を防ぐ方法
  - Context オブジェクトを分割する
  - React.memo を利用する (コンポーネントのメモ化)
  - useMemo を利用する (値のメモ化)

### Example

```tsx
import React, { createContext, useContext, useReducer, useMemo } from "react";

// 1. Contextは1つにまとめるのではなく、分割する
//const CountContext = createContext();
const CountStateContext = createContext();
const CountDispatchContext = createContext();

// reducer
function countReducer(state, action) {
  switch (action.type) {
    case "INCREMENT": {
      return { count: state.count + 1 };
    }
    case "DECREMENT": {
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
  console.log("render Count");
  // CountContext からは state のみを取得しているが、
  // dispatch が更新されても再レンダーされる
  // => これはContextを分割したことによって解決
  const { state } = useContext(CountStateContext);

  return <h1>{state.count}</h1>;
}

// Counter コンポーネント
function Counter() {
  console.log("render Counter");
  // CountContext からは dispatch のみを取得しているが、
  // state が更新されても再レンダーされる
  // => これはContextを分割したことによって解決
  const { dispatch } = useContext(CountDispatchContext);

  // CountContext.Provider の value の更新による Counter コンポーネントの
  // 再レンダーは避けられない。そのため dispatch を利用するレンダリング結果（計算結果）を
  // メモ化し、不要な再レンダーを防ぐ。
  return useMemo(() => {
    console.log("rerender Counter");
    return (
      <>
        <button onClick={() => dispatch({ type: "DECREMENT" })}>-</button>
        <button onClick={() => dispatch({ type: "INCREMENT" })}>+</button>
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

## Context を利用せずに Prop drilling 問題を解決する

- [コンテクストを使用する前に](https://ja.reactjs.org/docs/context.html#before-you-use-context)

- コンテクストを使用せずにこの問題を解決する 1 つの手法は、深い位置にあるコンポーネント自身を渡すようにする

```tsx
function Page(props) {
  const user = props.user;
  const userLink = (
    <Link href={user.permalink}>
      <Avatar user={user} size={props.avatarSize} />
    </Link>
  );
  return <PageLayout userLink={userLink} />;
}

// これで以下のようになります。
<Page user={user} avatarSize={avatarSize} />
// ... Page コンポーネントは以下をレンダー ...
<PageLayout userLink={...} />
// ... PageLayout コンポーネントは以下をレンダー ...
<NavigationBar userLink={...} />
// ... NavigationBar コンポーネントは以下をレンダー ...
{props.userLink}
```

## Render prop

- [レンダープロップ](https://ja.reactjs.org/docs/render-props.html)
- [レンダープロップパターン](https://zenn.dev/morinokami/books/learning-patterns-1/viewer/render-props-pattern)
- [React + TypeScript: レンダープロップ](https://qiita.com/FumioNonaka/items/6f20673cf50afe41f088)

- JSX の要素を返す関数を値とするコンポーネントの prop を使って、コンポーネント間でコードを共有するためのテクニック
- 横断的関心事にレンダープロップを使う
- コンポーネントは、独自のレンダリングロジックを実装する代わりに、単にレンダープロップを呼び出すだけとなる
- prop を受け取るコンポーネントを再利用しやすいこと

- コンポーネントへ描画(UI)ロジックをプロパティ経由で渡し、コンポーネントはそれを表示する
- 共通化された UI ロジックをコンポーネントで再利用する事を目的とする

### [Leveraging React Render Props for Flexible Component Composition](https://www.dhiwise.com/post/leveraging-react-render-props-for-flexible-component-composition)

- 関数を値とするプロップを使って React コンポーネント間でコードを共有するテクニックのこと
- これにより、レンダリング関数を prop としてコンポーネントに渡すことができるパターン
- メリットは、`柔軟性`と`再利用性`にある
  - コンポーネント・ロジックを再利用すること (だったら hook でもいいのでは？と思うのだが)
  - コンポーネントが何をレンダリングするかを制御すること
- コンポーネントの振る舞いをカプセル化し、関数プロップを使ってその振る舞いを他のコンポーネントに「注入」することを可能にする
  - これにより、複数のコンポーネントでこのロジックを共有し再利用することができる
- メリットまとめ
  - レンダープロップはコードの再利用を促進
  - "wrapper hell:ラッパー地獄 "の問題に対する解決策を提供
    - 不必要なコンポーネントのレイヤーを追加することなくコンポーネントロジックを共有する
  - レンダリングに関してより柔軟性を提供する

### 考察

- 大規模プロジェクトでコンポーネントを再利用する頻度が高いところ以外は無理に使うと可読性が悪くなるので注意
- ロジックの再利用ならカスタムフックのほうがシンプルでは？
