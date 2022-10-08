# [Test](https://reactjs.org/docs/testing.html)

- [React Test Utilities](https://reactjs.org/docs/test-utils.html)/[React Test Utilities (ja)](https://ja.reactjs.org/docs/test-utils.html)
- [Testing Recipes](https://reactjs.org/docs/testing-recipes.html)/[Testingレシピ](https://ja.reactjs.org/docs/testing-recipes.html)
- [Testing Environments](https://reactjs.org/docs/testing-environments.html)/[テスト環境](https://ja.reactjs.org/docs/testing-environments.html)

- [Jest](https://jestjs.io/docs/getting-started)
- [React Testing Library](https://testing-library.com/)

## Basic Structure
- E2E Test
- Integration Test
- Unit Test

## [React Test Utilities](https://ja.reactjs.org/docs/test-utils.html)
### act()
- UI テストを記述する際、レンダー、ユーザイベント、データの取得といったタスクはユーザインターフェースへのインタラクションの「ユニット (unit)」
- `react-dom/test-utils` の `act()` というヘルパーは、あなたが何らかのアサーションを行う前に、これらの「ユニット」に関連する更新がすべて処理され、DOM に反映されていることを保証する
```tsx
import { act } from 'react-dom/test-utils';
...
it('can render and update a counter', () => {
  // Test first render and componentDidMount
  act(() => {
    ReactDOM.createRoot(container).render(<Counter />);
  });
...
```

## Jest with Typescript
```
npm install --save-dev jest @types/jest ts-jest
npm install --save-dev jest-environment-jsdom
npm install --save-dev eslint-plugin-jest eslint-plugin-jest-dom
```

## React Testing Library
Componentのtestを行うためのライブラリ


```
npm install --save-dev @testing-library/react @testing-library/jest-dom @testing-library/user-event
npm install --save-dev eslint-plugin-testing-library
```

### APIs
- Core API
  - [Query](https://testing-library.com/docs/queries/about)
    - ByRole
      - `role`属性を利用して要素を検索する
      - `role`については[ARIA attributes in HTML](https://www.w3.org/TR/html-aria/#docconformance)で確認ができる
    - ByLabelText
    - ByPlaceholderText
    - ByText
      - 要素内のtextで検索する
    - ByDisplayValue
    - ByAltText
    - ByTitle
    - ByTestId
  - User Action
    - [Firing Events](https://testing-library.com/docs/dom-testing-library/api-events)
    - Async Methods
    - Appearance and Disappearance
    - Considerations for fireEvent
    - Using Fake Timers
  - Advanced
    - Accessibility
    - Custom Queries
    - Debugging
      - `screen.debug()`にてrender結果を確認できる
    - Querying Within Elements
    - Configuration Options

### getByとqueryBy, findByの違い
- `getBy` : 要素かエラーを返す
- `queryBy` : 存在しない要素のアサーションを行うために使用する
- `findBy` : 非同期要素によって生成される要素に対して使用する
```ts
expect(await screen.findByText(/Signed in as/)).toBeInTheDocument();
```

### HookのTestについて
- [React 18 で Custom Hooks のテストを書くときの注意点](https://zenn.dev/k_kazukiiiiii/articles/9f48bdd20435d2)
- [eact-hooks-testing-library](https://github.com/testing-library/react-hooks-testing-library)
- `@testing-library/react-hooks`はReact@18.xで動かないため、`@testing-library/react`を使用する

### Act()
- `react-dom/test-utils`にある`act()`は、`@testing-library`でも利用可能(こちらが推奨されている)
```tsx
import { renderHook, act, waitFor } from '@testing-library/react'
...
  test('something works', async () => {
    act(() => {
      // do something
    });
...
```

### [waitFor()](https://testing-library.com/docs/dom-testing-library/api-async#waitfor)
- Stateの変更など、しばらく待つ必要がある場合は、 `waitFor`を使用して、期待値がセットされるのを待つことができる
- waitForのタイムアウトに達するまで、何度もコールバックを実行できる
- `interval` オプションによって調整が可能
- デフォルトの`interval`は`50ms`
- デフォルトの`timeout`は`1000ms`

## Setting for Next.js
- [Next.js Testing](https://nextjs.org/docs/testing)
- [github example](https://github.com/vercel/next.js/tree/canary/examples/with-jest)

- `next/jest`を使う場合、`ts-jest` や `@types/jest`は不要となる
```js
const nextJest = require("next/jest");

const createJestConfig = nextJest({
  // includes `next.config.js` and `.env` for test
  dir: "./",
});

// Jest custom settings
const customJestConfig = {
  testEnvironment: "jest-environment-jsdom",
};

module.exports = createJestConfig(customJestConfig);
```

- `next/jest` プラグインを`jest.config.js`で使うことにより
  - transform の記載が不要
  - css/scss ファイル/画像ファイルのモック化が自動で行われる
  - 


## その他 References
- [React + Testing Library + Jestの覚書 (2022)](https://zenn.dev/nus3/articles/jest-react-testing-library)
- [Next.js 12でJestの設定がかなり楽になった](https://zenn.dev/miruoon_892/articles/e42e64fbb55137)
- [Jestのモックパターン](https://zenn.dev/technote/articles/jest-mock-patterns)
