# React Hooks

- ただの関数
- これにより、React の機能を、クラスを書かずに関数コンポーネントで使えるようになる
- ロジックの分離ができるので、ロジックの再利用やテストがしやすい
- コンポーネントのトップレベルで call する
- Hook の中で Hook を呼び出すこともできる

## Rules of Hooks

- [Rules of Hooks](https://reactjs.org/docs/hooks-rules.html)

- Only Call Hooks at the Top Level
  - Don’t call Hooks inside loops, conditions, or nested functions
- Only Call Hooks from React Functions
  - Don’t call Hooks from regular JavaScript functions

## useState

- 状態を扱うための Hook で、コンポーネント内で state 管理ができる
- useState()で 1 つの新しい状態を作成する
- local で使われる
- `const [状態, 更新関数] = useState(初期値)`

### オブジェクトの取り扱い

- 以下のように更新しないと、Object.is による比較で同一と見なされ、再レンダリングされない
- TODO: 自分で確認

```tsx
const [vote, setVote] = useState({ teamA: 0, teamB: 0});

const voteTeamA = () {
  setVote({...vote, vote.teamA + 1});
}

const voteTeamB = () {
  setVote({...vote, vote.teamB + 1});
}
```

### 配列の取り扱い

- 更新の方法に注意が必要
- TODO: 自分で確認

```tsx
const [items, setItems] = useState([{ name: 'Bob' }]);

const addItem = (name: string) => {
  // items.push({name: name}) //これでは再レンダリングが発生しない
  setItems([...items, [{ name: name }]]);
};

const deleteItem = (index) => {
  // items.splice(index, 1); //これでは再レンダリングが発生しない
  setItems(items.filter((_, i) => i !== index));
};
```

### state は 1 つのオブジェクトでまとめて管理すべきか、個別に管理すべきか

- state 同士が依存していたり、まとめた方が管理しやすい状況であれば、state を 1 つのオブジェクトにまとめて管理する
- 関連性によってグルーピング化する

### Example

- 以下は state が更新されると、再レンダリングが走る

```tsx
import React, { useState } from 'react';

const Counter = () => {
  const [count, setCount] = useState(0);
  const [open, setOpen] = useState(true);
  // toggleの関数を宣言
  const toggle = () => setOpen(!open);

  return (
    <>
      <button onClick={toggle}>{open ? 'close' : 'open'}</button>
      <div className={open ? 'isOpen' : 'isClose'}>
        <p>現在の数字は{count}です</p>
        {/* setCount()は、countを更新するための関数。countを引数で受け取ることも出来る */}
        <button onClick={() => setCount((prevState) => prevState + 1)}>
          + 1
        </button>
        <button onClick={() => setCount(count - 1)}>- 1</button>
        <button onClick={() => setCount(count + 1)}>+ 1</button>
      </div>
    </>
  );
};

export default Counter;
```

## useReducer

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

### useReducer と useState の使い分け

- `useReducer`の場合、複雑な state を管理しやすくなる
  - state の更新ロジックが reducer に集約される
  - コンポーネントに w 足す state 関数が dispatch だけになる
  - dispatch の同一性が保たれる
    - コンポーネントを再レンダリングしても、dispatch は発生しないため、メモ化したコンポーネントにそのまま dispatch を渡すことができる
    - 尚、通常の関数は再レンダリングする度に再生成される(useCallback で関数をラップする必要がある)

### Example

```tsx
import { useReducer } from 'react';

// reducerが受け取るactionの型を定義する
type Action = 'DECREMENT' | 'INCREMENT' | 'DOUBLE' | 'RESET';

// 現在の状態とactionにもとづいて次の状態を返す
const reducer = (currentCount: number, action: Action) => {
  switch (action) {
    case 'INCREMENT':
      return currentCount + 1;
    case 'DECREMENT':
      return currentCount - 1;
    case 'DOUBLE':
      return currentCount * 2;
    case 'RESET':
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
      <button onClick={() => dispatch('DECREMENT')}>-</button>
      <button onClick={() => dispatch('INCREMENT')}>+</button>
      <button onClick={() => dispatch('DOUBLE')}>×2</button>
      <button onClick={() => dispatch('RESET')}>Reset</button>
    </div>
  );
};

export default Counter;
```

## React のコンポーネントの再描画

- React のコンポーネントは次のタイミングで再描画が発生する
  - props や内部状態が更新された時
  - コンポーネント内で参照している Context の値が更新された時
  - 親コンポーネントが再描画された時

## useCallback

- メモ化(ある関数の計算結果を保持し、同一の呼出があった場合は保持しておいた結果を返すといった計算結果を再利用する手法)用の Hook の 1 つ
- `useCallback`は`関数`をメモ化するためのフック
- `useCallback(コールバック関数, 依存配列)`
  - 依存している値がない場合は、`[]`をセット
- `useCallback`は`React.memo`と併用するもの

### React.memo

- `コンポーネント`のレンダリング結果をメモ化する React の API
- 以下のようなコンポーネントでは効果が表れやすい。全てにやる必要はない。
  - レンダリングコストが高いコンポーネント
  - 頻繁に再レンダリングが発生するコンポーネントの Child コンポーネント
- `React.memo(関数コンポーネント);`
- しかし、コールバック関数を Props として受け取ったコンポーネントは再レンダリングされる。
  - これを防ぐために、関数を`useCallback`でメモ化する必要がある
- 関数コンポーネント内で`React.memo`を利用してもメモ化はできない

### Example

```tsx
import React, { useState, useCallback } from 'react';

type ButtonProps = {
  onClick: () => void;
};

// DecrementButtonは通常の関数コンポーネントでボタンを表示する
const DecrementButton = (props: ButtonProps) => {
  const { onClick } = props;

  console.log('DecrementButtonが再描画されました');

  return <button onClick={onClick}>Decrement</button>;
};

// IncrementButtonはメモ化した関数コンポーネントでボタンを表示する
const IncrementButton = React.memo((props: ButtonProps) => {
  const { onClick } = props;

  console.log('IncrementButtonが再描画されました');

  return <button onClick={onClick}>Increment</button>;
});

// DoubleButtonはメモ化した関数コンポーネントでボタンを表示する
const DoubleButton = React.memo((props: ButtonProps) => {
  const { onClick } = props;

  console.log('DoubleButtonが再描画されました');

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

## useMemo

- `useMemo`は`値`をメモ化するためのフック
- `useMemo(() => 値を計算するロジック, 依存配列);`
  - useMemo(関数, 依存配列)となるので、useCallback と同じ挙動をするように感じる
- `useMemo`はレンダリング結果のメモ化もできるため、`React.memo`と同じ使い方ができる
- 注意すべきは、useMemo, useCallback ともに、メモ化をする処理自体にコストがかかるため、シンプルな計算ロジックまでメモ化する必要はない

### Example

```tsx
import React, { useState, useMemo } from 'react';

const UseMemoSample = () => {
  // textは現在のテキストボックスの中身の値を保持する
  const [text, setText] = useState('');
  // itemsは文字列のリストを保持する
  const [items, setItems] = useState<string[]>([]);

  const onChangeInput = (e: React.ChangeEvent<HTMLInputElement>) => {
    setText(e.target.value);
  };

  // ボタンをクリックした時に呼ばれる関数
  const onClickButton = () => {
    setItems((prevItems) => {
      // 現在の入力値をitemsに追加する、この時新しい配列を作成して保存する
      return [...prevItems, text];
    });
    // テキストボックスの中の値を空にする
    setText('');
  };

  // numberOfCharacters1は再描画の度にitems.reduceを実行して結果を得る
  const numberOfCharacters1 = items.reduce((sub, item) => sub + item.length, 0);
  // numberOfCharacters2はuseMemoを使い、itemsが更新されるタイミングでitems.reduceを実行して結果を得る
  const numberOfCharacters2 = useMemo(() => {
    return items.reduce((sub, item) => sub + item.length, 0);
    // 第2引数の配列の中にitemsがあるので、itemsが新しくなった時だけ関数を実行してメモを更新します
  }, [items]);

  return (
    <div>
      <p>UseMemoSample</p>
      <div>
        <input value={text} onChange={onChangeInput} />
        <button onClick={onClickButton}>Add</button>
      </div>
      <div>
        {items.map((item, index) => (
          <p key={index}>{item}</p>
        ))}
      </div>
      <div>
        <p>Total Number of Characters 1: {numberOfCharacters1}</p>
        <p>Total Number of Characters 2: {numberOfCharacters2}</p>
      </div>
    </div>
  );
};

export default UseMemoSample;
```

## useEffect

- ある値が変わった時に限り、ある処理を実行する 機能
- `useEffect( 実行する関数(副作用), [依存する配列])`
- コンポーネントに`副作用`(コンポーネントの描画とは関係がない処理)を追加するための Hook
  - 副作用の例は、`APIとの通信`, `非同期処理`, `console.log` など
- `componentDidMount`、`componentDidUpdate`、`componentWillUnmount` ライフサイクルメソッドを統合したもの
- `props`や`state`が更新され、再描画が終わった後に処理が実行される。
- 依存配列を指定することで、特定のデータが変化した時だけ処理を行うように設定できる

### 依存配列によって、副作用が実行されるタイミングは異なる

1. コンポーネントがレンダリングされる度に副作用を実行する

```tsx
// 第2引数に何も渡さない
useEffect(() => {
  console.log('conpleted render');
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

3. 副作用を一度だけ実行させる
   - e.g. 外部 API からデータを取得する

```tsx
// 第2引数に空の配列を渡す
useEffect(() => {
  console.log('conpleted render');
}, []);
```

4. コンポーネントがアンマウント、もしくは副作用が再実行した時に実行される
   - TODO: 自分で確認
   - [sample code](https://codesandbox.io/s/04-useeffectdekurinatuputaimawoxuechusuruchuliwoshixingsaseru-gygtc)

```tsx
useEffect(() => {
  // 関数を返す
  return () => {
    console.log('cleanup');
  };
}, []);
```

### Example

```tsx
import { useState, useEffect } from 'react';

// タイマーが呼び出される周期を1秒にする
const UPDATE_CYCLE = 1000;

// localstorageで使用するキー
const KEY_LOCALE = 'KEY_LOCALE';

enum Locale {
  US = 'en-US',
  JP = 'ja-JP',
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

## useLayoutEffect

- DOM が更新された後、画面に実際に描画される前に実行される

### Example

```tsx
import { useState, useEffect, useLayoutEffect } from 'react';

// タイマーが呼び出される周期を1秒にする
const UPDATE_CYCLE = 1000;

// localstorageで使用するキー
const KEY_LOCALE = 'KEY_LOCALE';

enum Locale {
  US = 'en-US',
  JP = 'ja-JP',
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

  // useEffectからuseLayoutEffectに変更
  useLayoutEffect(() => {
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

## useContext

- `Context`の`Provider`から値を参照するための Hook
- つまり、`Context`と併用するための Hook

### Example

```tsx
import React, { useContext } from 'react';

type User = {
  id: number;
  name: string;
};

// ユーザーデータを保持するContextを作成する
const UserContext = React.createContext<User | null>(null);

const GrandChild = () => {
  // useContextにContextを渡すことで、Contextから値を取得する
  const user = useContext(UserContext);

  return user !== null ? <p>Hello, {user.name}</p> : null;
};

const Child = () => {
  const now = new Date();

  return (
    <div>
      <p>Current: {now.toLocaleString()}</p>
      <GrandChild />
    </div>
  );
};

const Parent = () => {
  const user: User = {
    id: 1,
    name: 'Alice',
  };
  return (
    // Contextに値を渡す
    <UserContext.Provider value={user}>
      <Child />
    </UserContext.Provider>
  );
};

export default Parent;
```

## useRef

- 書き換え可能な`ref`オブジェクト(React.createRef の戻り値)を作成する
- `ref`の機能は、
- 1. `データの保持`
  - `ref`オブジェクトに保存された値は更新しても、再描画が発生しないため、描画に関係ないデータをコンポーネント内で保持するのに使われる
  - データは`ref.current`から read/write できる
- 2. `DOMの参照`
  - `ref`をコンポーネントに渡すと、この要素がマウントされた時、`ref.current`に DOM の参照がセットされ、DOM の関数などを呼び出すことができる

```tsx
const count useRef(0);
console.log(count.current);
count.current = count.current + 1; // 更新
```

### Example

```tsx
import React, { useState, useRef } from 'react'

const sleep = (ms: number) => new Promise((resolve) => setTimeout(resolve, ms))

const UPLOAD_DELAY = 5000

const ImageUploader = () => {
  // 隠されたinput要素にアクセスするためのref
  const inputImageRef = useRef<HTMLInputElement | null>(null)
  // 選択されたファイルデータを保持するref
  const fileRef = useRef<File | null>(null)
  const [message, setMessage] = useState<string | null>('')

  // 「画像をアップロード」というテキストがクリックされた時のコールバック
  const onClickText = () => {
    if (inputImageRef.current !== null) {
      // inputのDOMにアクセスして、クリックイベントを発火する
      inputImageRef.current.click()
    }
  }
  // ファイルが選択された後に呼ばれるコールバック
  const onChangeImage = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files
    if (files !== null && files.length > 0) {
      // fileRef.currentに値を保存する。
      // fileRef.currentが変化しても再描画は発生しない
      fileRef.current = files[0]
    }
  }
  // アップロードボタンがクリックされた時に呼ばれるコールバック
  const onClickUpload = async () => {
    if (fileRef.current !== null) {
      // 通常はここでAPIを呼んで、ファイルをサーバーにアップロードする
      // ここでは擬似的に一定時間待つ
      await sleep(UPLOAD_DELAY)
      // アップロードが成功した旨を表示するために、メッセージを書き換える
      setMessage(`${fileRef.current.name} has been successfully uploaded`)
    }
  }

  return (
    <div>
      <p style={{ textDecoration: 'underline' }} onClick={onClickText}>
        画像をアップロード
      </p>
      <input
        ref={inputImageRef} {/* inputImageRef がこのタイミングで参照される */}
        type="file"
        accept="image/*"
        onChange={onChangeImage}
        style={{ visibility: 'hidden' }}
      />
      <br />
      <button onClick={onClickUpload}>アップロードする</button>
      {message !== null && <p>{message}</p>}
    </div>
  )
}

export default ImageUploader
```

## useImperativeHandle

- コンポーネントに`ref`が渡された時に、親の`ref`に代入される値を設定する
- これにより、child コンポーネントが持つデータを参照したり、child コンポーネントで定義されている関数を親から読んだりできる

### Example

```tsx
import React, { useState, useRef, useImperativeHandle } from 'react';

const Child = React.forwardRef((props, ref) => {
  const [message, setMessage] = useState<string | null>(null);

  // useImperativeHandleで親のrefから参照できる値を指定
  useImperativeHandle(ref, () => ({
    showMessage: () => {
      const date = new Date();
      const message = `Hello, it's ${date.toLocaleString()} now`;
      setMessage(message);
    },
  }));

  return <div>{message !== null ? <p>{message}</p> : null}</div>;
});

const Parent = () => {
  const childRef = useRef<{ showMessage: () => void }>(null);
  const onClick = () => {
    if (childRef.current !== null) {
      // 子のuseImperativeHandleで指定した値を参照
      childRef.current.showMessage();
    }
  };

  return (
    <div>
      <button onClick={onClick}>Show Message</button>
      <Child ref={childRef} />
    </div>
  );
};

export default Parent;
```

## カスタムフックと useDebugValue

- `useDebugValue`は`React Developer Tools`と連携して機能するもので、カスタムフックのデバッグ情報をプリントアウトするために使用され、開発ツールにフックの値を記録できるようになる。
- Hook を使用する関数を新たに定義して、それを関数コンポーネントのトップレベルで呼び出すことができる
- このような関数を実装することで、複数の Hook を組み合わせたカスタムフックを実装できる
- 慣習的に`use`から始まる名前にする
- 同じカスタムフックを使っても state は別々

### Example

```tsx
import React, { useState, useCallback, useDebugValue } from 'react';

// input向けにコールバックと現在の入力内容をまとめたフック
const useInput = () => {
  // 現在の入力値を保持するフック
  const [state, setState] = useState('');
  // inputが変化したら、フック内の状態を更新する
  const onChange = useCallback((e: React.ChangeEvent<HTMLInputElement>) => {
    setState(e.target.value);
  }, []);

  // デバッグ用に値を出力する
  // 値は開発者ツールのComponentsタブに表示される
  useDebugValue(`Input: ${state}`);

  // 現在の入力内容とコールバック関数だけ返す
  return [state, onChange] as const;
};

const Input = () => {
  const [text, onChangeText] = useInput();
  return (
    <div>
      <input type="text" value={text} onChange={onChangeText} />
      <p>Input: {text}</p>
    </div>
  );
};

export default Input;
```