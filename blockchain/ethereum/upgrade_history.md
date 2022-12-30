# Upgrade (Fork) History
- [The history of Ethereum](https://ethereum.org/en/history/)

## Paris (The Merge) - 2022/9/15
- [spec](https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/paris.md)

- Proof of Workのブロックチェーンが `terminal total difficulty`: `58750000000000000`を通過したことにより発生した
- これは2022/9/15のブロック15537393で起こり、次のブロックにParisのアップグレードが誘発された
- Parisは`The Merge` transitionで、その主な特徴は、Proof of Workのマイニングアルゴリズムと関連するコンセンサスロジックを止め、代わりにProof of Stakeに切り替えたこと
- Parisは実行クライアント（コンセンサスレイヤーのBellatrixに相当）をアップグレードし、接続されているコンセンサスクライアントから指示を受けることができるようにしたもの
- これには、`Engine API`と総称される新しい内部APIメソッド群を起動する必要があった
- これは間違いなく、`Homestead`以来のEthereumの歴史における最も重要なアップグレードとなった

  - [terminal total difficulty(TTD)](https://ethereum.org/en/glossary/#terminal-total-difficulty)
    - 合計難易度は、ブロックチェーンのある特定の時点までのすべてのブロックのEthashの採掘難易度の合計となる
    - 最終的な合計難易度は、実行クライアントがマイニングとブロックゴシップ機能をオフにするトリガーとして使用された合計難易度の特定の値であり、ネットワークが`Proof of Stake`に移行することを可能にするもの


## Bellatrix - 2022/9/6
- [spec](https://github.com/ethereum/consensus-specs/tree/dev/specs/bellatrix)

- Beaconチェーンの2回目のアップグレードで、The Mergeの準備のために予定されていたもの
- このアップグレードにより、バリデータの非アクティブとスラッシュ可能な違反に対するペナルティが完全な値となる
- The Mergeと最後のProof of Workブロックから最初のProof of Stakeブロックへの移行に備えるため、フォーク選択ルールの更新を含んでいる
- これには、最終的な合計難易度が 587500000000000000000 であることをコンセンサスクライアントに認識させることが含まれる

## Gray Glacier - 2022/6/30
- [blog](https://blog.ethereum.org/2022/06/16/gray-glacier-announcement)

- [difficulty bomb](https://ethereum.org/en/glossary/#difficulty-bomb)を3ヶ月後ろ倒しにしました。
  - Proof of Stakeへの移行の動機付けとして計画された、Proof of Workの難易度設定を指数関数的に増加させ、フォークの可能性を低減させるもの。`difficulty bomb`はproof-of-stakeへの移行に伴い、非推奨となった


## Arrow Glacier - 2021/12/9
- [blog](https://blog.ethereum.org/2021/11/10/arrow-glacier-announcement)

## Altair - 2021/10/27
- [spec](https://github.com/ethereum/consensus-specs/tree/dev/specs/altair)

- Beacon Chainのために予定されていた最初のアップグレード。
- `sync committees`を有効にするライトクライアントのサポートが追加され、「マージ」に向けて開発が進むにつれて、バリデータの非アクティブとスラッシングのペナルティが増加した

## London - 2021/8/5
- [blog](https://blog.ethereum.org/2021/07/15/london-mainnet-announcement)

- transaction fee marketを改革する`EIP-1559`が導入され、ガスの払い戻しの処理方法や[Ice Age](https://ethereum.org/en/glossary/#ice-age)のスケジュールも変更された
  - Ice Age: ブロック`200,000`でEthereumのHard Forkを行い、指数関数的な難易度上昇（別名、difficulty bomb）を導入し、Proof Of Stakeへの移行の動機付けとした

## Berlin - 2021/4/15
- [blog](https://blog.ethereum.org/2021/03/08/ethereum-berlin-upgrade-announcement)

- 特定のEVM操作のガスコストを最適化し、複数のトランザクションタイプのサポートを強化した
- 
## Beacon Chain genesis - 2020/12/1
- [blog](https://blog.ethereum.org/2020/11/27/eth2-quick-update-no-21)

## Staking deposit contract deployed - 2020/10/14
- [blog](https://blog.ethereum.org/2020/11/04/eth2-quick-update-no-19)

## Muir Glacier - 2020/1/2
- [blog](https://blog.ethereum.org/2019/12/23/ethereum-muir-glacier-upgrade-announcement)

## Istanbul - 2019/12/8
- [blog](https://blog.ethereum.org/2019/11/20/ethereum-istanbul-upgrade-announcement)

## Constantinople - 2019/2/28
- [blog](https://blog.ethereum.org/2019/02/22/ethereum-constantinople-st-petersburg-upgrade-announcement)

## Byzantium - 2017/10/16
- [blog](https://blog.ethereum.org/2017/10/12/byzantium-hf-announcement)

## Spurious Dragon - 2016/11/22
- [blog](https://blog.ethereum.org/2016/11/18/hard-fork-no-4-spurious-dragon)

## Tangerine whistle - 2016/10/18
- [blog](https://blog.ethereum.org/2016/10/18/faq-upcoming-ethereum-hard-fork)

## DAO fork - 2016/7/20
- [blog](https://blog.ethereum.org/2016/07/20/hard-fork-completed)

## Homestead - 2016/3/14
- [blog](https://blog.ethereum.org/2016/02/29/homestead-release)