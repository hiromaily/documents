# Finality

## Block

- PoS では、チェーンは`Slot`に分割され、32 個の Slot のグループは`Epoch`と呼ばれる
- 各 Slot は、チェーンにブロックが追加されるチャンスとなる
- Slot（ブロックの可能性）は、`12秒`おきに正確に発生する。(genesis.json の設定による)
- [Etherscan:Blocks](https://etherscan.io/blocks)を見る限り、12 秒毎に新しい Block が生成されている

## [Checkpoint](https://ethereum.org/se/glossary/#checkpoint)

Beacon Chain には、Slot (12 秒) と Epochs (32Slot) に分割されたテンポがあり、各 Epochs の最初の Slot が Checkpoint。 圧倒的多数の Validator が 2 つのチェックポイント間のリンクを証明した場合、それらは正当化され、別の Checkpoint がその上に正当化された場合、最終化(finalized)されます。

=> つまり、32Slot(12s\*32)は 384s なので、およそ 6 分 24 秒で Finality を得ることができる？？？

## [PoS Finality](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/#finality)

PoS Ethereum では、Finality は`checkpoint` Block を使用して管理される。各 Epochs の最初のブロックは`Checkpoint`となる。Validator は、有効であると見なす Checkpoint のペアに投票する。Checkpoint のペアがステークされた ETH の合計の少なくとも 3 分の 2 を表す票を集めた場合、Checkpoint はアップグレードされる。 2 つのうちの新しい方 (ターゲット) が`正当化:justified`される。 前の Epoch の「ターゲット」だったので、2 つのうち早い方がすでに正当化されている。 これで「ファイナライズ済み」にアップグレードされた。 ファイナライズされたブロックを元に戻すには、攻撃者はステーキングされた ETH の総供給量の少なくとも 3 分の 1 を失うことを約束する。 Finality には 3 分の 2 の多数決が必要であるため、攻撃者は総ステークの 3 分の 1 で投票することにより、ネットワークがファイナリティに到達するのを防ぐことができる。
