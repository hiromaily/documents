# Contract

## Mainnetのcontractの呼び出し
- [CALLING A SMART CONTRACT FROM JAVASCRIPT](https://ethereum.org/en/developers/tutorials/calling-a-smart-contract-from-javascript/)
- [Sending Static Calls to a Smart Contract With Ethers.js](https://betterprogramming.pub/sending-static-calls-to-a-smart-contract-with-ethers-js-e2b4ceccc9ab)
- [How to call a contract function/method using ethersjs](https://ethereum.stackexchange.com/questions/120817/how-to-call-a-contract-function-method-using-ethersjs)


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

## `address.call{}()`
```
(bool success, ) = _refundAddress.call{value: amount}("");
```

- [How to use address.call{}() in Solidity](https://ethereum.stackexchange.com/questions/96685/how-to-use-address-call-in-solidity)
