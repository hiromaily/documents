# connect-es

- [connect-es](https://github.com/bufbuild/connect-es)

## 依存する基本機能

- [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
- [Encoding API](https://developer.mozilla.org/en-US/docs/Web/API/Encoding_API)

## [packages](https://github.com/bufbuild/connect-es/tree/main/packages)

- connect-express
  - Adds your services to an Express server
- connect-fastify
  - Plug your services into a Fastify server
- connect-next
  - Serve your RPCs with Next.js API routes
- connect-node
  - Serve RPCs on vanilla Node.js servers
- connect-web
  - Adapters for web browsers
- connect
  - RPC clients and servers for your schema
- example
- protoc-gen-connect-es
  - proto ファイルを build する generator。Code generator plugin for the services in your schema
- protoc-gen-connect-web [Deprecated]
  - proto ファイルを build する generator。

## [Tutorial](https://connect.build/docs/web/getting-started/)

```sh
npm install \
@bufbuild/connect \
@bufbuild/connect-web
```
