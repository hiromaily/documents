# Beacon-API

- [Eth Beacon Node API](https://ethereum.github.io/beacon-APIs/)
- [github beacon-APIs](https://github.com/ethereum/beacon-APIs)

## Beacon Node Endpoint

- [ankr](https://www.ankr.com/rpc/eth/)
- [Lodestar](https://beaconstate-mainnet.chainsafe.io/)

## Beacon API

### /eth/v1/beacon/genesis

- 実行

```
curl -X 'GET' \
'http://{beacon-node}/eth/v1/beacon/genesis' \
-H 'accept: application/json'
```

- 結果

```
{
 "data": {
  "genesis_time": "1606824023",
  "genesis_validators_root": "0x4b363db94e286120d76eb905340fdd4e54bfe9f06bf33ff6cf5ad27f511bfe95",
  "genesis_fork_version": "0x00000000"
 }
}
```

### /eth/v1/beacon/states/{state_id}/root

- 実行

```
curl -X 'GET' \
'http://{beacon-node}/eth/v1/beacon/states/head/root' \
-H 'accept: application/json'
```

- 結果

```
{
 "execution_optimistic": false,
 "finalized": false,
 "data": {
  "root": "0x1c9bc09628ca607e87fd1a0464a53202bd342febf495d4672f7f84394d754b07"
 }
}
```

### /eth/v1/beacon/states/{state_id}/finality_checkpoints

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

### /eth/v1/beacon/states/{state_id}/validators

- 実行

```
curl -X 'GET' \
'http://{beacon-node}/eth/v1/beacon/states/head/validators' \
-H 'accept: application/json'
```

- 結果 (WIP: 実行環境では失敗した)

```
{
 "error": {
  "code": 0,
  "message": "we can't execute this request"
 }
}
```

### /eth/v1/beacon/headers

- 実行

```
curl -X 'GET' \
'http://{beacon-node}/eth/v1/beacon/headers' \
-H 'accept: application/json'
```

- 結果

```
{
 "execution_optimistic": false,
 "finalized": false,
 "data": [{
  "root": "0x2bcfef0a4e0a87041ba024b554875a24cb87fcf08841286cfa72fd9ef36a5fc7",
  "canonical": true,
  "header": {
   "message": {
    "slot": "6544158",
    "proposer_index": "412970",
    "parent_root": "0x94f568c392e67fec70f897ce07712f27f9151270b6c27c7024133a6a302e2fdf",
    "state_root": "0xbbd221b321658378c5ac9ccf151e077de82e7f765047ea6de5afb680f3209e18",
    "body_root": "0x16d636ab7822563d0a1f78a1cd19530d745efc0624c7de69ba9cc74be41defdc"
   },
   "signature": "0x8ba76d50cd1d0534a9f0c0b3321bcdb18660cfc5561dd59030be9766b51dae8d3019778471258cd7c06ac74f0f852fcf01bed1e3570b6612230ba6a52278f6adab9008137aef0d8c472cbf1bd4c5b0cb49dc523e15a85c4840d23783284e84ca"
  }
 }]
}
```

### /eth/v1/beacon/headers/{block_id}

- 実行

```
curl -X 'GET' \
'http://{beacon-node}/eth/v1/beacon/headers/head' \
-H 'accept: application/json'
```

- 結果

```
{
 "execution_optimistic": false,
 "finalized": false,
 "data": {
  "root": "0x93312937808684077f4a7a54c7ad6193aefc624a6aa2f5f1a7a50035e59ebf73",
  "canonical": true,
  "header": {
   "message": {
    "slot": "6544176",
    "proposer_index": "315867",
    "parent_root": "0xe073cf6075bec26dd1a10c3c1c117b854a44bc1a21367874f5009408acc8a3d8",
    "state_root": "0xf51b171797b7d07ac81790551f8d46eb5875309f36cfcddb24e9380235b4678a",
    "body_root": "0x5c6101cc5e5f7395a588c97d2417b80b29f7fa3327ce6abb813328adda74f505"
   },
   "signature": "0x8590e346f002dc6a2b21a8476d2b08f2c229ce366efc7734b91d1f61e6842bda4dcea7878fee9ae8402fb1222eb78ddc05856fb086e8ca7c97a2fdf0c79a6101b9741b1dbcd2f5e69770671729363f1efb78c446f8b6dfd818285c6eec52bd58"
  }
 }
}
```

### /eth/v2/beacon/blocks/{block_id}

- 実行

```
curl -X 'GET' \
'http://{beacon-node}/eth/v2/beacon/blocks/head' \
-H 'accept: application/json'
```

- 結果

```
{
 "version": "capella",
 "execution_optimistic": false,
 "finalized": false,
 "data": {
  "message": {
   "slot": "6544213",
   "proposer_index": "176666",
   "parent_root": "0x219edca85a5d3b99a2bdc23a12845104b5eda0a9203f67095396c2598b0483f4",
   "state_root": "0xd226d7c35aca707395fd14ab7852fd4961cbdd9d47bdeee2cfe51ff0b3c66c54",
   "body": {
    "randao_reveal": "0x8957e0c81f81f9de494d3e0f91000e9b9807d097f725adf9f9abae37ff701fd5dd10c8d1dc535201c998be804d8144721997d8d2336e38f22942084ab775bb95830653f87d111f089b01513940fdea910e3c562141511c471756847ac57ba92a",
    "eth1_data": {
     "deposit_root": "0x45347b79762889232c5b0d21a4d249973fcd3327e625392a765b2547752ca984",
     "deposit_count": "749765",
     "block_hash": "0x138e4f7a7f664b8de40194a29a71a77af3fe0646b990e98a43a3653fb7e22d7f"
    },
    "graffiti": "0x4c69676874686f7573652f76342e302e312d6135333833306600000000000000",
    "proposer_slashings": [],
    "attester_slashings": [],
    "attestations": [{
     "aggregation_bits": "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff07",
     "data": {
      "slot": "6544212",
      "index": "16",
      "beacon_block_root": "0x219edca85a5d3b99a2bdc23a12845104b5eda0a9203f67095396c2598b0483f4",
      "source": {
       "epoch": "204505",
       "root": "0x90ae5b5f762032e253bfe0e1c2eced60e9b04b935f9c6f2ec75ad810e206b70e"
      },
      "target": {
       "epoch": "204506",
       "root": "0x9f2dddbda29c2980d8606a233276ea60f8b44b00ce6552dd5c37e9457a4cc31f"
      }
     },
     "signature": "0x84389e08a70f05679a2cce9b1c7c27be7e3c62d439ff80961333531bbc7b03a781011202b40f4cd4f2b67b31312ed6480484250164cc04097db9210563a2651009c7498384681a3b25d578181a32b0deed91487fb052cc757131fddff4f89afa"
    }, ...
    ],
    "deposits": [],
    "voluntary_exits": [],
    "sync_aggregate": {
     "sync_committee_bits": "0xffffffffffffffffffffffffffffffbffffffffffffffffffffffffffffffffffffdfffffffffffffffffffffffbffffffffffffffffff7fffffffffffffffff",
     "sync_committee_signature": "0xad9cc700ac015cbe417eafbbecf2e9081d49d0d093c35e87a63499268d65de2e1b805ff6cb0c47d91a323f6a58543ca416ec450d7f468e0b32ca9657a0ebcc5b8c14b918f2280bfa974450c54938c17fd47c4933eca304faf888ddf5b95e32c0"
    },
    "execution_payload": {
     "parent_hash": "0xad775e1d5bdce54a767d7b2c1649a502263fdfed49b3fbf90d63ac693b05d66e",
     "fee_recipient": "0xa1959e227e26a1d218884c13d7b318d2061cfd95",
     "state_root": "0x8f984ef6fdb5b2947d09c7e3aa9652873f4072106b01b7b91704c211e8c76126",
     "receipts_root": "0x56d0ac4b2a16168ad633bd53100bce67e1aebf38bd742d6b984917ce2918d873",
     "logs_bloom": "0x042110104380351f14541cca82029a29d0091240024510486223481a35622a2300a5118040440060420218051d5405109f41f814d8422dc501020650c03868006410fa0565220d5dee2a590b822c81280cec1584194a0b204c425c4298f00e800202c20807048c0509c0002300482c9909544a35a4080c3a8a36081a6c9a90101b30a35401a600840079184286c00b42548285930b88424c483004c041986a9086e80b411a0064262a6000f634842ce60774e20b0508286ba1c2481700602c60c59f61965014547380508c4010a458046061100295102cd4402f051e100e28090d32a60808008420033d66ad30501880e200c27a5900014091300222808e5c25",
     "prev_randao": "0x63badebda7a6feeb39e4b8e1b183011837ed1181f37766b4e38a0bc07664c47b",
     "block_number": "17363928",
     "gas_limit": "30000000",
     "gas_used": "9787001",
     "timestamp": "1685354579",
     "extra_data": "0x6279206275696c64657230783639",
     "base_fee_per_gas": "33477665174",
     "block_hash": "0x1d311994500816c4f809baf46a7b39a08b86143e2b312d0370e0e2447b00bb85",
     "transactions": ["0x02f9..., 0xf83..."],
     "withdrawals": [{
      "index": "5264636",
      "validator_index": "512706",
      "address": "0xb9d7934878b5fb9610b3fe8a5e441e8fad7e293f",
      "amount": "12809905"
     }, {
      "index": "5264637",
      "validator_index": "512707",
      "address": "0xb9d7934878b5fb9610b3fe8a5e441e8fad7e293f",
      "amount": "12756184"
     }, ...
     ]
    },
    "bls_to_execution_changes": []
   }
  },
  "signature": "0xb1fc519f144b4cc643e65bd0c95b24c63c810cf662ba29f5aa97dd707b415dca16412092929645fbed0ee8f5ca21f69807478eeab629e98961609e5d1e4228c366948c926199391f49a6c257fc749089a33955bf99ee089a699a166061ecd91a"
 }
}
```

### /eth/v1/beacon/blocks/{block_id}/root

- 実行

```
curl -X 'GET' \
'http://{beacon-node}/eth/v1/beacon/blocks/head/root' \
-H 'accept: application/json'
```

- 結果

```
{
 "execution_optimistic": false,
 "finalized": false,
 "data": {
  "root": "0x5eea3748d1e41d7ebf59773db6248f2cf563581882a2445a6448601f83697428"
 }
}
```
