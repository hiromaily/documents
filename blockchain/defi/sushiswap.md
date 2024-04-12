# SushiSwap

- [github](https://github.com/sushiswap)
  - [sushiswap](https://github.com/sushiswap/sushiswap)
  - [subgraphs](https://github.com/sushiswap/subgraphs)

## sushiswapの構成
### SmartContract関連
- [protocols](https://github.com/sushiswap/sushiswap/tree/master/protocols)
  - [bentobox/contracts](https://github.com/sushiswap/sushiswap/tree/master/protocols/bentobox/contracts)
    - [interfaces](https://github.com/sushiswap/sushiswap/tree/master/protocols/bentobox/contracts/interfaces)
      - IBatchFlashBorrower.sol
      - [IBentoBoxV1.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/bentobox/contracts/interfaces/IBentoBoxV1.sol)
      - IFlashBorrower.sol
      - IFlashLoan.sol
      - IStrategy.sol
      - IWETH.sol
    - [BentoBox.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/bentobox/contracts/BentoBox.sol)
      - [SushiSwap: BentoBoxV1 address](https://etherscan.io/address/0xf5bce5077908a1b7370b9ae04adc565ebd643966)
    - [MasterContractManager.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/bentobox/contracts/MasterContractManager.sol)
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
          - `interface IStargateAdapter {}`
        - [IStargateReceiver.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/stargate/IStargateReceiver.sol)
          - `function sgReceive(uint16 _chainId, bytes memory _srcAddress, uint256 _nonce, address _token, uint256 amountLD, bytes memory payload) external;`
          - Implementation -> [adapters/StargateAdapter.sol](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/StargateAdapter.sol#L114-L172)
        - [IStargateRouter.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/stargate/IStargateRouter.sol)
          - `struct lzTxObj {uint256 dstGasForCall; uint256 dstNativeAmount; bytes dstNativeAddr;}`
          - `function swap(uint16 _dstChainId, uint256 _srcPoolId, uint256 _dstPoolId, address payable _refundAddress, uint256 _amountLD, uint256 _minAmountLD, lzTxObj memory _lzTxParams, bytes calldata _to, bytes calldata _payload) external payable;`
          - `function quoteLayerZeroFee(uint16 _dstChainId, uint8 _functionType, bytes calldata _toAddress, bytes calldata _transferAndCallPayload, lzTxObj memory _lzTxParams) external view returns (uint256, uint256);`
          - Implementation -> [Stargate Router](https://github.com/stargate-protocol/stargate/blob/main/contracts/Router.sol)
        - [IStargateWidget.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/stargate/IStargateWidget.sol)
          - `function partnerSwap(bytes2 _partnerId) external;`
          - Implementation ??
      - [trident](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts/interfaces/trident)
      - [IBentoBoxMinimal.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/IBentoBoxMinimal.sol)
        - `function balanceOf(address, address) external view returns (uint256);`
        - `function toShare(address token, uint256 amount, bool roundUp) external view returns (uint256 share);`
        - `function toAmount(address token, uint256 share, bool roundUp) external view returns (uint256 amount);`
        - `function registerProtocol() external;`
        - `function deposit(address token_, address from, address to, uint256 amount, uint256 share) external payable returns (uint256 amountOut, uint256 shareOut);`
        - `function withdraw(address token_, address from, address to, uint256 amount, uint256 share) external returns (uint256 amountOut, uint256 shareOut);`
        - `function transfer(address token, address from, address to, uint256 share) external;`
      - [IERC20Permit.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/IERC20Permit.sol)
      - [IImmutableState.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/IImmutableState.sol)
      - [ISushiXSwap.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/ISushiXSwap.sol)
        - `function cook(uint8[] memory actions, uint256[] memory values, bytes[] memory datas) external payable;`
      - [IWETH.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/interfaces/IWETH.sol)
    - [libraries](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts/libraries)
      - [SafeMath.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/libraries/SafeMath.sol)
      - [UniswapV2Library.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/libraries/UniswapV2Library.sol)
    - [misc](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts/misc)
      - [StargateFeeV04Extraction.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/misc/StargateFeeV04Extraction.sol)
    - [mocks](https://github.com/sushiswap/sushiswap/tree/master/protocols/sushixswap/contracts/mocks)
      - [MockERC20.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/mocks/MockERC20.sol)
    - [SushiXSwap.sol](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/SushiXSwap.sol)
      - `function cook(uint8[] memory actions, uint256[] memory values, bytes[] memory datas) external payable;`

#### [SushiXSwapコントラクト](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/SushiXSwap.sol)
- `cook` functionのみで、渡された`actions`(複数)によって処理を切り替えている
- `ACTION_MASTER_CONTRACT_APPROVAL`
  - bentoBox.setMasterContractApproval() をcall
    - Implementationは、bentobox/contracts内
      - MasterContractManager.sol
      - flat/BentoBoxFlat.sol
- `ACTION_SRC_DEPOSIT_TO_BENTOBOX`
  - [_depositToBentoBox() in BentoAdapter](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/BentoAdapter.sol#L23-L32)
- `ACTION_SRC_TRANSFER_FROM_BENTOBOX`
  - [_transferFromBentoBox() in BentoAdapter](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/BentoAdapter.sol#L44-L60)
- `ACTION_SRC_TOKEN_TRANSFER`
  - [_transferFromToken() in TokenAdapter](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/TokenAdapter.sol#L33-L39)
- `ACTION_DST_DEPOSIT_TO_BENTOBOX`
  - [_transferTokens() in TokenAdapter](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/adapters/TokenAdapter.sol#L17-L27)
  - [_depositToBentoBox() in BentoAdapter](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/BentoAdapter.sol#L44-L60)
- `ACTION_DST_WITHDRAW_TOKEN`
  - [_transferTokens() in TokenAdapter](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/adapters/TokenAdapter.sol#L17-L27)
- `ACTION_DST_WITHDRAW_OR_TRANSFER_FROM_BENTOBOX`
  - [_transferFromBentoBox() in BentoAdapter](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/BentoAdapter.sol#L44-L60)
- `ACTION_UNWRAP_AND_TRANSFER`
  - [_unwrapTransfer() in TokenAdapter](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/TokenAdapter.sol#L44-L47)
- `ACTION_WRAP_TOKEN`
  - [_wrapToken() in TokenAdapter](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/TokenAdapter.sol#L52-L54)
- `ACTION_LEGACY_SWAP`
  - [_swapExactTokensForTokens() in SushiLegacyAdapter](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/SushiLegacyAdapter.sol#L14-L44)
- `ACTION_TRIDENT_SWAP`
  - [_exactInput() in TridentSwapAdapter](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/TridentSwapAdapter.sol#L23-L57)
- `ACTION_TRIDENT_COMPLEX_PATH_SWAP`
  - [_complexPath() in TridentSwapAdapter](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/TridentSwapAdapter.sol#L65-L123)
- `ACTION_STARGATE_TELEPORT`
  - [_stargateTeleport() in StargateAdapter](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/StargateAdapter.sol#L47-L79)

#### [StargateAdapterコントラクト](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/StargateAdapter.sol)

##### [_stargateTeleport()](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/protocols/sushixswap/contracts/adapters/StargateAdapter.sol#L47-L79)
- Bridges the token to dst chain using Stargate Router
- [stargateRouter.swap()](https://github.com/stargate-protocol/stargate/blob/c647a3a647fc693c38b16ef023c54e518b46e206/contracts/Router.sol#L107-L134) を呼び出す
- どういった経路で呼び出されるのか？
  - [Applicationレイヤー](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/apps/xswap/pages/index.tsx)
    - `Confirm Swap`ボタンをClick in xswap/pages/index.tsx
      - [execute()](https://github.com/sushiswap/sushiswap/blob/master/apps/xswap/pages/index.tsx#L461-L537)
        - 以下teleport()が実行される条件は、`crossChain && srcAmountOut && dstAmountIn`
        - [teleport() in Cooker apps/xswap/lib/SushiXSwap.ts](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/apps/xswap/lib/SushiXSwap.ts#L774-L849)
    - `useEffect`内で、getFee()実行 (Reactによるレンダリング後)
      - [getFee()](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/apps/xswap/pages/index.tsx#L691-L747)
        - [teleport() in Cooker apps/xswap/lib/SushiXSwap.ts](https://github.com/sushiswap/sushiswap/blob/f01135e26ec457d3185160788ff2a8bf8e5b8a45/apps/xswap/lib/SushiXSwap.ts#L774-L849)
  - [コントラクトレイヤー](https://github.com/sushiswap/sushiswap/blob/master/protocols/sushixswap/contracts/SushiXSwap.sol)
    - SushiXSwapコントラクトの`cook()`で、Action==`ACTION_STARGATE_TELEPORT`

### WIP: Application関連
- [apps](https://github.com/sushiswap/sushiswap/tree/master/apps)
  - [xswap](https://github.com/sushiswap/sushiswap/tree/master/apps/xswap)
    - [lib](https://github.com/sushiswap/sushiswap/tree/master/apps/xswap/lib)
      - [hooks](https://github.com/sushiswap/sushiswap/tree/master/apps/xswap/lib/hooks)
      - [state](https://github.com/sushiswap/sushiswap/tree/master/apps/xswap/lib/state)
      - [SushiXSwap.ts](https://github.com/sushiswap/sushiswap/blob/master/apps/xswap/lib/SushiXSwap.ts)
      - [storage.ts](https://github.com/sushiswap/sushiswap/blob/master/apps/xswap/lib/storage.ts)
    - [pages](https://github.com/sushiswap/sushiswap/blob/master/apps/xswap/lib/storage.ts)
      - [index.tsx](https://github.com/sushiswap/sushiswap/blob/master/apps/xswap/pages/index.tsx)



## trident
SushiSwapが新たに開発したAMMとルーティングシステム。
Tridentは拡張可能なAMMフレームワークとして設計されており、開発者はIPoolインターフェースに準拠した新しいプールタイプを追加することが可能。
発売前に、イーサリアム全体のプールインターフェースの標準化を支援するために、IPoolインターフェース設計のためのEIPが提出される予定。
新しいAMMプールタイプが設計または実験された場合、インターフェイスに適合している限り、Tridentに追加することができる。
このようにして、Tridentは少なくとも、すべての一般的なAMMプール設計のスーパーセットとなり、Sushiが構築するための将来性のあるアーキテクチャとなる。

[github: trident](https://github.com/sushiswap/trident)
