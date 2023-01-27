# Foundry

Ethereum testing framework

## Reference
- [github](https://github.com/foundry-rs/foundry)

## Install
```
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## 機能
- Solidity コンパイラのバージョン自動検出とインストール (~/.svm)
- インクリメンタルコンパイルとキャッシュ：変更されたファイルのみ再コンパイル
- 並列コンパイル
- 非標準的なディレクトリ構造のサポート
- テストはSolidityで書く（DappToolsと同様）
- fuzz-testを高速化
- 柔軟なデバッグロギング
  - `DsTest`の吐き出されるログを利用した`DappTools`スタイル
  - `console.sol`のコントラクトを使用したHardhatスタイル
- Foundry GitHubアクションによる高速CI。


## `foundry.toml`による構成



## Forge Standard Library
Forge Standard Library is a collection of helpful contracts and libraries for use with Forge and Foundry.

- [github](https://github.com/foundry-rs/forge-std)
- [Docs: Forge Standard Library Overview](https://book.getfoundry.sh/forge/forge-std)