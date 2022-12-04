# Ethereum

[How does Ethereum work, anyway?](https://www.preethikasireddy.com/post/how-does-ethereum-work-anyway)

## Private Network (Local Testnet)
- [Go Ethreum: Private Networks](https://geth.ethereum.org/docs/interface/private-network)
- [Go Ethreum: Developer mode](https://geth.ethereum.org/docs/getting-started/dev-mode)
- [DEVELOPMENT NETWORKS](https://ethereum.org/en/developers/docs/development-networks/)

- [Running a Private Ethereum Blockchain using Docker](https://medium.com/scb-digital/running-a-private-ethereum-blockchain-using-docker-589c8e6a4fe8)
- [Create your own Ethereum private network](https://gist.github.com/0mkara/b953cc2585b18ee098cd)
- 
## フォーマット
- [RLP](https://github.com/ethereum/wiki/wiki/%5BJapanese%5D-RLP)
  - トランザクションのフォーマットなど、Ethereumのデータに使われる
  - Recursive Length Prefixの略
  - [Golang:RLP package](https://github.com/ethereum/go-ethereum/blob/master/rlp/encode.go)

- [ABI]
  - ABIとは一般的な用語であり、バイナリーファイル（主に実行形式ファイルと呼ばれるもの）へのアクセスに対して互換性を与えるために定義されるもの
  - これは、人間が判読できるコード インターフェイスの表現である APIに非常に似ていて、 ABI はバイナリ コントラクトと対話するために使用されるメソッドと構造を定義する。
  - これは API と同様ですが、下位レベルで行われる。
  - ABI エンコーディング
    - ABI は、関数シグネチャや変数宣言などの必要な情報を、EVM がその関数をバイトコードで呼び出すために理解できる形式でエンコードする関数の呼び出し元を示す。
    - ABI エンコーディングはほとんど自動化されており、REMIX などのコンパイラやブロックチェーンと対話するウォレットによって処理される。
  - コントラクト ABI は JSON 形式で表される。
  - コントラクト ABI をエンコードおよびデコードする方法については、明確な仕様がある。
  - [コントラクトABIの仕様](https://solidity-ja.readthedocs.io/ja/latest/abi-spec.html)
  - [ABIエンコーディングおよびデコーディングの関数](https://solidity-ja.readthedocs.io/ja/latest/units-and-global-variables.html#abi)

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