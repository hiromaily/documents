# カスタムフックと useDebugValue

- `useDebugValue`は`React Developer Tools`と連携して機能するもので、カスタムフックのデバッグ情報をプリントアウトするために使用され、開発ツールにフックの値を記録できるようになる。
- Hook を使用する関数を新たに定義して、それを関数コンポーネントのトップレベルで呼び出すことができる
- このような関数を実装することで、複数の Hook を組み合わせたカスタムフックを実装できる
- 慣習的に`use`から始まる名前にする
- 同じカスタムフックを使っても state は別々

## Example

```tsx
import React, { useState, useCallback, useDebugValue } from "react";

// input向けにコールバックと現在の入力内容をまとめたフック
const useInput = () => {
  // 現在の入力値を保持するフック
  const [state, setState] = useState("");
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
