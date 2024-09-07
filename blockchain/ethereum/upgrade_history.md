# Upgrade (Fork) History

- [The history of Ethereum](https://ethereum.org/en/history/)
- [Upgrading Ethereum to radical new heights](https://ethereum.org/en/upgrades/)

## Shanghai - TBD

- [spec](https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/shanghai.md)

- これにより`staking withdrawals`が実行レイヤーに備わることになる
- Capella のアップグレードと連動する
- staker は beacon chain から実行レイヤーに ETH を引き出すことができる

## Capella - TBD

- [spec](https://github.com/ethereum/consensus-specs/blob/dev/specs/capella/beacon-chain.md)

- Beacon チェーンの 3 回目のアップグレード
- Execution Client の`Shanghai`への Upgrade を同時に実行し、互いに同期することで `staking withdrawals`が可能となる
- `initial deposit`時に`withdrawal credentials`を提供しなかった staker が withdrawal が可能となる

## Paris (The Merge) - 2022/9/15

- [spec](https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/paris.md)

- Proof of Work のブロックチェーンが terminal total difficulty `58750000000000000`を通過したことによって引き起こされた
- これは 2022 年 9 月 15 日のブロック`15537393`で起こり、次のブロックに Paris アップグレードが発動された。
- Paris は`The Merge transaction`であり、その主な特徴は、PoW のマイニングアルゴリズムと関連するコンセンサスロジックを止め、代わりに PoS に切り替えたこと

### 概要

`Ethereum1.0`と`Ethereum2.0`の名称は廃止され、`Execution Layer`と`Consensus Layer`という呼称に改めされた

- Eth1 -> 実行レイヤー
- Eth2 -> 合意レイヤー
- 実行レイヤー + 合意レイヤー = イーサリアム

### References

- [The Merge](https://ethereum.org/en/upgrades/merge/)
- [リブランディング: Eth2 の名称廃止](https://blog.ethereum.org/ja/2022/01/24/the-great-eth2-renaming)
- [The New Ethereum Upgrade (2.0): Your Guide 2022](https://www.alchemy.com/overviews/ethereum-2-0-your-guide-for-2022)

## Bellatrix - 2022/9/6

- [spec](https://github.com/ethereum/consensus-specs/tree/dev/specs/bellatrix)

- Beacon チェーンの 2 回目のアップグレードで、The Merge の準備のために予定されていたもの
- このアップグレードにより、バリデータの非アクティブとスラッシュ可能な違反に対するペナルティが完全な値となる
- The Merge と最後の Proof of Work ブロックから最初の Proof of Stake ブロックへの移行に備えるため、フォーク選択ルールの更新を含んでいる
- これには、最終的な合計難易度が 587500000000000000000 であることをコンセンサスクライアントに認識させることが含まれる

## Gray Glacier - 2022/6/30

- [blog](https://blog.ethereum.org/2022/06/16/gray-glacier-announcement)

- [difficulty bomb](https://ethereum.org/en/glossary/#difficulty-bomb)を 3 ヶ月後ろ倒しにしました。
  - Proof of Stake への移行の動機付けとして計画された、Proof of Work の難易度設定を指数関数的に増加させ、フォークの可能性を低減させるもの。`difficulty bomb`は proof-of-stake への移行に伴い、非推奨となった

## Arrow Glacier - 2021/12/9

- [blog](https://blog.ethereum.org/2021/11/10/arrow-glacier-announcement)

## Altair - 2021/10/27

- [spec](https://github.com/ethereum/consensus-specs/tree/dev/specs/altair)

- Beacon Chain のために予定されていた最初のアップグレード。
- `sync committees`を有効にするライトクライアントのサポートが追加され、「マージ」に向けて開発が進むにつれて、バリデータの非アクティブとスラッシングのペナルティが増加した

## London - 2021/8/5

- [blog](https://blog.ethereum.org/2021/07/15/london-mainnet-announcement)

- transaction fee market を改革する`EIP-1559`が導入され、ガスの払い戻しの処理方法や[Ice Age](https://ethereum.org/en/glossary/#ice-age)のスケジュールも変更された
  - Ice Age: ブロック`200,000`で Ethereum の Hard Fork を行い、指数関数的な難易度上昇（別名、difficulty bomb）を導入し、Proof Of Stake への移行の動機付けとした

## Berlin - 2021/4/15

- [blog](https://blog.ethereum.org/2021/03/08/ethereum-berlin-upgrade-announcement)

- 特定の EVM 操作のガスコストを最適化し、複数のトランザクションタイプのサポートを強化した
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
