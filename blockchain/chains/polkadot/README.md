# Polkadot

異なる Blockchain 間での相互運用性を確保するために、複数の Blockchain を 1 つのネットワークに接続することができるプロトコル

- [Porkadot](https://polkadot.network/)
- [Technology](https://polkadot.network/technology/)
- [Parachain](https://polkadot.network/parachains/)
- [Docs](https://wiki.polkadot.network/)
  - [Learn](https://wiki.polkadot.network/docs/getting-started)
- [Github](https://github.com/paritytech/polkadot)

## Parachain

[Docs](https://wiki.polkadot.network/docs/learn-parachains)

- Polkadot に接続する、独立した個々のブロックチェーンのことで、これは複数存在し、Polkadot エコシステムで並列に動作する
- ネットワーク全体のセキュリティを継承し、[XCM](https://wiki.polkadot.network/docs/learn-xcm)形式により他の Parachain と通信を行うことができる
- Parachain は`Collators`呼ばれるノード、ネットワークメンテナーによって維持される

- Parachain は PoS（プルーフオブステーク）メカニズムに基づく Polkadot ネットワークのセキュリティとトランザクションの検証に依存している
- 一方で、Polkadot ネットワークで中心的な役割を果たすメインチェーンは Relay chain と呼ばれ、トランザクションアドレスが検証される。
- Parachain と Relay chain は連携して動作し、常に情報を交換する
- 開発者はカスタム Parachain を Polkadot ネットワークに接続することを選択でき、ネットワーク上の他の全てのパラチェーン間の相互運用性を実現できる

- Polkadot ホスト（PH）は、パラチェーン上で実行される状態遷移を Wasm 実行ファイルとして指定することを要求している

### Collators ノードの役割 (照合者)

- パラチェーンのフルノードを維持
- パラチェーンの必要な情報をすべて保持
- 新しいブロック候補を生成して Relay チェーンバリデータに渡し、検証して Polkadot の共有状態に含めること
- コレーターノードのインセンティブは、パラチェーンの実装の詳細次第
- パラチェーンの実装で規定されていない限り、Relay チェーンにステークされていることや、ネイティブトークンを所有していることは必要ない。

### Parachain Hub

- Polkadot はパラチェーン間のクロスチェーン機能を持つ
- 送受信には、ある程度の待ち時間が必要になる (楽観的なシナリオでは、このメッセージの待ち時間は少なくとも 2 ブロック)
- クロスチェーンメッセージの送信には必要なレイテンシーがあるため、一部のパラチェーンは全体のハブとなる計画がある。

### Parachain Slot

- `スロット` と呼ばれるパラチェーンの枠は 100 個に限定されている
- 1 回目の Parachain オークションによって、以下の project が Parachain として稼働を始めた
  - Acala
  - Moonbeam
  - Astar
  - Parallel Finance
  - Clover

## バリデーター

- [Docs](https://wiki.polkadot.network/docs/learn-architecture#validators)
- トランザクションの検証を行う
- ネットワークバリデーターはトランザクションを複数のパラチェーンに分散させることによりスケーラビリティをさらに向上させる

## Smart Contracts

- [Docs](https://wiki.polkadot.network/docs/build-smart-contracts)
- Relay chain ではなく、Polkadot 上の Parachain が Smart Contract をサポートする
- Substrate(モジュラー Framework)によって、以下に対応している
  - Frontier が提供する EVM Pallet(Substrate runtime module)
    - Substrate チェーン(Parachain という意味?)が Ethreum コントラクト(EVM)をネイティブに実行できるようにするツール群
  - Wasm ベースのコントラクト(Frame ライブラリの Contracts Pallet)
- つまり、Solidity, Rust の両方で contract の記述ができるということ？
- `Smart Contract Environments are still Maturing`とある

## Bridges

- [Docs](https://wiki.polkadot.network/docs/learn-bridges)

- Bridge 方式
  - Bridge Pallet
    - Substrate Native の Chain は Bridge Pallet を使用する (Kusama <-> Porkadot bridge)
  - Smart Contract
    - Chain が Substrate 上にない場合、非 Substrate チェーン上に Smart Contract を持たせる必要がある。(Ethreum など)
  - Higher-order protocols

## DOT

Polkadot の Native Token

## Substrate

- [Docs](https://substrate.io/technology/)

## Glossary

[Docs](https://wiki.polkadot.network/docs/glossary)

- [Pallet](https://wiki.polkadot.network/docs/glossary#pallet)

  - A Substrate runtime module
  - Blockchain を作成できるモジュール型フレームワークである Substrate のカスタム、Pre-built モジュールを指す
  - パレットは Substrate で簡単に組み合わせることができる
  - 各パレットにはドメイン固有のロジックが含まれているため、Polkadot のように Substrate ベースのチェーンに特定の機能を追加することができる
  - また、開発者は、チェーンのニーズに合わせて独自のパレットを作成することもできる

- [Substrate](https://wiki.polkadot.network/docs/glossary#substrate)
  - 基盤という意味
  - Blockchain を構築するためのモジュラー framework。
  - Substrate で構築されたチェーンは、Parachain として簡単に接続することができる。
- [Parachain Development Kit](https://wiki.polkadot.network/docs/glossary#parachain-development-kit-pdk)
  - SDK と同様に、開発者が Polkadot 互換のパラチェーンを簡単に作成するためのツール群
- [XCM](https://wiki.polkadot.network/docs/learn-xcm)
  - Cross-Consensus Message Format
