# Merkle Tree 2

![Merkle Tree Overview](https://raw.githubusercontent.com/hiromaily/documents/main/images/Merkle%20tree.png "Merkle Tree")

全てノードがハッシュを持った二分木(Binary tree)で、ハッシュ木とも言われる  
二分木とは、データ構造の一つである木構造（ツリー構造）のうち、どの親ノードも二つ以下の子ノードを持つもの。子がN個以下に制限されたN分木（N-ary tree）のうち最も単純な構造の木

## 図の説明

- Data: 検証したい元データ
- Leaves(Leaf): Dataをハッシュ化した値
- Nodes: `Leaf`または`Node`を結合してハッシュ化した値
- Root: 全ての`Leaf`をハッシュ化することによって得られる値で、`Verify`に使われる

## Verifyについて

- ある`Leaft`が`Root`を生成する一部であることを検証する
- 全ての`Leaf`がなくても`Proof`があればいい

## Proofについて

`Block Header`と`部分 Merkle Tree`で、`Merkle Proof`もしくは`Merkle Path`と言われ、Root Hashの再計算に必要な最小ノード郡

## BlockchainのHeader(Block Hash)には以下の情報が含まれる

- Prev Hash
- Nonce
- Root Hash

## LightClientはFullNodeから以下の情報を取得する

- Block Header
- 部分 Merkle Tree
- Tx (target transaction)
