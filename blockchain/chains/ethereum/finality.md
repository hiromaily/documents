# PoS Finality

## Block

- PoS では、チェーンは`Slot`に分割され、32 個の Slot のグループは`Epoch`と呼ばれる
- 各 Slot は、チェーンにブロックが追加されるチャンスとなる
- Slot（ブロックの可能性）は、`12秒`毎に正確に発生する。(genesis.json の設定による)
- [Etherscan:Blocks](https://etherscan.io/blocks)を見る限り、`12秒`毎に新しい Block が生成されている

### Block の生成について

- [Angle Explains: ETH 2.0, changes in block production and impact on MEV](https://blog.angle.money/angle-explains-eth-2-0-changes-in-block-production-and-impact-on-mev-f9c6f353c6bd)

![eth2 epoch slot](https://raw.githubusercontent.com/hiromaily/documents/main/images/eth2_epoch_slot.webp "eth2 epoch slot")

- PoS では、チェーンは`Slot`に分割され、32 個の Slot のグループは`Epoch`と呼ばれる
- 各 Slot は、チェーンにブロックが追加されるチャンスとなる
- Slot（ブロックの可能性）は、12 秒おきに正確に発生する。(genesis.json の設定による)
- 1 ブロックあたり 2ETH の採掘報酬は、1 ブロックあたり 0.22ETH の賭け報酬となり、~90%減少している
- これは ETH の供給にとってメリットが、バリデータの収益に占める transaction fee の割合がはるかに高くなる
- 収益を上げ、競合するバリデータに対して市場シェアを獲得するためには、`MEV`を最大化することがより重要になる
- PoS では Epoch 32slot の Validator(採掘者)が事前に判明する

- TODO: Miner Extractable Value（MEV）リスク

## [Checkpoint](https://ethereum.org/se/glossary/#checkpoint)

Beacon Chain には、Slot (12 秒) と Epochs (32Slot) に分割されたテンポがあり、各 Epochs の最初の Slot が Checkpoint。 圧倒的多数の Validator が 2 つのチェックポイント間のリンクを証明した場合、それらは正当化され、別の Checkpoint がその上に正当化された場合、最終化(finalized)されます。

=> つまり、32Slot(12s\*32)は 384s なので、およそ 6 分 24 秒で Finality を得ることができる？？？

## [PoS Finality](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/#finality)

PoS Ethereum では、Finality は`checkpoint` Block を使用して管理される。各 Epochs の最初のブロックは`Checkpoint`となる。Validator は、有効であると見なす Checkpoint のペアに投票する。Checkpoint のペアがステークされた ETH の合計の少なくとも 3 分の 2 を表す票を集めた場合、Checkpoint はアップグレードされる。 2 つのうちの新しい方 (ターゲット) が`正当化:justified`される。 前の Epoch の「ターゲット」だったので、2 つのうち早い方がすでに正当化されている。 これで「ファイナライズ済み」にアップグレードされた。 ファイナライズされたブロックを元に戻すには、攻撃者はステーキングされた ETH の総供給量の少なくとも 3 分の 1 を失うことを約束する。 Finality には 3 分の 2 の多数決が必要であるため、攻撃者は総ステークの 3 分の 1 で投票することにより、ネットワークがファイナリティに到達するのを防ぐことができる。

## Gaspe

Gasper（Casper FFG + LMD GHOST）によって、ターゲット ブロックに投票するため、明示的なファイナリティを提供する。Epoch ごとに、バリデーターが投票を送信して収集し、Block を完成させるまでに 2 エポックかかる。
平均 Block Finality 時間は 2.5 エポック タイムとなり、960 秒 (12 秒 _32_ 2.5) に相当する。

## [What Happens After Finality in ETH2?](https://hackmd.io/@prysmaticlabs/finality)

- 2/3 以上のバリデータが長期間にわたってチェーンヘッドに正しく投票した場合、特定のチェックポイント以前のすべてを確定したとみなすことができる
- ある Epoch において、バリデータの 2/3 以上がチェーンヘッドに正しく投票した場合、その Epoch を `justified`と呼ぶ
- 2 つのエポックが連続して`justified` された場合、`current_epoch - 2`を`finalized`と 見なす
- 主要なバリデータがオフラインになったり、人気のあるクライアントの実装に深刻なバグがあったりしない限り、current_epoch を常に確定させるインセンティブは `-2`であり、eth2 のエポックが 6.4 分であることを考えると、理想的には 12.8 分前のエポックが常に確定するはず

## Explorer の挙動

[beaconcha.in](https://beaconcha.in/epochs)を見ると、まさに`current_epoch - 2`の epoch は finalized されている。

`finality_checkpoints` API を実行しても仕様通りの結果となる。
[参考](./beacon-api.md)
