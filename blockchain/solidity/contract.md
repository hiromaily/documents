# Contract

## thisについて
`this`は現在のコントラクト型でアドレスに明示的に変換可能

## Javascript から Solidity の Contract の呼び出し

- [CALLING A SMART CONTRACT FROM JAVASCRIPT](https://ethereum.org/en/developers/tutorials/calling-a-smart-contract-from-javascript/)
- [Sending Static Calls to a Smart Contract With Ethers.js](https://betterprogramming.pub/sending-static-calls-to-a-smart-contract-with-ethers-js-e2b4ceccc9ab)
- [How to call a contract function/method using ethersjs](https://ethereum.stackexchange.com/questions/120817/how-to-call-a-contract-function-method-using-ethersjs)

### call()と send()の違いについて

- [Calling smart contract functions using web3.js - call() vs send()](https://bitsofco.de/calling-smart-contract-functions-using-web3-js-call-vs-send/)

- 状態の変わる function の呼び出しには、`call()`
- 状態の変わらない function の呼び出しには、`send()`

### Typescript Sample using Web3

```
import Web3 from 'web3'
import { AbiItem } from 'web3-utils'
import EndpointABI from '../json/endpoint.json'

const web3 = new Web3(args.nodeURL)
const contractAbi: AbiItem[] = EndpointABI as AbiItem[];
const endpoint = new web3.eth.Contract(
  contractAbi,
  args.contractAddr
)

// call
await endpoint.methods.estimateFees(chainID, ua, payload, payInZro, fmtAdapterParams).call((err: any, res: any) => {
  if (err) {
    console.log('An error occured', err)
    return
  }
  console.log('The balance is: ', res)
})
```

### `eth_call`を使ってコマンドラインから呼び出す方法

1. 実行したい Contract のアドレスを etherscan などで探す
2. function の signature を使って function selector を抽出する

- `defaultAdapterParams(uint16,uint16)` の場合, [keccak-256 で hash 化できるサイト](https://emn178.github.io/online-tools/keccak_256.html)などで、signature を hash 化し、出力された hash 値から 8 バイト取得し、それに 0x をつけて、`0x2a819bbf`といった文字列を作成する

3. function のパラメータの値をそれぞれ 16 進数化する
4. curl で以下のようなコマンドを実行する

- params to: コントラクトアドレス
- data: 2 で作成した function selector と 16 進数化したパラメータを連結した文字列。この例では以下のパラメータの連携になる
  - 0x2a819bbf
  - 0000000000000000000000000000000000000000000000000000000000000065
  - 0000000000000000000000000000000000000000000000000000000000000001

```
curl -X POST -H "Content-Type: application/json" \
--data '{"jsonrpc": "2.0", "id": 1, "method": "eth_call", "params": [{"to": "0x4d73adb72bc3dd368966edd0f0b2148401a178e2", "data": "0x2a819bbf00000000000000000000000000000000000000000000000000000000000000650000000000000000000000000000000000000000000000000000000000000001"}, "latest"]}' \
"https://mainnet.infura.io/v3/XXXXXX"
```

#### RPC の Endpoint

余談だが、endpoint には、[ankr](https://www.ankr.com/rpc/)が便利

##  `address.call{}()`
- [アドレス型](./README.md#address型)
- [アドレス型のメンバー](https://solidity-ja.readthedocs.io/ja/latest/units-and-global-variables.html#address-related)
- [アドレスのメンバ](https://solidity-ja.readthedocs.io/ja/latest/types.html#members-of-addresses)
```
# `value`修飾子でEtherを送金する
(bool success, ) = addr.call{value: amount}("");

# gas修飾子で供給ガスを調整することも可能
addr.call{value: msg.value, gas: 5000}(
    abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
);
```


- [How to use address.call{}() in Solidity](https://ethereum.stackexchange.com/questions/96685/how-to-use-address-call-in-solidity)

## Constructors

- [Solidity Tutorial : all about Constructors](https://medium.com/coinmonks/solidity-tutorial-all-about-constructors-46a10610336)

- constructor はコントラクトが deploy されるタイミングで一度だけ呼び出される
- constructor に`function`は不要
- constructor は必ずしも定義が必要なわけではない
- `internal` constructor は`0.7.0`以降は deprecated されている。その代わりに `abstract contract`が作れるはず。
- contract の継承と呼び出しについて

```sol
contract Animal {

    string name;
    uint feet;
    bool canSwim;

    constructor(string memory _name, uint _feet, bool _canSwim) {
        name = _name;
        feet = _feet;
        canSwim = _canSwim;
    }
}
contract Lion is Animal {

    constructor(string memory _name)
        Animal(_name, 4, true)
    {
        // ...
    }
}
```
