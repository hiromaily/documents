# DeFi

スマートコントラクトによって実現される分散型金融　(Decentralized Finance)

## DeFi の特徴

- 法律等の制約を受けない
- 手数料が安い
- 自由にサービス設計ができる
- 運営者はいるが、徐々に権限をコミュニティーに移譲する`分散ガバナンス`が進んでいる

## DeFi の主要サービス

### レンディング

- 資金の貸し借りを仲介者なしで取引することができる
- このサービスに預けると利子を得ることができる
- 逆に借りる場合は、利子を支払うことになる
- 借りる市場で利用できる仮想通貨が多ければ多いほど金利を低くし、利用できる仮想通貨が少なければ少ないほど金利を高くする
  - 1 つの通貨では、使用率が高ければ金利が高くなる
- このロジックは公開されていることが望ましい
- 代表的なサービスは`Compound`
  - 高い利率の仮想通貨を貸し借りするほど、より多くの`COMP`と言われる`ガバナンストークン`を得ることができる
  - `ガバナンストークン`を持つ利用者が、新たなサービスを導入するか否かについて投票を行う
- 運用規模を拡大するためには、仮想通貨を預けてくれる利用者を増やすことが不可欠
  - Compound では、預け入れ額に応じてガバナンストークンを配布する
- 借り手側は、借り入れる際には、仮想通貨での担保を用意する必要がある
- 担保として貸し出した仮想通貨はロックされて自由に移動することができなくなる
- 借りた仮想通貨を返すことで資金ロックが解除される

### DEX (分散型取引所)

- 仮想通貨同士を交換する取引所の機能のことで、スマートコントラクトによって自動で取引がされることになる。
- 代表的なサービスは`Uniswap`で、非営利目的で運営されていて手数料がほとんど発生しない
- DeFi としての特色は、アカウントの作成は必要なく、仮想通貨の wallet と同期させることによって swap することができる

### AMM (Automated Market Maker)

- 現在の証券取引所システムはミリ秒以下の応答速度で注文を処理し、1 秒間に数万件の処理を行うことができる
- 仮想通貨の取引では、Ethereum では 1 秒間に 20 件程度の処理しかできない
- しかし、swap 取引では、需要と供給の関係をリアルタイムに反映させることが大事
- このため、取引のルールをアルゴリズムによって制御する`自律的に機能するマーケットメーカー:AMM`が考え出された
- 2 種類の仮想通貨を 1:1 の価値となるように組み合わせたものを`流動性プール`という
  - 例えば ETH と OMG では `1 ETH`と`500 OMG`は同じ価値となる場合、このような組み合わせをいう
  - そして流動性プールの目的は、2 種類の仮想通貨ペア間の交換を円滑にするためのもの
  - 多くの人が ETH から OMG に swap したいと考えるとき、OMG の価値をあげて交換比率を柔軟に変更することが大事
  - そのアルゴリズムは`ETHの総量とOMGの総量を掛け合わせた量を不変量とする`
  - 上記の例では、流動性プールを作成した人が最初に拠出したのが、`10 ETH`と`500 OMG`とすると、両通貨の総量を掛け合わすと`5000`となり、この数値が`不変量 (invariant)`となる
  - ここで、買い手が`1 ETH`を流動性プールに預けた場合、`不変量 (5000) / ETH 総量(11) = OMG 総量 (454.5)`で、OMG の元々の総量が 500 なので、500-454.5 の`45.5`を書いてに返却することになる
  - この結果、元々の交換比率が`1:50`だったが、この取引によって`1:45.5`に更新された
  - 尚、実際に買い手が手持ちの仮想通貨を流動性プールに送信する際に、一定の手数料が差し引かれることになる。この手数料の一部が流動性を供給した利用者に対してインセンティブとして配布される
  - AMM による取引は P2P 取引ではなく、買い手に対して相手側は流動性プールそのもの

### 流動性

- 市場(マーケット)に出回っている仮想通貨の総量
- 仮想通貨が今後値上がりすると予想される場合、自分で長期保有するため、この状態は「流動性が低い」とされる
- 取引所にとってある程度の流動性を確保することが死活問題

### 修道性マイニング (Liquidity Mining)

- 利用者の保有する仮想通貨を DEX に預けることで、その見返りとして新たな仮想通貨（ガバナンストークン）を入手できるという仕組み
- イールドファーミング (Yield Farming)の一種

### ステーキング

- 仮想通貨を一定期間預けることで、その対価として収益を得る仕組み
- PoS は、仮想通貨を多く持っている人(ステークを保有している人)ほどマイニングできる権利が割当たる可能性が高くなる

## DeFI 関連専門用語

- TVL: Total Value Locked ... 預かり資産額
- KYC: 本人確認
- AML: マネーロンダリング規制
- ステーブルコインの 3 つの種類
  - 法定通貨担保型 ... ドル等の実際の通貨を裏付けとして準備した上で発行する
  - 仮想通貨担保型 ... ETH 等の仮想通貨を裏付けとして準備した上で発行する
  - 無担保型 ... アルゴリズムだけで価値を安定化させるように取引する
- rug pull:
  - サービス運営者が資金を持ち逃げするという詐欺のことで、DeFi の場合、流動性プールから流動性を取り除く行為のことを指す。
  - 具体的には仮想通貨のペアによって構成される流動性プールから、片方の通貨を引き抜き別の取引所に送金するといった行為。
- フラッシュローン: 1 つのトランザクションの中で、最初に仮想通貨を借り、その通貨を使って swap 等の取引を行い、その結果を踏まえて仮想通貨の返済を行う
  - 手数料はかかるが、元手がなくとも大きな取引を同時に行うことができるのが特徴

## Bridge Application

[Blockchain Bridges: Building Networks of Cryptonetworks](https://medium.com/1kxnetwork/blockchain-bridges-5db6afac44f8)

異なるネットワーク間の相互運用性のために Blockchain Bridge というものが存在し、2021 年の時点で 40 以上の project が存在している。

### Applications

- [Stargate](https://stargate.finance/)

### Pool

- [Docs: Pool](https://stargateprotocol.gitbook.io/stargate/v/user-docs/stargate-features/pool)
- Liquidity(流動性)を Stargate の pool に追加することで、transfer 毎もしくは farm 毎に StableCoin reward (LP Token) を得ることができる。
- Liquidity Provider は そこで得た LP token を farm して(Stargate の farm に token を割り当てる) STG token reward を得ることができる。

#### App

- [Stargate Pool App](https://stargate.finance/pool)
  - 画面の表示項目
    - Total Amount
    - Pooled Tokens
    - LPT Farming
    - Share of Pool
    - Volume (24h)
    - Liquidity

#### Code

- Stargate の[Pool コントラクト](https://github.com/stargate-protocol/stargate/blob/c647a3a647fc693c38b16ef023c54e518b46e206/contracts/Pool.sol#L491)では、LDamount だったり SDamout というものが出てくるが、これは何？

### Farming

- [Docs: Farm](https://stargateprotocol.gitbook.io/stargate/v/user-docs/stargate-features/farm)
- LP token を farm することで、STG の reward を得ることで、Stargate community のメンバーとなる。
- STG reward は Stargate protocol の Governance token である`veSTG`を獲得するために stake することができる

### Staking

- STG token を lock して、Stargate protocol の Governance token である`veSTG`を獲得することができる
- コミュニティーメンバーは Vote-escrowed STG (veSTG)の残高を持つアカウントのことで、Stargate DAO のガバナンスに参加することができる

### Governance Model
