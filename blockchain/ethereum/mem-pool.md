# Mem Pool

メモリープール（Memory Pool）は一般的に`mempool`と表記されるが、ブロックチェーンには処理能力の限界があるので、トランザクションが順番待ちのような状態で保留されることがあり、その際にメモリープールがデータの一時保存先として利用されることになる。
メモリープールに溜まったトランザクションは、マイナーやバリデータが検証してから、ブロックチェーンに書き込まれる。ブロックチェーンに書き込まれたトランザクションは、メモリープールから消去される。

## mempool から情報を取得する

```sh
curl --data '{"method":"txpool_content","id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST ADD_YOUR_ETHEREUM_NODE_URL
```

- [geth: txpool Namespace](https://geth.ethereum.org/docs/interacting-with-geth/rpc/ns-txpool)
