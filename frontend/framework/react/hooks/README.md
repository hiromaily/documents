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

## 基本的な Hooks

- [useState](./useState.md)
- [useReducer](./useReducer.md)
- [useCallback](./useCallback.md)
- [useMemo](./useMemo.md)
- [useEffect](./useEffect.md)
- [useLayoutEffect](./useLayoutEffect.md)
- [useContext](./useContext.md)
- [useRef](./useRef.md)
- [useImperativeHandle](./useImperativeHandle.md)
- [useDebugValue](./useDebugValue.md)

## React のコンポーネントの再描画

- React のコンポーネントは次のタイミングで再描画が発生する
  - props や内部状態が更新された時
  - コンポーネント内で参照している Context の値が更新された時
  - 親コンポーネントが再描画された時
