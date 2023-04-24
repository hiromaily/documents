# Light Client

Light Client はトランザクションの状態を検証するが、そのためにブロックチェーンの一部の情報のみを保存するもので、これはEthereumでは `Consensus Client` で持つ機能

[Light Client](../light-client/README.md)

## consensus-specs
- [ethereum/consensus-specs](https://github.com/ethereum/consensus-specs/)
  - [altair](https://github.com/ethereum/consensus-specs/tree/dev/specs/altair)
    - [full-node](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/full-node.md)
    - [light-client](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/light-client.md)
    - [p2p-interface](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/p2p-interface.md)
    - [sync-protocol](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/sync-protocol.md)
  - [capella](https://github.com/ethereum/consensus-specs/tree/dev/specs/capella)
    - [fork](https://github.com/ethereum/consensus-specs/blob/dev/specs/capella/light-client/fork.md)
    - [full-node](https://github.com/ethereum/consensus-specs/blob/dev/specs/capella/light-client/full-node.md)
    - [p2p-interface](https://github.com/ethereum/consensus-specs/blob/dev/specs/capella/light-client/p2p-interface.md)
    - [sync-protocol](https://github.com/ethereum/consensus-specs/blob/dev/specs/capella/light-client/sync-protocol.md)

## Light client-based RPC Proxy for PoS Ethereum
- [lightclients/kevlar](https://github.com/lightclients/kevlar)

## [Light Clientの同期処理](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/light-client.md)
1. Light Clientは、フォークスケジュールを含む `spec/preset`、genesis_timeと genesis_validators_rootを含む `genesis_state`、および`trusted block root`で帯域外に設定されなければならない（MUST）。信頼されたブロックは、弱い主体性の期間内であるべきであり、そのルートは確定した`Checkpoint`からであるべきである（SHOULD）。 
2. 設定された`genesis_time`に基づいてローカルクロックが初期化され、現在のフォークダイジェストが決定され、関連するLight Client データプロバイダをブラウズして接続する。 
3. Light Clientは、設定された信頼できるブロックルートの`LightClientBootstrap`オブジェクトをフェッチする。`bootstrap`オブジェクトは、`initialize_light_client_store`に渡され、local `LightClientStore` を取得する。 
4. Light Clientは、ローカル時計に基づいて、`store.finalized_header.beacon.slot` から`finalized_period`を、`store.optimistic_header.beacon.slot` から`optimistic_period` を、`current_slot`から`current_period`を追跡する。 条件は以下の3つ。
  1. `finalized_period == optimistic_period`かつ`is_next_sync_committee_known`が`False` の場合
      - Light Clientは`finalized_period` に対して`LightClientUpdate`をフェッチする。`finalized_period == current_period` の場合、このフェッチは`current_period` が進む前のランダムな時間にスケジュールされるべき（SHOULD）。 
  2. `finalized_period + 1 < current_period` の場合
      - Light Clientは、範囲 `[finalized_period + 1, current_period)`(現在の期間は除く) の各Sync Committee Period について`LightClientUpdate`をフェッチする。 
  3. `finalized_period + 1 >= current_period` のとき
      - Light Clientは`LightClientFinalityUpdate`と`LightClientOptimisticUpdate` を観測し続ける。受信したオブジェクトは、`process_light_client_finality_update`と`process_light_client_optimistic_update` に渡される。これにより、`finalized_header`と`optimistic_header`が最新のブロックを反映するようになる。 
5. `process_light_client_store_force_update`は、Light Client 同期が停止した場合、ユースケースに依存するheuristics(情報探索などの発見方法)に基づいて呼び出されてもよい。利用可能な場合は、影響を受けるSync Committee Periodをカバーするために、代替の同期メカニズムにフォールバックすることが好ましい。

## [Sync Protocol](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/sync-protocol.md)
Beacon Chainは、リソースに制約のあるデバイスやメーター付きVM（例：Cross-chain Bridge用のブロックチェーンVM）など、制約のある環境において、合理的な安全性と活力をもってイーサリアムにアクセスするためのLightClientフレンドリーに設計されている。
これはBeaconChain拡張で導入されたSync Committeeを使用するBeacon Chainの最小限のLightClientデザインを提案するものとなる。
追加ドキュメントでは、LightClient Sync Protocolの使用方法について説明している
- [Full Node](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/full-node.md)
- [Light Client](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/light-client.md)
- [Networking](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/p2p-interface.md)

- [Containers](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/sync-protocol.md##containers)
  - `LightClientHeader`
  - `LightClientBootstrap`
  - `LightClientUpdate`
  - `LightClientFinalityUpdate`
  - `LightClientOptimisticUpdate`
  - `LightClientStore`
- [Helper functions](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/sync-protocol.md##helper-functions)
  - `is_valid_light_client_header`
  - `is_sync_committee_update`
  - `is_finality_update`
  - `is_better_update`
  - `is_next_sync_committee_known`
  - `get_safety_threshold`
  - `get_subtree_index`
  - `compute_sync_committee_period_at_slot`
- [Light client initialization](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/sync-protocol.md##light-client-initialization)
  - `initialize_light_client_store`
- [Light client state updates](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/sync-protocol.md##light-client-state-updates)
  - `validate_light_client_update`
  - `apply_light_client_update`
  - `process_light_client_store_force_update`
  - `process_light_client_update`
  - `process_light_client_finality_update`
  - `process_light_client_optimistic_update`
