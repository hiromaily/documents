# Consensus Client

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
- [Lodestar](https://lodestar.chainsafe.io/)

  - [Github](https://github.com/ChainSafe/lodestar)
  - TypeScript Implementation of Ethereum Consensus

- 現在は Prysm が一番高いシェアを誇るが、Lighthouse との差は日々縮まっており、いずれ追い抜かれるように見える
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
