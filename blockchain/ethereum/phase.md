# Phase

Ethereum 2.0 (Serenity) と呼ばれる大規模なアップデートにはフェーズが分かれている。

[Ref: The 3 Phases of Ethereum’s 2.0 Serenity Upgrade](https://www.gemini.com/cryptopedia/ethereum-2-0-blockchain-roadmap-proof-of-stake-pos)

## Phase 0: The Beacon Chain

- Beacon Chainを稼働させる
  - Beacon Chain Consensus メカニズム(Casper)、Validator Nodeの 3 つの主要な技術的実装が Ethereum エコシステムに提供された。
  - ETH2.0(Serenity) の開発が進むにつれて、Beacon ChainはEthereum ネットワークの主要な決済レイヤーになり、今後のシャード チェーンの調整を担当するようになる。

## ~~Phase 1: The Merge~~
- ~~現在、マージは 2022 年第 2 四半期に予定されている~~
- ~~完了すると、Ethereum MainnetはBeacon Chain内のシャードになり、PoS は公式のConsensus メカニズムになる~~
- ~~Ethereum Mainnet シャードは PoS を使用し、Ethereumの PoW とマイニングの両方を終了する~~
- ~~Mainnetを追加することで、この新しい PoS EthereumにSmart Contractを実行する機能が含まれ、Ethereumのすべての完全な履歴と状態が得られる~~
- ~~ステークされた ETH の引き出しなどの機能は、マージ後すぐにはサポートされないことに注意~~

## Phase 1: Shard Chains (シャードチェーン)
- Chard ChainとRollupの実装
  - RollupとはMainチェーンのセキュリティーを活用しながらTransactionの一部をまとめてoff-chainで処理することにより、ネットワークの混雑解消を測るスケーリングソリューション。Transaction自体はL2で実行されるものの、Transactionの正当性はL1のConsensusメカニズムに依存して検証され、Transactionデータの保存もL1で行われる
  - シャーディングはEthereumネットワークをより小さなシャードに分解し、Transaction容量と速度を向上させるスケーリングソリューション
- これは 2 回の更新で提供される
- Version1: データの可用性
  - シャード チェーンは、最初はEthereum ネットワークに余分なデータのみを提供し、63 個の新しいチェーン (合計 64 個) を追加する
  - ローンチ時には、Transactionやスマート コントラクトはサポートされない
  - ただし、これらの追加されたチェーンとロールアップにより、Transaction容量が劇的に向上し、ガス料金が削減され、1 秒あたり数万のTransactionを処理することが可能になる
  - Rollupは、メインの Ethereum チェーン (Layer1) からTransactionを実行し、完了したTransaction データをLayer1 にポストするLayer2 ソリューション
  - Transactionを単一のオフチェーン Transactionに`Rollup`するこのプロセスには、スケーラビリティの大きな利点がある
- Version2: コードの実行
  - アップグレードの最終段階では、シャードが現在のEthereum Mainnetにより似たものになり、Transactionの処理とスマート コントラクトの実行が可能になる
  - シャードも通信できるようになり、シャード間のTransactionが可能になる
  - このステップが必要かどうかは、Ethereum コミュニティ内で議論されている
    - 多くの人は、「Version1: データの可用性」で提供される 1 秒あたりのTransaction数の増加で十分であり、「よりスマートな」シャードは必要ないと考えている

## Phase 1.5, 2: Bridging the Gap

Ethereum 1.0 と Ethereum 2.0 のエコシステムは現在別個のものであり、簡単に橋渡しすることはできない。 EthereumのSerenity開発ロードマップのフェーズ 1.5 は、Ethereum 1.0 MainnetをEthereum 2.0 の 64 のシャード チェーンの 1 つとして統合することにより、2 つのエコシステム間の橋渡しを行うことを任務としている。これにより、新しいシステムでシャード間の相互運用性とスマート コントラクト機能が可能になる。 フェーズ 2 はフェーズ 1.5 に続き、Solidity 以外のプログラミング言語をSmart Contract開発に使用できるようにし、各シャード チェーンを独自の本格的なMainnetに変換する。 クロスシャード通信、Transaction、および dAppsのDeployを実現する方法の詳細は、まだ検討中となる。

## Phase 3: Final Touches
これは、完了する前にさまざまなニーズや問題の解決に対応する包括的なフェーズとなる。
これには、追加のシャード チェーンや、プライバシーとセキュリティの実装の強化が含まれる場合がある。
