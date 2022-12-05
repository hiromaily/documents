# Validator

[Validator](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/#validators)
[My Journey to Becoming a Validator on Ethereum 2.0](https://consensys.net/blog/blockchain-explained/my-journey-to-becoming-a-validator-on-ethereum-2-0/)

- Ethreum mainnet の Deposit contract の特定のトランザクションを使用して`32ETH`を Deposit することでバリデーターになることができる
- 有効な Deposit が発生するたびに、イベントがトリガーされる
- Beacon チェーンはこのイベントログを参照する
- Deposit が行われ、Beacon チェーンのノードによって検出されると、バリデーターが起動される
- バリデータは新しいブロックを作成したり（ブロック提案者）、提案されたブロックに投票したり（委員会）する役割を担っている

![eth2 validator](https://raw.githubusercontent.com/hiromaily/documents/main/images/eth2_validator.webp 'eth2 validator')

- バリデータは、誠実な行動には報酬を与え、不正な行動にはペナルティを与える
- 報酬と罰則は、特定のシナリオに基づいて決定される。したがって、各バリデーターの預金は、報酬とペナルティーによって上下する。

- バリデータは Beacon ノードに接続され、バリデータの割り当てに関する更新情報を 取得する
- バリデータは、Beacon ノードの機能を実装したり、Beacon ノードを呼び出したりできるバリデータークライアントによって 実行される
- 1 つのバリデータクライアントで 1 つまたは複数のバリデータを実行できる

## PoS（Proof of Stake）のしくみ

ビーコンチェーンにおける Ethereum の PoS プロトコル`Casper FFG`の動作について

- 時間はエポックに分割され、エポックはさらに 12 秒ずつの 32 個のスロットに細分化される
- エポック開始前に、各スロットにブロック提案者としてのバリデータが割り当てられ、さらに委員会と呼ばれる特定のバリデータのグループ(最小 128 人)が割り当てられる
- バリデータは 1 つのエポックにつき 1 つのコミッティーにしか所属できない。また、1 つのスロットに対して複数の委員会が存在することもある
- すべての委員会は同じ大きさでなければならない

![eth2 validator](https://raw.githubusercontent.com/hiromaily/documents/main/images/eth2_validator2.webp 'eth2 validator')

- 各スロットにおいて、そのブロック提案者は既存の Beacon チェーンに追加するブロックを選択し、委員会はこれをメインチェーンに追加するかどうかを投票する
- これらの投票は「認証」と呼ばれ、バリデータの預託金によって重み付けされる
- バリデータは自分の票をブロードキャストし、バリデータの 3 分の 2 の票を得たブロックが受理される

- 多数決は、バリデータの数ではなく、預託金の重みに基づいて決定される。
- 2/3rd majority とは、預託金の合計が、そのバリデータの集合の預託金の合計の 2/3 に等しいバリデータの集合を指す
- 安全に機能させるためには、最低 16,384 のバリデータ数が必要である
- 仮に攻撃者が 16,384 個のバリデータの 3 分の 1 を制圧したとしても、同じ攻撃者がランダムに選んだ 128 個のバリデータ委員会の 3 分の 2 以上を制圧できる可能性は非常に低い（1 兆分の 1）
- エポック境界のブロック（チェックポイント）だけが正当化され、最終化される。最終化については[GASPER](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/gasper/)を参照

## TODO: Lodestar の Validator の挙動について

- [Validator management](https://chainsafe.github.io/lodestar/usage/validator-management/)
- lodestar における`Validator deposit contract`について

  - `Validator deposit contract` は、バリデータを初期化し、PoS に参加するために必要な 32ETH の deposit を行うための SC となる。

- Keyword
  - DEPOSIT_CONTRACT_ADDRESS
    - chainConfig に定義
      - packages/config/src/chainConfig/presets/mainnet.ts
      - packages/config/src/chainConfig/presets/minimal.ts
    - もしくは、network 種別に応じた設定ファイルに定義されている
      - packages/config/src/chainConfig/networks/sepolia.ts
  - DEPOSIT_CONTRACT_TREE_DEPTH

### lodestar を`dev`モードで起動したときの Validator の挙動

- packages/cli/src/cmds/dev/handler.ts devHandler()
  - beaconHandler()呼び出し後、args.startValidators の値が存在する場合、validatorHandler()を呼び出す
- packages/cli/src/cmds/validator/handler.ts validatorHandler()

  - getBeaconConfigFromArgs()
  - getValidatorPaths()
  - getAccountPaths()
  - getProposerConfigFromArgs()
  - getVersionData()
  - getSignersFromArgs()
  - setMaxListeners()
  - SlashingProtection(dbOps)
  - Validator.initializeFromBeaconNode() ... 一番重要なところ

    - packages/validator/src/validator.ts
    - waitForGenesis() ... beacon node によって genesis を fetch する
    - new Validator(opts, genesis, metrics)

      - new IndicesService(logger, api, metrics)
      - new ValidatorStore()
      - new ValidatorEventEmitter()
      - new ChainHeaderTracker(logger, api, emitter)
      - new BlockProposingService(config, loggerVc, api, clock, validatorStore, metrics)
      - new AttestationService()
      - new SyncCommitteeService()
      - this.chainHeaderTracker.start(this.controller.signal) ... これにより validator が開始する
        - packages/validator/src/services/chainHeaderTracker.ts
        - this.api.events.eventstream([EventType.head], signal, this.onHeadUpdate);
          - これにより、head の更新イベントを subscribe する
        - https://github.com/ChainSafe/lodestar/blob/unstable/packages/validator/src/services/chainHeaderTracker.ts#L50-L77
        - onHeadUpdate() ... これが実際の validator の処理
          - event から message を取得
          - message から slot, block, previousDutyDependentRoot, currentDutyDependentRoot
          - validator の headBlockSlot と headBlockRoot を更新
          - パラメータから、headEventData を作成
          - head event handler を headEventData をパラメータとして実行
            - https://github.com/ChainSafe/lodestar/blob/unstable/packages/validator/src/services/attestationDuties.ts#L254-L305
            - onNewHead()
              - attester duties
              - 以下の条件を満たす場合、`handleAttesterDutiesReorg()`を実行する
                - `if (nextEpochDependentRoot && currentDutyDependentRoot !== nextEpochDependentRoot)`
                - `if (currentEpochDependentRoot && currentEpochDependentRoot !== previousDutyDependentRoot)`
                - handleAttesterDutiesReorg() ... Redownload attester duties
                  - pollBeaconAttestersForEpoch()
                    - For the given `indexArr`, download the duties for the given `epoch` and store them in duties
          - this.emitter.emit(ValidatorEvent.chainHead, headEventData)

  - beacon が管理する validator の型情報
    - https://github.com/ChainSafe/lodestar/blob/unstable/packages/api/src/beacon/routes/validator.ts

```ts
export type AttesterDuty = {
  // The validator's public key, uniquely identifying them
  pubkey: BLSPubkey;
  // Index of validator in validator registry
  validatorIndex: ValidatorIndex;
  committeeIndex: CommitteeIndex;
  // Number of validators in committee
  committeeLength: UintNum64;
  // Number of committees at the provided slot
  committeesAtSlot: UintNum64;
  // Index of validator in committee
  validatorCommitteeIndex: UintNum64;
  // The slot at which the validator must attest.
  slot: Slot;
};
```

- keymanager パラメータが存在する場合、 keymanager API の backend 処理が実行される
  - new KeymanagerApi()
  - new KeymanagerRestApiServer()

### KeyManager API の機能とは？

- [Eth2 key manager API](https://ethereum.github.io/keymanager-APIs/?urls.primaryName=dev)
- Fee Recipient ... Set of endpoints for management of fee recipient.
  - [GET] `/eth​/v1​/validator​/{pubkey}​/feerecipient` ... List Fee Recipient.
  - [POST] `​/eth​/v1​/validator​/{pubkey}​/feerecipient` ... Set Fee Recipient.
  - [DELETE] `/eth​/v1​/validator​/{pubkey}​/feerecipient` ... Delete Configured Fee Recipient
- Gas Limit ... Set of endpoints for management of gas limits.
  - [GET] `​/eth​/v1​/validator​/{pubkey}​/gas_limit` ... Get Gas Limit.
  - [POST] `​/eth​/v1​/validator​/{pubkey}​/gas_limit` ... Set Gas Limit.
  - [DELETE] `​/eth​/v1​/validator​/{pubkey}​/gas_limit` ... Delete Configured Gas Limit
- Local Key Manager ... Set of endpoints for key management of local keys.
  - [GET] `​/eth​/v1​/keystores` ... List Keys.
  - [POST] `​/eth​/v1​/keystores` ... Import Keystores.
  - [DELETE] `​/eth​/v1​/keystores` ... Delete Keys.
- Remote Key Manager ... Set of endpoints for key management of external keys.
  - [GET] `​/eth​/v1​/remotekeys` ... List Remote Keys.
  - [POST] `​/eth​/v1​/remotekeys` ... Import Remote Keys.
  - [DELETE] `​/eth​/v1​/remotekeys` ... Delete Remote Keys.

### `DEPOSIT_CONTRACT_ADDRESS`がいつ使われている？

- packages/beacon-node/src/api/impl/config/index.ts
  - getConfigApi() > getDepositContract()
- packages/beacon-node/src/eth1/provider/eth1Provider.ts
  - Eth1Provider class のメンバーに`depositContractAddress`が存在する
  - validateContract()
  - getDepositEvents()
    - packages/beacon-node/src/eth1/eth1DepositDataTracker.ts update() > updateDepositCache()から呼ばれる
    - beacon node 起動時に、`eth1`option が true の場合、runAutoUpdate()を実行し、内部で loop し、処理を定期的に実行する
- packages/beacon-node/src/eth1/eth1DepositDataTracker.ts
  - updateDepositCache() ... これは、eth1DepositDataTracker の update()から呼ばれる
    - getDepositEvents()を呼び出し、depositEvent が取得された場合、depositsCache プロパティに追加される
- https://github.com/ChainSafe/lodestar/blob/eccde2f3d71448ad5b5026f87e4699c29b5b04f7/packages/beacon-node/src/chain/genesis/genesis.ts
  - waitForGenesis()から呼ばれる、waitForGenesisValidators()内にて、`depositEvents`を使っている
  - それを applyDeposits()のパラメータとして呼び出すことで、validator に変更が入る
    - applyDeposits()の戻り値が、`activatedValidatorCount`にセットされる
    - TODO: しかし、waitForGenesis()は初期化処理時にしか呼ばれていないのでは？

### 初期 Validator の変更がどのように行われるのか？

- これがおそらく、eth1 上で 32ETH の deposit が行われたことを beacon node がイベントで検知することによって、Validator を起動するタイミングになる

### Validator Client の挙動について

- validator package が存在する
  - https://github.com/ChainSafe/lodestar/tree/unstable/packages/validator
  - validator 機能を持つモジュール群

## Staking / Validator Deposit Contract

- Lodestar については、Beacon Node が指定した`Deposit Contract`

### Spec

- [Deposit Contract on spec](https://github.com/ethereum/consensus-specs/tree/dev/solidity_deposit_contract)
- [Phase 0 -- Deposit Contract](https://github.com/ethereum/consensus-specs/blob/dev/specs/phase0/deposit-contract.md)

### Others

- [Check the deposit contract address](https://ethereum.org/en/staking/deposit-contract/)
- [Deposit Process](https://kb.beaconcha.in/ethereum-2.0-depositing)
- [Validator deposit contract on Prysm](https://docs.prylabs.network/docs/how-prysm-works/validator-deposit-contract)

  - `Validator Deposit Contract` は、バリデータを初期化し、Ethreum の PoS に完全に参加するために必要な`32ETH`の deposit を行うための Smart Contract
  - Validator は、既存の Ethreum の Blockchain から`Validator Deposit Contract`に`32ETH`の入金が行われ、ノードが完全にスピンアップすると、PoS システムのキューに入れられる
  - すべての Initial Deposit が Ethreum から行われるようにすることで、Ethereum の PoS は、既存の Ether のセキュリティプールと価値を活用し、起動時にネットワークを secure にすることができる
  - Prysm ノードの場合、このコントラクトからの Deposit Log を自動的にリッスンし、バリデータが起動できる状態になったことを検出する

### Example

- [eth1 の genesis.json sample](https://github.com/rauljordan/eth-pos-devnet/blob/master/execution/genesis.json#L32-L35)

```
		"0x4242424242424242424242424242424242424242": {
			"balance": "0",
			"code": "0x60806040526004361061003f5760003560e01c80630...."
		},
```

- いくつかの sample ではアドレスに`0x4242424242424242424242424242424242424242`が使われているが、eth2 側の config に`DEPOSIT_CONTRACT_ADDRESS`があり、それが一致していれば問題ないと思われる
- [sample config](https://notes.ethereum.org/@protolambda/merge-devnet-setup-guide#Eth2-config-template)
