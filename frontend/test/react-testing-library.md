# React Testing Library

Component の test を行うためのライブラリ

```
npm install --save-dev @testing-library/react @testing-library/jest-dom @testing-library/user-event
npm install --save-dev eslint-plugin-testing-library
```

## APIs

- Core API
  - [Query](https://testing-library.com/docs/queries/about)
    - ByRole
      - `role`属性を利用して要素を検索する
      - `role`については[ARIA attributes in HTML](https://www.w3.org/TR/html-aria/#docconformance)で確認ができる
    - ByLabelText
    - ByPlaceholderText
    - ByText
      - 要素内の text で検索する
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
      - `screen.debug()`にて render 結果を確認できる
    - Querying Within Elements
    - Configuration Options

## getBy と queryBy, findBy の違い

- `getBy` : 要素かエラーを返す
- `queryBy` : 存在しない要素のアサーションを行うために使用する
- `findBy` : 非同期要素によって生成される要素に対して使用する

```ts
expect(screen.queryByText(/Searches for JavaScript/)).toBeNull();

expect(await screen.findByText(/Signed in as/)).toBeInTheDocument();
```

## [waitFor()](https://testing-library.com/docs/dom-testing-library/api-async#waitfor)

- State の変更など、しばらく待つ必要がある場合は、 `waitFor`を使用して、期待値がセットされるのを待つことができる
- waitFor のタイムアウトに達するまで、何度もコールバックを実行できる
- 非同期で生成される要素であれば、`findBy`のみで取得可能
- `interval` オプションによって調整が可能
- デフォルトの`interval`は`50ms`
- デフォルトの`timeout`は`1000ms`

## act()

- UI テストを記述する際、レンダー、ユーザイベント、データの取得といったタスクはユーザインターフェースへのインタラクションの「ユニット (unit)」
- `react-dom/test-utils` の `act()` というヘルパーは、ユーザーが何らかのアサーションを行う前に、これらの「ユニット」に関連する更新がすべて処理され、DOM に反映されていることを保証する
- `Warning: An update to Counter inside a test was not wrapped in act(...).` というエラーが出ることがある

```tsx
import { act } from '@testing-library/react'
...
it('can render and update a counter', () => {
  // Test first render and componentDidMount
  act(() => {
    ReactDOM.createRoot(container).render(<Counter />);
  });
...
```
