# Cross-Chain Bridges

Implement or utilize existing cross-chain bridges that allow tokens to be transferred between different blockchain networks. These bridges typically involve locking the token on one chain and minting an equivalent amount of the token on another chain.

異なるブロックチェーンネットワーク間でトークンの移動を可能にする。これらのブリッジでは通常、あるチェーン上でトークンをロックし、別のチェーン上で同量のトークンを mint する。

## Locking Assets 資産のロック

The process begins with the user locking or depositing the asset they want to transfer into a smart contract on the originating blockchain. For example, if you want to transfer USDC from Ethereum to Polygon, you would lock your USDC tokens in a smart contract on the Ethereum blockchain.

このプロセスは、ユーザーが送金元のブロックチェーン上のスマートコントラクトに送金したい資産をロックまたは預けることから始まる。例えば、USDC を Ethereum から Polygon に送金したい場合、USDC トークンを Ethereum のブロックチェーン上のスマートコントラクトにロックする。

## Confirmation and Verification 確認と検証

Once the assets are locked in the smart contract, the bridge protocol verifies the transaction and confirms the deposit. This verification process ensures that the assets are legitimate and can be transferred to the destination chain.

アセットがスマートコントラクトにロックされると、ブリッジプロトコルはトランザクションを検証し、デポジットを確認する。この検証プロセスにより、アセットが正当なものであり、送金先のチェーンに送金できることが保証される。

## Minting or Issuance ミントもしくは発行

After the assets are locked and verified, an equivalent amount of the asset is minted or issued on the destination blockchain. In the example of transferring USDC from Ethereum to Polygon, new USDC tokens are minted on the Polygon network to represent the locked USDC from Ethereum.

アセットがロックされ、検証された後、そのアセットと等価な量が送金先のブロックチェーン上で mint または発行される。イーサリアムからポリゴンへ USDC を送金する例では、イーサリアムからロックされた USDC を表す新しい USDC トークンがポリゴンネットワーク上で mint される。

## Cross-Chain Communication

The bridge protocol facilitates communication between the smart contracts on the originating and destination blockchains. This communication ensures that the minting of new tokens on the destination chain corresponds accurately to the locking of assets on the originating chain.

ブリッジプロトコルは、送金元ブロックチェーンと送金先ブロックチェーンのスマートコントラクト間の通信を容易にする。この通信により、送金先チェーンでの新しいトークンの mint が、送金元チェーンでの資産のロックに正確に対応することが保証される。

## Redeeming Assets 資産の換金

Once the new tokens are minted on the destination chain, users can redeem them by interacting with the smart contract on that chain. For example, users can withdraw the minted USDC tokens from the smart contract on the Polygon network.

送金先チェーンで新しいトークンが mint されると、ユーザーはそのチェーン上のスマートコントラクトとやり取りすることで、トークンを換金することができる。例えば、ユーザーは Polygon ネットワーク上のスマートコントラクトから USDC トークンを引き出すことができる。

## Bi-Directional Bridges 双方向ブリッジ

Some cross-chain bridges support bi-directional transfers, allowing assets to move back and forth between the connected blockchains. In the case of USDC, users can transfer USDC tokens from Ethereum to Polygon and vice versa using the same cross-chain bridge.

一部のクロスチェーンブリッジは双方向転送をサポートしており、接続されたブロックチェーン間で資産を行き来させることができる。USDC の場合、ユーザーは同じクロスチェーンブリッジを使ってイーサリアムから Polygon へ、またはその逆方向へ USDC トークンを転送することができる。

## Security and Trustlessness セキュリティと信頼性

Cross-chain bridges often employ cryptographic techniques and smart contracts to ensure security and trustlessness. The process typically involves multiple layers of verification to prevent fraud or unauthorized access to the locked assets.

クロスチェーンブリッジは多くの場合、セキュリティと信頼性を確保するために暗号技術とスマートコントラクトを採用している。このプロセスでは通常、ロックされた資産への詐欺や不正アクセスを防ぐため、何重もの検証が行われる。

## Bridge Operators

In some cases, cross-chain bridges may have operators or validators responsible for maintaining and securing the bridge infrastructure. These operators play a crucial role in ensuring the smooth operation and security of the bridge.

