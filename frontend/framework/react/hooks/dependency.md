# Injecting Hook Dependencies
[Injecting Hooks Into React Components](https://careers.wolt.com/en/blog/engineering/injecting-hooks-into-react-components)

## hook dependenciesをReactコンポーネントに注入する方法は以下の3つ
- passing in props
- binding parameters in a function closure,
- retrieving them from a React context

## Passing Hooks in Props
- Hookをインポートする代わりに、propsで渡すことも可能
- しかし、Hookのルールに注意し、Hookの呼び出し順序を変えないようにしなければならない
- また、propsの中でHookを渡すことは、ある人からは無作法とみなされるかもしれない

```tsx
import React from 'react';

import { Child } from 'components/Child';
import { useFoo } from 'hooks/useFoo';

export const Parent = () => {
  return (
    <div>
      <Child useFoo={useFoo} />
    </div>
  );
};

interface Props {
  useFoo: () => string;
}

export const Child = ({ useFoo }: Props) => {
  const foo = useFoo();
  return <div>Foo: {foo}</div>;
};
```

- 原理的には、親コンポーネント内でHookの実装を提供することも可能
```tsx
import React from "react";

import { Child } from "components/Child";

interface Props {
  useBar: () => string;
  useBaz: () => string;
}

export const Parent = ({ useBar, useBaz }: Props) => {
  // inline definition for useFoo
  const useFoo = () => {
    const bar = useBar();
    const baz = useBaz();

    return `${bar} ${baz}`;
  };
  return (
    <div>
      <Child useFoo={useFoo} />
    </div>
  );
};
```

- propに渡されたフックの定義をインラインで提供することは、Hookのルールを破るものではないが、`useFoo`を `useCallback`でラップしない限り、Childが不必要に再レンダリングする可能性がある。しかし、ESLintはこれに対して正当な警告を示す
```sh
React Hook "useBar" cannot be called inside a callback. React Hooks must be called in a React function component or a custom React Hook function. 
```

- インライン化されたHookをHook作成関数に展開し、その結果をメモ化することで、この問題を回避することは可能
```tsx
import React, { useMemo } from "react";

import { Child } from "./components/Child";

interface Props {
  useBar: () => string;
  useBaz: () => string;
}

// hook creator/factory
const createUseFoo =
  ({ useBar, useBaz }: Pick<Props, "useBar" | "useBaz">) =>
  () => {
    const bar = useBar();
    const baz = useBaz();

    return `${bar} ${baz}`;
  };
```

- しかし、Hook Factoryを使うと、ESLintはフックのルールを破ること、例えば条件付きでHookを呼び出すことから守ってくれなくなる。次のコードは`useFooWithParam`を条件付きで呼び出している。
```tsx
const createUseFoo =
 ({ useBar, useFooWithParam }: Pick<Props, "useBar" | "useFooWithParam">) =>
 () => {
   const bar = useBar();
   // Calling useFooWithParam conditionally changes the hook call order
   return bar ? useFooWithParam(bar) : "";
 };
``` 

## Currying Hook Parameters: Hookパラメータのカリー化
コードが冗長化するため、割愛

## Passing Hooks Through Context
- Context経由でHookを提供する
- [react-facade](https://github.com/garbles/react-facade)を使うことでProxy機能により可読性と利便性が高まる

```ts
import { createFacade } from "react-facade";

type Hooks = {
  useFoo: () => string;
};

export const [hooks, ImplementationProvider] = createFacade<Hooks>();
```
```tsx
import React from "react";
import { hooks } from "./facade";

export const Child = () => {
  const foo = hooks.usefoo();
  return <div>Foo: {foo}</div>;
};
```

- `ImplementationProvider`を使用して、ファサード用のHook実装を提供する必要がある
- 複数のコンポーネントがファサードを共有することも、アプリ全体を共有することもできるが、ファサードを共有することで、コンポーネントでフックの型を指定する利点の一部が失われる

