# useEffect

- ある値が変わった時に限り、ある処理を実行する 機能
- `useEffect( 実行する関数(副作用), [依存する配列])`
- コンポーネントに`副作用`(コンポーネントの描画とは関係がない処理)を追加するための Hook
  - 副作用の例は、`APIとの通信`, `非同期処理`, `console.log` など
- `componentDidMount`、`componentDidUpdate`、`componentWillUnmount` ライフサイクルメソッドを統合したもの
- `props`や`state`が更新され、再描画が終わった後に処理が実行される。
- 依存配列を指定することで、特定のデータが変化した時だけ処理を行うように設定できる

## 依存配列によって、副作用が実行されるタイミングは異なる

1. コンポーネントがレンダリングされる度に副作用を実行する

```tsx
// 第2引数に何も渡さない
useEffect(() => {
  console.log("conpleted render");
});
```

2. 副作用が依存する値が更新された時だけ、副作用を実行する
   - e.g. クエリパラメータが更新されたら外部 API からデータを取得する

```tsx
// 第2引数に依存する配列を渡す
useEffect(() => {
  console.log(message);
}, [message]);
```

`このとき、第2引数に依存する配列の中の値がobjectの場合、比較に失敗する可能性があるため、プリミティブな値を渡すこと`

3. 副作用を一度だけ実行させる
   - e.g. 外部 API からデータを取得する

```tsx
// 第2引数に空の配列を渡す
useEffect(() => {
  console.log("conpleted render");
}, []);
```

4. コンポーネントがアンマウント、もしくは副作用が再実行した時に実行される
   - TODO: 自分で確認
   - [sample code](https://codesandbox.io/s/04-useeffectdekurinatuputaimawoxuechusuruchuliwoshixingsaseru-gygtc)

```tsx
useEffect(() => {
  // 関数を返す
  return () => {
    console.log("cleanup");
  };
}, []);
```

## Example

```tsx
import { useState, useEffect } from "react";

// タイマーが呼び出される周期を1秒にする
const UPDATE_CYCLE = 1000;

// localstorageで使用するキー
const KEY_LOCALE = "KEY_LOCALE";

enum Locale {
  US = "en-US",
  JP = "ja-JP",
}

const getLocaleFromString = (text: string) => {
  switch (text) {
    case Locale.US:
      return Locale.US;
    case Locale.JP:
      return Locale.JP;
    default:
      return Locale.US;
  }
};

const Clock = () => {
  const [timestamp, setTimestamp] = useState(new Date());
  const [locale, setLocale] = useState(Locale.US);

  // タイマーのセットをするための副作用
  useEffect(() => {
    // タイマーのセット
    const timer = setInterval(() => {
      setTimestamp(new Date());
    }, UPDATE_CYCLE);

    // クリーンアップ関数を渡し、アンマウント時にタイマーの解除をする
    return () => {
      clearInterval(timer);
    };
    // 初期描画時のみ実行する
  }, []);

  // localstorageから値を読み込むための副作用
  useEffect(() => {
    const savedLocale = localStorage.getItem(KEY_LOCALE);
    if (savedLocale !== null) {
      setLocale(getLocaleFromString(savedLocale));
    }
  }, []);

  // localeが変化した時に、localstorageに値を保存するための副作用
  useEffect(() => {
    localStorage.setItem(KEY_LOCALE, locale);
    // 依存配列にlocaleを渡し、localeが変化する度に実行するようにする
  }, [locale]);

  return (
    <div>
      <p>
        <span id="current-time-label">現在時刻</span>
        <span>:{timestamp.toLocaleString(locale)}</span>
        <select
          value={locale}
          onChange={(e) => setLocale(getLocaleFromString(e.target.value))}
        >
          <option value="en-US">en-US</option>
          <option value="ja-JP">ja-JP</option>
        </select>
      </p>
    </div>
  );
};

export default Clock;
```

## useEffect()で発生する無限 Loop について

- [React の useEffect で無限ループが発生するメカニズムを理解する](https://qiita.com/takano-h/items/11f7b35dbf4844f7565d)

- React のレンダリングの流れは、
  - ユーザー操作 -> 状態の更新 -> 仮想 DOM の更新 -> 差分を実 DOM に反映
- useEffect() は第二引数に入れた パラメータ が前回レンダリング時と比較して「異なる」場合に実行される
- つまり、意図せず「前回と異なる値である」と React に判断されてしまっていることが原因となる
- 無限ループさせないためには、「前回レンダリング時と同じオブジェクトなので、 effect を実行しなくて良い」と useEffect に伝えること
- object の比較はセンシティブのため気をつけること

```tsx
// 1. useMemo
const hoge = useMemo(() => {
  return {};
}, []);

useEffect(() => {
  // 無限ループしない
  setCount((n) => n + 1);
  console.log(hoge);
}, [hoge]);

// 2. useCallback
const fuga = useCallback(() => {
  console.log("fuga");
}, []);

useEffect(() => {
  // 無限ループしない
  setCount((n) => n + 1);
  fuga();
}, [fuga]);

// 3. useState()
const [foo, setFoo] = useState({});

useEffect(() => {
  // 無限ループしない
  setCount((n) => n + 1);
  console.log(foo);
}, [foo]);

// 4. Component function外に設定した定数(中身は{})を設定
useEffect(() => {
  // 無限ループしない
  setCount((n) => n + 1);
  console.log(bar);
}, [bar]);
```

### ありがちな間違い

- [React useEffect で無限ループが発生するときに確認すること](https://zukucode.com/2021/06/react-useeffect-loop.html)

- component function 内に定義された function を依存引数に設定する
  - component が レンダリングされる度に、function は別の object として扱われる
  - そのため、useCallback()などを使って回避するとよい
- component function 内に定義された object を依存引数に設定する
  - オブジェクトの値に変更がなくても、オブジェクトは毎回再生成される
