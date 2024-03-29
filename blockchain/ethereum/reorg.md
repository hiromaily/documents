# Reorg

- [What is a reorg?](https://www.alchemy.com/overviews/what-is-a-reorg)

日本語で`再編成`の意味。
ブロックチェーンの reorg は、バリデータがブロックチェーンの最も正確なバージョンについて意見が一致しない場合に起こる。再整理は、複数のブロックが偶然同時に生成された場合、バグがある場合、悪意のある攻撃による場合に発生する。再整理によって、より弱い重複ブロックチェーンは排除される。再編成が長引けば長引くほど、その処理コストは高くなる。

ブロックチェーンの再編成では、より長いチェーンが作成されたため、ブロックがブロックチェーンから削除される。その結果、異なるマイナーが同時に同じような難易度の取引ブロックをチェーンに追加することになる。

このようなことが起こるのは、次のブロックに追加するマイナーが、フォークのどちらが正しいチェーンか、あるいは正規のチェーンかを判断しなければならないからである。採掘者または検証者がフォークまたは正規のチェーンを選択すると、もう一方のチェーンは失われる。

再編成攻撃とは、古いチェーンが存在し続けている間に、ノードが新しいチェーンからブロックを受け取ることを指す。この場合、チェーンは分割され、フォーク（ブロックチェーンの複製）が作成される。

## なぜ起きるのか？

ブロックチェーンの再編成は、2 つのブロックが同時に公開されたときに発生する。短い 1 ブロックや 2 ブロックの再編成はネットワークの遅延のためによく起こるが、再編成が 1 ブロックや 2 ブロックより長くなると、悪意のある攻撃やネットワーク障害につながる可能性がある。

## reorg による影響

### 1.遅延とユーザー・エクスペリエンスの低下

ノードコストの増加とともに、再編成は取引の遅延の可能性を増加させる。これは取引所にとって重大な問題である。というのも、取引所はトランザクションが時間通りに確認されることに依存しなければならず、そうでなければ入金待ちの時間が長くなるという結果を被る可能性があるからである。

### 2.ノードコスト

再フォークは時間の経過とともにブロックチェーン内のノード数を増加させ、ユーザーエクスペリエンスの低下を引き起こす可能性がある。新しいフォークに移行する際、状態の更新にはより多くのメモリとディスクのコストがかかる。

### 3.不確実性

再注文が目立つと、ユーザーはトランザクションが時間通りに実行される保証が少なくなる。十分なコンテキストがなければ、DeFi トランザクションの結果ははるかに悪くなり、有害な MEV 抽出にもつながる。

### 4.攻撃に対する脆弱性

再投資がより一般的になると、攻撃者は正直なマイナーの全員ではなく、（「最長連鎖ルール」によって）一部のマイナーを打ち負かせばよくなる。リオークの数が増えれば、攻撃者の役割はより簡単になる。

## カノニカル・チェーン (Canonical chain)

同意された "主鎖 "である。したがって、終了する側鎖の 1 つとはみなされない。
