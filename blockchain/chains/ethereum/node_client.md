# Node とクライアント

[Docs: NODES AND CLIENTS](https://ethereum.org/en/developers/docs/nodes-and-clients/)要約

- Ethereum は、ブロックとトランザクションデータを検証できるソフトウェアを実行するコンピュータ（Node と呼ばれる）の分散型ネットワーク
- `クライアント`と呼ばれるソフトウェア・アプリケーションをコンピュータ上で実行し、Ethereum の`Node`にする必要がある
- 実行クライアントを単独で実行することはできなくなったため、The Merge の後、ユーザーがイーサリアムネットワークにアクセスするためには、`実行クライアント`と`コンセンサスクライアント`の両方を一緒に実行する必要がある
- `Node`とは、Ethereum のクライアントソフトウェアのインスタンスで、同じくイーサリアムのソフトウェアを実行している他のコンピュータに接続され、ネットワークを形成しているもの
- `クライアント`は、データをプロトコルの規則に照らして検証し、ネットワークを安全に保つ、イーサリアムの実装
- Post-Merge Ethereum は、`Execution Layer`と`Consensus Layer`の 2 つの部分から構成されるが、両レイヤーは、それぞれ異なるクライアントソフトウェアによって実行される
- `実行クライアント`（実行エンジン、EL クライアント(execution layer)、または旧 Eth1 クライアントとも呼ばれる）は、ネットワークでブロードキャストされた新しいトランザクションを聞き、EVM で実行し、最新の状態と現在のすべての Ethereum データのデータベースを保持する。
- `コンセンサスクライアント`（ビーコン Node、CL クライアント(consensus layer)、旧 Eth2 クライアントとも呼ばれる）は、Proof-of-stake コンセンサスアルゴリズムを実装し、実行クライアントからの検証済みデータに基づいてネットワークの合意を達成することができる

![client](https://github.com/hiromaily/documents/raw/main/images/eth1eth2client.png "client")

## Spec References

- [execution-specs](https://github.com/ethereum/execution-specs/)
- [consensus-specs](https://github.com/ethereum/consensus-specs)

## ネットワーク上の Node を追跡する

- [Ethereum Node Tracker](https://etherscan.io/nodetracker)
- [Ethereum Mainnet Statistics](https://ethernodes.org/)
- [Eth2 Nodewatch: General Information](https://www.nodewatch.io/)

## Node の種類

### Full node

- ブロックチェーンの全データを保存（ただし、これは定期的に刈り取られるため、フル Node は創世記までの全状態データを保存しない）
- ブロックバリデーションに参加し、すべてのブロックとステートを検証する。
- すべての状態はフル Node から導き出すことができる（ただし、非常に古い状態はアーカイブ Node へのリクエストから再構築される）
- ネットワークにサービスを提供し、要求に応じてデータを提供する

### Light node

- すべてのブロックをダウンロードするのではなく、ブロックヘッダをダウンロードする
- これらのヘッダには、ブロックの内容に関する概要情報のみが含まれている
- Light node が必要とするその他の情報は、Full node に要求する
- Light node は、受信したデータをブロックヘッダ内のステートルートに照らして独自に検証することができる
- Light node により、ユーザーは Full node の実行に必要な強力なハードウェアや広帯域幅を使わずに Ethereum ネットワークに参加することができる
- 最終的には、Light node は携帯電話や組み込みデバイスで動作するようになるかもしれない
- Light node はコンセンサスに参加しないが（つまり、マイナー／Validator にはなれません）、Full node と同じ機能とセキュリティ保証で Ethereum のブロックチェーンにアクセスすることが可能

- 実行クライアントである`Geth`には、[light sync](https://github.com/ethereum/devp2p/blob/master/caps/les.md)オプションがある
- しかし、ライトな Geth の Node は、ライトな Node のデータを提供するフル Node に依存する
- Light node のデータを提供することを選ぶ Full node はほとんどなく、Light node はしばしばピアを見つけることができないことを意味する

- `Light clients`は Ethereum の活発な開発分野であり、コンセンサス層と実行層の新しい`Light clients`が間もなく登場すると思われる (2022/12/30 現在)
- ゴシップネットワーク上で Light client データを提供するルートも考えられる
- ゴシップネットワークは、Full node がリクエストに応えることを必要とせずに Light node のネットワークをサポートすることができるため、これは有利なこと

- Ethereum はまだ多くの Light node をサポートしていないが、Light node のサポートは近い将来、急速に発展すると予想される分野
- 特に、`Nimbus`、`Helios`、`LodeStar`などのクライアントは、現在 Light node に大きく注力している

### Archive node

- Full node に保持されているすべてのものを保存し、過去の状態のアーカイブを構築する
- ブロック#4,000,000 の口座残高のようなものを照会したい場合や、トレースを使ってマイニングすることなく、単純かつ確実に自分のトランザクションセットをテストしたい場合に必要となる
- このデータはテラバイトの単位を表すため、一般ユーザーにとってアーカイブ Node は魅力的ではないが、`ブロックエクスプローラ`、ウォレットベンダー、チェーン分析などのサービスには便利
- アーカイブ以外のモードでクライアントを同期すると、ブロックチェーンデータが刈り取られることになる
- つまり、すべての履歴状態のアーカイブは存在しませんが、フル Node はオンデマンドで構築することができる

## 自分で Node を立てるメリット

- 全てのトランザクションとブロックを自分自身で検証できる
- Ethereum からのデータに依存する他のサービスを実行し、セルフホスティングすることができる。
  - 例えば、ビーコンチェーン Validator、レイヤー 2 などのソフトウェア、インフラ、ブロックエクスプローラ、ペイメントプロセッサーなど
- カスタム RPC エンドポイントを提供することができる
- プロセス間通信（IPC）を使って Node に接続したり、プラグインとしてプログラムを読み込むように Node をカスタマイズすることができる
- ETH を直接ステークしてネットワークを確保し、報酬を獲得することができる

## 実行クライアント

- Go Ethereum (Geth)
- Nethermind
- Besu
- Erigon
- Akula
- OpenEthereum (deprecated)

## コンセンサスクライアント

- Prysm
- Lighthouse
- Lodestar
- Nimbus
- Teku

## 同期モード

これはトレードオフの関係にある

### 実行レイヤー同期モード

- Full sync
  - すべてのブロック（ヘッダー、トランザクション、レシートを含む）をダウンロードし、Genesis からすべてのブロックを実行することによって、ブロックチェーンの状態を定期的にに生成する
  - すべてのトランザクションを検証することにより、信頼を最小化し、最高のセキュリティを提供する
  - トランザクション件数が増加すると、すべてのトランザクションを処理するのに数日から数週間かかることもある
- Fast sync
  - すべてのブロック（ヘッダー、トランザクション、レシートを含む）をダウンロードし、すべてのヘッダーを検証し、状態をダウンロードし、ヘッダーと照合して検証する
  - コンセンサスメカニズムの安全性に依存する
  - 同期には数時間しかかからない
- Light sync
  - Light Client モードでは、すべてのブロックヘッダ、ブロックデータをダウンロードし、いくつかのランダムな検証を行う
  - 信頼できるチェックポイントからチェーンの先端部分のみを同期させる
  - 開発者の信頼とコンセンサスメカニズムに依存しながら、最新の状態のみを取得する
  - 数分後には現在のネットワークの状態でクライアントが使用できるようになる
  - 注意点として、`Light sync`はまだ Proof-of-stake Ethereum に対応していない
- Snap sync
  - Geth チームによって開拓された、クライアントを同期するための最新のアプローチ
  - Peer によって提供される動的スナップショットを使用すると、中間トライ Node をダウンロードせずにすべてのアカウントとストレージデータを取得し、ローカルで Merkle トライを再構築することができる
  - 現在 Ethereum の mainnet で`デフォルト`となっている最速の同期戦略
  - セキュリティを犠牲にすることなく、ディスク使用量とネットワーク帯域幅を大幅に節約できる
- [Optimistic sync](https://github.com/ethereum/consensus-specs/blob/dev/sync/optimistic.md)
  - オプトインと後方互換性を持つように設計されたマージ後の同期戦略
  - 実行 Node が確立した方法によって同期することを可能にする
  - 実行エンジンはビーコンブロックを完全に検証することなく最適にインポートし、最新のヘッドを見つけ、上記の方法でチェーンの同期を開始することができる
  - そして、実行クライアントが追いついた後、ビーコンチェーンのトランザクションの有効性をコンセンサス・クライアントに通知する

### コンセンサスレイヤー同期モード ??

- Checkpoint sync
  - 弱主体性シンクとも呼ばれ、Beacon Node のシンクに優れたユーザーエクスペリエンスを生み出す
  - これは弱い主観性の仮定に基づいており、genesis の代わりに最近の弱い主観性のチェックポイントから Beacon Chain を同期することを可能にする
  - チェックポイント同期により、genesis からの同期と同様の信頼性仮定で、最初の同期時間が大幅に短縮される

## Node アーキテクチャー

![node-architecture](https://github.com/hiromaily/documents/raw/main/images/node-architecture.png "node-architecture")

- この 2 つのクライアント構造が機能するためには、コンセンサスクライアントがトランザクションのバンドルを実行クライアントに渡すことができなければならない
- ローカルでトランザクションを実行することで、クライアントはトランザクションが Ethereum の規則に違反していないこと、そして Ethereum の状態への更新が正しいことを検証する
- 同様に、Node がブロック生産者に選ばれたとき、コンセンサスクライアントは新しいブロックに含めるトランザクションのバンドルを Geth に要求し、それらを実行してグローバルな状態を更新できるようにしなければならない。
- このクライアント間の通信は、`エンジンAPI`を使用したローカル RPC 接続によって処理される

### 実行クライアントの役割

- 担当すること

  - トランザクション処理、
  - トランザクションゴシップ、
  - ステート管理、
  - Ethereum Virtual Machine（EVM）のサポート
  - トランザクションのリスト、更新された状態トライ、およびその他の実行関連データである実行ペイロードを作成する
    - これらはコンセンサス・クライアントによって、各ブロックに実行ペイロードを含める
  - 新しいブロックのトランザクションを再実行し、それらが有効であることを確認する
  - トランザクションの実行は、Ethereum Virtual Machine（EVM）と呼ばれる実行クライアントの組み込みコンピュータで行われる
  - RPC メソッドを通じて Ethereum への UI も提供し、ユーザーは Ethereum のブロックチェーンへの問い合わせ、トランザクションの提出、スマートコントラクトのデプロイができるようになる

- 担当しないこと (コンセンサスクライアントの権限)
  - ブロック構築、
  - ブロックゴシップ
  - コンセンサスロジックの処理
- まとめ
  - Ethereum へのユーザーゲートウェイ
  - Ethereum Virtual Machine(EVM)、Ethereum のステートおよびトランザクションプールを持つ

### コンセンサスクライアントの役割

- Node が Ethereum ネットワークと同期するためのすべてのロジックを処理する
- これには、peer からブロックを受け取り、フォーク選択アルゴリズムを実行して、Node が常に（Validator の有効残高で重み付けされた）attestations(認証)の最大蓄積を持つチェーンに従うことを保証することが含まれる
- 実行クライアントと同様に、コンセンサスクライアントも独自の P2P ネットワークを持ち、ブロックと attestations(認証)を共有する

- コンセンサスクライアントはブロックの認証や提案に関与しない。これは、コンセンサスクライアントにオプションで追加できる`Validator`によって行われる
- Validator を持たないコンセンサスクライアントは、`チェーンの先頭にあるNodeを同期させるだけ`となる
- これにより、ユーザーは実行クライアントを使用して、自分が正しいチェーン上にいることを確信しながら Ethereum とトランザクションすることができる

### Validator

- `32ETH`が`deposit contract`にある場合、Node オペレータはコンセンサスクライアントに`Validator`を追加することができる
  - 具体的には、ユーザーが `32 ETH` をステークして Ethereum の PoS コンセンサス メカニズムに参加する場合、`Prysm`や`Lodestar`といった Beacon Chain(Node)に接続する `バリデータ クライアント` と呼ばれる別のソフトウェアを使用する
  - これは、新しいブロックの作成や他の提案されたブロックへの投票など、バリデータ キーと義務を管理する特別なソフトウェア
  - Validator クライアントは、実行ノードに依存するビーコン ノードを介して Ethereum ネットワークに接続する
- Validator クライアントはコンセンサスクライアントに同梱されており、いつでも Node に追加することができる
- Validator は`attestations(認証)`と`block proposals`を処理する
- これらにより、Node は報酬を得たり、ペナルティや slashing により ETH を失ったりすることができる
- Validator を実行することで、Node は新しいブロックを提案するために選ばれる資格を得ることもできる

### Node 比較の構成要素

- 実行クライアント
  - P2P ネットワーク上でトランザクションをゴシップする
  - トランザクションの実行・再実行
  - 受信した状態変化を確認する
  - ステートトライとレシートトライを管理する
  - 実行ペイロードの作成
  - Ethereum と対話するための JSON-RPC API を公開する
- コンセンサスクライアント
  - P2P ネットワーク上でブロックと認証をゴシップする
  - フォーク選択アルゴリズムの実行
  - チェーンの先頭を把握する
  - Beacon の状態を管理する（コンセンサスと実行情報を含む）
  - RANDAO で蓄積されたランダム性を記録する
  - 正当性とファイナライズの記録を保持する
- Validator
  - ブロックの提案
  - 報酬・ペナルティの発生
  - attestations(証明書)の作成
  - 32ETH の staking が必要
  - ブロックの提案
  - Slash される
