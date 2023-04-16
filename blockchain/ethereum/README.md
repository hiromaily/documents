# Ethereum

## References
- [How does Ethereum work, anyway?](https://www.preethikasireddy.com/post/how-does-ethereum-work-anyway)
- [Ethereum 2.0 Knowledge Base](https://kb.beaconcha.in/)
- [Ethereum Book (eth2)](https://eth2.incessant.ink/book/00__introduction/00__foreword.html)

## Contents
- [ABI](./abi.md)
  - ABIエンコーディング
- [Consensus Client (Beacon Chain)](./consensus_client.md)
  - Beacon Chainに関する情報まとめ
- [Data Structure](./data_structure.md)
  - データ構造とエンコーディング
  - Recursive Length Prefix (RLP)
  - Simple Serialize (SSZ)
- [Finality](./finality.md)
  - Block
  - Checkpoint
  - PoS Finality
- [Genesis](./genesis.md)
  - Genesis Config (genesis.json)
- [Light Client](./light-client.md)
- [Network](./network.md)
  - Networkの種類
  - Testnetの種類など
  - Private Network (Local Testnet)
  - Localnetの構築について
- [Node Client](./node_client.md)
  - EthereumのDocumentである、[Nodes and Clients](https://ethereum.org/en/developers/docs/nodes-and-clients/)の要約
  - Execution ClientとConsensus Clientについて
  - Nodeの種類について (Full node, Light node)
  - 自分でNodeを立てるメリット
  - 実行クライアント
  - コンセンサスクライアント
  - 同期モード
  - Nodeアーキテクチャー
    - 実行クライアントの役割
    - コンセンサスクライアントの役割
    - Validator (簡単なまとめのみ)
    - Node比較の構成要素
- [Phase](./phase.md)
- [Staking](./staking.md)
- [Tips](./tips.md)
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
