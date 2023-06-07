# Jotal

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

## Core
- [atom](https://jotai.org/docs/core/atom)
  - atom と呼ばれる最小単にのStateを保持したオブジェクトを生成する。生成には atom というファクトリ関数に初期値を渡して実行する。
- [useAtom](https://jotai.org/docs/core/use-atom)
  - useAtomで`atom`を利用する
- [Store](https://jotai.org/docs/core/store)
- [Provider](https://jotai.org/docs/core/provider)
  - コンポーネント全体でアクセスできる atom を設定する 

## Utilities
- [Storage](https://jotai.org/docs/utilities/storage)
- [SSR](https://jotai.org/docs/utilities/ssr)
- [Async](https://jotai.org/docs/utilities/async)
- [Resettable](https://jotai.org/docs/utilities/resettable)
- [Family](https://jotai.org/docs/utilities/family)

## [Comparison](https://jotai.org/docs/basics/comparison)
以下が比較対象として言及されており(つまり以下とアプローチは違えど目的が同じ)、Recoildの影響も受けている
- useContext + useState
- [use-context-selector](https://github.com/dai-shi/use-context-selector)

`Jotai takes a bottom-up approach with the atomic model, inspired by Recoil.`
とある。

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