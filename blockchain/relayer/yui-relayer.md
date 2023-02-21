# YUI Relayer
- [yui-relayer](https://github.com/hyperledger-labs/yui-relayer)

## 対応Chain
- Cosmos/Tendermint with [ibc-go](https://github.com/cosmos/ibc-go)
- EVM chains with [ibc-solidity](https://github.com/hyperledger-labs/yui-ibc-solidity)
- Hyperledger Fabric with [fabric-ibc](https://github.com/hyperledger-labs/yui-fabric-ibc)
- Corda with [corda-ibc](https://github.com/hyperledger-labs/yui-corda-ibc)

## 用語集
- Chain ... チェーンへのトランザクションの送信とその状態の問い合わせをサポートする
- Prover ... ターゲットチェーンの状態に関する証明を生成または照会する。この証明は、相手側のチェーンに配置されたOn-chain Light Clientによって検証される。
- ProvableChain ... ChainとProverから構成される
- Path ... パケットを中継する2つのProvableChainのパス
- ChainConfig ... Chainを生成するための設定
- ProverConfig ... Prover を生成するための設定


## Relayの確認方法
- [test-tx](https://github.com/hyperledger-labs/yui-relayer/blob/main/tests/cases/tm2tm/scripts/test-tx)

```
# transfer tx 
${RLY} tx transfer ibc01 ibc0 ibc1 100samoleans ${TM_ADDRESS1}
# relay packet
${RLY} tx relay ibc01
# relay acks
${RLY} tx acks ibc01
```

## WIP: Relayの挙動について



## WIP: Relayerにおけるmockの挙動は？
```go
import mock "github.com/hyperledger-labs/yui-relayer/provers/mock/module"

func main() {
	if err := cmd.Execute(
		ethereum.Module{},
		ethProver.Module{},
		mock.Module{},
		tendermint.Module{},
	); err != nil {
		log.Fatal(err)
	}
}
```

## relayerのconfigファイルについて

### fabric sample
```
{
  "chain": {
    "@type": "/relayer.chains.fabric.config.ChainConfig",
    "chain_id": "ibc1",
    "wallet_label": "Org1MSP",
    "channel": "channel1",
    "chaincode_id": "fabibc",
    "connection_profile_path": "./configs/fabric/connection-profile/org1/local.yaml"
  },
  "prover": {
	"@type": "/relayer.chains.fabric.config.ProverConfig",
	"ibc_policies": [
	  "Org1MSP"
	],
	"endorsement_policies": [
	  "Org1MSP"
	],
	"msp_config_paths": [
	  "./chains/fabric/organizations/peerOrganizations/org1.fabric-tendermint-cross-demo.com/peers/peer0.org1.fabric-tendermint-cross-demo.com/msp"
	]
  }
}
```

### tendermint sample
```
{
  "chain": {
    "@type": "/relayer.chains.tendermint.config.ChainConfig",
    "key": "testkey",
    "chain_id": "ibc0",
    "rpc_addr": "http://localhost:26657",
    "account_prefix": "cosmos",
    "gas_adjustment": 1.5,
    "gas_prices": "0.025stake"
  },
  "prover": {
	  "@type": "/relayer.chains.tendermint.config.ProverConfig",
	  "trusting_period": "336h"
  }
}
```

### fabric sample
```
{
  "chain": {
    "@type": "/relayer.chains.fabric.config.ChainConfig",
    "chain_id": "ibc1",
    "wallet_label": "Org1MSP",
    "channel": "channel1",
    "chaincode_id": "fabibc",
    "connection_profile_path": "./configs/fabric/connection-profile/org1/local.yaml"
  },
  "prover": {
	  "@type": "/relayer.chains.fabric.config.ProverConfig",
	  "ibc_policies": [
	    "Org1MSP"
	  ],
	  "endorsement_policies": [
	    "Org1MSP"
	  ],
	  "msp_config_paths": [
	    "./chains/fabric/organizations/peerOrganizations/org1.fabric-tendermint-cross-demo.com/peers/peer0.org1.  fabric-tendermint-cross-demo.com/msp"
	  ]
  }
}
```

### ethereum sample
```
{
  "chain": {
    "@type": "/relayer.chains.ethereum.config.ChainConfig",
    "chain_id": "ibc1",
    "eth_chain_id": 1337,
    "rpc_addr": "http://localhost:8545",
    "hdw_mnemonic": "math razor capable expose worth grape metal sunset metal sudden usage scheme",
    "hdw_path": "m/44'/60'/0'/0/0",
    "ibc_host_address": "",
    "ibc_handler_address": ""
  },
  "prover": {
    "@type": "/relayer.provers.lcp.config.ProverConfig",
    "origin_prover": {
      "@type": "/relayer.chains.quorum.config.ProverConfig",
      "trust_level_numerator": 1,
      "trust_level_denominator": 3,
      "trusting_period": "336"
    },
    "lcp_service_address": "localhost:50051",
    "mrenclave": "",
    "allowed_quote_statuses": [],
    "allowed_advisory_ids": [],
    "elc_client_id": "GoQuorum-QBFT-0"
  }
}
```