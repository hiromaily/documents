# Transaction の作成から送信まで

## [eth_sendTransaction](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sendtransaction)の実行に伴うフローについて

- Transaction の作成
  - その Account から有効な Nonce を設定する
  - Gas Estimation
- Transaction への署名
  - sender の private key を使って署名をし、この署名は sender によって transaction が作成されたことの暗号証明及び改竄されていないことの証明となる
- transaction を Ethereum Network に bloadcast する
- Transaction を受け取った Node は、その署名、Nonce 等を検証する
- 検証が問題なければ、Node は Transaction を Transaction pool に追加する
- Ethereum2.0 以前では、Miner が Mining を行うことになる。Ethereum2.0 では Validator が検証する。

### 署名について

[デジタル署名](../../cryptography/digital-signature.md)

### 署名済み Transaction の検証について

- WIP: 要検証
- [Ethers v5 → viem Migration Guide](https://viem.sh/docs/ethers-migration.html)

```ts
import { parseTransaction } from "viem";
import { ethers } from "ethers";

// Sample signed transaction data received from eth_sendTransaction
const signedTransactionData =
  "0xf86c808504a817c8008252089435353535353535353535353535353535353535358801ca0cf1f68a82dd313f46a59a5a43e1e87267859356f4ea67b9ed89b277d9dc4c9a03a06595c34907c54d0b1e5ea37a16d4b29d0482ca8d9a13467b9538d7d0f66f8c787";

// Decode the signed transaction
//
//parseTransaction
const decodedTx = parseTransaction(signedTransactionData);

// Verify the sender's address matches the expected address
const expectedSenderAddress = "0xExpectedSenderAddress";
if (decodedTx.from.toLowerCase() !== expectedSenderAddress.toLowerCase()) {
  console.error("Sender address mismatch");
  return;
}

// Verify the signature
const recoveredAddress = ethers.utils.verifyMessage(
  decodedTx.data,
  signedTransactionData
);
if (recoveredAddress.toLowerCase() !== expectedSenderAddress.toLowerCase()) {
  console.error("Invalid signature");
  return;
}

// If all verifications pass, proceed with broadcasting the transaction
// and executing it on the Ethereum network
console.log("Transaction is valid and can be broadcasted");
```

## トランザクションのライフサイクル

- トランザクションが送信されると、次のようになる
  - トランザクションを送信すると、暗号化により Transaction Hash が生成される `0x97d99bc7729211111a21b12c933c949d4f31684f1d6954ff477d0477538ff017`
  - そして、そのトランザクションはネットワークにブロードキャストされ、他の多くのトランザクションと一緒に Transaction Pool に含まれる
  - バリデータは、トランザクションを検証して `successful` と見なすために、あなたのトランザクションを選んでブロックに含めなければならない
  - 時間が経つにつれて、送信したトランザクションを含むブロックは`justified`,`finalized`にアップグレードされる。これらのアップグレードにより、あなたのトランザクションが成功し、決して変更されないことがより確実となる。いったん`finalized`されたブロックは、何十億ドルもかかる攻撃によってのみ変更することができる。
- 手順をまとめると
  - Client 側での Transaction への署名
  - Transaction の送信
  - Transaction Hash が生成される
  - Mem Pool へ Transaction が含まれる
    - このとき Transaction は Broad Cast される
    - Status は`Pending`
  - Validator による Transaction の検証
    - signature, gas limit, gas price
  - Validator による transaction の選定、Block への取り込み

## トランザクションの Replace/Cancel

- [Metamask: How to speed up or cancel a pending transaction](https://support.metamask.io/hc/en-us/articles/360015489251-How-to-speed-up-or-cancel-a-pending-transaction)
- [Metamask: Why can't I replace a pending transaction?](https://support.metamask.io/hc/en-us/articles/11225646961563-Why-can-t-I-replace-a-pending-transaction)
- [Etherscan: How to replace a Pending/Dropped transaction](https://info.etherscan.com/how-to-replace-a-transaction/)
- [alchemy: Ethereum Transactions - Pending, Mined, Dropped & Replaced](https://docs.alchemy.com/docs/ethereum-transactions-pending-mined-dropped-replaced)
- [How to fix replacement transaction underpriced](https://mycryptoview.com/meta-mask/how-to/how-to-fix-replacement-transaction-underpriced)

In Ethereum, once a transaction is broadcasted to the network and included in the transaction pool (mem pool) of a node, it's generally not possible to replace or cancel it directly. However, you can try to accelerate or replace a transaction using the following methods:

### 1. Replace-by-fee (RBF)

Ethereum does not natively support RBF (as of my last knowledge update in January 2022). RBF is more commonly associated with Bitcoin.
However, you can try to broadcast a new transaction with the same nonce but a higher gas fee. Miners are incentivized to include transactions with higher fees, so they might pick up the new transaction instead of the stuck one.

### 2. Fee Bumping on EIP-1559 Transactions

If you're using Ethereum Improvement Proposal (EIP)-1559 transactions, you may be able to increase the fee by sending a new transaction with the same nonce and a higher gas fee per unit of computation (the "gas price"). This is similar to RBF but specific to EIP-1559.

### 3. Use of Transaction Accelerators

Some services provide transaction acceleration, allowing you to "speed up" your stuck transaction by paying an additional fee. These services are usually operated by miners or mining pools.

### 4. Wait for Transaction to be Dropped

Transactions in the mempool will eventually be dropped if they remain unmined for an extended period. This can be time-consuming, and there's no guarantee.

### 5. Revert the Transaction Through a Contract

If the transaction was sent to a smart contract, you might be able to send a new transaction to the same contract with a function that cancels or reverts the original transaction.

### 6. Using Flashbots

Flashbots is a research and development organization that works on MEV (Miner/Maximal Extractable Value) solutions. It provides a way to submit transactions directly to miners, potentially bypassing the mempool.
