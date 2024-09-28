# Nonce

- Ethereum のトランザクションにおける nonce は、ある Ethereum のアドレス（アカウント）から実行されたトランザクションの総数
  - この数には、memPool に transaction が滞留している状態は含まれない
- 0 から 1 つずつインクリメントされる

## Ethereum アドレスの現在の nonce を取得する

### [eth_getTransactionCount](https://docs.alchemy.com/reference/eth-gettransactioncount)

#### 実行

```bash
curl --request POST \
     --url https://eth-mainnet.g.alchemy.com/v2/docs-demo \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --data '
{
  "id": 1,
  "jsonrpc": "2.0",
  "params": [
    "0xe5cB067E90D5Cd1F8052B83562Ae670bA4A211a8",
    "latest"
  ],
  "method": "eth_getTransactionCount"
}
'
```

#### 結果

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": "0x31" //49
}
```

## Transaction に紐づく nonce を取得する

### [eth_getTransactionByHash - Ethereum](https://docs.alchemy.com/reference/eth-gettransactionbyhash)

transaction が pending の状態でも取得可能。この場合は、`blockHash`, `blockNumber`, `transactionIndex`が`null`となる

```bash
curl --request POST \
     --url https://eth-mainnet.g.alchemy.com/v2/docs-demo \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --data '
{
  "id": 1,
  "jsonrpc": "2.0",
  "method": "eth_getTransactionByHash",
  "params": [
    "0x88df016429689c079f3b2f6ad39fa052532c56795b733da78a91ebe6a713944b"
  ]
}
'
```

### [eth_getTransactionReceipt - Ethereum](https://docs.alchemy.com/reference/eth-gettransactionreceipt)

[eth_getTransactionReceipt - Ethereum](https://docs.alchemy.com/reference/eth-gettransactionreceipt)では取得できない。
これは、transaction が block に取り込まれた後に取得ができるメソッドとなる。

```bash
curl --request POST \
     --url https://eth-mainnet.g.alchemy.com/v2/docs-demo \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --data '
{
  "id": 1,
  "jsonrpc": "2.0",
  "method": "eth_getTransactionReceipt",
  "params": [
    "0x8fc90a6c3ee3001cdcbbb685b4fbe67b1fa2bec575b15b0395fea5540d0901ae"
  ]
}
'
```

- result

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "blockHash": "0x1d59ff54b1eb26b013ce3cb5fc9dab3705b415a67127a003c3e61eb445bb8df2",
    "blockNumber": "0x5daf3b",
    "hash": "0x88df016429689c079f3b2f6ad39fa052532c56795b733da78a91ebe6a713944b",
    "input": "0x68656c6c6f21",
    "r": "0x1b5e176d927f8e9ab405058b2d2457392da3e20f328b16ddabcebc33eaac5fea",
    "s": "0x4ba69724e8f69de52f0125ad8b3c5c2cef33019bac3249e2c0a2192766d1721c",
    "v": "0x25",
    "gas": "0xc350",
    "from": "0xa7d9ddbe1f17865597fbd27ec712455208b6b76d",
    "transactionIndex": "0x41",
    "to": "0xf02c1c8e6114b1dbe8937a39260b5b0a374432bb",
    "type": "0x0",
    "value": "0xf3dbb76162000",
    "nonce": "0x15",
    "gasPrice": "0x4a817c800"
  }
}
```

### nonce と [eth_getTransactionCount](https://docs.alchemy.com/reference/eth-gettransactioncount)の関係性

- nonce の index は 0 から
- tx2 側が先に`contained`になることはない

| 時系列 | tx1                  | tx2                  | transaction count |
| :----- | :------------------- | :------------------- | :---------------- |
| 1      | nonce:10 (pending)   | nonce:11 (pending)   | 10                |
| 2      | nonce:10 (contained) | nonce:11 (pending)   | 11                |
| 3      | nonce:10 (contained) | nonce:11 (contained) | 12                |

- そのため、pending の tx に対して、tx に紐づく nonce 値より `transaction count` が大きい場合、その tx は Drop されたものと判断される
