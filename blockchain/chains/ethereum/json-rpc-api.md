# JSON-RPC API

これは`Execution APIs`とも言われ、Execution Client 側の API 機能となる

- [ethereum.org Docs](https://ethereum.org/en/developers/docs/apis/json-rpc/)
- [github: execution-apis](https://github.com/ethereum/execution-apis)

## [eth_getTransactionByHash](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_gettransactionbyhash)

- Transaction Hash に紐づく transaction 情報を返す
- 結果の取得には、後続の`eth_getTransactionReceipt`のほうが望ましい

```sh
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getTransactionByHash","params":["0x88df016429689c079f3b2f6ad39fa052532c56795b733da78a91ebe6a713944b"],"id":1}'
```

Result

```json
{
  "jsonrpc":"2.0",
  "id":1,
  "result":{
    "blockHash":"0x1d59ff54b1eb26b013ce3cb5fc9dab3705b415a67127a003c3e61eb445bb8df2",
    "blockNumber":"0x5daf3b", // 6139707
    "from":"0xa7d9ddbe1f17865597fbd27ec712455208b6b76d",
    "gas":"0xc350", // 50000
    "gasPrice":"0x4a817c800", // 20000000000
    "hash":"0x88df016429689c079f3b2f6ad39fa052532c56795b733da78a91ebe6a713944b",
    "input":"0x68656c6c6f21",
    "nonce":"0x15", // 21
    "to":"0xf02c1c8e6114b1dbe8937a39260b5b0a374432bb",
    "transactionIndex":"0x41", // 65
    "value":"0xf3dbb76162000", // 4290000000000000
    "v":"0x25", // 37
    "r":"0x1b5e176d927f8e9ab405058b2d2457392da3e20f328b16ddabcebc33eaac5fea",
    "s":"0x4ba69724e8f69de52f0125ad8b3c5c2cef33019bac3249e2c0a2192766d1721c"
  }
}
```

## [eth_getTransactionReceipt](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_gettransactionreceipt)

- Transaction Hash に紐づく Transaction の Receipt を返す

```sh
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getTransactionReceipt","params":["0x85d995eba9763907fdf35cd2034144dd9d53ce32cbec21349d4b12823c6860c5"],"id":1}'
```

Result

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "blockHash":
      "0xa957d47df264a31badc3ae823e10ac1d444b098d9b73d204c40426e57f47e8c3",
    "blockNumber": "0xeff35f",
    "contractAddress": null, // string of the address if it was created
    "cumulativeGasUsed": "0xa12515",
    "effectiveGasPrice": "0x5a9c688d4",
    "from": "0x6221a9c005f6e47eb398fd867784cacfdcfff4e7",
    "gasUsed": "0xb4c8",
    "logs": [{
      // logs as returned by getFilterLogs, etc.
    }],
    "logsBloom": "0x00...0", // 256 byte bloom filter
    "status": "0x1",
    "to": "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
    "transactionHash":
      "0x85d995eba9763907fdf35cd2034144dd9d53ce32cbec21349d4b12823c6860c5",
    "transactionIndex": "0x66",
    "type": "0x2"
  }
}
```

### ログ情報の取得

- front-end 側で検索して取得する

```js
const Web3 = require("web3");

// Connect to an Ethereum node
const web3 = new Web3("https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID");

// Transaction hash
const txHash = "0x1234567890...";

