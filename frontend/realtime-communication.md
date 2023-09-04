# Real-Time Communication

## 種類

- WebSockets
- Server-Sent Events (SSE)
- Long Polling (HTTP Comet)
- WebRTC
- MQTT
- HTTP/2 Server Push
- WebPush
- gRPC: Server Streaming RPCs

### WebSockets

WebSocket は、クライアントとサーバー間の双方向通信を可能にするプロトコル。
WebSocket を使用すると、クライアントがデータを要求しなくても、サーバーはクライアントにデータをプッシュできる。

### Server-Sent Events (SSE)

SSE を使用すると、サーバーはデータを HTTP 応答としてクライアントにプッシュできるため、WebSocket のより簡単な代替手段になる

### Long Polling (HTTP Comet)

ロング ポーリングは、クライアントがサーバーにリクエストを送信する手法。
サーバーは、クライアントに送り返すデータがあるまで接続を開いたままにする。
ロング ポーリングは、リアルタイム通信をシミュレートする効果的な方法ですが、WebSocket や SSE よりも効率が悪い場合がある。

### WebRTC

WebRTC は、サーバーを必要とせずにクライアント間のピアツーピア通信を可能にするリアルタイム通信プロトコル。
WebRTC は、ビデオ チャット、ファイル共有、およびその他のリアルタイム アプリケーションに使用できる。

### MQTT (Message Queue Telemetry Transport)

Publish/Subscribe モデルのメッセージングにより、非同期に 1 対多の通信ができるプロトコル
シンプルかつ軽量に設計されているため、機械同士が通信を行いやり取りする M2M (Machine-to-Machine)や家電や自動車など多種多様な「モノ」が通信を行いやり取りする`IoT (Internet of Things)` を実現するのに適したプロトコルと言われている。

### HTTP/2 Server Push

サーバーサイド側からコンテンツをクライアントにプッシュする仕組み

- [Removing HTTP/2 Server Push from Chrome](https://developer.chrome.com/blog/removing-push/)
  - 性能後退が見られるため、ほとんど使われていない。その結果 default で disabled 化された。

### WebPush

- [Push API](https://developer.mozilla.org/ja/docs/Web/API/Push_API)と言われるもの
- [npm: web-push](https://www.npmjs.com/package/web-push)

### [gRPC: Server Streaming RPCs](https://grpc.io/docs/what-is-grpc/core-concepts/#server-streaming-rpc)

- [Internal Docs](../grpc-proto/README.md)

## 頻繁にアクセスする場合と、接続を維持する場合の違い

### 頻繁にアクセスする場合

- リクエストのたびに、接続の設定と解除のオーバーヘッドが高い
- 接続ごとのサーバーのリソース使用量は比較的低い

### 接続を維持する場合

- 接続の設定と解除のオーバーヘッドが低い
- 接続に関連するリソースを長期間にわたって管理する必要がある
- 定期的にデータを送信または更新を受け取る
- 接続が長い期間開いている場合に、ネットワークの中断やクライアントの切断などの問題を処理する必要があ r う
- 接続数の制限、リソース管理が必要

#### サーバーリソースの例

- メモリ (RAM)
  - 長寿命の接続は、接続ごとにメモリを占有する。メモリはデータの一時的な保存や処理に使用される。
  - 長時間の接続が多数ある場合、メモリの使用量が増加する可能性がある。
- CPU
  - 長寿命の接続は、定期的なデータ送信や受信を処理するために CPU リソースを消費する。
  - 接続数が多い場合、CPU 使用率が増加する可能性がある
- ネットワーク帯域幅
  - 長寿命の接続がデータを送信または受信し続ける場合、ネットワーク帯域幅を占有する。
  - 大量の接続が同時にデータを送信する場合、ネットワーク帯域幅の使用量が増加する。
- スレッド/プロセス
  - 一部のサーバーアプリケーションは、接続ごとにスレッドまたはプロセスを生成する。
  - 長寿命の接続が多数ある場合、スレッドやプロセスの数が増加し、オペレーティングシステムのリソースを占有する可能性がある
- ディスク I/O
  - 長寿命の接続は、ディスクにデータを書き込んだり、データを読み取ったりする場合がある
  - 大量のデータの書き込みや読み取りが行われる場合、ディスク I/O の負荷が増加する可能性がある
- セッション状態
  - サーバーが長寿命の接続の状態を追跡する必要がある場合、セッション情報を保存するためにメモリやデータベースリソースが必要
