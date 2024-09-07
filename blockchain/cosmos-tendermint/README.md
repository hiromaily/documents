# Cosmos And Tendermint

## References

### Cosmos

- [Official](https://cosmos.network/)
- [Cosmos SDK Docs](https://docs.cosmos.network/main)
- [Tendermint Docs](https://docs.tendermint.com/)
- [Developer Portal](https://tutorials.cosmos.network/) ... tutorial
  - [What is Cosmos?](https://tutorials.cosmos.network/academy/1-what-is-cosmos/)

- [How does Cosmos work? Part1](https://www.preethikasireddy.com/post/how-does-cosmos-work-how-does-it-compare-to-bitcoin-and-ethereum-part-1)
- [How does Cosmos work? Part2](https://www.preethikasireddy.com/post/how-does-cosmos-work-how-does-it-compare-to-bitcoin-and-ethereum-part-2)
- [Cosmos SDKの教科書](https://zenn.dev/kimurayu45z/books/abf4114858f7c35b775d)
- [IBC(ブロックチェーン間通信)の概要](https://zenn.dev/qope/articles/51bc0d7ff25fc8)

### Tendermint

- [Docs](https://docs.tendermint.com/v0.34/)
  - [What is Tendermint](https://docs.tendermint.com/v0.34/introduction/what-is-tendermint.html)

![tendermint flow](https://github.com/hiromaily/documents/raw/main/images/tendermint_flow01.png "tendermint flow")

## Cosmosのコンセンサス

- Tendermintコンセンサスアルゴリズムを使用している
- Tendermintは、`アプリケーションにとらわれないコンセンサスエンジン`
- このアルゴリズムは`Byzantine Fault-Tolerant`(ビザンチン フォールト トレラント) であり、シビル(Sybil)耐性メカニズムとして`Proof of Stake`を使用している

### バリデータ

- 合意形成の手助けをする責任を負うノードを `バリデータ` と呼ぶ
- バリデータは、ネットワークがコンセンサスを達成するのを助けるために進んで参加する ネットワークノード
- バリデータはその対価として、手数料とブロック報酬を受け取る
- Tendermintはこれらのバリデータの投票を集計し、正しい次のブロックを決定する

### Staking ステーキング

- Staking によるシビル(Sybil)・レジスタンスを実現する
- 各バリデーターは、投票の重み付けに使用される独自の投票権を持っている
- 投票権は通常、ブロックチェーンが最初に起動したとき（genesis時）、またはアプリケーション開発者が決定する何らかのロジックを通じてブロックチェーンが決定する
- 投票力を決定する典型的なアプローチは、`バリデータが担保としてシステムにロックするトークンの量によって行われる`。この賭け金は `bond` "と呼ばれる

### コンセンサス

- プロトコルの規則に従い、バリデータは`ラウンド`を経て各ブロックについてコンセンサスを 得る
- 各ラウンドは3つのステップ(`Propose`, `Prevote`, `Precommit`)と、2つの条件付きステップ `Commit`,`NewHeight` から構成される
- バリデータが次のHeightにどのブロックを追加するかについて合意形成するために使用する プロトコルルールを以下に示す
  1. まず、`Propose`のステップ。これは指定された提案者がブロックを提案するところである。ラウンドの提案者は、有効者の順番に並んだリストから投票力に比例して決定論的に選ばれる。
  2. 次に、各バリデータがPrevote票をブロードキャストする`Prevote`ステップに入る。
  3. あるラウンドで投票権の2/3以上が特定のブロックに`Prevote`した場合、これを `polka`(ポルカ) と呼ぶ。`polka`が達成されると、次のステップに進む。
  4. `Precommit`ステップでは、各バリデータが`Precommit`票をブロードキャストする。
  5. あるラウンドで投票権の2/3が特定のブロックに対して`Precommit`した場合、そのブロックは`Commit`ステップに移行する。ここでブロックをブロックチェーンに追加し、ブロックの高さを`NewHeight`にインクリメントする。新しいブロックがブロックチェーンに追加されるたびに、ブロックチェーンの「高さ」は1つずつ増加する。
  6. そうでない場合は、`Prevote`または`Precommit`のステップに戻る。

- Tendermint では、バリデータが投票とコミットを成功させた後、直ちにブロックが確定される
- Tendermintコンセンサスでは、固定された既知のバリデータが存在する必要があり、各バリデータは公開鍵によって識別される
- Tendermintでは、次のブロックを提案するリーダー（提案者）を選ぶ
- Tendermintはブロックチェーンが停止することなく進行することを保証するために、明示的なタイムアウトを使用している

![consensus flow](https://github.com/hiromaily/documents/raw/main/images/tendermint_consensus_logic.png "consensus flow")
