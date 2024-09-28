# Ethereum

## References

- [How does Ethereum work, anyway?](https://www.preethikasireddy.com/post/how-does-ethereum-work-anyway)
- [Ethereum 2.0 Knowledge Base](https://kb.beaconcha.in/)
- [Ethereum Book (eth2)](https://eth2.incessant.ink/book/00__introduction/00__foreword.html)

## Contents

- [ABI](./abi.md)
  - ABI エンコーディング
- [Consensus Client (Beacon Chain)](./consensus_client.md)
  - Beacon Chain に関する情報まとめ
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
  - Network の種類
  - Testnet の種類など
  - Private Network (Local Testnet)
  - Localnet の構築について
- [Node Client](./node_client.md)
  - Ethereum の Document である、[Nodes and Clients](https://ethereum.org/en/developers/docs/nodes-and-clients/)の要約
  - Execution Client と Consensus Client について
  - Node の種類について (Full node, Light node)
  - 自分で Node を立てるメリット
  - 実行クライアント
  - コンセンサスクライアント
  - 同期モード
  - Node アーキテクチャー
    - 実行クライアントの役割
    - コンセンサスクライアントの役割
    - Validator (簡単なまとめのみ)
    - Node 比較の構成要素
- [Phase](./phase.md)
- [Staking](./staking.md)
- [Tips](./tips.md)
- [Transaction と Gas](./transaction-gas.md)
- [Upgrade History](./upgrade_history.md)
- [Validator](./validator.md)
  - PoS（Proof of Stake）のしくみ

## Development tools

- [Truffle](https://trufflesuite.com/)
- [Hardhat](https://hardhat.org/)
- [Foundry](https://github.com/foundry-rs/foundry/)

## 用語集

- ENR: Ethereum Node Records
  - ノード検出プロトコル
- Ethash
  - Ethereum におけるプルーフオブワークのアルゴリズム
  - マイナーがハッシュ値を生成する際に、いくつかの計算プロセスを必要とし、メモリ耐性（ASIC 耐性）を備えている
  - ASIC 耐性によって、マイニングの中央集権化を防ぐ
  - Ethash アルゴリズムのステップは以下の通り
    - １つ前のブロックヘッダーの情報と、マイナーが推測したノンスを、SHA3 でハッシュ化する。この値を Mix0 とする。
    - Mix0 によって、DAG Page から 128 バイトのページを取得する
    - Mix0 は、取得した DAG Page と組み合わされ Mix1 とする。この組み合わせはイーサリアム固有のミキシング機能を用いる
    - 2 および 3 を 64 回繰り返して、最終的なアウトプットの Mix64 を出力する
    - Mix64 は、処理されて 32 バイトの Mix ダイジェストが生成される
    - Mix ダイジェストは、あらかじめ定義されたターゲットの閾値と比較される。この Mix ダイジェストが、ターゲット閾値以下であればマイニングが成功したとみなされ、イーサリアムネットワークにブロードキャストされ、マイナーは報酬を獲得する。
