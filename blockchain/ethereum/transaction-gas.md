# Ethereum Transaction And Gas

- [Transaction](https://ethereum.org/en/developers/docs/transactions/)
- [What is Gas and How is it Used?](https://www.web3.university/tracks/create-a-smart-contract/what-is-gas-and-how-is-it-used)
- [How to estimate the gas fee](https://metamask.zendesk.com/hc/en-us/articles/360059562111-How-to-estimate-the-gas-fee)
- [EIP-1559](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1559.md)
- [Ethereum Gas Tracker: Gas Price](https://etherscan.io/gastracker)

## [Transaction](https://ethereum.org/en/developers/docs/transactions/)

### Transactionとは
- Ethereumのトランザクションは、外部所有のアカウントが管理するアカウントによって開始されるアクションを指す
- この状態を変えるアクションは、トランザクションの中で行われる。これにより `world state`が変化する
- EVMの状態を変更するトランザクションは、ネットワーク全体にブロードキャストされる必要がある
- どのノードもEVM上でトランザクションを実行するよう要求をブロードキャストすることができる
- この後、バリデータがトランザクションを実行し、その結果の状態変化をネットワークの残りの部分に伝達する
- トランザクションにはfeeが必要で、検証済みのブロックに含まれる必要がある

### 送信されたトランザクションに含まれるもの
- recipient
  - 受け取りアドレス
    - 外部所有アカウントの場合、トランザクションはvalueを転送する
    - コントラクトアカウントの場合、トランザクションはContractコードを実行する
- signature:署名
  - 送信者の識別子
  - これは送信者の秘密鍵がトランザクションに署名し、送信者がこのトランザクションを許可したことを確認するときに生成される 
- nonce
  - アカウントからのトランザクション番号を示す連続的に増加するカウンタ
- value
  - 送信者から受信者に転送するETHの量（WEI: ETHのdenomination 単位名）
- data
  - 任意のデータを格納するためのオプションフィールド． 
- gasLimit
  - トランザクションで消費されるガス単位の最大量。ガスの単位は計算のステップを表す 
- maxPriorityFeePerGas
  - バリデータへのチップとして含まれるガスの最大量 
- maxFeePerGas
  - トランザクションのために支払われるガスの最大量（baseFeePerGasとmaxPriorityFeePerGas を含む）


[Gas](https://ethereum.org/en/developers/docs/gas/)は、バリデータでトランザクションを処理するために必要な計算への参照であり、ユーザーはこの計算のために料金を支払わなければならない。`gasLimit` および`maxPriorityFeePerGas`は、バリデータに支払うトランザクション手数料の上限を決定する。

### トランザクションオブジェクト
- トランザクションオブジェクト例
```
{
  from: "0xEA674fdDe714fd979de3EdF0F56AA9716B898ec8",
  to: "0xac03bb73b6a9e108530aff4df5077c2b3d481e5a",
  gasLimit: "21000",
  maxFeePerGas: "300",
  maxPriorityFeePerGas: "10",
  nonce: "0",
  value: "10000000000"
}
```

トランザクションオブジェクトは送信者の秘密鍵を使用して署名する必要がある。これは、そのトランザクションが送信者からのものでしかなく、不正に送信されたものではないことを証明するもの。
GethのようなEthereumクライアントがこの署名プロセスを処理することになる。

- JSON-RPCによる`account_signTransaction` callの例
```
// Request
{
  "id": 2,
  "jsonrpc": "2.0",
  "method": "account_signTransaction",
  "params": [
    {
      "from": "0x1923f626bb8dc025849e00f99c25fe2b2f7fb0db",
      "gas": "0x55555",
      "maxFeePerGas": "0x1234",
      "maxPriorityFeePerGas": "0x1234",
      "input": "0xabcd",
      "nonce": "0x0",
      "to": "0x07a565b7ed7d7a678680a4c162885bedbb695fe0",
      "value": "0x1234"
    }
  ]
}

// Response
{
  "jsonrpc": "2.0",
  "id": 2,
  "result": {
    "raw": "0xf88380018203339407a565b7ed7d7a678680a4c162885bedbb695fe080a44401a6e4000000000000000000000000000000000000000000000000000000000000001226a0223a7c9bcf5531c99be5ea7082183816eb20cfe0bbc322e97cc5c7f71ab8b20ea02aadee6b34b45bb15bc42d9c09de4a6754e7000908da72d48cc7704971491663",
    "tx": {
      "nonce": "0x0",
      "maxFeePerGas": "0x1234",
      "maxPriorityFeePerGas": "0x1234",
      "gas": "0x55555",
      "to": "0x07a565b7ed7d7a678680a4c162885bedbb695fe0",
      "value": "0x1234",
      "input": "0xabcd",
      "v": "0x26",
      "r": "0x223a7c9bcf5531c99be5ea7082183816eb20cfe0bbc322e97cc5c7f71ab8b20e",
      "s": "0x2aadee6b34b45bb15bc42d9c09de4a6754e7000908da72d48cc7704971491663",
      "hash": "0xeba2df809e7a612a0a0d444ccfa5c839624bdc00dd29e3340d46df3870f8a30e"
    }
  }
}
```

- `raw`は再帰的長さプレフィックス(RLP)で符号化された署名済みトランザクション
- `tx`はJSON形式の署名済みトランザクション
- 署名ハッシュにより、そのトランザクションが送信者から送られ、ネットワークに提出されたことを暗号的に証明することができる

### トランザクションのデータフィールド: data filed
- ほとんどのトランザクションは、外部所有のアカウントからコントラクトにアクセスする
- コントラクトのほとんどは Solidity で書かれており、`アプリケーションバイナリインターフェース (ABI)` に従ってそのデータフィールドを解釈する
- 最初の4バイトは、関数名と引数のハッシュを使用して、どの関数を呼び出すかを指定する
- このデータベースを使用して、セレクタから関数を特定できる場合もある
- calldataの残りは引数で、ABI仕様で指定されたとおりにエンコードされている
-  例えば、[このトランザクション](https://etherscan.io/tx/0xd0dcbe007569fcfa1902dae0ab8b4e078efe42e231786312289b1eee5590f6a1)の場合
  -  `Calldata`を見るには、`Click to see More` をクリックして、更なる詳細を表示する
  -  `関数セレクタ`は0xa9059cbbだが、このシグネチャを持つ既知の関数がいくつかある。 この場合、コントラクトのソースコードがEtherscanにアップロードされているので、関数はtransfer(address,uint256)であることがわかっている
  - 残りのデータ
```
0000000000000000000000004f6742badb049791cd9a37ea913f2bac38d01279
000000000000000000000000000000000000000000000000000000003b0559f4
```
    - ABIの仕様によると、整数値（アドレスなど、20バイトの整数）は、`32バイト`のワードとして現れ、前面にゼロがパディングされる
    - つまり、`to`アドレス は`4f6742badb049791cd9a37ea913f2bac38d01279`とわかる
    - その値は0x3b0559f4=990206452である。

### トランザクションのType
- Regular transactions
  - ある口座から別の口座へのトランザクション
- Contract deployment transactions
  - データフィールドが契約コードに使用される、「宛先」アドレスのないトランザクション
- Execution of a contract
  - デプロイされたスマートコントラクトと相互作用するトランザクション。この場合、`to` アドレスはスマートコントラクトのアドレスとなる

### On Gas
- 前述のとおり、トランザクションの実行にはガスが必要
- 単純なTransferトランザクションには`21000`ユニットのガスが必要
- つまり、ボブがアリスに`1ETH`を`baseFeePerGas:190gwei`、`maxPriorityFeePerGas:10gwei`で送るには、ボブは以下の手数料を自分のアカウントから支払う必要がある。
```
// (baseFeePerGas + maxPriorityFeePerGas) * GasLimit
(190 + 10) * 21000 = 4,200,000 gwei (0.0042 ETH)
// 0.0042というfeeの内訳は以下の通り
// base fee:        0.00399 ETH
// Validator's tip: 0.000210 ETH
```
![gas](../../images/gas-tx.png "gas")

### トランザクションのライフサイクル
- トランザクションが送信されると、次のようになる
  - トランザクションを送信すると、暗号化によりトランザクションハッシュが生成される`0x97d99bc7729211111a21b12c933c949d4f31684f1d6954ff477d0477538ff017` 
  - そして、そのトランザクションはネットワークにブロードキャストされ、他の多くのトランザクションと一緒にプールに含まれる
  - バリデータは、トランザクションを検証して `successful` と見なすために、あなたのトランザクションを選んでブロックに含めなければならない
  - 時間が経つにつれて、あなたのトランザクションを含むブロックは`justified`,`finalized`にアップグレードされる。これらのアップグレードにより、あなたのトランザクションが成功し、決して変更されないことがより確実となる。いったん`finalized`されたブロックは、何十億ドルもかかる攻撃によってのみ変更することができる。

### TYPED TRANSACTION ENVELOPE
- Ethereumはもともと、トランザクションのフォーマットが1つだった
- 各トランザクションには、`nonce, gas price, gas limit, to address, value, data, v, r, s` が含まれており、これらのフィールドは`RLPエンコード`され、以下のような形になっている
```
RLP([nonce、gasPrice、gasLimit、to、value、data、v、r、s])
```
- Ethereumは、アクセスリストや[EIP-1559](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1559.md) などの新機能をレガシーなトランザクション形式に影響を与えずに実装できるよう、複数の種類のトランザクションをサポートするように進化してきた。
  - EIP-1559: Fee market change for ETH 1.0 chain 
- [EIP-2718: Typed Transaction Envelope](https://eips.ethereum.org/EIPS/eip-2718)は、将来のトランザクションタイプのエンベロープとなるトランザクションタイプを定義している
  - `EIP-2718`は、型付けされたトランザクションのための新しい一般化されたエンベロープである
  - 新しい規格では、トランザクションは次のように解釈される
```
TransactionType || TransactionPayload
// TransactionType: 0から0x7fまでの数字で、合計128のトランザクションタイプが可能
// TransactionPayload: トランザクションの種類によって定義される任意のバイト配列
```

## [Gas and Fee](https://ethereum.org/en/developers/docs/gas/)
Gasとは、Ethereumネットワーク上で特定の操作を実行するために必要な計算量を測定する単位を指す  
Ethereumのトランザクションは実行するために計算リソースを必要とするため、トランザクションごとに手数料が必要となる  
Gasとは、Ethereum上でトランザクションを正常に行うために必要なfeeのことを指す  

![gas](../../images/gas.png "gas")

- `Gas fees`は、Ethereumのネイティブ通貨である`ether（ETH）`で支払われる
- `Gas prices`は`gwei`で表記される
  - gweiはETHの1通貨であり、1gweiは0.000000001ETHと等しい

## 計算式概要
![gas calc1](../../images/gas_calc1.png "gas")
![gas calc2](../../images/gas_calc2.png "gas")


### 2021/8に発生したLondonアップグレード以前
例えば、アリスがボブに1ETHを支払う場合、このトランザクションでは、`gas limit`は`21,000`で、`gas price`は200gweiとなる  
このとき、手数料の合計は、
```
Gas units (limit) * Gas price per unit
=> 21,000 * 200 = 4,200,000 gwei (0.0042 ETH)
```

### 2021/8に発生したLondonアップグレード以後
Ethereumネットワークのトランザクションfeeの計算方法が変更された  
`Gas price`は`base fee + priority fee`となる  

例えば、JordanがTaylorに1ETHを支払う場合、このトランザクションでは、`gas limit`は`21,000`で、`base fee`は10gweiとなり、Jordanはこれに、2gweiの`priority fee`を含んでいる  
このとき、手数料の合計は、
```
// base fee: protocolによって設定されるvalue
// priority fee: ユーザーによって設定されるvalueで、validatorへのtipとなる
units of gas used * (base fee + priority fee)
=> 21,000 * (10 + 2) = 252,000 gwei (0.000252 ETH)
// fee (0.000252 ETH) の内訳
// Base fee: 0.00021 ETH
// Validator tips: 0.000042 ETH 
```

さらに、Jordan は、トランザクションのmax fee(maxFeePerGas) を設定することもできる。max feeと実際のfeeの差は、Jordanに返金される

### Block size
- Londonアップグレード以前では、Ethereumには固定サイズのブロックがあった。  
- ネットワーク需要が高い時、これらのブロックは全容量で動作していました。その結果、ユーザーはブロックに含まれるために、高い需要が減るのを待たなければならないことが多く、ユーザーエクスペリエンスが低下していた。  
- Londonアップグレードでは、Ethereumに可変サイズブロックが導入された。  
- 各ブロックの目標サイズは`1500万 gas`であるが、ブロックの限界である`3000万 gas`（目標ブロックサイズの2倍）までは、ネットワークの需要に応じてブロックのサイズが増減される。
- このプロトコルでは、`tâtonnement`というプロセスを通じて、平均して`1,500万`という平衡ブロックサイズを実現している。
- つまり、ブロックサイズが目標ブロックサイズより大きい場合、プロトコルは次のブロックの`base fee`を増加させる。
- 同様に、ブロックサイズがターゲットブロックサイズより小さい場合、プロトコルは`base fee`を減少させる。
- `base fee`の調整量は、現在のブロックサイズが目標ブロックサイズからどれだけ離れているかに比例する。
- ブロックの詳細は[こちら](https://ethereum.org/en/developers/docs/blocks/)

### Base fee
- 各ブロックには、`reserve price`として機能する`base fee`が設定されている。
- ブロックに含まれるためには、ガスあたりの提供priceが最低でも`base fee`と等しくなければならない
- `base fee`は現在のブロックとは無関係に計算され、それ以前のブロックによって決定される。
- ブロックが採掘されると、この`base fee`はburnされて、circulationから取り除かれる。
- `base fee`は、直前のブロックサイズ（全てのトランザクションに使用されたガス量）と目標ブロックサイズを比較する計算式で算出される。
- 目標ブロックサイズを超えた場合、`base fee`は1ブロックあたり最大`12.5％`増加する
- この指数関数的な増加により、ブロックサイズをいつまでも高いままにしておくことは経済的に不可能となる。

![base fee](../../images/base_fee.png "base fee")

- Londonアップグレード以前のgas auction市場と比較すると、このトランザクション手数料の仕組みの変更により、手数料の予測はより確実なものとなっている。
- また、fullブロックの基本料金の上昇スピードが速いので、fullブロックのスパイクが長く続くことはないだろうということも重要。


### Priority fee (tips)
- Londonアップグレード以前は、ブロックに含まれるあらゆるトランザクションから、採掘者はガス料金の合計を受け取っていた。
- 新しいbase feeがburnされるため、Londonアップグレードでは、ブロックにトランザクションを含めるよう採掘者にインセンティブを与える`priority fee (tips)`が導入された
- `tip`がなければ、採掘者は同じブロック報酬を受け取ることができるため、空のブロックを採掘することが経済的に可能であると考えるだろう
- 通常の条件下では、少額のチップは採掘者がトランザクションを含めるための最小限のインセンティブとなる
- 同じブロック内の他のトランザクションより優先的に実行される必要があるトランザクションの場合、競合するトランザクションに勝つためには、より高いチップが必要となる

### Max fee
- ネットワーク上でトランザクションを実行するために、ユーザーはトランザクション実行のために支払ってもよい上限を`maxFeePerGas`によって指定することができる
- トランザクションが実行されるには、`max fee`が`base fee`+`tips`の合計を上回らなければならない
- トランザクションの送信者は、`max fee`と`base fee`および`tips`の合計との差額を払い戻しを受け取ることができる

### feesの計算
- Londonアップグレードの主な利点の1つは、トランザクション手数料を設定する際のユーザーエクスペリエンスを向上させること
- このアップグレードに対応したウォレットでは、トランザクションを成立させるためにいくら支払うかを明示する代わりに、ウォレットプロバイダが推奨トランザクション手数料（base fee + 推奨priority fee）を自動的に設定し、ユーザーに負担をかける複雑さを軽減することができる

### [EIP-1559](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1559.md)
- Londonアップグレードで`EIP-1559 (Fee market change for ETH 1.0 chain)`を導入したことにより、トランザクション手数料の仕組みが従来のgas priceオークションよりも複雑になりったが、gas feeの予測が可能になり、結果としてトランザクション手数料市場の効率性が向上するというメリットが生まれた
- ユーザーは、ガスのmarket price（baseFeePerGas）を超える金額を支払うことはないと分かっていながら、トランザクションを実行するためにいくら支払ってもよいと思うかに対応する`maxFeePerGas`を付けてトランザクションを申請し、tipsを差し引いた余剰分を返金してもらうことができる

### Gas Feesはなぜ存在するのか?
- Gas FeesはEthereumのネットワークの安全性を保つのに役立つ
- ネットワーク上で実行されるすべての計算に対してfeeを要求することで、悪質な業者がネットワークにスパムをかけることを防ぐ
- コードにおける偶発的または敵対的な無限ループやその他の計算の無駄を避けるために、各トランザクションはコード実行の計算ステップ数に上限を設定する必要がある
- 計算の基本単位は`gas`でとなる
- トランザクションには上限があるが、トランザクションに使用されなかったガスはユーザーに返却される `(i.e. max fee - (base fee + tip)`


### Gas Limitとは何か?
- Gas Limitとは、トランザクションで消費するガスの最大量を指す
- スマートコントラクトを含むより複雑なトランザクションは、より多くの計算作業を必要とするため、単純な支払いよりも高いガスリミットを必要とする
- 標準的なETHの送金には、`21,000 unit`のガスの上限が必要となるが、このときGas Limitを50,000とした場合、EVMは21,000を消費し、残りの29,000が戻ってくることになる
- しかし、ガスが少なすぎる場合、例えば、単純なETHの転送に20,000のガスの制限を指定すると、EVMは、トランザクションを実行しようとする20,000 unitを消費するが、コードを最後まで実行できず、EVMはその後、変更を元に戻すことになる。採掘者はすでに20,000 gas unit分の作業を行ったので、そのgasは消費されることになる。

### なぜGas Feeはそんなに高くなるのか？
- Gas Feeが高いのは、Ethereumの人気に起因する
- Ethereum上で何らかの操作を行うにはガスを消費する必要があり、ガスのスペースはブロックごとに制限されている
- 手数料には、計算、データの保存や操作、トークンの転送などが含まれ、さまざまな量のgas unitを消費する
- dAppsの機能が複雑になればなるほど、スマートコントラクトが実行する操作の数も増え、各トランザクションが限られたサイズのブロックの中でより多くのスペースを占めることになる
- 需要が多すぎる場合、ユーザーはより高いtip額を提示して、他のユーザーのトランザクションを打ち負かそうとする必要がある
- 高いtipは、あなたのトランザクションが次のブロックに入る可能性を高くすることができる

### Gas Cost削減のための取り組み
- Ethereumの[スケーラビリティのアップグレード](https://ethereum.org/en/upgrades/)は、最終的にgas feeの問題のいくつかを解決し、その結果、プラットフォームが毎秒数千のトランザクションを処理し、グローバルに拡張することを可能にすることが期待されている
- [Layer2 スケーリング](https://ethereum.org/en/developers/docs/scaling/#layer-2-scaling)は、Gas Cost、ユーザーエクスペリエンス、スケーラビリティを大幅に向上させるための主要な取り組みとなる


### Gas Cost削減のための戦略
- ETHのGas Costを削減したい場合、トランザクションの優先レベルを示すtipを設定することができる
- マイナーたちは、あなたが支払うtipを維持できるため、gasあたりのtipが高いトランザクションを優先して実行し、低いtipが設定されたトランザクションを実行しようとは思わなくなる
- gas pricesを監視して、ETHをより安く送れるようにしたい場合は、さまざまなツールを使うことができます。
  - [Ethereum Gas Tracker](https://etherscan.io/gastracker)
  - [Chrome Extension: Blocknative Gas Fee Estimator for ETH & MATIC](https://chrome.google.com/webstore/detail/blocknative-gas-fee-estim/ablbagjepecncofimgjmdpnhnfjiecfm)
  - [Eth Gas Station](https://ethgasstation.info/)
  - [Gas Fees Caluculator](https://www.cryptoneur.xyz/gas-fees-calculator)
  - [ETH Gas API](https://www.blocknative.com/gas-platform)

## EIP-1559
- [EIP-1559のトランザクションガス手数料のメカニズムの変更の調査](https://recruit.gmo.jp/engineer/jisedai/blog/eip-1559-research/)
- Londonアップグレードによって、トランザクションガス手数料のメカニズムに変更が入った
  - EIP-1559はファーストプライスオークション（first-price auction）を廃止し、固定価格セール（fixed-price sale）に置き換えた
  - これは、「Gas Price」でのオークションの代わりに、予測可能（ブロック毎に固定）の「Base Fee Per Gas 」、チップ機能の「Priority Fee Per Gas」とロックに含めるために出せる最大額の「Max Fee Per Gas」を新たにガスメカニズムに組み込んだもの

### JSON-RPCの変更
- eth_feeHistory
  - 各ブロックのBase Fee Per Gasの履歴データを返す
- eth_call
  - `maxPriorityFeePerGas`と`maxFeePerGas`が追加された
- eth_getBlockBy
  - `baseFeePerGas`が追加された
- eth_getTransactionBy
  - `maxPriorityFeePerGas`と`maxFeePerGas`の2つの新しいフィールドが追加
  - `gasPrice`が廃止