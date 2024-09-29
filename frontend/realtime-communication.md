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
ロング ポーリングは、リアルタイム通信をシミュレートする効果的な方法だが、WebSocket や SSE よりも効率が悪い場合がある。

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
- 接続が長い期間開いている場合に、ネットワークの中断やクライアントの切断などの問題を処理する必要がある
- 接続数の制限、リソース管理が必要

### サーバーリソースの例

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

## TODO: 長時間接続はなぜ高負荷なのか？

- keyword: `long-lived HTTP2 stream`

### [gRPC on HTTP/2 Engineering a Robust, High-performance Protocol](https://grpc.io/blog/grpc-on-http2/)

### [The Mysterious Gotcha of gRPC Stream Performance](https://ably.com/blog/grpc-stream-performance)

#### 彼らの想定

- HTTP2 は、長寿命の TCP コネクション上でストリームを多重化するので、新しいリクエストのための TCP コネクションのオーバーヘッドはない
- HTTP2 フレーミングは、複数の gRPC メッセージを単一の TCP パケットで送信することを可能にする
- 長寿命の接続では、ストリームリクエストはメッセージ単位で最高のパフォーマンスを持つはず ??

#### 現実

- 1300message/s で CPU はすでにかなり高かった
- CPU プロファイルで調査
- 実際、CPU 時間の 27％が読み込みと書き込みのシステムコールに費やされている
- goroutine のスケジューリングは CPU 時間の 17%を占め、gRPC 内部は残りのほとんどを費やしているようだった
- Application 側のコード、つまりメッセージの処理を実行するアプリケーション・コードは、ほとんど実行時間を費やしていないよう
- パフォーマンステストの CPU 使用率の統計を分解してみると、通常、CPU 使用率のほぼ半分がシステム（つまりカーネル）使用率であることがわかった
- subscribe による負荷は、publish による負荷とほぼ同じだった
- gRPC ストリームのパフォーマンスなのかもしれない
  - シンプル・サーバーに対して同じパフォーマンス・テストを実行したところ、同じメッセージ・レートでもパフォーマンスが大幅に向上した
- さらに悪いことに、サーバに別々に到着するデータフレームは、送信される PING フレームの数を増加させる

### [Performance best practices with gRPC](https://learn.microsoft.com/en-us/aspnet/core/grpc/performance?view=aspnetcore-7.0)

#### 接続の同時実行

- HTTP/2 接続には通常、一度に接続できる最大同時ストリーム数（アクティブな HTTP リクエスト数）の制限がある。
- デフォルトでは、ほとんどのサーバーがこの同時ストリーム数の上限を 100 に設定している
- gRPC チャネルは単一の HTTP/2 接続を使用し、同時呼び出しはその接続上で多重化される
- アクティブなコールの数が接続ストリームの上限に達すると、追加のコールがクライアントにキューイングされる
- キューに入れられたコールは、アクティブなコールの完了を待ってから送信される
- 高負荷のアプリケーションや長時間ストリーミング gRPC コールを実行するアプリケーションでは、この制限のためにコールがキューイングされることによるパフォーマンスの問題が発生する可能性がある

#### Streaming

- パフォーマンス上の理由から単項コールを双方向ストリーミングに置き換えることは高度なテクニックであり、多くの状況では適切ではない
- ストリーミングコールを使うのは、次のような場合に良い選択とされる
  - 高スループットまたは低遅延が要求される
  - gRPC と HTTP/2 がパフォーマンスのボトルネックになっている
  - クライアントのワーカーは、gRPC サービスと通常のメッセージを送受信している
- Streaming の複雑さと制限について
  - ストリームは、サービスエラーや接続エラーによって中断されることがある。エラーが発生した場合、ストリームを再開するためのロジックが必要となる
  - gRPC ストリーミング・メソッドは、1 種類のメッセージの受信と 1 種類のメッセージの送信に限定される

### [envoyproxy/envoy](https://github.com/envoyproxy/envoy) の issue

- [High memory usage with long HTTP/2 connections (GRPC)](https://github.com/envoyproxy/envoy/issues/9891)
- [Extremely high memory usage with long streaming gRPC requests](https://github.com/envoyproxy/envoy/issues/15904)

### [同時接続数 30 万超のチャットサービスのメッセージ配信基盤を Redis Pub/Sub から Redis Streams にした話](https://engineering.linecorp.com/ja/blog/redis-pub_Sub-redis-streams)
