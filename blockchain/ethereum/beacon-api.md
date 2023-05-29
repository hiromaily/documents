# Beacon-API

- [Eth Beacon Node API](https://ethereum.github.io/beacon-APIs/)
- [github beacon-APIs](https://github.com/ethereum/beacon-APIs)

## Beacon Node Endpoint
- [ankr](https://www.ankr.com/rpc/eth/)
- [Lodestar](https://beaconstate-mainnet.chainsafe.io/)


## Beacon API

### finality_checkpoints
指定された「stateId」を持つ状態のファイナリティ チェックポイントを返す。 ファイナリティがまだ達成されていない場合、チェックポイントはルートとしてエポック 0 と ZERO_HASH を返す必要がある。

- 実行 (実行時の最新epochは`204469`)
```
curl -X 'GET' \
'https://beaconstate-mainnet.chainsafe.io/eth/v1/beacon/states/head/finality_checkpoints' \
-H 'accept: application/json'
```

- 結果
```
{
	"data": {
		"finalized": {
			"epoch": "204467",
			"root": "0x88d94601c8f62fe1309fbc4c139e4fb99448b3caa3126ff8cf0886ce3c62e4bb"
		},
		"current_justified": {
			"epoch": "204468",
			"root": "0x6586ff608a061b1c888c774d45c4703c9a13428cb65351d9d36c7c7559ebc58b"
		},
		"previous_justified": {
			"epoch": "204467",
			"root": "0x88d94601c8f62fe1309fbc4c139e4fb99448b3caa3126ff8cf0886ce3c62e4bb"
		}
	}
}
```