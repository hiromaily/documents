# Solidity Assembly

Solidity のアセンブリプログラミングは opcode を直接記述する低レベルプログラミングを指す。

## References

- [Docs](https://solidity-jp.readthedocs.io/ja/latest/assembly.html)
- [Chapter 11: Assembly Programming | Solidity Programming Essentials を読む](https://zenn.dev/mah/articles/9b2dbee85eac80)
- [Solidity Inline Assembly で気になったことをまとめる](https://blog.suishow.net/2021/08/25/solidity-inline-assembly-%E6%B3%A8%E7%9B%AE%E3%81%99%E3%82%8B%E3%81%A8%E3%81%93%E3%82%8D-%F0%9F%99%83/)

## inline assembly を使うメリット

- capability の増大
  - アセンブリを利用することでしかできないことがある。例えばアドレスがコントラクトアドレスかどうかを判断することはアセンブリでならできるが、Solidity では確認できない
- ガス使用量の最適化
  - Solidity コンパイラで生成されたコードと比較してアセンブリコードは命令数が少ないため、コードを最適化することができる
- 完全な制御が可能
  - アセンブリ言語を直接記述することで、コンパイラが生成するコードと比較して生成されるバイトコードをより詳細に制御することができる

## よく使われる Instruction

- `add`, `sub`, `mul`, `div`はそのまま値の計算結果を返すもの
- `mload(p)`は指定した領域から 32byte の情報を取得する
- `mstore(p, v)`は指定した領域に対して、値`v`をセットする

## ソースコードを例に解説

### `mload(add(_adapterParameters, 2))` が何を意味するのか？

- [code](https://github.com/LayerZero-Labs/LayerZero/blob/main/contracts/RelayerV2.sol)

```sol
function _getPrices(uint16 _dstChainId, uint16 _outboundProofType, address, bytes memory _adapterParameters) internal view returns (uint basePrice, uint pricePerByte) {
    require(!paused, "Admin: paused");
    // decoding the _adapterParameters - reverts if type 2 and there is no dstNativeAddress
    require(_adapterParameters.length == 34 || _adapterParameters.length > 66, "Relayer: wrong _adapterParameters size");
    uint16 txType;
    uint extraGas;
    assembly {
        txType := mload(add(_adapterParameters, 2))
        extraGas := mload(add(_adapterParameters, 34))
    }
...
}
```
