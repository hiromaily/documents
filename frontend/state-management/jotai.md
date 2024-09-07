# Jotai

ReactのためのGlobal State管理ライブラリで、React の余分な再レンダリングの問題も解決する

Featuresには、

- Minimal core API (2kb)
- Many utilities and integrations
- TypeScript oriented
- Works with Next.js, Gatsby, Remix, and React Native
- React Fast Refresh with SWC and Babel plugins

## References

- [Official](https://jotai.org/)
- [github](https://github.com/pmndrs/jotai)
  - [examples](https://github.com/pmndrs/jotai/tree/main/examples)
- [You Might Not Need React Query for Jotai](https://blog.axlight.com/posts/you-might-not-need-react-query-for-jotai/)
- [React の状態管理ライブラリ9選](https://zenn.dev/kazukix/articles/react-state-management-libraries)
- [jotaiをさわってみた](https://chaika.hatenablog.com/entry/2023/03/11/073000)
- [jotai Provider](https://chaika.hatenablog.com/entry/2023/03/11/111100)

## [Jotaiの様々なLibrary](https://github.com/jotaijs)

## Core

### [atom](https://jotai.org/docs/core/atom)

- atom functionに初期値を与えて呼び出すことで、`atom config`が生成される
- このconfigがデータを保持するわけではなく、値は`store`に存在する
- atom configはimmutableなobject
- atom同士を組み合わせて、Read/Write属性を追加することができる
  - Read-only atom
  - Write-only atom
  - Read-Write atom
- atomをrender function内で利用する場合、`useMemo`か`useRef`を必要とする (`useAtom`で解決するわけではない)
- atomの持つproperty
  - `debugLabel` ... atomの値を[debbugging](https://jotai.org/docs/guides/debugging)に表示する
  - `onMount` ... atomがprovider内で最初に使われたタイミングで呼び出される

### [useAtom](https://jotai.org/docs/core/use-atom)

- `useAtom` hookはstate内で`atom`を読み込む
- stateは、atom configとatom valueのWeakMapとして見ることができる
- `useState`と同じI/Fを持つので、同じような使い方ができる
- `useAtom`内でもメモ化は必要で、`useMemo`等を使うこと

### [Store](https://jotai.org/docs/core/store)

- `createStore()`によってStoreを作成し、Provider内で使われる
- storeの持つメソッド
  - `get` ... atomのvalueを取得
  - `set` ... atomのvalueをセット
  - `sub` ... atomのvalueの変更ををサブスクライブする
- `getDefaultStore` function
  - providerを使わないでstoreを使う場合、`provider-less mode`と言われる
  - WIP: 重要そうなので詳細調査

### [Provider](https://jotai.org/docs/core/provider)

- コンポーネント全体でアクセスできる atom を設定する
- Providerの利便性
  - 異なるstateをそれぞれのsub treeに提供する
  - atomの初期値を受け入れる
  - 全てのatomのvalueをmountから外れることで全て削除する
- `store` prop ... storeをProviderに渡す

```ts
const Root = () => (
  <Provider store={myStore}>
    <App />
  </Provider>
)
```

- `useStore` hook ... component tree内でstoreを返すためのhook

## Utilities

### [Storage](https://jotai.org/docs/utilities/storage)

#### `atomWithStorage`

- localStorageかsessionStorageを使って永続化された値を持つatomを生成する
- Parameters
  - key: 一意のString (localStorage, sessionStorageへのkeyとも取れる)
  - initialValue: atomへの初期値
  - storage: optionalで以下のメソッドを持つ
    - getItem()
    - setItem()
    - removalItem()
    - subscribe()
- storageオプションを指定しない限り、defaultで`localStorage`が使われる
- Server-side rendering
  - tipsが書かれているのでDocsを読むこと
- Storageの削除
  - `RESET` symbolを値に与える: `setText(RESET)`

### [SSR](https://jotai.org/docs/utilities/ssr)

### [Async](https://jotai.org/docs/utilities/async)

- 全てのatomは非同期読み出しや非同期書き込みをサポートしている
- asyncの使い方は[こちら](https://jotai.org/docs/guides/async)

#### lodable

- 非同期atomのsuspendやerror throwを望まない場合、`lodable` を使う。atomをwrapするのみ。

#### atomWithObservable

- `atomWithObservable` function は `rxjs`の`subject`もしくは`obsrvable`から atomを生成する

### [Resettable](https://jotai.org/docs/utilities/resettable)

### [Family](https://jotai.org/docs/utilities/family)

## Integrations

- tRPC
- URQL
- Immer
- XState
- Location
- Mokecules
- Optics

### [Query](https://jotai.org/docs/integrations/query)

### [Cache](https://jotai.org/docs/integrations/cache)

- [jotai-cache](https://github.com/jotaijs/jotai-cache)
- `atomWithCache`を使う

## Tools

### [SWC](https://jotai.org/docs/tools/swc)

### Babeel

### [Devtools](https://jotai.org/docs/tools/devtools)

## Bacics

### Concepts

### [Comparison](https://jotai.org/docs/basics/comparison)

以下が比較対象として言及されており(つまり以下とアプローチは違えど目的が同じ)、Recoildの影響も受けている

- useContext + useState
- [use-context-selector](https://github.com/dai-shi/use-context-selector)

`Jotai takes a bottom-up approach with the atomic model, inspired by Recoil.`
とある。

### [Showcase](https://jotai.org/docs/basics/showcase) (example)

## Guides

- v2 API migration
- TypeScript
- Gatsby
- Remix
- React Native
- Debugging
- Performance
- Testing
- Composing atoms
- Atoms in atom
- Initializing state on render
- Persistence

### [Next.js](https://jotai.org/docs/guides/nextjs)

### [Core internals](https://jotai.org/docs/guides/core-internals)

## Recipes

### [WIP: Large objects](https://jotai.org/docs/recipes/large-objects)

### Atom creators

### [Custom useAtom hooks](https://jotai.org/docs/recipes/custom-useatom-hooks)

## 使い方サンプル

- atomを定義

```ts
// atoms.ts
import { atom } from 'jotai';

export const input1Atom = atom('');
export const input2Atom = atom('');
export const input3Atom = atom('');
export const input4Atom = atom('');
```

- atomの値を使って計算するfunction

```ts
// centralFunction.ts (これもatom)
import { atom } from 'jotai';
import { input1Atom, input2Atom, input3Atom, input4Atom } from './atoms';

export const centralFunction = atom(
  get => {
    const input1 = get(input1Atom);
    const input2 = get(input2Atom);
    const input3 = get(input3Atom);
    const input4 = get(input4Atom);
    // Perform the desired action using the input values
    console.log(input1, input2, input3, input4);
  }
);
```

- コンポーネント1の例

```tsx
// Component1.tsx
import { useAtom } from 'jotai';
import { input1Atom, centralFunction } from './atoms';

const Component1 = () => {
  const [input1, setInput1] = useAtom(input1Atom);
  const [, triggerCentralFunction] = useAtom(centralFunction);

  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setInput1(event.target.value);
    triggerCentralFunction();
  };

  return <input type="text" value={input1} onChange={handleChange} />;
};

export default Component1;
```

## 既存の`useState`を置き換えるだけで、グローバルなステートにできる

### localStorage/sessionStorage

- ページのリロードや、タブを閉じても保持したいステートがある場合、`localStorage`や`sessionStorage`に保存するのが一般的だが、数値やオブジェクトのステートであっても、自動的に`文字列`に変換されてしまうため、`JSON.parse()`や`JSON.stringify()`によってシリアライズ/デシリアライズしたうえで保存するのが一般的となる

```ts
localStorage.setItem(key, JSON.stringify(value));

const keyValue = localStorage.getItem(key);
const parsed = JSON.parse(keyValue);
```

### `useState`と`useAtom`の比較

```ts
// useState()
const [auth,userAuth] = useState(null)

// jotai useAtom()
const [auth,useAuth] = useAtom('userAuth',null)
```

### 永続化のための`atomWithStorage`

```ts
// useState()
const [auth,userAuth] = useState(null)

// jotai atomWithStorage()
const [auth,useAuth] = atomWithStorage('userAuth',null)
```

- JSONへのシリアライズ/デシリアライズは不要
- デフォルトでは`localStoarge`

- useAtom
- useSetAtom
- atomWithStorage
