# Architecture

- [react-patterns](https://github.com/topics/react-patterns)
- [File Structure](https://reactjs.org/docs/faq-structure.html)
- [React Architecture Patterns for Your Projects](https://blog.openreplay.com/react-architecture-patterns-for-your-projects)
- [React Folder Structure in 5 Steps](https://www.robinwieruch.de/react-folder-structure/)
- [bulletproof-react](https://github.com/alan2207/bulletproof-react)

## Structure

```txt
└── /src
    ├── /assets
    ├── /components
    ├── /context
    ├── /hooks
    ├── /pages
    ├── /services
    ├── /utils
    └── App.js
    ├── index.js
```

- services ... For API
- hooks ... Custom Hooks
- pages ... For UI

## 基本方針

### 絶対パスによる Imports

```jsx
import { Button } from '@components';
```

## UI とビジネス層の分離について

- UI をコンポーネントに定義し、ビジネスロジックを Hooks に定義し、Hooks はビジネスロジックの function 自体をコンポーネントに渡す

コンポーネントと機能の分離

![コンポーネントと機能の分離](https://github.com/hiromaily/documents/raw/main/images/react-ui-business.webp "コンポーネントと機能の分離")

Page, Component, Hook の関係性

![Page, Component, Hook の関係性](https://github.com/hiromaily/documents/raw/main/images/react-ui-business2.webp "Page, Component, Hook の関係性")

Hook からビジネス層に依存するパターン１:抽象への依存を DI で解決する

![抽象への依存を DI で解決する](https://github.com/hiromaily/documents/raw/main/images/react-ui-business3.webp "抽象への依存を DI で解決する")

外部通信発生時のレイヤーの分離

![外部通信発生時のレイヤーの分離](https://github.com/hiromaily/documents/raw/main/images/front-end-layer.png "外部通信発生時のレイヤーの分離")

### ビジネスロジックに Testability を持たすためには

## すべてに対して単一のコンテキストを作成することを避ける

## 再レンダリングの取り扱い

- [5 Ways to Avoid React Component Re-Renderings](https://blog.bitsrc.io/5-ways-to-avoid-react-component-re-renderings-90241e775b8c)
