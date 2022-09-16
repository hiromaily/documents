# Light Client

- [IBC Light Client](https://ibcprotocol.org/lightClients/)
- [Blockchain Light Client](https://medium.com/codechain/blockchain-light-client-1171dfa1269a)


## 概要
- Light Clientはトランザクションの状態を検証するが、そのためにブロックチェーンの一部の情報のみを保存する
- ブロックチェーンの構造は、Header, Transaction, State, Cacheとなっている
- Header
  - Chainを形成する最小単位の構造で、以下が含まれる
    - 前のブロックのHash
    - タイムスタンプ
  - Light Clientの目的はヘッダーを検証すること
  - ヘッダーを検証するだけで Merkle ツリー内のすべての情報が検証される
- Header+Transaction
  - これが「ブロック」になる
  - ブロックを提案/マイニングするノードはブロックを公開し、他のノードはそれらのブロックを検証する
- Header+Transaction+State
  - ヘッダーによって検証できる最大の範囲
  - すべてのノードがまったく同じ値を持つことがプロトコルで保証されている単位

### ヘッダー検証
- ヘッダーはMerkle Rootがある限り、トランザクションと状態を検証できる

#### PoWの場合
1. 以前のHash, タイムスタンプ, フォーマットの基本情報を確認
2. HeaderのNonceを確認してPoWを完成させる
- TransactionやStateの確認の不要

#### PoSの場合
1. 以前のHash, タイムスタンプ, フォーマットの基本情報を確認
2. バリデータセットの情報を確認
3. Voteを確認する
4. それらのVoteがシェアの2/3を超えているかどうかを確認する
- PoSでは、状態の一部である、「バリデーターセット」が必要となる

## Tendermint
- [Light Client](https://docs.tendermint.com/v0.34/tendermint-core/light-client.html)
- [Go Package](https://pkg.go.dev/github.com/tendermint/tendermint/light)
