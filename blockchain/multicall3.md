# Multicall3
- 複数のコントラクトの読み取り結果を1つのJSON-RPCリクエストに集約する
- 単一のトランザクションで複数の状態変更コールを実行する
- 100以上のETH系のchain上にdeployされている

## References
- [Official](https://www.multicall3.com/)
- [github: multicall](https://github.com/mds1/multicall)

- [Deploy Chain List](https://www.multicall3.com/deployments)
- [ABI](https://www.multicall3.com/abi)

## Request例
```sh
{
  "jsonrpc": "2.0",
  "id": 5,
  "method": "eth_call",
  "params": [
    {
      "data": "0x82ad56cb0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000200000000000000000000000008c3085d9a554884124c998cdb7f6d7219e9c1e6f0000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a41ab62430000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000066000000000000000000000000c1f3a7613c70bbf1bd8c4924192bd75451fe0dd1000000000000000000000000000000000000000000000000000000000098968000000000000000000000000000000000000000000000000000000000",
      "to": "0xca11bde05977b3631167028862be2a173976ca11"
    },
    "latest"
  ]
}
```
- method: eth_call
- params:
  - data: 別途説明
  - to: "0xca11bde05977b3631167028862be2a173976ca11" のアドレスは、`Multicall3`コントラクトのアドレスとなる

### params.dataについて
#### 最初の10byte: `0x82ad56cb`
- [Ethereum Signature Database](https://www.4byte.directory/signatures/?bytes4_signature=0x82ad56cb)によると、
  - `aggregate3((address,bool,bytes)[])`
- solidity function
  - `function aggregate3(Call3[] calldata calls) external payable returns (Result[] memory returnData);` 
- Call3
```sol
struct Call3 {
  address target;
  bool allowFailure;
  bytes callData;
}
```

## Decode request data
```ts
import { ethers } from 'ethers';

// Sample data and ABI
const data = '0x82ad56cb0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000200000000000000000000000008c3085d9a554884124c998cdb7f6d7219e9c1e6f0000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a41ab62430000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000066000000000000000000000000c1f3a7613c70bbf1bd8c4924192bd75451fe0dd1000000000000000000000000000000000000000000000000000000000098968000000000000000000000000000000000000000000000000000000000';
// copy abi from https://www.multicall3.com/abi#json-minified
const abi = [
  // Insert the contract ABI here
];

// Create a contract interface from the ABI
const contractInterface = new ethers.Interface(abi);

// Get the method ID from the data
const methodId = data.slice(0, 10);

// Find the function signature from the method ID
const signature = contractInterface.getFunction(methodId).format();

// Get the encoded parameters from the data
//const encodedParameters = '0x' + data.slice(10);

// Decode the parameters using the ABI
//const decodedParameters = contractInterface.decodeFunctionData(signature, encodedParameters);
const decodedParameters = contractInterface.decodeFunctionData(signature, data);
console.log(decodedParameters);
// decodedParameters: Result(1) [
//   Result(1) [
//     Result(3) [
//       '0x8C3085D9a554884124C998CDB7f6d7219E9C1e6F',
//       true,
//       '0x1ab62430000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000066000000000000000000000000c1f3a7613c70bbf1bd8c4924192bd75451fe0dd10000000000000000000000000000000000000000000000000000000000989680'
//     ]
//   ]
// ]
```