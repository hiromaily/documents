# Ethereum 2.0

`Ethereum1.0`と`Ethereum2.0`の名称は廃止され、`実行レイヤー`と`合意レイヤー`という呼称に改めされた

- Eth1 -> 実行レイヤー
- Eth2 -> 合意レイヤー
- 実行レイヤー + 合意レイヤー = イーサリアム

## References

- [Upgrading Ethereum to radical new heights](https://ethereum.org/en/upgrades/)
- [リブランディング: Eth2 の名称廃止](https://blog.ethereum.org/ja/2022/01/24/the-great-eth2-renaming)
- [The New Ethereum Upgrade (2.0): Your Guide 2022](https://www.alchemy.com/overviews/ethereum-2-0-your-guide-for-2022)
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

## Ethereum Clients

- [Diversify Now](https://clientdiversity.org/)
- `Consensus Clients`と`Execution Clients`によって構成される

### Consensus Clients

- [Prysm](https://prysmaticlabs.com/)
  - [Github](https://github.com/prysmaticlabs/prysm)
    - Go implementation of Ethereum proof of stake
    - Star: 2.9k (Nov 2022)
  - [Docs](https://docs.prylabs.network/docs/getting-started)
- [Lighthouse](https://lighthouse.sigmaprime.io/)
  - [Github](https://github.com/sigp/lighthouse/)
    - Ethereum consensus client in Rust
    - Star: 2.1k (Nov 2022)
  - [Docs](https://lighthouse-book.sigmaprime.io/)
- Teku
  - [Github](https://github.com/ConsenSys/teku)
  - Java Implementation of the Ethereum 2.0 Beacon Chain
  - Star: 474
- Nimbus
  - [Github](https://github.com/status-im/nimbus-eth1)
  - Nimbus: an Ethereum 1.0 and 2.0 Client for Resource-Restricted Devices
  - Nim
- Lodestar

  - [Github](https://github.com/ChainSafe/lodestar)
  - TypeScript Implementation of Ethereum Consensus

- 現在は Prysm が一番高いシェアを誇るが、Lighthouse との差は日々縮まっており、いずれ追い抜かれるように見える
- クライアントの多様性の重要性と、イーサリアム ブロックチェーンを実行するプロトコル実装をより均等に分散させることの重要性について議論されている
  - [Prysmatic Labs’ Statement on Client Diversity](https://medium.com/prysmatic-labs/prysmatic-labs-statement-on-client-diversity-c0e3c2f05671)
- [Consensus Clients 比較](https://docs.rocketpool.net/guides/node/eth-clients.html#consensus-clients)

### Execution Clients

- Geth (圧倒的シェア)
- Nethermind
- Erigon
- Besu

## Node と Network

- [References](https://docs.prylabs.network/docs/concepts/nodes-networks)

- イーサリアムには、主に`実行ノード`と`ビーコンノード`の 2 種類のノードがある
- ユーザーが `32 ETH` をステークして Ethereum のプルーフ オブ ステーク コンセンサス メカニズムに参加する場合、Prysm ビーコン ノードに接続する`バリデータ クライアント`と呼ばれる別のソフトウェアを使用する
  - これは、新しいブロックの作成や他の提案されたブロックへの投票など、バリデータ キーと義務を管理する特別なソフトウェア
  - Validator クライアントは、実行ノードに依存するビーコン ノードを介して Ethereum ネットワークに接続する

## Eth Beacon Node API

- [Docs](https://ethereum.github.io/beacon-APIs/)

## 各 Consensus Clients の Install 方法

- [Installing consensus client (beacon chain and validator)](https://www.coincashew.com/coins/overview-eth/guide-or-how-to-setup-a-validator-on-eth2-mainnet/part-i-installation/configuring-consensus-client-beaconchain-and-validator)

- docker compose
  - [stereum-dev/ethereum2-docker-compose](https://github.com/stereum-dev/ethereum2-docker-compose)
- k8s
  - [ethpandaops/ethereum-k8s-testnets](https://github.com/ethpandaops/ethereum-k8s-testnets)

## Prysm as Consensus Clients

- [Docs](https://docs.prylabs.network/docs/getting-started)
  - [Nodes and networks](https://docs.prylabs.network/docs/concepts/nodes-networks)
- [Github](https://github.com/prysmaticlabs/prysm)

### Install

#### Docker による Install

- [Prysm Docs](https://docs.prylabs.network/docs/install/install-with-docker)
  - [Execution Node](https://docs.prylabs.network/docs/install/install-with-script)
- [Beaconnode & validator using Docker](https://kb.beaconcha.in/archive/outdated-prysm-client-windows/prysm-client-windows/docker-beaconnode-and-validator) ... maybe outdated

## Lighthouse as Consensus Clients

- [Docs](https://lighthouse-book.sigmaprime.io/)
- [Github](https://github.com/sigp/lighthouse/)

## Light Client

- 2022 Nov 現在、Code Name の`Altair`でしか、light-client の spec は存在しない
- [ethereum/consensus-specs](https://github.com/ethereum/consensus-specs/)
- [ethereum/consensus-specs light-client](https://github.com/ethereum/consensus-specs/tree/dev/specs/altair/light-client)
- [lightclients/kevlar](https://github.com/lightclients/kevlar)
