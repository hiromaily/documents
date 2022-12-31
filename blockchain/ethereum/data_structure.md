# データ構造とエンコーディング
- [Docs](https://ethereum.org/en/developers/docs/data-structures-and-encoding/)

Ethereumは大量のデータを作成、保存、転送します。このデータは、標準化されたメモリ効率の良い方法でフォーマットされ、誰でも比較的控えめなコンシューマーグレードのハードウェアでノードを実行できるようにする必要があります。これを実現するために、Ethereum スタックではいくつかの特定のデータ構造が使用されています。

## データ構造

### [Patricia merkle tries](https://ethereum.org/en/developers/docs/data-structures-and-encoding/patricia-merkle-trie/)
- Key-Valueペアを決定論的かつ暗号的に認証されたトライにエンコードする構造
- Ethereumの実行レイヤーで広く使用されている

- 暗号的に認証されたデータ構造を提供し、すべての（key、value）バインディングを格納するために使用することができる
- 完全に決定論的であり、同じ(key、value)のバインディングを持つトライは、最後のバイトまで同一であることが保証される
- つまり、ルートハッシュが同じであるため、挿入、検索、削除において`O(log(n))`の効率を実現することができる
- また、`red-black trees`のような比較に基づく複雑な代替手法に比べて、理解もコード化も簡単


### [Recursive Length Prefix (RLP)](https://ethereum.org/en/developers/docs/data-structures-and-encoding/rlp/)
- [RLP](https://github.com/ethereum/wiki/wiki/%5BJapanese%5D-RLP)
- [Golang:RLP package](https://github.com/ethereum/go-ethereum/blob/master/rlp/encode.go)
- RLPはEthereumの実行レイヤーのオブジェクトをシリアライズするために使われる主要なエンコーディング方法 
- RLPは、ノード間のデータ転送をスペース効率の良い形式で標準化する
- RLPの目的-は、バイナリデータの任意にネストされた配列をエンコードすること
- RLP の唯一の目的は構造のエンコードであり、特定のデータ型 (文字列や浮動小数点数など) のエンコードは高次のプロトコルに任されている
- デシリアライズされた正の整数の先頭の0は無効なものとして扱われる
- 文字列の長さの整数表現も、ペイロードの整数と同様にこの方法で符号化されなければならない

### [Simple Serialize](https://ethereum.org/en/developers/docs/data-structures-and-encoding/ssz/)
- Simple Serialize（SSZ）は、merklelizationと互換性があるため、Ethereumのコンセンサス層で主流のシリアライズ形式

- Simple serialize (SSZ)はBeacon Chainで使用されるシリアライズ方法
- これは実行層で使われていたRLPシリアライゼーションを、ピア発見プロトコルを除くコンセンサス層全体のいたるところで置き換えるものとなる
- SSZは決定論的であり、また効率的にMerkleizeするように設計されている
- SSZは、直列化スキームと、直列化されたデータ構造で効率的に動作するように設計されたMerkleizationスキームの2つのコンポーネントから構成されていると考えることができる