# Light Client

Light Client はトランザクションの状態を検証するが、そのためにブロックチェーンの一部の情報のみを保存するもので、これは Ethereum では `Consensus Client` で持つ機能

[Light Client](../light-client/README.md)

## consensus-specs

- [ethereum/consensus-specs](https://github.com/ethereum/consensus-specs/)
  - [altair](https://github.com/ethereum/consensus-specs/tree/dev/specs/altair)
    - [full-node](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/full-node.md)
    - [light-client](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/light-client.md)
    - [p2p-interface](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/p2p-interface.md)
    - [sync-protocol](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/sync-protocol.md)
  - [capella](https://github.com/ethereum/consensus-specs/tree/dev/specs/capella)
    - [fork](https://github.com/ethereum/consensus-specs/blob/dev/specs/capella/light-client/fork.md)
    - [full-node](https://github.com/ethereum/consensus-specs/blob/dev/specs/capella/light-client/full-node.md)
    - [p2p-interface](https://github.com/ethereum/consensus-specs/blob/dev/specs/capella/light-client/p2p-interface.md)
    - [sync-protocol](https://github.com/ethereum/consensus-specs/blob/dev/specs/capella/light-client/sync-protocol.md)

## Light client-based RPC Proxy for PoS Ethereum

- [lightclients/kevlar](https://github.com/lightclients/kevlar)

## [Light Client の同期処理](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/light-client.md)

1. Light Client は、フォークスケジュールを含む `spec/preset`、genesis_time と genesis_validators_root を含む `genesis_state`、および`trusted block root`で帯域外に設定されなければならない（MUST）。信頼されたブロックは、弱い主体性の期間内であるべきであり、そのルートは確定した`Checkpoint`からであるべきである（SHOULD）。
2. 設定された`genesis_time`に基づいてローカルクロックが初期化され、現在のフォークダイジェストが決定され、関連する Light Client データプロバイダをブラウズして接続する。
3. Light Client は、設定された信頼できるブロックルートの`LightClientBootstrap`オブジェクトをフェッチする。`bootstrap`オブジェクトは、`initialize_light_client_store`に渡され、local `LightClientStore` を取得する。
4. Light Client は、ローカル時計に基づいて、`store.finalized_header.beacon.slot` から`finalized_period`を、`store.optimistic_header.beacon.slot` から`optimistic_period` を、`current_slot`から`current_period`を追跡する。 条件は以下の 3 つ。
5. `finalized_period == optimistic_period`かつ`is_next_sync_committee_known`が`False` の場合
   - Light Client は`finalized_period` に対して`LightClientUpdate`をフェッチする。`finalized_period == current_period` の場合、このフェッチは`current_period` が進む前のランダムな時間にスケジュールされるべき（SHOULD）。
6. `finalized_period + 1 < current_period` の場合
   - Light Client は、範囲 `[finalized_period + 1, current_period)`(現在の期間は除く) の各 Sync Committee Period について`LightClientUpdate`をフェッチする。
7. `finalized_period + 1 >= current_period` のとき
   - Light Client は`LightClientFinalityUpdate`と`LightClientOptimisticUpdate` を観測し続ける。受信したオブジェクトは、`process_light_client_finality_update`と`process_light_client_optimistic_update` に渡される。これにより、`finalized_header`と`optimistic_header`が最新のブロックを反映するようになる。
8. `process_light_client_store_force_update`は、Light Client 同期が停止した場合、ユースケースに依存する heuristics(情報探索などの発見方法)に基づいて呼び出されてもよい。利用可能な場合は、影響を受ける Sync Committee Period をカバーするために、代替の同期メカニズムにフォールバックすることが好ましい。

## [Sync Protocol](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/sync-protocol.md)

Beacon Chain は、リソースに制約のあるデバイスやメーター付き VM（例：Cross-chain Bridge 用のブロックチェーン VM）など、制約のある環境において、合理的な安全性と活力をもってイーサリアムにアクセスするための LightClient フレンドリーに設計されている。
これは BeaconChain 拡張で導入された Sync Committee を使用する Beacon Chain の最小限の LightClient デザインを提案するものとなる。
追加ドキュメントでは、LightClient Sync Protocol の使用方法について説明している

- [Full Node](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/full-node.md)
- [Light Client](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/light-client.md)
- [Networking](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/p2p-interface.md)

- [Containers](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/sync-protocol.md##containers)
  - `LightClientHeader`
  - `LightClientBootstrap`
  - `LightClientUpdate`
  - `LightClientFinalityUpdate`
  - `LightClientOptimisticUpdate`
  - `LightClientStore`
- [Helper functions](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/sync-protocol.md##helper-functions)
  - `is_valid_light_client_header`
  - `is_sync_committee_update`
  - `is_finality_update`
  - `is_better_update`
  - `is_next_sync_committee_known`
  - `get_safety_threshold`
  - `get_subtree_index`
  - `compute_sync_committee_period_at_slot`
- [Light client initialization](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/sync-protocol.md##light-client-initialization)
  - `initialize_light_client_store`
- [Light client state updates](https://github.com/ethereum/consensus-specs/blob/dev/specs/altair/light-client/sync-protocol.md##light-client-state-updates)
  - `validate_light_client_update`
  - `apply_light_client_update`
  - `process_light_client_store_force_update`
  - `process_light_client_update`
  - `process_light_client_finality_update`
  - `process_light_client_optimistic_update`

## World of Light Clients 　要約

注) 既にページは消えていたが、[archived](http://web.archive.org/web/20221206063231/https://mycelium.xyz/research/world-of-light-clients-ethereum)からアクセス可能

パブリック ブロックチェーンの背後にある究極の動機は、分散化の概念にあります。 この概念は、単一のエンティティが大多数を制御できないように制御を分散することにより、個人に力を与えることを指します。 元帳で無効な変更が発生しないことを保証するメカニズムを通じてコンセンサスを達成できれば、グローバルを含むあらゆる規模での分散化が可能になります。 この規模でパブリック ブロックチェーンとやり取りする場合、信頼を必要とせずにチェーン上で何が起こっているかを確認することは、個人の権利になります。 主に、イーサリアムでは、完全なノードを実行するか、Infura や Alchemy などのサードパーティ サービスに依存するかの 2 つの相互作用方法があります。 前者はかなりの量のハードウェアとストレージを必要とし、後者はサービスへの信頼を伴うため、平均的なユーザーにとって、これらは対話するための理想的な方法ではありません。 リソースに優しく、トラストレスな代替手段は、軽量クライアントを実行することです。 この記事では、ライト クライアントとは何か、イーサリアム エコシステムへのメリットについて詳しく説明します。

### What are light clients?

不十分な計算リソースにアクセスできるノードがイーサリアム ネットワークに参加できないことを回避するために、light-nodes を許可する Light Client が提案されています。 現在、full-nodes を許可するクライアントが存在します。full-nodes は、ブロックチェーン全体の履歴のサブセットを追跡し、トランザクションとブロックを伝播します。 代わりに、light-nodes は full-nodes が保持する情報に依存して (同じ情報を保存または処理する必要はありません)、ブロックチェーンの状態を最新に保ちます。 ブロックチェーンの現在の正確な状態を保持しているノードのみがチェーンと対話できます (ただし、コンセンサスを形成することはできません)。 このパターンは、light-nodes が、携帯電話や IoT デバイスなどのデバイスでは不可能な極端なメモリとストレージの要件を回避するのに役立ちます。

### What are sync committees?

512 のバリデーターで構成される`sync committees`は、最近認証されたブロックのヘッダーの署名に使用でき、責任を負います。 sync 期間の形で `8192` ブロックごとに (バリデーターが過大な権限を獲得しないことを保証するために) 変更し、それぞれの新しい委員会は暗号ランダム シードによって決定されます。 各ブロックのフィールドに保存された`sync committees`の署名は、他のノード、特に light-nodes が現在「正しい」チェーンや経過したブロック数などの情報を判断できる重要かつ簡潔な形式です。 ノードがアクセスできる最後の checkpoint ブロックからの経過時間には、別の同期が必要です。

### Introduction

つまり、light client は、最新のブロック ヘッダーをダウンロードして検証することで追跡します。 チェーンで発生した変更に関する情報を取得するために、full-nodes にリクエストを送信します。 現在、メインネットとビーコン チェーンの 2 つの別個のチェーンが並行して存在します。 将来的には、これら 2 つのチェーンが統合され、現在のコンセンサス メカニズムの `Proof of Work` が `Proof of Stake` に置き換えられます。 特に、ビーコン チェーンは、クライアントにとって使いやすいように設計されています。 Altair ハードフォークに`sync committees`が導入されたことで、light client は最新のヘッダーに簡単に同期でき、チェーンの進行に合わせて同期を維持できます。 light client はコンセンサス クリティカルではないこと、つまりブロックの投票プロセスに参加しないことを強調する必要があります。 代わりに、ユーザーまたはアプリケーションが分散型の方法でチェーンとやり取りするための代替手段です。 なぜ`sync committees`が必要なのですか?

### Sync Committee

`512`のバリデーターで構成される`sync committees`は、新しく認証されたブロックのヘッダーに署名する責任があります。 約 27 時間 (正確には 27 時間 18 分 24 秒) 続く期間ごとに変化します。これは、各スロットの長さが `12 秒`である `8192` スロットに相当します。 次の`sync committees`の選択は、ランダム シードに基づいて、バリデーターのセットが破損する可能性を最小限に抑えます。 すべての新しいブロックには`sync committees`の署名とビットフィールドが含まれており、そのフィールドに直接保存されます。 この情報を使用して、軽量クライアントは、リソースによって制限された環境で最新のヘッダーを追跡できます。 これらの環境には、ブラウザー拡張機能、携帯電話、IoT デバイス、および低電力のラップトップが含まれます。 `sync committees`がなければ、検証者の多数決をカウントするために LMD (Last Message Driven) ゴーストとして知られる PoS アルゴリズムを実行する必要があるため、Light Client がブロックを検証するのに計算コストがかかります。

#### Initialization

最新のブロック ヘッダーに同期するには、Light Client は現在の`sync committees`を知る必要があります。 つまり、その委員会の一部であるバリデーターのすべての公開鍵を知っているということです。 この情報は、証明とともに、信頼された checkpoint ルートを提供することによって full-nodes から要求されます。 weak subjectivity(弱い主観) checkpoint とも呼ばれるこの checkpoint は、正規チェーンの一部として主観的に合意されたブロックのマークル ルートです。 証明は、ノードによって提供される`sync committees`がチェーンの一部であるかどうかを証明するマークル ブランチです。 リクエストを送信した後、ノードは、以下に規定する次の情報を含むスナップショットで応答します。 ブランチの検証が成功すると、light client はスナップショットを保存し、最新の同期期間に達するまで委員会の更新をフェッチします。

- 前者が最新のブロック ヘッダーに同期したい場合に、light-nodes と full-nodes の間で発生する知識の転送

![Light Client](../../../images/light-node-full-node.jpg "Light Client")

##### Header

Checkpoint ルートに対応するブロックのヘッダー

##### Current Sync Committee

現在の`sync committees`の公開鍵と集約された公開鍵

##### Current Sync Committee Branch

Merkle branch の形での現在の`sync committees`の proof(証明)

#### Syncing

checkpoint ルートの最新性に応じて、light client は checkpoint の同期期間から最新の同期期間まで同期する必要があります。 たとえば、提供された checkpoint ルートがスロット 2000 の古いブロック用であり、現在のブロックがスロット 18384 にある場合、ライト クライアントは 2 つの同期期間の更新を取得します。
light-nodes は、committee が変更して、彼らが知っている最新の checkpoint ルートから現在のブロックに到達するたびに、各同期期間の終わりに更新する必要があります。
2000 と 18384 の間には 16384 スロットの違いがあり、同期期間には 8192 スロットがあるため、2 つの同期期間が経過したことを意味します。 したがって、`sync committees`は 2 回変更されており、light client は 2 つの更新をフェッチしてこれらの変更を知る必要があります。 更新はスナップショットに似ていますが、次の`sync committees`と追加フィールドに関する情報が含まれています。

![Light Client eth-sync](../../../images/eth-sync.jpg "Light Client eth-sync")

##### Attested Header

更新が有効な場合に受け入れられるヘッダー

##### Next Sync Committee

次の`sync committees`の公開鍵と集約された公開鍵。

##### Next Sync Committee Branch

次の`sync committees`の The Merkle branch

##### Finality Header

現在の`sync committees`によって署名されたヘッダー

##### Sync Committee Aggregate

証明されたヘッダーを検証するために必要な`sync committees`のビットフィールドと署名が含まれています

##### Sync Committee Signature

証明されたヘッダーに署名したすべてのバリデーターの集約

##### Fork Version

証明済みヘッダーの署名に使用される 4 バイトの値

#### Tracking Header

最新の同期期間に同期した後、light client はスロットごとにヘッダー更新の要求を開始します。 受信すると、対応する`sync committees`の署名を認証してヘッダーを検証し、ビットフィールドをチェックして、十分な数の参加者が署名したことを確認します。 この検証が成功すると、受信したヘッダーを保存し、新しいスロットを待ちます。 この時点から、light client は、複雑なアルゴリズムを実行したり、過剰なストレージを必要としたりすることなく、ブロックの今後のヘッダーをトラストレスに検証できます。 非同期的に、現在のスロット、エポック、および同期期間のローカル クロックを維持し、`sync committees`がいつ変更されたかを正確に認識し、ヘッダーの更新を要求します。