場合によっては、クロスチェーンブリッジには、ブリッジインフラの維持と安全確保を担当するオペレーターやバリデーターが存在する。これらのオペレーターは、橋の円滑な運用とセキュリティを確保する上で重要な役割を果たす。

## Bridge 101

### Bridge の設計に必要な要素

- Monitoring: 監視
  - 通常、「Oracle」、「Validator」、「Relayer」のいずれかのアクターが存在し、送信元チェーンの状態を監視する。
- メッセージの受け渡し/中継
  - アクターはイベントをピックアップした後、送信元チェーンから送信先チェーンに情報を送信する必要がある
- Consensus: コンセンサス
  - モデルによっては、情報を送信先チェーンに伝えるために、送信元チェーンを監視するアクター間でコンセンサスが必要となる
- Signing: 署名
  - アクターは、送信先チェーンに送られる情報に、個別に、あるいは閾値署名スキームの一部として、暗号的に署名する必要がある

### Bridge の 4 つの Type

#### Asset-specific: 資産に特化した

外部のチェーンから特定の資産へのアクセスを提供することのみを目的としたブリッジ。これらの資産は、カストディアン(投資家に代わって有価証券の保管・管理などの業務を行う金融機関のこと)または非カストディアン方式で、原資産によって完全に担保された「ラップ」資産であることが多い。ビットコインは他のチェーンにブリッジされる最も一般的な資産であり、イーサリアムだけでも 7 つの異なるブリッジがある。これらのブリッジは実装が最も簡単で、流動性のフライホイールを享受できるが、機能が限られており、各移行先チェーンで再実装する必要がある。
例えば、wBTC や wrap Arweave などがある。

#### Chain-specific: チェーン固有

2 つのブロックチェーン間のブリッジで、通常、ソースチェーンでのトークンのロックとアンロック、送信先チェーンでのラップされたアセットの mint といった単純な操作をサポートする。このようなブリッジは通常、複雑さが限定的であるため市場投入までの時間が短いが、より広範なエコシステムへの拡張性も低い。一例として、Polygon の PoS ブリッジがあり、ユーザーは Ethereum から Polygon へ、またはその逆にアセットを転送することができるが、これらの 2 つのチェーンに限定されています。

#### Application-specific: アプリケーション専用

2 つ以上のブロックチェーンへのアクセスを提供するアプリケーション。アプリケーション自体はコードベースが小さくなるという利点がある。各ブロックチェーン上にアプリケーション全体のインスタンスを別々に持つのではなく、通常はそれぞれのブロックチェーン上に軽量でモジュール化された「アダプター」を持つ。アダプターを実装したブロックチェーンは、接続している他のすべてのブロックチェーンにアクセスできるため、ネットワーク効果が存在する。欠点は、その機能を他のアプリケーションに拡張するのが難しいことだ（例えば、lending:融資から exchange:取引所まで）。その例として、Compound Chain や Thorchain があり、それぞれクロスチェーン融資や取引所専用のブロックチェーンを構築している。

#### Generalized: 一般化

複数のブロックチェーン間で情報を転送するために特別に設計されたプロトコル。この設計は、O(1)の複雑さのため、強力なネットワーク効果を享受することができます - プロジェクトのための単一の統合は、ブリッジ内のエコシステム全体へのアクセスを提供します。欠点は、このスケーリング効果を得るために、セキュリティと分散化をトレードオフにする設計が一般的で、エコシステムに複雑な意図しない結果をもたらす可能性があることだ。その一例が IBC であり、これは 2 つの異種チェーン（最終性保証がある）間でメッセージを送信するために使用される。

### Bridge の設計における 3 つの Type

クロスチェーン取引を検証するために使用されるメカニズムに基づいて分類

どのブリッジも双方向通信チャネルであり、それぞれのチャネルに別々のモデルが存在する可能性があること、また、Gravity、Interlay、tBTC のようなハイブリッドモデルは、一方向にライトクライアント、もう一方にバリデータが存在するため、この分類では正確に表現できないことに注意することが重要である。

#### 外部バリデーターとフェデレーション(Federations)

