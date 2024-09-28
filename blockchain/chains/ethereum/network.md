# Ethereum Network

- [Network](https://ethereum.org/ja/developers/docs/networks/)

## Network の種類

- Mainnet
- Testnet
- Private network
- コンソーシアム network

## Testnet の種類

以下の違いは Configuration(genesis.json)による違いで、Ethereum は PoS でも PoW でも PoA でも動くように作られている

### [Sepolia](https://sepolia.dev/)

- PoS

### [Goerli](https://goerli.net/)

- PoS
- 2023 年でサポートが終了する
  - [github: Readme](https://github.com/eth-clients/goerli)

### 非推奨となった Testnet

- Ropsten
  - PoS
- Rinkeby
  - 古いバージョンの Geth クライアントにしか対応していない
- Kovan
  - 非常に古い PoA の Testnet となる

## Testnet の設定方法

- Ethereum Client の選択 (Geth)
- 独自の`genesis.json`を用意し Geth の構成を設定する (networkID といった起動パラメーターなど)
  - ここで、PoA や PoS の設定も変えることができる

## Private Network (Local Testnet)

### References

- [go-ethereum: Private Networks](https://geth.ethereum.org/docs/fundamentals/private-network)
- [DEVELOPMENT NETWORKS](https://ethereum.org/en/developers/docs/development-networks/)
- [Ethereum Private Network – Create your own Ethereum Blockchain!](https://www.edureka.co/blog/ethereum-private-network-tutorial)
- [How to set up a Private Ethereum Blockchain (Proof of Authority) with Go Ethereum - Part 1](https://hackernoon.com/how-to-set-up-a-private-ethereum-blockchain-proof-of-authority-with-go-ethereum-part-1)
- [Multi-client post-merge Eth devnet setup (maybe outdated)](https://notes.ethereum.org/@protolambda/merge-devnet-setup-guide)
- [Running a Private Ethereum Blockchain using Docker](https://medium.com/scb-digital/running-a-private-ethereum-blockchain-using-docker-589c8e6a4fe8)
- [Create your own Ethereum private network](https://gist.github.com/0mkara/b953cc2585b18ee098cd)
- [プライベート・ネットに接続する](https://book.ethereum-jp.net/first_use/connect_to_private_net)
- [Geth を使って、Ethereum の Private Network を作ってみよう！(2021)](https://note.com/standenglish/n/nd186bd57e102)
- [Connect to the Kintsugi Testnet](https://hackmd.io/@76u7HkGHS7-S8srG1WCWjg/B1y18LfYF#Connect-to-the-Kintsugi-Testnet)

## Localnet の構築について

- [How to set up an Ethereum proof-of-stake devnet in minutes](https://rauljordan.com/2022/08/21/how-to-setup-a-proof-of-stake-devnet.html)
  - これは`geth`と`prysm`を使った例となる
  - [Ethereum Proof-of-Stake Devnet](https://github.com/rauljordan/eth-pos-devnet)
- [Multi-client post-merge Eth devnet setup](https://notes.ethereum.org/@protolambda/merge-devnet-setup-guide)
  - 2020 年の記事なので古い
- [ethereum-localnet](https://github.com/hiromaily/ethereum-localnet)
