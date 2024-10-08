# Lodestar

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
        - <https://github.com/ChainSafe/lodestar/blob/unstable/packages/validator/src/services/chainHeaderTracker.ts#L50-L77>
        - onHeadUpdate() ... これが実際の validator の処理
          - event から message を取得
          - message から slot, block, previousDutyDependentRoot, currentDutyDependentRoot
          - validator の headBlockSlot と headBlockRoot を更新
          - パラメータから、headEventData を作成
          - head event handler を headEventData をパラメータとして実行
            - <https://github.com/ChainSafe/lodestar/blob/unstable/packages/validator/src/services/attestationDuties.ts#L254-L305>
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
    - <https://github.com/ChainSafe/lodestar/blob/unstable/packages/api/src/beacon/routes/validator.ts>

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
- <https://github.com/ChainSafe/lodestar/blob/eccde2f3d71448ad5b5026f87e4699c29b5b04f7/packages/beacon-node/src/chain/genesis/genesis.ts>
  - waitForGenesis()から呼ばれる、waitForGenesisValidators()内にて、`depositEvents`を使っている
  - それを applyDeposits()のパラメータとして呼び出すことで、validator に変更が入る
    - applyDeposits()の戻り値が、`activatedValidatorCount`にセットされる
    - TODO: しかし、waitForGenesis()は初期化処理時にしか呼ばれていないのでは？

### 初期 Validator の変更がどのように行われるのか？

- これがおそらく、eth1 上で 32ETH の deposit が行われたことを beacon node がイベントで検知することによって、Validator を起動するタイミングになる

### Validator Client の挙動について

- validator package が存在する
  - <https://github.com/ChainSafe/lodestar/tree/unstable/packages/validator>
  - validator 機能を持つモジュール群
