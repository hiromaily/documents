# Ethereum Network
- [Network](https://ethereum.org/ja/developers/docs/networks/)

## Networkの種類
- Mainnet
- Testnet
- Private network
- コンソーシアム network

- How to upgrade protocol?
 
## Testnetの種類

### Goerli
- PoS

### Sepolia
- PoS

## 非推奨となったTestnet

### Ropsten
- PoS

### Rinkeby
- 古いバージョンの Geth クライアントにしか対応していない

### Kovan
- 非常に古いプルーフ・オブ・オーソリティのTestnetとなる

## どうやってTestnetを開発するのか？
- 特別なGenesis Fileを用意して、Nodeを起動する。PoWの場合、そこからMineする
- どうやって、Consensusアルゴリズムを変更するのか？
- Private Networkと変わらない？


## Private Network
- [go-ethereum: Private Networks](https://geth.ethereum.org/docs/fundamentals/private-network)
- [DEVELOPMENT NETWORKS](https://ethereum.org/en/developers/docs/development-networks/)
- [Ethereum Private Network – Create your own Ethereum Blockchain!](https://www.edureka.co/blog/ethereum-private-network-tutorial)
- [How to set up a Private Ethereum Blockchain (Proof of Authority) with Go Ethereum - Part 1](https://hackernoon.com/how-to-set-up-a-private-ethereum-blockchain-proof-of-authority-with-go-ethereum-part-1)
- [プライベート・ネットに接続する](https://book.ethereum-jp.net/first_use/connect_to_private_net)
- [Gethを使って、EthereumのPrivate Networkを作ってみよう！(2021)](https://note.com/standenglish/n/nd186bd57e102)
- [Multi-client post-merge Eth devnet setup (maybe outdated)](https://notes.ethereum.org/@protolambda/merge-devnet-setup-guide)

## Genesis Files
```json
{
  "config": {
    "chainId": 12345,
    "homesteadBlock": 0,
    "eip150Block": 0,
    "eip155Block": 0,
    "eip158Block": 0,
    "byzantiumBlock": 0,
    "constantinopleBlock": 0,
    "petersburgBlock": 0,
    "istanbulBlock": 0,
    "berlinBlock": 0,
    "clique": {
      "period": 5,
      "epoch": 30000
    }
  },
  "difficulty": "1",
  "gasLimit": "8000000",
  "extradata": "0x00000000000000000000000000000000000000000000000000000000000000007df9a875a174b3bc565e6424a0050ebc1b2d1d820000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "alloc": {
    "7df9a875a174b3bc565e6424a0050ebc1b2d1d82": { "balance": "300000" },
    "f41c74c9ae680c1aa78f42e5647a62f353b7bdde": { "balance": "400000" }
  }
}
```

- [Genesis file items by Hyperledger BESU](https://besu.hyperledger.org/en/stable/public-networks/reference/genesis-items/)