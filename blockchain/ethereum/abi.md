# ABI (Application Binary Interface)

- ABIとは一般的な用語であり、バイナリーファイル（主に実行形式ファイルと呼ばれるもの）へのアクセスに対して互換性を与えるために定義されるもの
- これは、人間が判読できるコード インターフェイスの表現である APIに非常に似ていて、 ABI はバイナリ コントラクトと対話するために使用されるメソッドと構造を定義する。
- これは API と同様だが、下位レベルで行われる。
- コントラクト ABI は JSON 形式で表される。

- [コントラクトABIの仕様](https://solidity-ja.readthedocs.io/ja/latest/abi-spec.html)

## ABI エンコーディング

- コントラクト ABI をエンコードおよびデコードする方法については、明確な仕様がある。
- [ABIエンコーディングおよびデコーディングの関数](https://solidity-ja.readthedocs.io/ja/latest/units-and-global-variables.html#abi)

- ABI は、関数シグネチャや変数宣言などの必要な情報を、EVM がその関数をバイトコードで呼び出すために理解できる形式でエンコードする関数の呼び出し元を示す。
- ABI エンコーディングはほとんど自動化されており、REMIX などのコンパイラやブロックチェーンと対話するウォレットによって処理される。

- [ABI encode and decode using solidity](https://medium.com/coinmonks/abi-encode-and-decode-using-solidity-2d372a03e110)
- アプリケーション（および人）は、コントラクトにデータを送信したり、コントラクトからデータを取得したりする。このとき、データをコントラクトに送るには、コントラクトが読めるような形で送る必要がある。つまり、エンコードされる必要がある。
- このようなエンコードをどのように行うかのルールは、Ethereum Virtual Machine（EVM）の実装で定義されている

### ABI function

- abi.encode()
- abi.decode()
