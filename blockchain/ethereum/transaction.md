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

Ethereum では、トランザクションがネットワークにブロードキャストされ、ノードのトランザクションプール（mem pool）に含まれると、通常、それを直接置き換えたりキャンセルしたりすることはできない。しかし、以下の方法を使用してトランザクションを加速したり置き換えたりすることは可能：

### 1. Replace-by-fee (RBF)

Ethereum does not natively support RBF (as of my last knowledge update in January 2022). RBF is more commonly associated with Bitcoin.
However, you can try to broadcast a new transaction with the same nonce but a higher gas fee. Miners are incentivized to include transactions with higher fees, so they might pick up the new transaction instead of the stuck one.

Ethereum は RBF をネイティブにサポートしていない（2022 年 1 月現在）。RBF はビットコインの方が一般的である。
しかし、同じ nonce でより高いガス料金の新しいトランザクションをブロードキャストしようとすることは可能。マイナーはより高い手数料のトランザクションを含むようインセンティブを与えられているので、スタックしたトランザクションの代わりに新しいトランザクションをピックアップするかもしれない。

#### [How to re-send a transaction with higher gas price using Ethers.js](https://www.quicknode.com/guides/ethereum-development/transactions/how-to-re-send-a-transaction-with-higher-gas-price-using-ethersjs)

Re-sending the same transaction with higher gas and the same nonce using Ethers.js

同じ nonce を使っていても、transaction を構成するパラメータのうちの、gasPrice の値を増やせば、txHash も変わることになる。

### 2. Fee Bumping on EIP-1559 Transactions

If you're using Ethereum Improvement Proposal (EIP)-1559 transactions, you may be able to increase the fee by sending a new transaction with the same nonce and a higher gas fee per unit of computation (the "gas price"). This is similar to RBF but specific to EIP-1559.

Ethereum Improvement Proposal（EIP）-1559 トランザクションを使用している場合、同じ nonce と計算単位あたりの高いガス料金（「ガス料金」）で新しいトランザクションを送信することで、料金を増やすことができる場合がある。これは RBF に似ているが、EIP-1559 に特有である。

### 3. Use of Transaction Accelerators

Some services provide transaction acceleration, allowing you to "speed up" your stuck transaction by paying an additional fee. These services are usually operated by miners or mining pools.

トランザクションの高速化を提供するサービスもあり、追加料金を支払うことで動かなくなったトランザクションを「高速化」することができる。これらのサービスは通常、マイナーまたはマイニングプールによって運営されている。
おそらく、Metamask の仕組みがこれにあたる。

### 4. Wait for Transaction to be Dropped

Transactions in the mempool will eventually be dropped if they remain unmined for an extended period. This can be time-consuming, and there's no guarantee.

mempool 内のトランザクションは、長期間 mine されないままであれば、最終的に削除される。これには時間がかかり、保証もない。

### 5. Revert the Transaction Through a Contract

If the transaction was sent to a smart contract, you might be able to send a new transaction to the same contract with a function that cancels or reverts the original transaction.

トランザクションがスマートコントラクトに送信された場合、元のトランザクションをキャンセルまたは元に戻す関数を使って、同じコントラクトに新しいトランザクションを送信できるかもしれない。

### 6. Using Flashbots

Flashbots is a research and development organization that works on MEV (Miner/Maximal Extractable Value) solutions. It provides a way to submit transactions directly to miners, potentially bypassing the mempool.

Flashbots は、MEV (マイナー/最大抽出可能値) ソリューションに取り組む研究開発組織。これは、メモリプールをバイパスして、マイナーにトランザクションを直接送信する方法を提供する。

## [EIP-1559](https://eips.ethereum.org/EIPS/eip-1559)

Ethereum Improvement Proposal (EIP) 1559 は 2021 年 8 月 5 日に行われたアップグレードで、Ethereum のネットワーク取引手数料（ガス手数料）の計算方法と処理方法を変更するもの。このアップグレードは、ブロックベースの基本手数料と送信者指定の最大手数料のシステムを使用することで、イーサリアムのトランザクションをより効率的にし、ネットワーク混雑の多い時期や少ない時期により均等にマイナーにインセンティブを与えるために、ガス価格の入札ではなく、より効率的にした。これは London の Hardfork でパッケージ化された。
