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

- `Web Storage`は不可能
