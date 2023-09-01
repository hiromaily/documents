# Web Workers

- script をバックグラウンドのスレッドで実行するためのシンプルな手段
- Worker スレッドは、ユーザーインターフェイスを妨げることなくタスクを実行できる
- XMLHttpRequest, fetch を使用して入出力を行うこともできる
- Worker が生成されると、それを作成した JavaScript コードが指定するイベントハンドラーにメッセージを投稿することで、そのコードにメッセージを送ることができる

## Web Worker API

- `Worker()`を使用して生成されるオブジェクトであり、名前付きの JavaScript ファイルを実行する
  - このファイルは Worker スレッドで実行するコードを持つ
- 現在の `window` とは異なるグローバルコンテキストで実行される
  - `window` を使用して現在のグローバルスコープを取得しようとすると、 Worker の中でエラーが発生する
- Worker のコンテキスト
  - 専用 Worker（単一のスクリプトで利用される標準的な Worker）: `DedicatedWorkerGlobalScope オブジェクト`
    - 最初にワーカーを起動したスクリプトだけがアクセスできる
  - 共有 Worker の場合: `SharedWorkerGlobalScope`
    - 複数のスクリプトからアクセスできる
  - サービス Worker: `ServiceWorkerGlobalScope`
- Worker スレッドでは、どのようなコードでも実行できるが、いくつかの制限がある
  - 例えば、Worker 内から直接 DOM を操作することはできない
  - `window` オブジェクトの既定のメソッドやプロパティで、使用できないものがある
    - `WebSocket` や、`IndexedDB` のようなデータストレージ機構などを使用できる
- Worker と Main スレッドの間でデータをやり取りするには、メッセージの仕組みが使用される
  - どちらも `postMessage()` メソッドを使用してメッセージを送信し、`onmessage` イベントハンドラーによってメッセージに応答する
  - メッセージは message イベントの data 属性に収められる
  - データは共有されず、複製される

## [Web Workers が使用できる関数やクラス](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Functions_and_classes_available_to_workers)

- `Web Storage`は不可能

- Barcode Detection API
- Broadcast Channel API
- Cache API
- Channel Messaging API
- Console API
- Web Crypto API (e.g. Crypto)
- CSS Font Loading API
- CustomEvent
- Encoding API (e.g. TextEncoder, TextDecoder)
- Fetch API
- FileReader
- FileReaderSync (only works in workers!)
- FormData
- ImageBitmap
- ImageData
- IndexedDB
- Media Source Extensions API (dedicated workers only)
- Network Information API
- Notifications API
- OffscreenCanvas (and all the canvas context APIs)
- Performance API, including:
- Server-sent events
- ServiceWorkerRegistration
- URL API (e.g. URL)
- WebCodecs_API
- WebSocket
- XMLHttpRequest

## Library

### [Comlink](https://github.com/GoogleChromeLabs/comlink)

- tiny WebWorkers library
- Star: 10.1k
- last updated: Feb 2023

### [worker-dom](https://github.com/ampproject/worker-dom)

- The same DOM API and Frameworks you know, but in a Web Worker
- Star: 3.1k
- last updated: Aug 2023

### [threads.js](https://github.com/andywer/threads.js)

- Offload CPU-intensive tasks to worker threads in node.js, web browsers
- Star: 2.9k
- last updated: Nov 2022

### [Greenlet](https://github.com/developit/greenlet)

- Move an async function into its own thread.
- Star: 4.6k
- last updated: Oct 2019

### [Shopify/quilt](https://github.com/Shopify/quilt)

- A loosely related set of packages for JavaScript/TypeScript projects at Shopify
- Star: 1.6k
- last updated: Aug 2023

#### Web Workers related packages

- [@shopify/web-worker](https://github.com/Shopify/quilt/tree/main/packages/web-worker)
- [@shopify/react-web-worker](https://github.com/Shopify/quilt/tree/main/packages/react-web-worker)
