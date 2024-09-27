# Web APIs

Web APIs (Web Application Programming Interfaces) は、ウェブブラウザやサーバーとウェブアプリケーションがやり取りを行うための一連のインターフェースとプロトコルを指す。これにより、開発者はウェブページ上で複雑な操作や機能を実装しやすくなる

## 基本的な概念

1. **API とは**:

   - **API（Application Programming Interface）**: 異なるソフトウェアコンポーネントが互いに通信するための手段を提供するインターフェースのこと。API は、特定の操作や機能を利用するための定義済みの方法（メソッド、プロパティ）を提供する。

2. **Web API の定義**:
   - **Web API**: 具体的には、ウェブブラウザやサーバーが提供する API で、ウェブアプリケーションが特定の操作や機能を実行するために使用される。これには DOM 操作、ネットワークリクエスト、グラフィクス描画、メディア操作などが含まれる。

## 主なカテゴリ

### 1. **DOM (Document Object Model) API**

DOM API は、HTML や XML 文書の内容や構造を操作するためのインターフェースを提供する

- `document.getElementById()`
- `document.querySelector()`
- `element.innerHTML`
- `element.style`
- `element.addEventListener()`

### 2. **Fetch API**

Fetch API は、サーバーに対するリクエストとレスポンスを容易に行うためのインターフェースを提供する。

```js
fetch("https://api.example.com/data")
  .then((response) => response.json())
  .then((data) => console.log(data))
  .catch((error) => console.error("Error:", error));
```

### 3. **Canvas API**

Canvas API は、HTML5 の`<canvas>`タグと共に使用し、2D および 3D グラフィックスを描画するためのインターフェースを提供する。

```js
const canvas = document.getElementById("myCanvas");
const ctx = canvas.getContext("2d");
ctx.fillStyle = "green";
ctx.fillRect(10, 10, 100, 100);
```

### 4. **Web Storage API**

Web Storage API は、クライアント側でのデータ保存を可能にする。`localStorage`と`sessionStorage`から成ります。

```js
// localStorage
localStorage.setItem("key", "value");
console.log(localStorage.getItem("key"));

// sessionStorage
sessionStorage.setItem("key", "value");
console.log(sessionStorage.getItem("key"));
```

### 5. **Web Workers API**

Web Workers API は、バックグラウンドスレッドで JavaScript コードを実行するためのインターフェースを提供し、メインスレッドのブロックを防ぐ。

```js
const worker = new Worker("worker.js");
worker.postMessage("start");
worker.onmessage = function (event) {
  console.log("Worker said: ", event.data);
};
```

### 6. **Geolocation API**

Geolocation API は、デバイスの位置情報を取得するためのインターフェースを提供する。

```js
navigator.geolocation.getCurrentPosition((position) => {
  console.log("Latitude: " + position.coords.latitude);
  console.log("Longitude: " + position.coords.longitude);
});
```

### 7. **Notification API**

Notification API は、Web アプリケーションからシステム通知を生成するためのインターフェースを提供する。

```js
if (Notification.permission === "granted") {
  new Notification("Hello, world!");
} else if (Notification.permission !== "denied") {
  Notification.requestPermission().then((permission) => {
    if (permission === "granted") {
      new Notification("Hello, world!");
    }
  });
}
```

### 8. **WebRTC API**

WebRTC API は、ブラウザ内のリアルタイム通信（ビデオ、オーディオ、データ）を実現するためのインターフェースを提供する。

```js
navigator.mediaDevices
  .getUserMedia({ video: true, audio: true })
  .then((stream) => {
    const video = document.getElementById("myVideo");
    video.srcObject = stream;
  })
  .catch((error) => console.error("Error accessing media devices.", error));
```

### 9. **Service Workers API**

Service Workers API は、バックグラウンドで動作するスクリプトを提供し、キャッシュ管理やオフライン対応を可能にする。

```javascript
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

### 10. **Intersection Observer API**

Intersection Observer API は、ターゲット要素がビュー内に入ったり、ビューから出たりするタイミングを監視するためのインターフェースを提供する。

```js
const observer = new IntersectionObserver((entries, observer) => {
  entries.forEach((entry) => {
    if (entry.isIntersecting) {
      console.log("Element is in view: ", entry.target);
    }
  });
});

observer.observe(document.querySelector("#myElement"));
```

## References

[MDN Web APIs](https://developer.mozilla.org/en-US/docs/Web/API)
