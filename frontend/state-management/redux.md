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
- Reduxのロジックをシンプルに書くことを目的としている
- `RTK Query`と呼ばれるData FetchingとData Cachingの機能が強力

### Reduxの抱える問題として
- Redux Storeの構成が複雑すぎる
- Reduxに何か便利なことをさせるためには、多くのpackageを追加しなければならない
- Reduxはボイラープレートコードが多すぎる

### 機能
- [configureStore()](https://redux-toolkit.js.org/api/configureStore)：
  - `createStore`をラップして、シンプルな設定オプションと優れたデフォルトを提供する
  - `slice reducer`を自動的に組み合わせたり、Reduxのミドルウェアを追加したり、デフォルトで[`redux-thunk`](https://github.com/reduxjs/redux-thunk)を含んだり、`Redux DevTools Extension`を使えるようにしたりする
- [createReducer()](https://redux-toolkit.js.org/api/createReducer)：
  - switch文を書く代わりに、action typeのlookup tableを`reducer functions`に与えることができる
  - さらに、[immer](https://github.com/immerjs/immer)を自動的に使用し、`state.todos[3].completed = true`のように、通常のmutativeコードでよりシンプルなimmutable updateを記述することができる
- [createAction()](https://redux-toolkit.js.org/api/createAction)：
  - 与えられたaction type文字列に対して、`action creator function`を生成する
  - この関数自体には`toString()`が定義されており、型定数の代わりに使用することができる
- [createSlice()](https://redux-toolkit.js.org/api/createSlice)：
  - `reducer function`のオブジェクト、slice名、初期状態値を受け取り、対応する`action creators`と`action type`を持つ`slice reducer`を自動生成する。
- [createAsyncThunk](https://redux-toolkit.js.org/api/createAsyncThunk):
  - `action type` 文字列とpromiseを返す関数を受け取り、そのpromiseに基づいて`pending/fulfilled/rejected`の`action type`をディスパッチする`thunk`を生成する
- [createEntityAdapter](https://redux-toolkit.js.org/api/createEntityAdapter): 
  - storeで正規化されたデータを管理するための再利用可能なreducersとselectorsのセットを生成する
- [Reselectライブラリ](https://github.com/reduxjs/reselect)の[`createSelector`](https://redux-toolkit.js.org/api/createSelector) ユーティリティを、使いやすいようにre-exportedしている

### [RTK Query](https://redux-toolkit.js.org/rtk-query/overview)

### [セレクタを使ったデータの導出](https://redux.js.org/usage/deriving-data-selectors)
- データを引き出すためのロジックは、通常セレクタと呼ばれる関数として記述される。
- セレクタは状態から特定の値を調べるロジックや、実際に値を導き出すロジックをカプセル化し、不要な再計算を回避してパフォーマンスを向上させるために使用する
