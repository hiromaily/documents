# Blockchain

- [ブロックチェーンの仕組み](https://www.nttdata.com/jp/ja/services/blockchain/002/)
- [Security](./solidity/security/README.md)

## 用語

- トライ trie
  - 探索のためのデータ構造 木構造の一種
  - トライ木(trie tree)

### PoS: プルーフ・オブ・ステーク

コインの保有枚数（Stake）に応じて次のブロックを検証する人を決めるコンセンサスアルゴリズムで、PoS は資産保有量（Stake）が大きい人ほどブロック承認の成功率が高くなる。

- バリデータ
  - PoS コンセンサスに参加しているノード
- バリデータセット
  - バリデータの公開鍵とその Voting power(ステークした量に依存した投票力)のペア
- Commit
  - バリデータのブロックヘッダーに対する署名
- Stake
  - 仮想通貨(token)をロックして報酬を受け取る行為