通常、送信元チェーン上の「メールボックス」アドレスを監視するバリデーターのグループが存在し、コンセンサスが得られれば、送信先チェーン上でアクションを実行する。アセット移転は通常、メールボックスのアセットをロックし、移転先のチェーンでそのアセットと等価な量を鋳造することで行われる。このようなバリデータは、セキュリティモデルとして、別個のトークンを持つボンデッドバリデータであることが多い。

#### Light Client & Relays

アクターはソースチェーン上のイベントを監視し、そのチェーン上で記録された過去のイベントに関する暗号包含証明を生成する。これらの証明は、ブロックヘッダと一緒に宛先チェーンのコントラクト（つまり「ライトクライアント」）に転送され、コントラクトはあるイベントが記録されたことを検証し、検証後にアクションを実行する。ブロックヘッダと証明を「中継」するアクターが必要である。ユーザーがトランザクションを "自己中継 "することは可能であるが、中継者が継続的にデータを転送するというライブ性の前提が存在する。これは、仲介エンティティを信頼することなく、信頼できる有効な配信を保証するため、比較的安全なブリッジ設計であるが、開発者はソースチェーンからの状態証明を解析する新しい宛先チェーンごとに新しいスマートコントラクトを構築しなければならず、検証自体がガス集約的であるため、リソース集約的でもある。

#### 流動性ネットワーク

これはピアツーピアネットワークに似ており、各ノードがソースチェーンとデスティネーションチェーン双方の資産の「インベントリー」を保持する「ルーター」として機能する。このようなネットワークは通常、基礎となるブロックチェーンのセキュリティを活用します。ロックおよび紛争メカニズムを使用することで、ユーザーはルーターがユーザーの資金を持ち逃げできないことが保証されます。このため、Connext のような流動性ネットワークは、多額の価値を送金するユーザーにとってより安全な選択肢となる可能性が高い。さらに、ルーターが提供するアセットは、互いに完全な互換性がないデリバティブ・アセットではなく、相手チェーンのネイティブ・アセットであるため、このタイプのブリッジはクロスチェーンのアセット移転に最適であると考えられる。

### Bridge の 設計評価

#### Security: セキュリティ

信頼と有効性の前提、悪意のある行為者に対する許容度、ユーザー資金の安全性、反射性。

#### Speed: スピード

トランザクション完了までの待ち時間、および最終性の保証。スピードとセキュリティはトレードオフの関係にあることが多い。

#### Connectivity: 接続性

ユーザーとデベロッパーの両方がデスティネーションチェーンを選択でき、デスティネーションチェーンを追加する際の難易度も異なる。

#### Capital efficiency: 資本効率

システムを確保するために必要な資本と、資産を移転するための取引コストをめぐる経済学。

#### Statefulness: ステートフルネス

特定のアセットやより複雑なステートを転送したり、クロスチェーンのコントラクトコールを実行したりする能力。

### セキュリティ分類

#### Trust-less: 信頼できない

ブリッジのセキュリティは、ブリッジ先のブロックチェーンのセキュリティと同等である。基礎となるブロックチェーンに対するコンセンサスレベルの攻撃以外では、ユーザーの資金が失われたり盗まれたりすることはない。とはいえ、これらのシステムはすべて、経済的、工学的、暗号的な構成要素にわたって信頼の前提があるため（コードのバグがないなど）、実際には何もトラストレスではない。

#### Insured: 保険付き

悪意ある行為者はユーザーの資金を盗むことができるが、エラーや不品行があった場合には担保を差し入れる必要があり、差し押さえられるため、悪意ある行為者にとっては利益にならない可能性が高い。利用者の資金が失われた場合、担保の差し押さえによって弁済される。

#### Bonded: 担保付き

保険付きモデル（アクターが経済的なスキンを持つ）と似ているが、エラーや不正行為があった場合、担保が焼却処分される可能性が高いため、ユーザーが資金を回収できない点が異なる。内生的担保（すなわち担保がプロトコルトークンそのもの）は、ブリッジが失敗した場合にトークン価値が暴落する可能性が高く、ブリッジのセキュリティ保証がさらに低下するため、よりリスクが高い。

#### Trusted: 信頼できる

