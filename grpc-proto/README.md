# gRPC

RPC はリモートプロシージャコール(RPC)システムの 1 つ。RPC とは遠隔手続き呼出しのことで簡単に言えば「違うサーバーにある関数を実行させる仕組み」のことで、呼び出す側(クライアント)と呼び出される側(サーバー)に別れているクライアント-サーバーモデル方式を取っている

## Protocol Buffers

- gRPC は`Protocol Buffers`をデフォルトのメッセージの I/F format としている

- IDL(Interface Definition Language/インターフェース定義言語)でデータの構造を定義するシリアライズのためのフォーマット
- データを永続的に保存したりネットワーク通信でデータをやり取りする際に使われる

## stub スタブ

- gRPC では Stub というコンポーネントがサーバーとクライアントの仲介をする
- この仲介を果たす Stub は `proto` というサービス定義ファイルから生成される
- Stub はサーバー、クライアントそれぞれにライブラリとして組み込んで使用する

### 2 種類の Client スタブ

- blocking/synchronous スタブ
  - RPC コールはサーバーからの応答を待つ
- non-blocking/asynchronous スタブ
  - クライアントはサーバーにノンブロッキングコールを行い、レスポンスは非同期で返される

## 4 つの通信方法

### [Unary RPC](https://grpc.io/docs/what-is-grpc/core-concepts/#unary-rpc)

- client、server 共に unary(単一)の通信方式

### [Server streaming RPC](https://grpc.io/docs/what-is-grpc/core-concepts/#server-streaming-rpc)

- Server streaming RPC はクライアント側の投げてくるリクエストは Unary(単一)でレスポンス側が複数(Streaming)の通信方式

![Server streaming RPC](https://github.com/hiromaily/documents/raw/main/images/grpc-server-streaming.webp "Server streaming RPC")

### [Client streaming RPC](https://grpc.io/docs/what-is-grpc/core-concepts/#client-streaming-rpc)

- Client streaming RPC はクライアント側の投げてくるリクエストが複数(Streaming)でレスポンスが Unary(単一)の通信方式

### [Bidirectional streaming RPC](https://grpc.io/docs/what-is-grpc/core-concepts/#bidirectional-streaming-rpc)

- Bidirectional streaming RPC は Bidirectional(双方向)という語の通り、リクエストもレスポンスも両方複数(Streaming)の通信方式

## WIP: [Error handling](https://grpc.io/docs/guides/error/)
