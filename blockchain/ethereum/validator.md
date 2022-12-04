# Validator

## TODO
lodestar における`Validator deposit contract`について
- この挙動にdevモードであることは関係あるか？
- `Validator deposit contract`
  - は、バリデータを初期化し、PoSに参加するために必要な32ETHのdepositを行うためのSCとなる。
  - Validatorは、既存のEthereumのブロックチェーンから`Validator deposit contract`に32ETHの入金が行われ、ノードが完全に起動すると、Proof-of-Stake システムのキューに入れられる。
  - Prysmノードの場合、このコントラクトからのdeposit logを自動的にリッスンし、バリデータが起動できる状態になったことを検出する。


## Staking / Validator Deposit Contract
- [Check the deposit contract address](https://ethereum.org/en/staking/deposit-contract/)
- [Deposit Process](https://kb.beaconcha.in/ethereum-2.0-depositing)
- 