# Setting for Next.js

- [Next.js Testing](https://nextjs.org/docs/testing)
- [github example](https://github.com/vercel/next.js/tree/canary/examples/with-jest)

- `next/jest`を使う場合、`ts-jest` や `@types/jest`は不要となる

```js
const nextJest = require('next/jest');

const createJestConfig = nextJest({
  // includes `next.config.js` and `.env` for test
  dir: './',
});

// Jest custom settings
const customJestConfig = {
  testEnvironment: 'jest-environment-jsdom',
};

module.exports = createJestConfig(customJestConfig);
```

- `next/jest` プラグインを`jest.config.js`で使うことにより
  - transform の記載が不要
  - css/scss ファイル/画像ファイルのモック化が自動で行われる
