# Redux
Reduxは、Flixアーキテクチャーに基づき`Action`と呼ばれるイベントを使用して、アプリケーションの`State`（状態）を管理し更新するためのフレームワーク。 アプリケーションの多くの部分で必要な`State`を、グローバルなStateとして一元管理するのに役立つ。

これは、React、jQuery、Angular、Vueといったライブラリと併用できる

## References
- [Official](https://redux.js.org/)
- [Official: React Redux](https://react-redux.js.org/)
- [github: redux](https://github.com/reduxjs/redux)
- [github: react-redux](https://github.com/reduxjs/react-redux)
- [Redux Toolkit(RTK)](https://redux-toolkit.js.org/)
- [Redux DevTools: Chrome extension](https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd)

## Redux Data Flow
![redux data flow](../../../../images/redux-basics-animation-1.gif 'redux data flow')

### 1. ユーザーインタラクションにより、Actionを作成
- UserがたとえばボタンをClickすると、`ActionCreator`によって`Action`が作成される
- `Action`はtypeプロパティーを持つオブジェクトで、typeプロパティーの値はStringとなる
- `Actionオブジェクト`には、発生したイベントに関する追加情報(状態の変更値)を含めることができ、慣例によりその情報を`payload`と呼ばれるプロパティーにセットする
```js
{
  type: 'deposit',
  payload: 10
}
```

- `ActionCreator`はActionを返す関数となる
```js
const deposit = () => {
  return {
    type: 'deposit',
    payload: 10
  }
}
```

### 2. ActionをStoreへDispatch (送信) する
- `ActionCreator`によって作成された`Actionオブジェクト`を`Store`へ送る
- `Store`は、Reduxアプリケーションの状態を保持するオブジェクトとなる
- `Reducer`と言われる`StateとActionオブジェクトを受け取り、新しいStateを返す関数` を渡すことによって作成される
- `Store`には`Dispatch`と呼ばれるメソッドが備わっており、状態を更新する唯一の方法で、Actionオブジェクトを引数にとる。Storeにイベントが発生したことを知らせる役割を担っている
```js
import { configureStore } from '@reduxjs/toolkit'
 
const store = configureStore({ reducer: accountReducer })
store.dispatch(deposit())
```

### 3. ActionをもとにReducerがStateを更新
- DispatchされたActionと現在保持しているStateが、Store内のReducerに渡され、新しいStateを作成する
- Reducerは、StateとActionオブジェクトを受け取り新しいStateを返す関数で、受信したAction typeに基づいてイベントを処理するイベントリスナーとして機能する
- Reducerを作成するとき
  - 既存のStateに変更を加えることはできないが、現在保持しているStateをコピーし、コピーされた値に変更を加えることによって、更新を行う
  - 非同期ロジックを実行するといった副作用を引き起こしてはならない
```js
const initialState = { account: 0 }
 
const accountReducer = (state = initialState, action) => {
  switch (action.type) {
    case 'deposit': {
      // copy state
      return {
        ...state,
        // update state value from copied state
        account: state.account + action.payload,
      };
    }
    default:
      return state;
  }
}
```

### 4. StateをもとにUIを更新
- 最後に、Reducerによって新たに作成されたStateをもとに、UIが更新される


## [Redux Toolkit (RTK)](https://redux-toolkit.js.org/)