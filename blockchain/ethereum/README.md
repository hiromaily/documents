# Ethereum

[How does Ethereum work, anyway?](https://www.preethikasireddy.com/post/how-does-ethereum-work-anyway)

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

## 用語集
- ENR: Ethereum Node Records 
  - ノード検出プロトコル