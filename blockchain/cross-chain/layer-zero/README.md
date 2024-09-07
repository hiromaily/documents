# Layer Zero

- [Docs](https://layerzero.gitbook.io/docs/)
- [LayerZero-Labs/LayerZero](https://github.com/LayerZero-Labs/LayerZero)
  - This repository contains the smart contracts for LayerZero Endpoints

## Estimating Message Fees

- [Docs](https://layerzero.gitbook.io/docs/evm-guides/code-examples/estimating-message-fees)

```
// Endpoint.sol
// https://github.com/LayerZero-Labs/LayerZero/blob/main/contracts/Endpoint.sol
function estimateFees(uint16 _dstChainId, address _userApplication, bytes calldata _payload, bool _payInZRO, bytes calldata _adapterParams) external view override returns (uint nativeFee, uint zroFee) {
  LibraryConfig storage uaConfig = uaConfigLookup[_userApplication];
  ILayerZeroMessagingLibrary lib = uaConfig.sendVersion == DEFAULT_VERSION ? defaultSendLibrary : uaConfig.sendLibrary;
  return lib.estimateFees(_dstChainId, _userApplication, _payload, _payInZRO, _adapterParams);
}
```

```
// UltraLightNodeV2.sol
// https://github.com/LayerZero-Labs/LayerZero/blob/main/contracts/UltraLightNodeV2.sol
// returns the native fee the UA pays to cover fees
function estimateFees(uint16 _dstChainId, address _ua, bytes calldata _payload, bool _payInZRO, bytes calldata _adapterParams) external view override returns (uint nativeFee, uint zroFee) {
  ApplicationConfiguration memory uaConfig = _getAppConfig(_dstChainId, _ua);

  // Relayer Fee
  bytes memory adapterParams;
  if (_adapterParams.length > 0) {
      adapterParams = _adapterParams;
  } else {
      adapterParams = defaultAdapterParams[_dstChainId][uaConfig.outboundProofType];
  }
  uint relayerFee = ILayerZeroRelayerV2(uaConfig.relayer).getFee(_dstChainId, uaConfig.outboundProofType, _ua, _payload.length, adapterParams);

  // Oracle Fee
  address ua = _ua; // stack too deep
  uint oracleFee = ILayerZeroOracleV2(uaConfig.oracle).getFee(_dstChainId, uaConfig.outboundProofType, uaConfig.outboundBlockConfirmations, ua);

  // LayerZero Fee
  uint protocolFee = treasuryContract.getFees(_payInZRO, relayerFee, oracleFee);
  _payInZRO ? zroFee = protocolFee : nativeFee = protocolFee;

  // return the sum of fees
  nativeFee = nativeFee.add(relayerFee).add(oracleFee);
}
```

```
// RelayerV2.sol
// https://github.com/LayerZero-Labs/LayerZero/blob/main/contracts/RelayerV2.sol
function getFee(uint16 _dstChainId, uint16 _outboundProofType, address _userApplication, uint _payloadSize, bytes calldata _adapterParams) external view override returns (uint) {
  (uint basePrice, uint pricePerByte) = _getPrices(_dstChainId, _outboundProofType, _userApplication, _adapterParams);
  return basePrice.add(_payloadSize.mul(pricePerByte));
}

// txType 1
// bytes  [2       32      ]
// fields [txType  extraGas]
// txType 2
// bytes  [2       32        32            bytes[]         ]
// fields [txType  extraGas  dstNativeAmt  dstNativeAddress]
// User App Address is not used in this version
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
  require(extraGas > 0, "Relayer: gas too low");
  require(txType == 1 || txType == 2, "Relayer: unsupported txType");

  DstPrice storage dstPrice = dstPriceLookup[_dstChainId];
  DstConfig storage dstConfig = dstConfigLookup[_dstChainId][_outboundProofType];

  uint totalRemoteToken; // = baseGas + extraGas + requiredNativeAmount
  if (txType == 2) {
      uint dstNativeAmt;
      assembly {
          dstNativeAmt := mload(add(_adapterParameters, 66))
      }
      require(dstConfig.dstNativeAmtCap >= dstNativeAmt, "Relayer: dstNativeAmt too large");
      totalRemoteToken = totalRemoteToken.add(dstNativeAmt);
  }
  // remoteGasTotal = dstGasPriceInWei * (baseGas + extraGas)
  uint remoteGasTotal = dstPrice.dstGasPriceInWei.mul(dstConfig.baseGas.add(extraGas));

  totalRemoteToken = totalRemoteToken.add(remoteGasTotal);

  // tokenConversionRate = dstPrice / localPrice
  // basePrice = totalRemoteToken * tokenConversionRate
  basePrice = totalRemoteToken.mul(dstPrice.dstPriceRatio).div(10**10);

  // pricePerByte = (dstGasPriceInWei * gasPerBytes) * tokenConversionRate
  pricePerByte = dstPrice.dstGasPriceInWei.mul(dstConfig.gasPerByte).mul(dstPrice.dstPriceRatio).div(10**10);
}
```

### RelayerのGas Feeはどのようになっているのか？

#### 参考までに、Ethereumの場合

使われる要素として、`gas limit`, `base fee`, `validator tips`があり、計算式は

```
// gas limit * (base fee + validator tips)
21,000 * (10 + 2) = 252,000 gwei (0.000252 ETH)
```

#### 計算式

Ethereumの場合、`base fee`が常に変動する

```
// Native Fee
nativeFee = relayerFee + oracleFee + protocolFee

// RelayerFee
const dstGasPriceInWei = 9848022277
const baseGas = 120000
const extraGas = 200000
const requiredNativeAmount = 55555555555
const dstPriceRatio = 10600000001
const localPrice = 10 ** 10
const gasPerBytes = 1
const payloadSize = 0

// calculate _getPrices()
const remoteGasTotal = dstPrice.dstGasPriceInWei * (dstConfig.baseGas + _adapterParameters.extraGas)
const totalRemoteToken =
  dstConfig.baseGas + _adapterParameters.extraGas + _adapterParameters.requiredNativeAmount + remoteGasTotal
const tokenConversionRate = dstPrice.dstPriceRatio / localPrice

const basePrice = totalRemoteToken * tokenConversionRate

const pricePerByte =
  dstGasPriceInWei * dstConfig.gasPerBytes * tokenConversionRate
// calculate getFee()
const fee = (payloadSize * pricePerByte) + basePrice
```