// Get transaction receipt
web3.eth.getTransactionReceipt(txHash, (error, receipt) => {
  if (error) {
    console.error(error);
    return;
  }

  // Retrieve the logs
  const logs = receipt.logs;

  // Process the logs
  logs.forEach((log) => {
    // Access log properties
    const address = log.address;
    const topics = log.topics;
    const data = log.data;

    // Do something with the log
    console.log(`Log from address: ${address}`);
  });
});
```

## [eth_getBlockByNumber](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getblockbynumber)

- WIP: これには、slot が含まれていない。Block Height からどうやって Slot を取得する？

```sh
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["0x108f81f", true],"id":1}' https://rpc.ankr.com/eth/xxx
```

## [WIP: eth_getStorageAt](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getstorageat)

コントラクトの特定のストレージ位置に保存されている値を取得できるため、コントラクトの状態変数に直接アクセスして検査したい場合に便利

### eth_getBlockByNumber: Parameters

- data: storage の address
- quantity: storage 内の position(index) (integer)
- quantity: block number もしくは、`latest`, `earliest`, `pending`といったタグ

[eth_getStorageAt の例](http://man.hubwiz.com/docset/Ethereum.docset/Contents/Resources/Documents/eth_getStorageAt.html)

### どうやって storage position を算出するか？

#### 1.Solidity storage layout の理解

Solidity は State 変数をコントラクトのストレージに密集して格納する。各 State 変数は、そのタイプとサイズに応じて、1 つまたは複数のストレージ スロットを占有する。

- ストレージは State 変数の値を保持する key/value のようなデータ構造
- ストレージを配列として考えるとわかりやすい
- 各スペースは Slot とヤバれ、32byte(256bit)のデータを保持する
- 配列の最大超は 2^256-1
- Contract 内の宣言された各 State 変数はその宣言位置と型に応じて Slot を占有する
- 以下は例

```sol
contract StorageLayout {
  uint256 public id = 543; //Slot Index:0
  uint256 public count;
  address public owner;
  // 以下はイメージ
  // storage[0] = 543; // 0x000000000000000000000000000000000000000000000000000000000000021F (32byte)
  // storage[1] = 0;
  // storage[2] = 0x0;
}
```

- 上記の`id`はストレージのインデックス 0 に 543 を割り当てている
- ストレージ内のデータはすべてバイトとして保存されるため、10 進数の`543`を 16 進数バイト形式に変換すると`021f`となり、32 バイトにパディングされる
- web3.js を使った例

```js
// value = 0x000000000000000000000000000000000000000000000000000000000000021f
const value = await web3.eth.getStorageAt(
  "0x8Aa5C5B74F35a1cB01631bCA24D995d369670E60",
  0
);

// decode
await web3.eth.abi.decodeParameter("uint256", value);
```

- `文字列型`の場合、ゼロ値は空の文字列として表現される
- `アドレス型`の場合、値はゼロアドレス 0x000000000000000000、40 個のゼロ、または 20 個の空のバイトとして表現される
- `uint256`の場合は、バイトで表すと 64 個のゼロ
- `bool型`の場合、ゼロ値は`false`となり、0x00、1 バイト長
- ストレージ内の値はすべて ABI エンコードされて保存され、その変数を使用して値を取り出すときに自動的にデコードされる
- では、32 バイト未満の型のステート変数を宣言した場合はどうなるのか？

| Variable type | Size in bytes |
| ------------- | ------------- |
| uint8         | 1 byte        |
| uint16        | 2 bytes       |
| uint32        | 4 bytes       |
| uint64        | 8 bytes       |
| uint128       | 16 bytes      |
| uint256       | 32 bytes      |
| bool          | 1 bytes       |
| byte1         | 1 bytes       |
| byte2         | 2 bytes       |
| byte32        | 32 bytes      |
| address       | 20 bytes      |

- 次の例

```sol
contract StorageLayout {
  uint64 public value1 = 1;
  uint64 public value2 = 2;
  uint64 public value3 = 3;
  uint64 public value4 = 4;
  uint256 public value5 = 5;
}
```

- slot index:0 を呼び出す

```js
// value = 0x04000000000000000300000000000000020000000000000001
const value = await web3.eth.getStorageAt(
  "0x9168fBa74ADA0EB1DA81b8E9AeB88b083b42eBB4",
  0
);
```

- 右から左へ、最初に宣言された変数が一番右のバイトを占めている

- 次の例。8byte, 32byte, 8byte と宣言したらどうなる？

```sol
contract StorageLayout {
  uint64 public value1 = 1;
  uint256 public value2 = 2;
  uint64 public value3 = 3;
}
```

```js
// 0x0000000000000000000000000000000000000000000000000000000000000001
web3.eth.getStorageAt("0x8eDf01e48279a8b59dcCDe6D06Df8A002a2132e0", 0);
// 0x0000000000000000000000000000000000000000000000000000000000000002
web3.eth.getStorageAt("0x8eDf01e48279a8b59dcCDe6D06Df8A002a2132e0", 1);
// 0x0000000000000000000000000000000000000000000000000000000000000003
web3.eth.getStorageAt("0x8eDf01e48279a8b59dcCDe6D06Df8A002a2132e0", 2);
```

#### Reference

- [ストレージ内の状態変数のレイアウト](https://solidity-ja.readthedocs.io/ja/latest/internals/layout_in_storage.html)
- [Solidity layout and access of storage state variables simply explained](https://coinsbench.com/solidity-layout-and-access-of-storage-variables-simply-explained-1ce964d7c738)
- [What is Smart Contract Storage Layout?](https://docs.alchemy.com/docs/smart-contract-storage-layout)

#### 2. Storage Position を計算する

Solidity における配列の格納位置は、配列の最初の要素の格納位置によって決定される。格納位置は、要素のインデックスにスロットサイズを掛けることで得られる。配列のような動的なサイズの型では、スロットサイズは 32 バイトとなる。

```js
const slotIndex = web3.utils.keccak256("chainPaths"); // Calculate the slot index
const slotSize = 32; // Slot size in bytes
const index = 1; // Index of the element you want to retrieve

