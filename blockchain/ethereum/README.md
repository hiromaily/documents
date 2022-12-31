# Ethereum

[How does Ethereum work, anyway?](https://www.preethikasireddy.com/post/how-does-ethereum-work-anyway)

## Contents
- [ABI](./abi.md)
- [Consensus Client](./consensus_client.md)
- [データ構造とエンコーディング](./data_structure.md)
- [Genesis](./genesis.md)
- [Network](./network.md)
- [Node Client](./node_client.md)
- [The Merge](./the_merge.md)
- [TransactionとGas](./transaction-gas.md)
- [Upgrade History](./upgrade_history.md)
- [Validator](./validator.md)

## Development tools
- [Truffle](https://trufflesuite.com/)
- [Hardhat](https://hardhat.org/)
- [Foundry](https://github.com/foundry-rs/foundry/)

## 用語集
- ENR: Ethereum Node Records 
  - ノード検出プロトコル
- Ethash
  - Ethereumにおけるプルーフオブワークのアルゴリズム 
  - マイナーがハッシュ値を生成する際に、いくつかの計算プロセスを必要とし、メモリ耐性（ASIC耐性）を備えている
  - ASIC耐性によって、マイニングの中央集権化を防ぐ
  - Ethashアルゴリズムのステップは以下の通り
    - １つ前のブロックヘッダーの情報と、マイナーが推測したノンスを、SHA3でハッシュ化する。この値をMix0とする。
    - Mix0によって、DAG Pageから128バイトのページを取得する
    - Mix0は、取得したDAG Pageと組み合わされMix1とする。この組み合わせはイーサリアム固有のミキシング機能を用いる
    - 2および3を64回繰り返して、最終的なアウトプットのMix64を出力する
    - Mix64は、処理されて32バイトのMixダイジェストが生成される
    - Mixダイジェストは、あらかじめ定義されたターゲットの閾値と比較される。このMixダイジェストが、ターゲット閾値以下であればマイニングが成功したとみなされ、イーサリアムネットワークにブロードキャストされ、マイナーは報酬を獲得する。
