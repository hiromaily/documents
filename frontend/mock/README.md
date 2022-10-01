# Mock


## Mock Service Worker (MSW)
API mocking library that uses the Service Worker API to intercept the actual requests.

- [Official](https://mswjs.io/)
- [Docs](https://mswjs.io/docs/getting-started/install)
- [github](https://github.com/mswjs/msw): Star: 10.5K, 2018/11 created
- [github:example](https://github.com/mswjs/examples)
- Others
  - [How to Mock API Requests in Front-End Development?](https://www.codit.eu/blog/how-to-mock-api-requests-in-front-end-development/)

### 特徴
- Service Worker API を使用して実際のリクエストをインターセプトする API mock ライブラリ
- mockサーバ用のプロセスを別で立てる必要がない
- `DevTools`の`Network`タブから、モックの動作確認ができる
- `REST`や`GraphQL`のAPIに対応

### Next.jsを使った場合における問題 (Node.js関連)
Next.jsの[example](https://github.com/vercel/next.js/tree/canary/examples/with-msw)でも再現するが、以下のエラーが発生する
```
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

これは、既知の問題でissueにもあがっており、今後修正されると思われる（2022/10/1現在)
- [Directory import is not supported resolving ES modules](https://github.com/mswjs/msw/issues/1201)
  - `There is no support for ESM right now`
- [ESM support + treeshaking unused bits](https://github.com/mswjs/msw/issues/1384)
- [Stackoverflow: 'Directory import is not supported resolving ES modules' with Node.js](['Directory import is not supported resolving ES modules' with Node.js](https://stackoverflow.com/questions/64453859/directory-import-is-not-supported-resolving-es-modules-with-node-js))
  -  ES6 modulesでは、ディレクトリのimportができないとある。つまり、具体的なファイル名まで指定する必要がある。
  -  今回、ファイルの単体読み込みをしてみたが、今後は`Could not find a declaration file for module`というエラーが発生した

## Mirage.js
- [Official](https://miragejs.com/)
- [Docs](https://miragejs.com/docs/getting-started/introduction/)
- [github](https://github.com/miragejs/miragejs): Star: 4.8K, 2019/9 created
