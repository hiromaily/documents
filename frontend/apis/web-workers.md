# Web Workers

- script をバックグラウンドのスレッドで実行するためのシンプルな手段
- Worker スレッドは、ユーザーインターフェイスを妨げることなくタスクを実行できる
- XMLHttpRequest, fetch を使用して入出力を行うこともできる
- Worker が生成されると、それを作成した JavaScript コードが指定するイベントハンドラーにメッセージを投稿することで、そのコードにメッセージを送ることができる
- [スレッドセーフ](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers#about_thread_safety)

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

## Worker の種類

### [1. 専用 Workers: dedicated workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers#dedicated_workers)

- 呼び出し元のスクリプトだけがアクセスできる

#### 起動

- Worker スレッドで実行するスクリプトの URI を指定した `Worker()` コンストラクターを呼び出す

```js
const myWorker = new Worker('worker.js');
```

#### メッセージのやり取り

- ` postMessage()`` メソッドと  `onmessage` イベントハンドラーを使う
- main.js

```js
myWorker.postMessage([first.value, second.value]);
myWorker.onmessage = (e) => {
  console.log('Message received from worker', e.data);
};
```

- worker.js

```js
onmessage = (e) => {
  console.log('Message received from main script');
  const workerResult = `Result: ${e.data[0] * e.data[1]}`;
  console.log('Posting message back to main script');
  postMessage(workerResult);
};
```

#### 終了

```js
myWorker.terminate();
```

#### エラー処理

- Worker 内で実行時エラーが発生すると、 onerror イベントハンドラーが呼び出される

#### Sub Workers の起動

- Worker は、必要に応じてさらに多くの Worker を生み出すことができる
- `sub-workers`は、親ページと同じオリジン内でホストされていなければならない
- `sub-workers`の URI は、親ページのものではなく、親ワーカーの位置を基準に解決される

#### Worker スレッドからの Script や Library の import

```js
importScripts(); /* imports nothing */
importScripts('foo.js'); /* imports just "foo.js" */
importScripts('foo.js', 'bar.js'); /* imports two scripts */
importScripts(
  '//example.com/hello.js'
); /* You can import scripts from other origins */
```

### [2. 共有 Workers: Shared workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers#shared_workers)

- `Shared workers`は、オリジンが同一であれば（異なるウィンドウ、iframe の Worker であても）複数のスクリプトからアクセスできる
- `Shared workers`の大きな違いのひとつが、 `port オブジェクト`を通して通信しなければならないこと
- Port への接続方法
  - メッセージを送信する前に `onmessage` イベントハンドラーを使用して暗黙的に行う
  - あるいは `start()` メソッドを使用して明示的に開始するか

#### 起動

```js
const myWorker = new SharedWorker('worker.js');
```

#### メッセージのやり取り

割愛

### [3. 埋め込みワーカー: Embedded workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers#embedded_workers)

- html ファイルの、`script` タグに埋め込む方法について

### [4. その他のワーカー](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers#other_types_of_workers)

- ServiceWorkers
- Audio Worklet

## [Content security policy](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers#content_security_policy)

- Worker は、自分を生成した Main Thread から区別された独自の実行コンテキストを持っているとみなされる
- そのため、自分を生成した Main Thread（または Parent Workers）のコンテンツセキュリティポリシーでは管理されない
- Worker のコンテンツセキュリティポリシーを指定するには、Worker script 自身が配信されたリクエストの Content-Security-Policy レスポンスヘッダーで設定する

## [Worker とのデータ転送の詳細](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers#transferring_data_to_and_from_workers_further_details)

- Main Page と Worker の間で渡されるデータは、共有ではなくコピーされる
- 渡される Object は、Worker に渡されるときにシリアライズされ、その後、反対側でシリアライズが解除される
- Main Page と Worker は同じインスタンスを共有しないため、最終的には両側に複製が作成される

## コード例

- main.js

```js
// main.js

document.addEventListener('DOMContentLoaded', () => {
  const startButton = document.getElementById('startButton');
  const statusElement = document.getElementById('status');

  let worker;

  startButton.addEventListener('click', () => {
    // 1.Worker機能の検出
    if (typeof Worker !== 'undefined' && window.Worker) {
      if (!worker) {
        // 2.専用Workerの起動
        // Worker object
        // - 名前付きの Workerスレッドで実行するコードを保持するjsファイルを実行する
        worker = new Worker('worker.js');

        // workerから返されたmessageに応答する
        worker.onmessage = function (event) {
          statusElement.textContent = event.data;
        };

        // workerにmessageを送る
        worker.postMessage('start');

        startButton.textContent = 'Stop Polling';
      } else {
        // workerの終了
        worker.terminate();
        worker = undefined;

        startButton.textContent = 'Start Polling';
      }
    } else {
      statusElement.textContent =
        'Web Workers are not supported in this browser.';
    }
  });
});
```

- worker.js

```js
// worker.js

let isPolling = false;

function pollAPI() {
  if (!isPolling) {
    return;
  }

  // Perform your API request here and check for specific data
  // If the specific data is found, post a message to the main thread
  // If not found, schedule the next polling iteration

  // Example:
  fetch('https://api.example.com/status')
    .then((response) => response.json())
    .then((data) => {
      if (data.status === 'completed') {
        // main.jsにmessageを送信する (main側は、worker.onmessageイベントで検知)
        postMessage('Status changed to completed.');
        isPolling = false;
      } else {
        setTimeout(pollAPI, 5000); // Poll every 5 seconds (adjust as needed)
      }
    })
    .catch((error) => {
      console.error('Error polling API:', error);
      isPolling = false;
    });
}

// worker側でevent受信。main側でpostMessageされたmessageを受信できる
onmessage = function (event) {
  if (event.data === 'start' && !isPolling) {
    isPolling = true;
    pollAPI();
  }
};
```

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
- [Example](https://github.com/GoogleChromeLabs/comlink#examples)

#### コード例

- main.js

```js
// main.js
import { wrap } from 'comlink';

async function init() {
  const startPollingButton = document.getElementById('startPollingButton');
  const statusElement = document.getElementById('status');

  let pollingWorker;

  startPollingButton.addEventListener('click', async () => {
    if (!pollingWorker) {
      // 専用Workerの起動
      // Worker object
      // - 名前付きの Workerスレッドで実行するコードを保持するjsファイルを実行する
      pollingWorker = new Worker('polling-worker.js');
      // worker objectをwrap()して、こちらをmain側で取り扱う
      const pollServer = wrap(pollingWorker);

      startPollingButton.textContent = 'Stop Polling';
      statusElement.textContent = 'Polling...';

      try {
        // worker側からexposeされたfunctionを呼び出す
        const updateAvailable = await pollServer();
        if (updateAvailable) {
          statusElement.textContent = 'Update available!';
        }
      } catch (error) {
        console.error('Error polling server:', error);
        statusElement.textContent = 'Error occurred while polling.';
      } finally {
        pollingWorker.terminate();
        pollingWorker = undefined;
        startPollingButton.textContent = 'Start Polling';
      }
    } else {
      pollingWorker.terminate();
      pollingWorker = undefined;
      startPollingButton.textContent = 'Start Polling';
      statusElement.textContent = 'Not polling';
    }
  });
}

init();
```

- polling-worker.js

```js
// polling-worker.js
import { expose } from 'comlink';

// Simulate a function that polls the server for updates
async function pollServer() {
  while (true) {
    // Simulate an API request here
    // Replace this with your actual API polling logic
    const response = await fetch('https://api.example.com/check_updates');
    const data = await response.json();

    // Check if the data indicates an update
    const updateAvailable = data.updateAvailable;

    if (updateAvailable) {
      // If an update is available, notify the main thread
      return true;
    }

    // Sleep for a few seconds before the next poll
    await new Promise((resolve) => setTimeout(resolve, 5000));
  }
}

// このfunctionがexposeされることで、main.jsからアクセスできるようになる
// そのため、Classのinstanceをexposeした方が使いやすいかもしれない
expose(pollServer);
```

- index.html

```html
<!-- index.html -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Comlink Polling Example</title>
  </head>
  <body>
    <h1>Comlink Polling Example</h1>
    <button id="startPollingButton">Start Polling</button>
    <p>Status: <span id="status">Not polling</span></p>
    <script src="main.js"></script>
  </body>
</html>
```

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

## References

- [Web Workers API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API)
- [Using Web Workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers)
