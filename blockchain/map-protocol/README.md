# MAP Protocol

MAP プロトコルは、`Light-client`と`zk-SNARK`の技術をベースに構築された、証明可能で安全なクロスチェーン通信を行う Web3 のオムニチェーンレイヤー
MAP は、EVM と非 EVM の両方のチェーンを接続することで、パブリックチェーンと dApp にクロスチェーンのインフラを提供する。

## [Map-contracts](https://github.com/mapprotocol/map-contracts)

### [Management protocol](https://github.com/mapprotocol/map-contracts/tree/main/protocol)

- MAP プロトコル管理は、MAP リレーチェーン上で行われる

### MAP Relay Chain light client

- MAP Relay Chain ライトクライアントを全チェーンに実装する
- EVM チェーン
  - EVM チェーン上の MAP Relay Chain ライトクライアント
- Near
  - Near プロトコル上の Relay Chain ライトクライアント

### MAP 上のライトクライアント

- テストネットの展開と管理のためのスクリプト
- BNB スマートチェーンライトクライアント
  - BNB スマートチェーンライトクライアント on MAP Relay Chain
- Near light client

  - 地図上の Near Protocl ライトクライアントリレーチェーン

- MAP オムニチェーンサービス
  - MAP オムニチェーンサービスを参照実装し、チェーン間の相互運用性を実現するために、すべてのチェーンに MOS コントラクトを依存する。
  - MOS on Evm Chains
  - MOS on near
