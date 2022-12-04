# Ethereum 2.0

`Ethereum1.0`と`Ethereum2.0`の名称は廃止され、`実行レイヤー`と`合意レイヤー`という呼称に改めされた

- Eth1 -> 実行レイヤー
- Eth2 -> 合意レイヤー
- 実行レイヤー + 合意レイヤー = イーサリアム

## References
- [Ethereum 2.0 Knowledge Base](https://kb.beaconcha.in/)
- [Ethereum Book (eth2)](https://eth2.incessant.ink/book/00__introduction/00__foreword.html)

### Upgrade
- [The Merge](https://ethereum.org/en/upgrades/merge/)
- [Upgrading Ethereum to radical new heights](https://ethereum.org/en/upgrades/)
- [リブランディング: Eth2 の名称廃止](https://blog.ethereum.org/ja/2022/01/24/the-great-eth2-renaming)
- [The New Ethereum Upgrade (2.0): Your Guide 2022](https://www.alchemy.com/overviews/ethereum-2-0-your-guide-for-2022)

### Consensus Client
- [The Beacon Chain Ethereum 2.0 explainer you need to read first](https://ethos.dev/beacon-chain)
- [ethereum/consensus-specs](https://github.com/ethereum/consensus-specs/tree/dev/specs/altair/light-client)
- [Diversify Now](https://clientdiversity.org/)
- [Ethereum 2.0 (Eth2)・コンセンサスレイヤーとは？](https://pontem.network/posts/ethereum-2-0-eth2-konsensasureiyatoha)

## Phase

Ethereum 2.0 と呼ばれる大規模なアップデートにはフェーズが分かれている。

### Phase 0 The Beacon Chain

- ビーコン チェーンを稼働させる
  - ビーコン チェーン、PoS コンセンサス メカニズム(Casper)、バリデータ ノードの 3 つの主要な技術的実装が Ethereum エコシステムに提供された。
  - ETH2.0(Serenity) の開発が進むにつれて、ビーコン チェーンはイーサリアム ネットワークの主要な決済レイヤーになり、今後のシャード チェーンの調整を担当するようになる。

### Phase 1 The Merge

- 現在、マージは 2022 年第 2 四半期に予定されている
- 完了すると、イーサリアム メインネットはビーコン チェーン内のシャードになり、PoS は公式のコンセンサス メカニズムになる
- イーサリアム メインネット シャードは PoS を使用し、イーサリアムの PoW とマイニングの両方を終了する
- メインネットを追加することで、この新しい PoS イーサリアムにはスマート コントラクトを実行する機能が含まれ、イーサリアムのすべての完全な履歴と状態が得られる
- ステークされた ETH の引き出しなどの機能は、マージ後すぐにはサポートされないことに注意
  - これらは代わりに、次の最初のハードフォークで Release される予定

### Phase 2 Shard Chains (シャードチェーン)

- これは 2 回の更新で提供される
- バージョン 1: データの可用性
  - シャード チェーンは、最初はイーサリアム ネットワークに余分なデータのみを提供し、63 個の新しいチェーン (合計 64 個) を追加する
  - ローンチ時には、トランザクションやスマート コントラクトはサポートされない
  - ただし、これらの追加されたチェーンとロールアップにより、トランザクション容量が劇的に向上し、ガス料金が削減され、1 秒あたり数万のトランザクションを処理することが可能になる
  - ロールアップは、メインの Ethereum チェーン (レイヤー 1) からトランザクションを実行し、完了したトランザクション データをレイヤー 1 にポストするレイヤー 2 ソリューション
  - トランザクションを単一のオフチェーン トランザクションに「ロールアップ」するこのプロセスには、スケーラビリティの大きな利点がある
- バージョン 2: コードの実行
  - アップグレードの最終段階では、シャードが現在のイーサリアム メインネットにより似たものになり、トランザクションの処理とスマート コントラクトの実行が可能になる
  - シャードも通信できるようになり、シャード間のトランザクションが可能になる
  - このステップが必要かどうかは、イーサリアム コミュニティ内で議論されている
    - 多くの人は、「バージョン 1: データの可用性」で提供される 1 秒あたりのトランザクション数の増加で十分であり、「よりスマートな」シャードは必要ないと考えている

## Node(Client) と Network

- [References](https://docs.prylabs.network/docs/concepts/nodes-networks)

- イーサリアムには、主に`実行ノード`と`ビーコンノード`の 2 種類のノードがある
- ユーザーが `32 ETH` をステークして Ethereum のプルーフ オブ ステーク コンセンサス メカニズムに参加する場合、Prysm ビーコン ノードに接続する`バリデータ クライアント`と呼ばれる別のソフトウェアを使用する
  - これは、新しいブロックの作成や他の提案されたブロックへの投票など、バリデータ キーと義務を管理する特別なソフトウェア
  - Validator クライアントは、実行ノードに依存するビーコン ノードを介して Ethereum ネットワークに接続する

- [Diversify Now](https://clientdiversity.org/)
- `Consensus Clients`と`Execution Clients`によって構成される

### Consensus Clients
- [./consensus_client.md]

### Execution Clients

- Geth (圧倒的シェア)
- Nethermind
- Erigon
- Besu


## Light Client
- これはConsensus Clientで持つ機能
- 2022 Nov 現在、Code Name の`Altair`でしか、light-client の spec は存在しない
- [ethereum/consensus-specs](https://github.com/ethereum/consensus-specs/)
- [ethereum/consensus-specs light-client](https://github.com/ethereum/consensus-specs/tree/dev/specs/altair/light-client)
- [lightclients/kevlar](https://github.com/lightclients/kevlar)

## SSZ (Simple Serialize)

Ethreum2.0 用に設計された構造化データのエンコードと merkleization(マーキュリー化)のための標準

### genesis.ssz

SSZ-encoded, genesis beacon state

## Blockの生成について
- [Angle Explains: ETH 2.0, changes in block production and impact on MEV](https://blog.angle.money/angle-explains-eth-2-0-changes-in-block-production-and-impact-on-mev-f9c6f353c6bd)

![eth2 epoch slot](https://raw.githubusercontent.com/hiromaily/documents/main/images/eth2_epoch_slot.webp "eth2 epoch slot")

- PoSでは、チェーンは`Slot`に分割され、32個のSlotのグループは`Epoch`と呼ばれる
- 各Slotは、チェーンにブロックが追加されるチャンスとなる
- Slot（ブロックの可能性）は、12秒おきに正確に発生する。(genesis.jsonの設定による)
- 1ブロックあたり2ETHの採掘報酬は、1ブロックあたり0.22ETHの賭け報酬となり、~90%減少している
- これはETHの供給にとってメリットが、バリデータの収益に占めるtransaction feeの割合がはるかに高くなる
- 収益を上げ、競合するバリデータに対して市場シェアを獲得するためには、`MEV`を最大化することがより重要になる
- PoSではEpoch 32slotのValidator(採掘者)が事前に判明する

- TODO: Miner Extractable Value（MEV）リスク

## Localnetの構築について
- [How to set up an Ethereum proof-of-stake devnet in minutes](https://rauljordan.com/2022/08/21/how-to-setup-a-proof-of-stake-devnet.html)
  - これは`geth`と`prysm`を使った例となる
  - [Ethereum Proof-of-Stake Devnet](https://github.com/rauljordan/eth-pos-devnet)
