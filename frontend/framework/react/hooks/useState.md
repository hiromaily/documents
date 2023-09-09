# useState

- 状態を扱うための Hook で、コンポーネント内で state 管理ができる
- useState()で 1 つの新しい状態を作成する
- local で使われる
- `const [状態, 更新関数] = useState(初期値)`

## オブジェクトの取り扱い

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

## 配列の取り扱い

- 更新の方法に注意が必要
- TODO: 自分で確認

```tsx
const [items, setItems] = useState([{ name: "Bob" }]);

const addItem = (name: string) => {
  // items.push({name: name}) //これでは再レンダリングが発生しない
  setItems([...items, [{ name: name }]]);
};

const deleteItem = (index) => {
  // items.splice(index, 1); //これでは再レンダリングが発生しない
  setItems(items.filter((_, i) => i !== index));
};
```

## state は 1 つのオブジェクトでまとめて管理すべきか、個別に管理すべきか

- state 同士が依存していたり、まとめた方が管理しやすい状況であれば、state を 1 つのオブジェクトにまとめて管理する
- 関連性によってグルーピング化する

## Example

- 以下は state が更新されると、再レンダリングが走る

```tsx
import React, { useState } from "react";

const Counter = () => {
  const [count, setCount] = useState(0);
  const [open, setOpen] = useState(true);
  // toggleの関数を宣言
  const toggle = () => setOpen(!open);

  return (
    <>
      <button onClick={toggle}>{open ? "close" : "open"}</button>
      <div className={open ? "isOpen" : "isClose"}>
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
