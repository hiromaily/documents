# Rendering

## 再レンダリングが起きる3つのパターン
1. Stateが更新されたコンポーネント
2. Propsが変更されたコンポーネント
3. 再レンダリングされたコンポーネント配下のコンポーネント全て

## 再レンダリングの最適化
- 上記、`3`のパターンで子のコンポーネントは不要な場合でも再レンダリングが発生する可能性がある
- このとき、有効な手段が`メモ化`というレンダリング時の制御を行う手法
- `メモ化`は前回の処理結果を保持しておくことで、処理を高速化する

## コンポーネントのメモ化
- コンポーネントを`memo`でラップする
- これにより、Propsに変更がない限り再レンダリングされない

```tsx
import { memo } from "react";
...
// コンポーネントのメモ化
export const Child1 = memo((props) => {
  console.log("Child1 レンダリング ");

  const { onClickReset } = props;

  return (
    <div style={style}>
      <p>Child1</p>
      <button onClick={onClickReset}>リセット</button>
      <Child2 />
      <Child3 />
    </div>
  );
});
```

## 関数のメモ化 (useCallback)
- 関数をPropsに渡す時にコンポーネントをメモ化していても`関数の再生成`によって再レンダリングが発生する
- これを防ぐために関数をメモ化するために、`useCallback`を適用する
  - 第１引数に関数、第２引数に依存配列を設定する
  - 依存配列が空の場合、最初に作成されたものが使いまわされる

```tsx
import { useState, memo, useCallback } from "react";

export const App = memo(() => {
  // 関数のメモ化
  const onClickReset = useCallback(() => {
    setNum(0);
  }, []);
  
  ...

  return (
    <>
      <button onClick={onClickButton}>ボタン</button>
      <p>{num}</p>
      <Child1 onClickReset={onClickReset} />
      <Child4 />
    </>
  );
});
```

## 変数のmemo化 (useMemo)
- useMemo
  - 第１引数の関数で変数に設定する値の返却、第２引数に依存配列を設定する
  - 変数に設定するロジックが複雑だが、結果が常に変更しない場合に有効

```tsx
const sum = useMemo(() => {
  return 1 + 3;
}, []);
```