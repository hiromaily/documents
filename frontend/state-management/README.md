# State Management

- [React の状態管理ライブラリ9選](https://zenn.dev/kazukix/articles/react-state-management-libraries)
  - Redux
    - npm trendでは圧倒的
    - Fluxアーキテクチャー
    - 大規模向け
    - [Redux Toolkit(RTK)](https://redux-toolkit.js.org/)の使用が推奨されている
    - 原則
      - Single source of truth
      - State is read-only
      - Changes are made with pure functions
  - Recoil
    - Metaによって開発されており、Atom, Selectorという概念を持つ
    - Hooksを使用した状態管理を行う
  - Zustand
    - Reduxに近いがHooksを使用した状態管理を行う。
    - 極めて軽量
  - Jotai
  - Valtio
  - Nano stores
  - Hookstate
  - Elf
  - Rematch
- [Reactにおける状態管理の動向を追ってみた](https://zenn.dev/yuki_tu/articles/a7b0a1a90c09f4)
  - 2022年の記事なので少し古い
- [React ステート管理 比較考察](https://blog.uhy.ooo/entry/2021-07-24/react-state-management/)
  - 2021年の記事なので古い

## Principle

- クライアント側に状態を持たせないように設計すべき
- APIで取得した値はすべてキャッシュとして管理
- 認証情報などページをまたぐ必要のあるもの、継続してユーザーに知らせ続けるものはグローバルに状態を管理できるライブライを利用
- ~~見た目の制御もローカルな状態管理である`useState`, `useRef`などもなるべく利用しない~~

## Flux アーキテクチャ

- [Flux](../architecture/flux.md)

## WIP: トップダウン型とボトムアップ型

- [トップダウン型の状態管理 (#Redux #Zustand )と比較して知るボトムアップ型の状態管理 (#Recoil #Jotai )](https://zenn.dev/jotaifriends/articles/d714f9c16c1d3a)

- トップダウン型 ... Redux, Zustand
  - 親のコンポーネントから何かの値が子のコンポーネントへ渡されるこの形をトップダウン
  - useState()やContext APIを使ったflowなど
  - 例えば末端のコンポーネントで扱う必要のあるStateもトップに位置する1つの巨大なState、Store、に含めて扱う
- ボトムアップ型 ... Recoil, Jotai
