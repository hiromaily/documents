# Architecture

BlockchainプロジェクトにおけるFrontendの設計について

## 必要要件

- Blockchainに必要なUtilityライブラリの導入
  - [web3.js](https://web3js.readthedocs.io/en/v1.10.0/)
  - [Ethers.js](https://docs.ethers.org/v6/) ... v6 as of Aug 2023
  - [Wagmi](https://wagmi.sh/) + [Viem](https://viem.sh/)
- view functionの呼び出し及びTransactionの送信をTypescriptで実装することになるが、そのときのI/F及び、Typeを定義する必要がある。
- function毎に型定義することは現実的でないため、何かしらの手段が必要
  - [TypeChain](https://github.com/dethcrypto/TypeChain) + Ethers.js
  - [ABI<Type>](https://abitype.dev/) + Viem、これは[zod](https://abitype.dev/api/zod)との相性も良い

## Responseに対してのType Guardをどうすべきか？

### [ts-auto-guard](https://github.com/rhys-vdw/ts-auto-guard)を使うケース

- [ts-auto-guard](https://github.com/rhys-vdw/ts-auto-guard)によって既存の型からType Guardを生成することができる
- 前提条件として、既存の型情報を用意しておく必要がある。
- これは`ABI<Type>`によってabiから型推論した型から生成できるかは、要検証

### [zod](https://zod.dev/)を使うケース

- [ABI<Type>](https://abitype.dev/)が`zod`に対応している