const storagePosition = web3.utils.toHex(
  web3.utils
    .toBN(slotIndex)
    .add(web3.utils.toBN(index).mul(web3.utils.toBN(slotSize)))
);

web3.eth
  .getStorageAt(contractAddress, storagePosition, blockNumber)
  .then((result) => {
    console.log(`Storage value at position ${storagePosition}: ${result}`);
  })
  .catch((error) => {
    console.error(error);
  });
```

## [eth_call](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_call)

- [`eth_call`を使ってコマンドラインから呼び出す方法](../solidity/contract.md#eth_callを使ってコマンドラインから呼び出す方法)

### eth_call: Parameters

#### Transaction call object

- from (optional): 20bytes string
  - tx の sender address
- to: 20bytes string
  - tx の receiver (実行する contract のアドレス)
- gas (optional): int
  - `eth_call`は基本ガスを消費しないが、実行する function によってはこのパラメータが必要な場合がある
- gasPrice (optional): int
  - ガスの支払いに使われる gasPrice
- value (optional): int
  - このトランザクションで送信される native amount
- data: string
  - function selector と、エンコードされたパラメータ

#### Quantity|TAG

- block number, もしくは、`latest`, `earliest`, `pending`

## [eth_estimateGas](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_estimategas)

- [docs from alchemy](https://docs.alchemy.com/reference/eth-estimategas)

Transaction を完了させるために必要なガスの量の見積もりを生成して返す.
EVM の仕組みやノードの性能など様々な理由により、推定値は実際に取引で使用されたガス量よりも大幅に多くなる可能性がある。

## [eth_sendTransaction](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sendtransaction)

### Transaction Parameters

#### Transaction object

- from : 20bytes string
  - tx の sender address
- to: 20bytes string
  - tx の receiver (実行する contract のアドレス)
- gas (optional): int
  - default: 90000, トランザクジョン実行のために与えられる gas で、使われなかった余った gas は返却される
- gasPrice (optional): int
  - ガスの支払いに使われる gasPrice
- value (optional): int
  - このトランザクションで送信される native amount
- data: string
  - function selector と、エンコードされたパラメータ
- nonce (optional): int
  - nonce 値

### eth_sendTransaction: Parameters

eth_call と同じだが、data も optional となる。

### wagmi による実行

```ts
import { useContract } from "wagmi";

const tokenContract = useContract({
  address: token?.address ?? AddressZero,
  abi: erc20ABI,
  signerOrProvider: signer,
});

const estimatedGas = await tokenContract.estimateGas
  .approve(spender as Address, MaxUint256)
  .catch(() => {
    // General fallback for tokens who restrict approval amounts
    useExact = true;
    return tokenContract.estimateGas.approve(
      spender as Address,
      BigNumber.from(amountToApprove.quotient.toString())
    );
  });
```

## [eth_getCode](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getcode)

- [docs from alchemy](https://docs.alchemy.com/reference/eth-getcode)

特定のアドレスのコードを返す。contract のアドレスを渡した場合、smart contract の bytecode が取得できる。
