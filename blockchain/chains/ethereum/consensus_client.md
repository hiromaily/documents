# Consensus Client (Beacon Chian)

Beacon Chian とも言われ、Ethereum2.0 のコンセンサスエンジンとして機能するブロックチェーン

## 特徴

- PoS システムを実装することができる最小限の構造として設計されている
- Transaction の処理やスマートコントラクトのホストは行わない
- Proof of Work における Miner またはパズル解決者を、ブロックを決定する Validator に置き換えた Ethereum 2.0 の中核となることを意図している
- バリデータのアドレス、各バリデータの状態、attestations(認証)（バリデータの投票）、シャードへのリンクなどのレジストリが格納されている
- Ethereum Beacon Chain は、乱数の公開ソースを提供する暗号サービスである randomness beacon にちなんで命名された。
- `RANDAO` と呼ばれる疑似乱数処理に基づいてブロックのバリデータをランダムに選択し、コンセンサスメカニズムを管理する

## References

- [The Beacon Chain](https://medium.com/blockchain-stories/ethereum-2-0-the-beacon-chain-d669fa65e50d)
- [The Beacon Chain Ethereum 2.0 explainer you need to read first](https://ethos.dev/beacon-chain)
- [Ethereum 2.0 (Eth2)・コンセンサスレイヤーとは？](https://pontem.network/posts/ethereum-2-0-eth2-konsensasureiyatoha)
- [Spec: ethereum/consensus-specs](https://github.com/ethereum/consensus-specs/tree/dev/specs/altair/light-client)
- [Spec: Bellatrix -- The Beacon Chain](https://github.com/ethereum/consensus-specs/blob/dev/specs/bellatrix/beacon-chain.md)
- [Eth Beacon Node API](https://ethereum.github.io/beacon-APIs/)

## 主要な Consensus Client

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
- [Teku](https://docs.teku.consensys.net/)
  - [Github](https://github.com/ConsenSys/teku)
  - Java Implementation of the Ethereum 2.0 Beacon Chain
  - Star: 474
- [Nimbus](https://nimbus.guide/)
  - [Github](https://github.com/status-im/nimbus-eth1)
  - Nimbus: an Ethereum 1.0 and 2.0 Client for Resource-Restricted Devices
  - Nim
- [Lodestar](https://lodestar.chainsafe.io/)
  - [Github](https://github.com/ChainSafe/lodestar)
  - TypeScript Implementation of Ethereum Consensus

### 考察

- [Diversify Now](https://clientdiversity.org/)
- クライアントの多様性の重要性と、イーサリアム ブロックチェーンを実行するプロトコル実装をより均等に分散させることの重要性について議論されている
  - [Prysmatic Labs’ Statement on Client Diversity](https://medium.com/prysmatic-labs/prysmatic-labs-statement-on-client-diversity-c0e3c2f05671)
- [Consensus Clients 比較](https://docs.rocketpool.net/guides/node/eth-clients.html#consensus-clients)

## Eth Beacon Node API

- [Docs](https://ethereum.github.io/beacon-APIs/)
- 基本的に Consensus Client はこの API 仕様に準拠している

## 各 Consensus Clients の Install 方法

- [Installing consensus client (beacon chain and validator)](https://www.coincashew.com/coins/overview-eth/guide-or-how-to-setup-a-validator-on-eth2-mainnet/part-i-installation/configuring-consensus-client-beaconchain-and-validator)

- docker compose
  - [stereum-dev/ethereum2-docker-compose](https://github.com/stereum-dev/ethereum2-docker-compose)
- k8s
  - [ethpandaops/ethereum-k8s-testnets](https://github.com/ethpandaops/ethereum-k8s-testnets)

### Prysm as Consensus Clients

- [Docs](https://docs.prylabs.network/docs/getting-started)
  - [Nodes and networks](https://docs.prylabs.network/docs/concepts/nodes-networks)
- [Github](https://github.com/prysmaticlabs/prysm)

### Lighthouse as Consensus Clients

- [Docs](https://lighthouse-book.sigmaprime.io/)
- [Github](https://github.com/sigp/lighthouse/)
