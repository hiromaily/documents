# Validator
[Validator](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/#validators)

- Ethreum mainnetの Deposit contractの特定のトランザクションを使用して`32ETH`をDepositすることでバリデーターになることができる
- 有効なDepositが発生するたびに、イベントがトリガーされる
- Beaconチェーンはこのイベントログを参照する
- Depositが行われ、Beaconチェーンのノードによって検出されると、バリデーターが起動される
- バリデータは新しいブロックを作成したり（ブロック提案者）、提案されたブロックに投票したり（委員会）する役割を担っている

![eth2 validator](https://raw.githubusercontent.com/hiromaily/documents/main/images/eth2_validator.webp "eth2 validator")

- バリデータは、誠実な行動には報酬を与え、不正な行動にはペナルティを与える
- 報酬と罰則は、特定のシナリオに基づいて決定される。したがって、各バリデーターの預金は、報酬とペナルティーによって上下する。

- バリデータはBeaconノードに接続され、バリデータの割り当てに関する更新情報を 取得する
- バリデータは、Beaconノードの機能を実装したり、Beaconノードを呼び出したりできるバリデータークライアントによって 実行される
- 1つのバリデータクライアントで1つまたは複数のバリデータを実行できる

## PoS（Proof of Stake）のしくみ
ビーコンチェーンにおけるEthereumのPoSプロトコル`Casper FFG`の動作について

- 時間はエポックに分割され、エポックはさらに12秒ずつの32個のスロットに細分化される
- エポック開始前に、各スロットにブロック提案者としてのバリデータが割り当てられ、さらに委員会と呼ばれる特定のバリデータのグループ(最小128人)が割り当てられる
- バリデータは1つのエポックにつき1つのコミッティーにしか所属できない。また、1つのスロットに対して複数の委員会が存在することもある
- すべての委員会は同じ大きさでなければならない

![eth2 validator](https://raw.githubusercontent.com/hiromaily/documents/main/images/eth2_validator.webp "eth2 validator")

- 各スロットにおいて、そのブロック提案者は既存のBeaconチェーンに追加するブロックを選択し、委員会はこれをメインチェーンに追加するかどうかを投票する
- これらの投票は「認証」と呼ばれ、バリデータの預託金によって重み付けされる
- バリデータは自分の票をブロードキャストし、バリデータの3分の2の票を得たブロックが受理される

- 多数決は、バリデータの数ではなく、預託金の重みに基づいて決定される。
- 2/3rd majority とは、預託金の合計が、そのバリデータの集合の預託金の合計の 2/3 に等しいバリデータの集合を指す
- 安全に機能させるためには、最低16,384のバリデータ数が必要である
- 仮に攻撃者が16,384個のバリデータの3分の1を制圧したとしても、同じ攻撃者がランダムに選んだ128個のバリデータ委員会の3分の2以上を制圧できる可能性は非常に低い（1兆分の1）
- エポック境界のブロック（チェックポイント）だけが正当化され、最終化される。最終化については[GASPER](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/gasper/)を参照

## TODO
lodestar における`Validator deposit contract`について
- この挙動にdevモードであることは関係あるか？
- `Validator deposit contract`
  - は、バリデータを初期化し、PoSに参加するために必要な32ETHのdepositを行うためのSCとなる。
  - Validatorは、既存のEthereumのブロックチェーンから`Validator deposit contract`に32ETHの入金が行われ、ノードが完全に起動すると、Proof-of-Stake システムのキューに入れられる。
  - Prysmノードの場合、このコントラクトからのdeposit logを自動的にリッスンし、バリデータが起動できる状態になったことを検出する。


## Staking / Validator Deposit Contract
### Spec
- [Deposit Contract on spec](https://github.com/ethereum/consensus-specs/tree/dev/solidity_deposit_contract)
- [Phase 0 -- Deposit Contract](https://github.com/ethereum/consensus-specs/blob/dev/specs/phase0/deposit-contract.md)

### Others
- [Check the deposit contract address](https://ethereum.org/en/staking/deposit-contract/)
- [Deposit Process](https://kb.beaconcha.in/ethereum-2.0-depositing)
- [Validator deposit contract on Prysm](https://docs.prylabs.network/docs/how-prysm-works/validator-deposit-contract)

  - `Validator Deposit Contract` は、バリデータを初期化し、EthreumのPoSに完全に参加するために必要な`32ETH`のdepositを行うためのSmart Contract
  - Validatorは、既存のEthreumのBlockchainから`Validator Deposit Contract`に`32ETH`の入金が行われ、ノードが完全にスピンアップすると、PoSシステムのキューに入れられる
  - すべてのInitial DepositがEthreumから行われるようにすることで、EthereumのPoSは、既存のEtherのセキュリティプールと価値を活用し、起動時にネットワークをsecureにすることができる
  - Prysmノードの場合、このコントラクトからのDeposit Logを自動的にリッスンし、バリデータが起動できる状態になったことを検出する

### Example
- [eth1のgenesis.json sample](https://github.com/rauljordan/eth-pos-devnet/blob/master/execution/genesis.json#L32-L35)
```
		"0x4242424242424242424242424242424242424242": {
			"balance": "0",
			"code": "0x60806040526004361061003f5760003560e01c80630...."
		},
```
- いくつかのsampleではアドレスに`0x4242424242424242424242424242424242424242`が使われているが、eth2側のconfigに`DEPOSIT_CONTRACT_ADDRESS`があり、それが一致していれば問題ないと思われる
- [sample config](https://notes.ethereum.org/@protolambda/merge-devnet-setup-guide#Eth2-config-template)