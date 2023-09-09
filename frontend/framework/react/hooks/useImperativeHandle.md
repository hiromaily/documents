# useImperativeHandle

- コンポーネントに`ref`が渡された時に、親の`ref`に代入される値を設定する
- これにより、child コンポーネントが持つデータを参照したり、child コンポーネントで定義されている関数を親から読んだりできる

## Example

```tsx
import React, { useState, useRef, useImperativeHandle } from "react";

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
