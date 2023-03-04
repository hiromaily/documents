# SushiSwap

- [github](https://github.com/sushiswap)
  - [sushiswap](https://github.com/sushiswap/sushiswap)
  - [subgraphs](https://github.com/sushiswap/subgraphs)

## sushiswapの構成
### SmartContract関連
- [protocols](https://github.com/sushiswap/sushiswap/tree/master/protocols)
  - [bentobox/contracts](https://github.com/sushiswap/sushiswap/tree/master/protocols/bentobox/contracts)
  - [sushixswap/contracts](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts)
    - [adapters](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts/adapters)
      - [BentoAdapter.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/adapters/BentoAdapter.sol)
      - [StargateAdapter.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/adapters/StargateAdapter.sol)
      - [SushiLegacyAdapter.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/adapters/SushiLegacyAdapter.sol)
      - [TokenAdapter.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/adapters/TokenAdapter.sol)
      - [TridentSwapAdapter.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/adapters/TridentSwapAdapter.sol)
    - [base](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts/base)
      - [ImmutableState.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/base/ImmutableState.sol)
    - [interfaces](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts/interfaces)
      - [stargate](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts/interfaces/stargate)
        - [IStargateAdapter.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/stargate/IStargateAdapter.sol)
        - [IStargateReceiver.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/stargate/IStargateReceiver.sol)
        - [IStargateRouter.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/stargate/IStargateRouter.sol)
        - [IStargateWidget.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/stargate/IStargateWidget.sol)
      - [trident](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts/interfaces/trident)
      - [IBentoBoxMinimal.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/IBentoBoxMinimal.sol)
      - [IERC20Permit.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/IERC20Permit.sol)
      - [IImmutableState.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/IImmutableState.sol)
      - [ISushiXSwap.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/ISushiXSwap.sol)
      - [IWETH.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/IWETH.sol)
    - [libraries](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts/libraries)
      - [SafeMath.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/libraries/SafeMath.sol)
      - [UniswapV2Library.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/libraries/UniswapV2Library.sol)
    - [misc](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts/misc)
      - [StargateFeeV04Extraction.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/misc/StargateFeeV04Extraction.sol)
    - [mocks](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts/mocks)
      - [MockERC20.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/mocks/MockERC20.sol)
    - [SushiXSwap.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/SushiXSwap.sol)

## trident
SushiSwapが新たに開発したAMMとルーティングシステム。
Tridentは拡張可能なAMMフレームワークとして設計されており、開発者はIPoolインターフェースに準拠した新しいプールタイプを追加することが可能。
発売前に、イーサリアム全体のプールインターフェースの標準化を支援するために、IPoolインターフェース設計のためのEIPが提出される予定。
新しいAMMプールタイプが設計または実験された場合、インターフェイスに適合している限り、Tridentに追加することができる。
このようにして、Tridentは少なくとも、すべての一般的なAMMプール設計のスーパーセットとなり、Sushiが構築するための将来性のあるアーキテクチャとなる。

[github: trident](https://github.com/sushiswap/trident)
