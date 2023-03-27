# Real-Time Communication

- WebSockets
- Server-Sent Events (SSE)
- Long Polling (HTTP Comet)
- WebRTC
- MQTT
- HTTP/2 Server Push
- WebPush

## WebSockets
WebSocket は、クライアントとサーバー間の双方向通信を可能にするプロトコル。
WebSocket を使用すると、クライアントがデータを要求しなくても、サーバーはクライアントにデータをプッシュできる。

## Server-Sent Events (SSE)
SSE を使用すると、サーバーはデータを HTTP 応答としてクライアントにプッシュできるため、WebSocket のより簡単な代替手段になる

## Long Polling (HTTP Comet)
ロング ポーリングは、クライアントがサーバーにリクエストを送信する手法。
サーバーは、クライアントに送り返すデータがあるまで接続を開いたままにする。
ロング ポーリングは、リアルタイム通信をシミュレートする効果的な方法ですが、WebSocket や SSE よりも効率が悪い場合がある。

## WebRTC
WebRTC は、サーバーを必要とせずにクライアント間のピアツーピア通信を可能にするリアルタイム通信プロトコル。
WebRTC は、ビデオ チャット、ファイル共有、およびその他のリアルタイム アプリケーションに使用できる。

## MQTT (Message Queue Telemetry Transport)
Publish/Subscribe モデルのメッセージングにより、非同期に1対多の通信ができるプロトコル
シンプルかつ軽量に設計されているため、機械同士が通信を行いやり取りするM2M (Machine-to-Machine)や家電や自動車など多種多様な「モノ」が通信を行いやり取りする`IoT (Internet of Things)` を実現するのに適したプロトコルと言われている。

## HTTP/2 Server Push
サーバーサイド側からコンテンツをクライアントにプッシュする仕組み

- [Removing HTTP/2 Server Push from Chrome](https://developer.chrome.com/blog/removing-push/)
  - 性能後退が見られるため、ほとんど使われていない。その結果defaultでdisabled化された。

## WebPush
- [Push API](https://developer.mozilla.org/ja/docs/Web/API/Push_API)と言われるもの
- [npm: web-push](https://www.npmjs.com/package/web-push)