事業者は担保を提供せず、利用者はシステム障害や悪意ある行為の際に資金を回収することができないため、利用者は主にブリッジ事業者の評判に頼ることになる。

### デザインのトレードオフのまとめ

外部バリデータとフェデレーションは、トランザクションをトリガーし、データを保存し、任意の数のデスティネーションチェーン上でそのデータとのやりとりを可能にするため、一般的にステートフルネスとコネクティビティに優れている。しかし、これはセキュリティの犠牲を伴う。というのも、ユーザーは定義上、ソースチェーンやデスティネーションチェーンではなく、ブリッジのセキュリティに依存しているからである。今日、ほとんどの外部バリデータは信頼されたモデルであるが、中には担保された モデルもあり、そのサブセットはエンドユーザーを保証するために使用されている。プロトコルトークンが担保として使用される場合、そのトークンのドル価値がユーザーを救済するのに十分高いという前提がある。さらに、担保となる資産が被保険資産と異なる場合、オラクルの価格フィードに依存することになるため、ブリッジのセキュリティはオラクルのセキュリティまで低下する可能性がある。信頼されていない場合、これらのブリッジは、促進する経済スループットに比例して担保を拡大する必要があるため、資本効率も最も低い。

ライトクライアントとリレーは、ヘッダーリレーシステムがあらゆる種類のデータを受け渡しできるため、ステートフルネスにも強い。また、中継者が情報を送信する必要があるため、ライブ性の前提はあるが、追加の信頼前提を必要としないため、セキュリティにも強い。また、資本ロックアップを一切必要としないため、最も資本効率の高いブリッジでもある。これらの長所は、接続性を犠牲にしている。チェーンのペアごとに、開発者は新しいライトクライアント・スマートコントラクトをソースチェーンとデスティネーションチェーンの両方にデプロイしなければならないが、その複雑さは O(LogN)から O(N)の間である（同じコンセンサスアルゴリズムを持つチェーンでサポートを追加するのは比較的簡単なので、この範囲である）。また、不正証明に依存する楽観的モデルでは、レイテンシが最大 4 時間まで増加する可能性があり、速度面で大きな欠点がある。

流動性ネットワークは、ローカルに検証されたシステムであるため（つまりグローバルなコンセンサスを必要としない）、スピードとセキュリティで優れている。また、資本効率はセキュリティよりも取引フローや取引量に連動するため、保税・保険付きの外部バリデーターよりも資本効率が高い。例えば、2 つのチェーン間のフローがある程度等しく、リバランシングメカニズムが組み込まれていれば、流動性ネットワークは、任意に大量の経済スループットを促進することができる。流動性ネットワークは calldata の受け渡しができる反面、機能が制限されるため、ステートフルネスとトレードオフの関係にある。例えば、受信者が提供されたデータに基づいてやりとりを行う許可を持っている場合（例えば、送信者からの署名されたメッセージでコントラクトを呼び出す）、チェーンをまたいでデータとやりとりすることができるが、「所有者」を持たないデータ、または一般化された状態の一部であるデータ（例えば、表現トークンの鋳造）の受け渡しには役立たない。

### オープンな課題

堅牢なクロス・チェーン・ブリッジの構築は、分散システムにおいて非常に難しい問題である。この分野では多くの活動が行われているが、まだいくつかの未解決の問題がある

#### 最終性とロールバック

確率的な最終性を持つチェーンにおいて、ブリッジはどのようにブロック・リオルグやタイム・バンディット攻撃を説明するのでしょうか？例えば、ポルカドット（Polkadot）からイーサリアム（Ethereum）に資金を送金したユーザーが、いずれかのチェーンで状態のロールバックを経験した場合、どうなりますか？

#### NFT の移籍と出所

複数のチェーンにまたがる NFT について、ブリッジはどのように証明性を保持するのか。例えば、Ethereum、Flow、Solana の各マーケットプレイスで売買される NFT があった場合、所有者の記録はどのようにすべての取引と所有者に対応するのでしょうか。

#### ストレステスト

チェーン混雑時やプロトコル、ネットワークレベルの攻撃時に、様々なブリッジ設計がどのように機能するか？