# useMemo

- `useMemo`は`値`をメモ化するためのフック
- `useMemo(() => 値を計算するロジック, 依存配列);`
  - useMemo(関数, 依存配列)となるので、useCallback と同じ挙動をするように感じる
- `useMemo`はレンダリング結果のメモ化もできるため、`React.memo`と同じ使い方ができる
- 注意すべきは、useMemo, useCallback ともに、メモ化をする処理自体にコストがかかるため、シンプルな計算ロジックまでメモ化する必要はない

## React.memo

- `コンポーネント`のレンダリング結果をメモ化する React の API
- 以下のようなコンポーネントでは効果が表れやすい。全てにやる必要はない。
  - レンダリングコストが高いコンポーネント
  - 頻繁に再レンダリングが発生するコンポーネントの Child コンポーネント
- `React.memo(関数コンポーネント);`
- しかし、コールバック関数を Props として受け取ったコンポーネントは再レンダリングされる。
  - これを防ぐために、関数を`useCallback`でメモ化する必要がある
- 関数コンポーネント内で`React.memo`を利用してもメモ化はできない

## Example

```tsx
import React, { useState, useMemo } from "react";

const UseMemoSample = () => {
  // textは現在のテキストボックスの中身の値を保持する
  const [text, setText] = useState("");
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
    setText("");
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
