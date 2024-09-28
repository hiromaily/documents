# Mock Service Worker (MSW)

- Service Worker API を使った Mocking ライブラリで、実際のリクエストをインターセプトする

## References

- [Official](https://mswjs.io/)
- [Docs](https://mswjs.io/docs/getting-started/install)
- [github](https://github.com/mswjs/msw): Star: 10.5K, 2018/11 created
- [github:example](https://github.com/mswjs/examples)
  - [nextjs example](https://github.com/vercel/next.js/tree/canary/examples/with-msw)
- Others
  - [How to Mock API Requests in Front-End Development?](https://www.codit.eu/blog/how-to-mock-api-requests-in-front-end-development/)

## 特徴

- Service Worker API を使用して実際のリクエストをインターセプトする API mock ライブラリ
- mock サーバ用のプロセスを別で立てる必要がない
- `DevTools`の`Network`タブから、モックの動作確認ができる
- `REST`や`GraphQL`の API に対応

## 動作していることの確認

ブラウザの console に以下のメッセージ表示される

```log
> [MSW] Mocking enabled
```

## Jest を使った Unittest 内での利用について

- [integrate/node](https://mswjs.io/docs/getting-started/integrate/node)
- Test 時には、test runner として Jest を利用している
- [Direct usage](https://mswjs.io/docs/getting-started/integrate/node#direct-usage)にある通り、
  - Jest の jsdom のような DOM のような環境がない場合、`NodeJS では絶対リクエスト URL を使用する必要がある`ことに注意してください。これはリクエスト ハンドラーに反映される必要があります。

```js
export const server = setupServer(
  // NOT "/user", nothing to be relative to!
  rest.get('https://api.backend.dev/user', (req, res, ctx) => {
    return res(ctx.json({ firstName: 'John' }));
  })
);
```

```js
// src/setupTests.js
import { server } from './mocks/server.js';

// Establish API mocking before all tests.
beforeAll(() => server.listen());

// Reset any request handlers that we may add during the tests,
// so they don't affect other tests.
afterEach(() => server.resetHandlers());

// Clean up after the tests are finished.
afterAll(() => server.close());
```

## 不具合

### Next.js 13 の App directory で動かない問題

- [Support Next.js 13 (App directory)](https://github.com/mswjs/msw/issues/1644)

### Next.js を使った場合における問題 (Node.js 関連)

Next.js の[example](https://github.com/vercel/next.js/tree/canary/examples/with-msw)でも再現するが、以下のエラーが発生する

```log
error - unhandledRejection: Error [ERR_UNSUPPORTED_DIR_IMPORT]: Directory import '/Users/user/github.com/repo/path/node_modules/@mswjs/interceptors/lib/interceptors/ClientRequest' is not supported resolving ES modules imported from /Users/user/github.com/repo/path/node_modules/msw/lib/node/index.mjs
Did you mean to import @mswjs/interceptors/lib/interceptors/ClientRequest/index.js?
    at new NodeError (node:internal/errors:387:5)
    at finalizeResolution (node:internal/modules/esm/resolve:400:17)
    at moduleResolve (node:internal/modules/esm/resolve:965:10)
    at defaultResolve (node:internal/modules/esm/resolve:1173:11)
    at nextResolve (node:internal/modules/esm/loader:173:28)
    at ESMLoader.resolve (node:internal/modules/esm/loader:852:30)
    at ESMLoader.getModuleJob (node:internal/modules/esm/loader:439:18)
    at ModuleWrap.<anonymous> (node:internal/modules/esm/module_job:76:40)
    at link (node:internal/modules/esm/module_job:75:36) {
  code: 'ERR_UNSUPPORTED_DIR_IMPORT',
  url: 'file:///Users/user/github.com/repo/path/node_modules/@mswjs/interceptors/lib/interceptors/ClientRequest'
```

これは、既知の問題で issue にもあがっており、今後修正されると思われる（2022/10/1 現在)

- [Can't resolve '@mswjs/interceptors/lib/interceptors/ClientRequest'](https://github.com/mswjs/msw/issues/1267)
- [Directory import is not supported resolving ES modules](https://github.com/mswjs/msw/issues/1201)
  - `There is no support for ESM right now`
- [ESM support + treeshaking unused bits](https://github.com/mswjs/msw/issues/1384)
- [Stackoverflow: 'Directory import is not supported resolving ES modules' with Node.js](['Directory import is not supported resolving ES modules' with Node.js](https://stackoverflow.com/questions/64453859/directory-import-is-not-supported-resolving-es-modules-with-node-js))
  - ES6 modules では、ディレクトリの import ができないとある。つまり、具体的なファイル名まで指定する必要がある。
  - 今回、ファイルの単体読み込みをしてみたが、今後は`Could not find a declaration file for module`というエラーが発生した

#### Workaround

- before

```ts
import { setupServer } from 'msw/node';
import { handlers } from './handlers';

export const server = setupServer(...handlers);
```

- after

```ts
import { handlers } from './handlers';

export const server = require('msw/node').setupServer(...handlers);
```
