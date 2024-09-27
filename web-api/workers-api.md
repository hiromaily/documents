# Web Workers API と Service Workers API

Web Workers API と Service Workers API は、どちらも JavaScript コードをバックグラウンドで実行するための仕組みだが、その目的や機能にいくつかの重要な違いがある

## Web Workers API

**目的**:
主に計算やデータ処理など、リソース集約型のタスクをメインスレッドとは別に実行するためのスレッドを提供する。これにより、メインスレッドがブロックされるのを防ぎ、よりスムーズなユーザー体験を提供できる。

**主な特徴**:

1. **独立したスレッド**:

   - Web Worker はメインスレッドとは独立して動作し、完全に別のスレッドでコードを実行する。

2. **ユーザーインターフェースとは無関係**:

   - DOM 操作や直接的な UI 操作はできません。バックグラウンドでの重たい計算やデータ処理に適している。

3. **通信手段**:

   - Message Passing（メッセージパッシング）を使ってメインスレッドとデータをやり取りする。`postMessage`メソッドと`onmessage`イベントリスナーを使用する。

4. **ライフサイクル**:
   - メインスレッドが終了すると、Web Worker も終了する。また、メインスレッドから明示的に終了させることも可能 (`worker.terminate()` メソッド)。

**使用例**:

```js
// main.js
const worker = new Worker("worker.js");
worker.postMessage("start");
worker.onmessage = function (event) {
  console.log("Worker said: ", event.data);
};

// worker.js
onmessage = function (event) {
  if (event.data === "start") {
    // heavy computation
    let result = 0;
    for (let i = 0; i < 1000000; i++) {
      result += i;
    }
    postMessage(result);
  }
};
```

## Service Workers API

**目的**:
主にオフラインキャッシュ管理やバックグラウンドのデータ同期、プッシュ通知などの高度なウェブ機能を追加するために使用される。PWA (Progressive Web Apps) の基盤となる技術。

**主な特徴**:

1. **プロキシサーバ**:

   - クライアントとネットワークの間に位置するプロキシとして動作し、リクエストやレスポンスをキャッシュすることができる。

2. **イベント駆動型**:

   - メインスレッドから独立して動作し、特定のイベント（インストール、アクティベート、フェッチなど）を処理する。ページが開かれていない状態でもバックグラウンドで動作する。

3. **オフライン対応**:

   - ネットワーク状態に関係なくアプリケーションを利用可能にするオフライン対応の機能を提供する。

4. **持続的なライフサイクル**:
   - 一度登録されると、ブラウザやページの再読み込みを超えて持続する。インストール、アクティベート、フェッチなどのライフサイクルイベントを持つ。

**使用例**:

```js
// service-worker.js
self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open("v1").then((cache) => {
      return cache.addAll(["index.html", "styles.css", "script.js"]);
    })
  );
});

self.addEventListener("fetch", (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
});

// main.js
if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("/service-worker.js")
      .then((registration) => {
        console.log(
          "ServiceWorker registration successful with scope: ",
          registration.scope
        );
      })
      .catch((error) => {
        console.log("ServiceWorker registration failed: ", error);
      });
  });
}
```

## 違いのまとめ

**Web Workers**:

- 主にバックグラウンド処理や重たい計算を行うために使われる。
- メインスレッドとは独立したスレッドで動作し、UI 操作はできない。
- サイトが閉じれば通常終了する。

**Service Workers**:

- 主にオフラインキャッシュ、プッシュ通知、バックグラウンド同期などの PWA 機能を提供するために使われる。
- リクエストをキャッシュし、ネットワークプロキシとして動作する。
- ページが閉じても持続的に動作する。
