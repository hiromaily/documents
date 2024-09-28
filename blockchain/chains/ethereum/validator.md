# Validator

- [Spec: Phase 0 -- Honest Validator](https://github.com/ethereum/consensus-specs/blob/dev/specs/phase0/validator.md)
- [Validator](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/#validators)
- [My Journey to Becoming a Validator on Ethereum 2.0](https://consensys.net/blog/blockchain-explained/my-journey-to-becoming-a-validator-on-ethereum-2-0/)
- [My Journey to Being a Validator on Ethereum 2.0, Part 5](https://consensys.net/blog/developers/my-journey-to-being-a-validator-on-ethereum-2-0-part-5/)
- [How to become an ETH2 Validator](https://www.cleverti.com/blockchain/how-to-become-an-eth2-validator-step-by-step-practical-tutorial/)
- [Staking Launchpad](https://launchpad.ethereum.org/en/)
- [Spec: Phase 0 -- Deposit Contract](https://github.com/ethereum/consensus-specs/blob/dev/specs/phase0/deposit-contract.md)

- Ethreum mainnet の Deposit contract の特定のトランザクションを使用して`32ETH`を Deposit することでバリデーターになることができる
- 有効な Deposit が発生するたびに、イベントがトリガーされる
- Beacon チェーンはこのイベントログを参照する
- Deposit が行われ、Beacon チェーンのノードによって検出されると、バリデーターが起動される
- バリデータは新しいブロックを作成したり（ブロック提案者）、提案されたブロックに投票したり（委員会）する役割を担っている

![eth2 validator](https://raw.githubusercontent.com/hiromaily/documents/main/images/eth2_validator.webp 'eth2 validator')

- バリデータは、誠実な行動には報酬を与え、不正な行動にはペナルティを与える
- 報酬と罰則は、特定のシナリオに基づいて決定される。したがって、各バリデーターの預金は、報酬とペナルティーによって上下する。

- バリデータは Beacon ノードに接続され、バリデータの割り当てに関する更新情報を 取得する
- バリデータは、Beacon ノードの機能を実装したり、Beacon ノードを呼び出したりできるバリデータークライアントによって 実行される
- 1 つのバリデータクライアントで 1 つまたは複数のバリデータを実行できる

## PoS（Proof of Stake）のしくみ

ビーコンチェーンにおける Ethereum の PoS プロトコル`Casper FFG`の動作について

- 時間はエポックに分割され、エポックはさらに 12 秒ずつの 32 個のスロットに細分化される
- エポック開始前に、各スロットにブロック提案者としてのバリデータが割り当てられ、さらに委員会と呼ばれる特定のバリデータのグループ(最小 128 人)が割り当てられる
- バリデータは 1 つのエポックにつき 1 つのコミッティーにしか所属できない。また、1 つのスロットに対して複数の委員会が存在することもある
- すべての委員会は同じ大きさでなければならない

![eth2 validator](https://raw.githubusercontent.com/hiromaily/documents/main/images/eth2_validator2.webp 'eth2 validator')

- 各スロットにおいて、そのブロック提案者は既存の Beacon チェーンに追加するブロックを選択し、委員会はこれをメインチェーンに追加するかどうかを投票する
- これらの投票は「認証」と呼ばれ、バリデータの預託金によって重み付けされる
- バリデータは自分の票をブロードキャストし、バリデータの 3 分の 2 の票を得たブロックが受理される

- 多数決は、バリデータの数ではなく、預託金の重みに基づいて決定される。
- 2/3rd majority とは、預託金の合計が、そのバリデータの集合の預託金の合計の 2/3 に等しいバリデータの集合を指す
- 安全に機能させるためには、最低 16,384 のバリデータ数が必要である
- 仮に攻撃者が 16,384 個のバリデータの 3 分の 1 を制圧したとしても、同じ攻撃者がランダムに選んだ 128 個のバリデータ委員会の 3 分の 2 以上を制圧できる可能性は非常に低い（1 兆分の 1）
- エポック境界のブロック（チェックポイント）だけが正当化され、最終化される。最終化については[GASPER](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/gasper/)を参照

## Staking / Validator Deposit Contract

- Lodestar については、Beacon Node が指定した`Deposit Contract`

### Spec

- [Deposit Contract on spec](https://github.com/ethereum/consensus-specs/tree/dev/solidity_deposit_contract)
- [Phase 0 -- Deposit Contract](https://github.com/ethereum/consensus-specs/blob/dev/specs/phase0/deposit-contract.md)

### Others

- [Check the deposit contract address](https://ethereum.org/en/staking/deposit-contract/)
- [Deposit Process](https://kb.beaconcha.in/ethereum-2.0-depositing)
- [Validator deposit contract on Prysm](https://docs.prylabs.network/docs/how-prysm-works/validator-deposit-contract)

  - `Validator Deposit Contract` は、バリデータを初期化し、Ethreum の PoS に完全に参加するために必要な`32ETH`の deposit を行うための Smart Contract
  - Validator は、既存の Ethreum の Blockchain から`Validator Deposit Contract`に`32ETH`の入金が行われ、ノードが完全にスピンアップすると、PoS システムのキューに入れられる
  - すべての Initial Deposit が Ethreum から行われるようにすることで、Ethereum の PoS は、既存の Ether のセキュリティプールと価値を活用し、起動時にネットワークを secure にすることができる
  - Prysm ノードの場合、このコントラクトからの Deposit Log を自動的にリッスンし、バリデータが起動できる状態になったことを検出する

### Example

- [eth1 の genesis.json sample](https://github.com/rauljordan/eth-pos-devnet/blob/master/execution/genesis.json#L32-L35)

```
  "0x4242424242424242424242424242424242424242": {
   "balance": "0",
   "code": "0x60806040526004361061003f5760003560e01c80630...."
  },
```

- いくつかの sample ではアドレスに`0x4242424242424242424242424242424242424242`が使われているが、eth2 側の config に`DEPOSIT_CONTRACT_ADDRESS`があり、それが一致していれば問題ないと思われる
- [sample config](https://notes.ethereum.org/@protolambda/merge-devnet-setup-guide#Eth2-config-template)
