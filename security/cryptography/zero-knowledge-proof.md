# ゼロ知識証明 Zero-Knowledge Proof (ZKP)

ゼロ知識証明は様々な形でセキュリティとプライバシーを提供する強力な技術。  
理解を深めるためには、特定のプロトコル（例えば `zk-SNARKs` や `zk-STARKs`）について学ぶとよい

## ゼロ知識証明とは？

ゼロ知識証明は、一方（**証明者**）がもう一方（**検証者**）に対して、持っている情報（**秘密**）を一切漏らさずに、その情報を正しく持っていることを証明する方法。具体的には、以下の3つの特性を満たす証明方法

1. **完備性（Completeness）**: もし証明者が秘密を正しく持っているなら、検証者はそれが正しいと確信をもつことができる。
2. **健全性（Soundness）**: もし証明者が秘密を持っていない場合、不正な証明を通して検証者をだますことはできない（または極めて低い確率でしかできない）。
3. **ゼロ知識性（Zero-knowledge）**: 証明過程で検証者は、秘密そのものやそれに関する情報を得ることがない。

### どうやって動作するのか？

`ZKP`は具体的な形式はいろいろあるが、シンプルな例を考えてみる。たとえば、以下のようなシナリオがあるとする

#### フィアット-シャミールプロトコル（Fiat–Shamir protocol）

1. **セットアップ**: まず、証明者が秘密の値 \( s \) を持っているとする。また、公開されている値として、証明者と検証者の両方が \( v = s^2 \mod n \) という値を知っているとする（この \( n \) は大きな合成数）。

2. **証明の準備**: 証明者はランダムな値 \( r \) を選び、以下のように計算する：

   \[ x = r^2 \mod n \]

   この \( x \) を検証者に送ります。

3. **挑戦**: 検証者はランダムに挑戦値 \( e \) を選びます。この \( e \) は通常0か1。

4. **応答**: 証明者は \( e \) に基づいて以下のように応答する：

   \[ y = r \cdot s^e \mod n \]

5. **検証**: 検証者は受け取った \( y \) から以下の条件をチェックする：

   \[ y^2 \equiv x \cdot v^e \mod n \]

   この条件が成り立てば、証明者が秘密の値 \( s \) を正しく持っていると判断される。

このプロセスを複数回繰り返すことで、偽証明者が証明に成功する確率を極めて低くすることができる。

## ゼロ知識証明の応用例

- **ブロックチェーンと暗号通貨**: ZKPはプライバシーを守りながら取引の正当性を証明するために使用される。 例としては、Zcash（zk-SNARKs使用）が有名。
- **認証システム**: パスワードを共有せずに認証を行うことが可能。
- **選挙システム**: 投票内容を公開せずに票を正しく集計することができる。