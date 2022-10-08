# [Test](https://reactjs.org/docs/testing.html)
- [Jest](https://jestjs.io/docs/getting-started)
- [React Testing Library](https://testing-library.com/)


## Basic Structure
- E2E Test
- Integration Test
- Unit Test

## Jest with Typescript
```
npm install --save-dev jest @types/jest ts-jest
npm install --save-dev jest-environment-jsdom
```

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

## React Testing Library
Componentのtestを行うためのライブラリ


```
npm install --save-dev @testing-library/react @testing-library/jest-dom @testing-library/user-event
```


## その他 References
- [React + Testing Library + Jestの覚書 (2022)](https://zenn.dev/nus3/articles/jest-react-testing-library)
- [Next.js 12でJestの設定がかなり楽になった](https://zenn.dev/miruoon_892/articles/e42e64fbb55137)