# BNB Chain
[Binance](https://www.binance.com/en)は暗号通貨取引所であり、2019年に`Binance Chain`をリリースし、2020年に`Binance Smart Chain`をリリースした。Binance ChainはCosmos SDKを使って作られたチェーンだが、BSCはEthereumのフォークであり、EVM互換である。

`Binance Chain`と`BSC`は2022年2月に統合され、`BNB Chain`になった。`BNB Chain`では`Binance Chain`がビーコンチェーンとしてステーキングや投票に使われ、`BSC`がスマートコントラクトの実行やコンセンサスに使われる。

[Introducing BNB Chain: The Evolution of Binance Smart Chain](https://www.binance.com/en/support/announcement/introducing-bnb-chain-the-evolution-of-binance-smart-chain-854415cf3d214371a7b60cf01ead0918)

## コンセンサス
`DPoS`（Delegated Proof of Stake、BNBの保有者から投票を受けたバリデータがブロックを作成する）と`PoA`（Proof of Authority、承認された機関がブロックを作成する）を組み合わせた`PoSA`（Proof of Staked Authority）という仕組みで行われる。
ブロックの生成は`29`のバリデータによって行われるため、トランザクションは高速に処理される。
BNB Chainではブロック作成時に新しくトークンが発行されることはなく、バリデータや、バリデータに投票したBNBの所有者はトランザクション手数料を受け取る。

## ハッキングについて
BNB Chainの限られた数のバリデータによるブロック生成方式には、トランザクションを高速に処理できる一方で懸念点もあり、2022年10月にブリッジがハッキングされた際には、Binanceはバリデータに対してBSCを一時停止するよう依頼し、ブロックチェーンが一時停止した。この措置によって被害は抑えられたが、一方で未だBinanceが中心に存在する中央集権的な運用体制も露呈した。

## Finality
[BNB Chain Documentation](https://docs.bnbchain.org/docs/learn/intro/#fast-finality)

`1/2*N+1` を超える検証者が誠実であることを考えると、PoA ベースのネットワークは通常、安全かつ適切に機能する。
ただし、一定量のビザンチンバリデーターが依然としてクローン攻撃を通じてネットワークを攻撃できる場合がある。 BSC は、ビザンチンのバリデーターに二重署名または無効化に対してペナルティを与えるためのスラッシュロジックを導入しており、これにより悪意のあるバリデーターが非常に短時間で暴露され、`クローン攻撃`の実行が非常に困難になるか、非常に無益になる。

### FastFinality導入前
BSC はコンセンサス メカニズムとして `PoSA` を使用するが、これは投票メカニズムがないことを意味し、finalityの点では確率的となる。
Binance は、(2/3*Validator Num + 1) ブロックがfinalizedするとみなす。
これは現在 `15` ブロック(Validator Numが21のため)。1 block 3secなので、45秒となる。

### [FastFinality](https://www.bnbchain.org/en/blog/the-coming-fastfinality-on-bsc/)


BSC ネットワーク上の `FastFinality` は、ユーザーにトランザクションを検証するためのより高速かつ安全な方法を提供する。Proof of Stake Authority (PoSA) と Byzantine Fault Tolerance (BFT) アルゴリズムを組み合わせて利用し、トランザクションがわずか数秒で完了することを保証する。
(2/3*ValidatorSize) 以上のバリデーターが期待どおりに投票した場合、トランザクションを完了するまでに平均 2.5 ブロックかかり、完了時間は約 7.5 秒に短縮される。

- 今後の [`Plato` アップグレード](https://forum.bnbchain.org/t/bnb-chain-upgrades-mainnet/936#platoupcoming-6)後(July-25-2023)、`Fast Finality` 機能が有効になる。
- 設計の詳細は[BEP-126: Introduce Fast Finality Mechanism](https://github.com/bnb-chain/BEPs/blob/master/BEP126.md)

## References
- [Official](https://www.bnbchain.org/en)
- [BNB Chainとは？大手暗号通貨取引所Binanceによるブロックチェーン](https://gaiax-blockchain.com/bnb-chain)