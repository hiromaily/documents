# Test

- React の Test
  - [React Testing Overview](https://legacy.reactjs.org/docs/testing.html)
  - [React Test Utilities](https://legacy.reactjs.org/docs/test-utils.html)
    - 以下に示す React Testing Library のほうを推奨
  - [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)
  - [Testing Recipes](https://reactjs.org/docs/testing-recipes.html)
  - [Testing Environments](https://reactjs.org/docs/testing-environments.html)
- [Jest](https://jestjs.io/docs/getting-started)

## Basic Structure

- E2E Test
- Integration Test
- Unit Test

## [React Test Utilities](https://ja.reactjs.org/docs/test-utils.html)

- これはすでに更新が止まっているので注意

## Test 環境で、fetch を使って`ReferenceError: fetch is not defined`エラーがでるケース

[cross-fetch](https://www.npmjs.com/package/cross-fetch)を使って解消する

```js
import { render, screen } from '@testing-library/react';
import 'cross-fetch/polyfill';
```
