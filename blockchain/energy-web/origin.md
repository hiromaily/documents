# EnergyWeb Origin

Originは、エネルギー属性証明書(EAC)の発行と管理のためのシステムを提供するツールキットのセット


## References
- [Github](https://github.com/energywebfoundation/origin)
- [Docs](https://energy-web-foundation-origin.readthedocs-hosted.com/en/latest/)

## SDKs
- [Traceability SDK](https://energy-web-foundation-origin.readthedocs-hosted.com/en/latest/traceability/)
- [Trade SDK](https://energy-web-foundation-origin.readthedocs-hosted.com/en/latest/trade/)
- [Device Registry SDK](https://energy-web-foundation-origin.readthedocs-hosted.com/en/latest/device-registry/)

## OriginでgasPriceはどこで使われているのか？
- [gasPriceをgithub上で検索](https://github.com/search?q=org%3Aenergywebfoundation+gasPrice&type=code
)

- [origin repository](https://github.com/energywebfoundation/origin)
  - gasPriceの設定は見つからない。これはコントラクトを含まないオフチェーン側のロジックが含まれている様子
  - API機能もこちらに含まれる
- [pjm-origin-monorepo]
  - こちらにはコントラクトも含まれるため、設定はこちらのpackagesに含まれている

### 関連コンポーネント

#### pjm-origin-monorepo
- [pjm-origin-monorepo: wrappedContracts/CertificateLogic.ts](https://github.com/energywebfoundation/pjm-origin-monorepo/blob/4e74a0559167c37f87bcb2f9870244efbb9a1b03/packages/origin/src/wrappedContracts/CertificateLogic.ts)
  - safeTransferFrom()からsend()を呼び出す際に、txParamsを渡す
- [pjm-origin-monorepo: packages/utils-general/src/GeneralFunctions.ts](https://github.com/energywebfoundation/pjm-origin-monorepo/blob/4e74a0559167c37f87bcb2f9870244efbb9a1b03/packages/utils-general/src/GeneralFunctions.ts)
  - Contractの呼び出しや、Transactionの送信ロジックを含む
  - `buildTransactionParams()` ... 渡されたパラメータから、Transaction(from, gas, gasPrice, nonce, data, to, privateKey)オブジェクトを作成し、返す。
    - gasPriceは以下の手法で取得
      - `const networkGasPrice = await this.web3.eth.getGasPrice();`
      - `parameters.gasPrice ? parameters.gasPrice : networkGasPrice.toString(),`
  - `sendRaw()` ... RawTransactionの送信
  - `send()` ... buildTransactionParams()によってTransactionを作成し、sendRaw()を呼び出す

他にも様々なLogicがある
- [wrappedContracts/MarketLogic.ts](https://github.com/energywebfoundation/pjm-origin-monorepo/blob/4e74a0559167c37f87bcb2f9870244efbb9a1b03/packages/market/src/wrappedContracts/MarketLogic.ts)
- [wrappedContracts/UserLogic.ts](https://github.com/energywebfoundation/pjm-origin-monorepo/blob/4e74a0559167c37f87bcb2f9870244efbb9a1b03/packages/user-registry/src/wrappedContracts/UserLogic.ts)
- [wrappedContracts/AssetLogic.ts](https://github.com/energywebfoundation/pjm-origin-monorepo/blob/4e74a0559167c37f87bcb2f9870244efbb9a1b03/packages/asset-registry/src/wrappedContracts/AssetLogic.ts)


#### originからどう呼ばれるのか？
- [origin: traceability/issuer/src/blockchain-facade/Certificate.ts](https://github.com/energywebfoundation/origin/blob/ab7c5021294c4b9f73b8529385ef4d59492154b0/packages/traceability/issuer/src/blockchain-facade/Certificate.ts)
  - transfer() ... safeTransferFrom()を呼び出す。このときのtxParamsは空。 
