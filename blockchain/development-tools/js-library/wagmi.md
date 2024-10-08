# Wagmi

React Hooks for Ethereum

- [Docs](https://wagmi.sh/)
- [Github](https://github.com/wagmi-dev/wagmi)
- [Awesome wagmi](https://github.com/wagmi-dev/awesome-wagmi)

## [Getting Started](https://wagmi.sh/react/getting-started)

- 基本的な実装方法について
- [TypeScript の指定](https://wagmi.sh/react/typescript)についても言及されている

## [機能一覧](https://wagmi.sh/#features)

- Ethers.js や [Viem](./viem.md) と合わせて使う React Hooks で 20 以上の Hook が用意されている
- Wallet を通じて、ENS, contracts, transactions, signing といった基本機能を使うことができる
- Wallet Connector により、[MetaMask](https://docs.metamask.io/wallet/), [WalletConnect](https://docs.walletconnect.com/2.0), [Coinbase Wallet](https://docs.cloud.coinbase.com/wallet-sdk/v2.0.0/docs/welcome), `Injected` などに接続ができる
  - [WalletConnect は V2 に対応している](https://wagmi.sh/react/migration-guide#012x-breaking-changes)
  - [Injected](https://wagmi.sh/react/connectors/injected)とは？
- キャッシュ機能,リクエストの重複排除, `Multicall`, バッチ処理, 持続性
- Wallet, block, network の Auto-refresh data
- ABI 管理やコード生成のための CLI
- Test suite running against forked Ethereum network
- TypeScript ready (infer types from ABIs and EIP-712 Typed Data)

## その他 Docs から特筆すべき点

- [MockConnector](https://wagmi.sh/react/connectors/mock)を持つため、Test もしくは開発時に利用できそう
- Web3Modal でも使われている
- Wagmi は ABIType と EIP-712 の型データ定義に基づいて型を推論することができる
  - [EIP-712](https://eips.ethereum.org/EIPS/eip-712) はヒューマンリーダブルな型付署名で、eth_sign 実行時に使われる
  - [Wagmi: EIP-712 Typed Data](https://wagmi.sh/react/typescript#contract-abis)
  - [Wagmi: abitype](https://wagmi.sh/react/typescript#contract-abis)

## [ABI の取り扱いについて](https://wagmi.sh/react/typescript#contract-abis)

以下の Hook は、abi に const アサーションを追加することで型推論をサポートする

- [useContract](https://wagmi.sh/react/hooks/useContractRead)
  - 型安全な Contract インスタンスを宣言的に作成するための Hook
- [useContractEvent](https://wagmi.sh/react/hooks/useContractEvent)
  - Ethers Contract のイベントを Subscribe するための Hook
- [useContractRead](https://wagmi.sh/react/hooks/useContractRead)
  - Ethers Contract の読み取り専用メソッドを呼び出すための Hook
- [useContractReads](https://wagmi.sh/react/hooks/useContractReads)
  - 複数の Ethers Contract の読み取り専用メソッドを呼び出すための Hook
- [useContractWrite](https://wagmi.sh/react/hooks/useContractWrite)
  - Ethers Contract write メソッドを呼び出すための Hook で、`usePrepareContractWrite` Hook とペアで使用する
- [usePrepareContractWrite](https://wagmi.sh/react/prepare-hooks/usePrepareContractWrite)
  - `useContractWrite` で送信する Contract の write メソッドを準備するための Hook
  - `gas estimate`など、Contract write transasction の送信に必要なパラメータを fetch し続ける
- [useContractInfiniteReads](https://wagmi.sh/react/hooks/useContractInfiniteReads)
  - 無限スクロール(fetch more)をサポートする複数の Ethers Contarct 読み取り専用メソッドを呼び出すための Hook。Contract データの動的なリストをレンダリングするのに便利

## [Client](https://wagmi.sh/react/client)

Wagmi Client はフレームワークに依存しない（Vanilla JS）クライアントで、自動接続、Connecter、Ethers プロバイダなど、Wallet の接続状態や設定を管理する

```ts
const client = createClient({
  provider,
  webSocketProvider,
});
```

- autoConnect (optional)
  - マウント時に最後に使用したコネクタへの再接続を有効にする。(Default:false)
- connectors (optional)
  - accounts へのリンクに使用するコネクター。(Default: [new InjectedConnector()])
- logger (optional)
  - Wagmi でログがどのようにブロードキャストされるかをオーバーライドするために、Custom Logger を提供する機能。(Default: console.log)
  - log を無効化するには、`null`を設定する
- provider
  - Ethereum ネットワークに接続するための ethers Interface
- storage (optional)
  - データを永続化し、キャッシュするための戦略。(Default: window.localStorage)
- webSocketProvider (optional)
  - ethers Ethereum ネットワークに接続するための WebSocket Interface。
  - WebSocket プロバイダを提供する場合、特定のインスタンスでポーリングの代わりに使用される。

## [対応 Chain について](https://wagmi.sh/react/chains)

[chain の定義先](https://github.com/wagmi-dev/references/tree/main/packages/chains/src)

### 以下に一部抜粋

- [mainnet](https://github.com/wagmi-dev/references/blob/f62be25b5666ede63aa518bb0a3e62432fdacd00/packages/chains/src/mainnet.ts)
- goerli
- [sepolia](https://github.com/wagmi-dev/references/blob/main/packages/chains/src/sepolia.ts)
- [bsc](https://github.com/wagmi-dev/references/blob/main/packages/chains/src/bsc.ts)
- [bscTestnet](https://github.com/wagmi-dev/references/blob/main/packages/chains/src/bscTestnet.ts)
- [foundry](https://github.com/wagmi-dev/references/blob/f62be25b5666ede63aa518bb0a3e62432fdacd00/packages/chains/src/foundry.ts)
- [hardhat](https://github.com/wagmi-dev/references/blob/main/packages/chains/src/hardhat.ts)
- [localhost](https://github.com/wagmi-dev/references/blob/main/packages/chains/src/localhost.ts)

独自の EVM 系チェーンを設定することも可能: [Build your own](https://wagmi.sh/react/chains#build-your-own)

## Provider

RPC サーバーの提供先

[Configuring Chains](https://wagmi.sh/react/providers/configuring-chains)

- Alchemy、Infura、またはその他のプロバイダでチェーンを構成することができる。このとき、Connector や Provider で RPC URL の定義やチェーンの設定を気にする必要がない。これらは wagmi によって内部的に管理されている
- chains, providers は複数設定することができる
- [Multiple providers](https://wagmi.sh/react/providers/configuring-chains#multiple-providers)
  - すべてのチェーンが単一のプロバイダをサポートしていない場合に便利。例えば、`Ethereum`には`Alchemy`を使い、`Avalanche`には`avax.network`を使いたい場合など
  - ethers.js の`FallbackProvider`を wrap することで、Provider が down した場合に他の Provider に fallback する（例：Infura がダウンした場合、Alchemy にフォールバックする）
- [Quorum](https://wagmi.sh/react/providers/configuring-chains#quorum)
  - `targetQuorum`オプションに 1 以上の値を設定すると、複数のプロバイダにインタラクションをディスパッチし、レスポンスを互いに比較することで検証を行う。
  - Quorum に達した場合、結果が返さる
- [Configuration](https://wagmi.sh/react/providers/configuring-chains#configuration)

  - pollingInterval (optional)
    - Provider が Pooling する頻度をミリ秒単位で指定する。(Default: 4000ms)
  - targetQuorum (optional)
    - target quorum を設定する (Default: 1)
  - minQuorum (optional)
    - Provider が受け入れなければならない最小の Quorum を設定する (Default: 1)
  - stallTimeout (optional)
    - 別の Provider が試行されるまでのタイムアウトをミリ秒単位で指定する。

### Provider の種類

- [Alchemy](https://wagmi.sh/react/providers/alchemy)
  - `alchemyProvider`は Alchemy RPC URL でチェーンを構成し、また ethers.js の AlchemyProvider を提供する
- [Infura](https://wagmi.sh/react/providers/infura)
  - `infuraProvider`は、Infura RPC URL でチェーンを構成し、また ethers.js の InfuraProvider を提供する
- [Public](https://wagmi.sh/react/providers/public)
  - `publicProvider`は、public RPC URL でチェーンを構成し、ethers.js の getpublicProvider も提供する
  - つまり無料で使える Node 群を利用する
  - これはレート制限につながる可能性がある
- [JSON RPC](https://wagmi.sh/react/providers/jsonRpc)
  - `jsonRpcProvider`は、指定した RPC URL でチェーンを構成し、さらに ether.js `StaticJsonRpcProvider`を提供する

## Connectors

### [Injected](https://wagmi.sh/react/connectors/injected)

InjectedConnector は、Browser や Window に`Ethereum Provider`を注入するウォレットをサポートする
`MetaMask` Browser Extension は、この最も一般的な例

### [MetaMask](https://wagmi.sh/react/connectors/metaMask)

`MetaMaskConnector`は`MetaMask`との接続をサポートする

### [WalletConnect](https://wagmi.sh/react/connectors/walletConnect)

`WalletConnectConnector`は、デフォルトで`WalletConnect v2`を使用し、`WalletConnect Ethereum Provider`をラップしてその設定オプションをサポートする

### [Coinbase Wallet](https://wagmi.sh/react/connectors/coinbaseWallet)

`CoinbaseWalletConnector`は、`Coinbase Wallet SDK`を使用した`Coinbase Wallet`との接続をサポートする

### [Mock](https://wagmi.sh/react/connectors/mock)

`MockConnector` は、テストなどに便利なモックされた Connector 実装
Test 環境などでは Metamask は使えないので、そのような場合に利用する

### Others

#### [Ledger](https://wagmi.sh/react/connectors/ledger)

`LedgerConnector`は、[Ledger Connect Kit](https://developers.ledger.com/docs/dapp-connect-kit/introduction/)を使用した Ledger デバイスとの接続をサポートする

#### [Safe Wallet](https://wagmi.sh/react/connectors/safe)

`SafeConnector`は、[Safe Apps SDK](https://github.com/safe-global/safe-apps-sdk)を使用した Safe Wallet との接続をサポートする

## Hooks

Docs に用意されている Hook は比較的利用頻度が高いものと思われる

- [useAccount](https://wagmi.sh/react/hooks/useAccount)
- useBalance
- useBlockNumber
- useConnect
- useContract
- useContractEvent
- useContractInfiniteReads
- useContractRead
- useContractReads
- useContractWrite
- useDisconnect
- useEnsAddress
- useEnsAvatar
- useEnsName
- useEnsResolver
- useFeeData
- useNetwork
- useProvider
- useSendTransaction
- useSigner
- useSignMessage
- useSignTypedData
- useSwitchNetwork
- useToken
- useTransaction
- useWaitForTransaction
- useWatchPendingTransactions
- useWebSocketProvider
- usePrepareContractWrite
- usePrepareSendTransaction

### [useContractReads](https://wagmi.sh/react/hooks/useContractReads)

- 複数の contract を後述する`multicall`を使って呼び出す

#### useContractReads: 必須 Parameter

- address (optional とあるが必須では？)
  - contract アドレス
- abi (optional とあるが必須では？)
  - 呼びだす function を含む ABI ファイル
- functionName (optional とあるが必須では？)
  - 呼び出す function 名
- chainId(optional とあるが必須では？)
  - function の呼び出し先 chain である ID
- args (optional)
  - 呼び出す function に引数を渡す場合、こちらに設定する

#### useContractReads: 状況によって使い分ける Parameter

- allowFailure (optional)
  - 読み込み時にエラーが発生した場合、通常はエラーが throw されるが、`true`の場合はエラーを throw しない
- blockNumber (optional)
  - 指定した blockNumber の Block から State を読み込む
- blockTag (optional)
  - 読み込み時、指定した block の状態に該当する block から State を読み込む (参考: [default block parameter](https://ethereum.org/en/developers/docs/apis/json-rpc/#default-block))
    - `latest`: for the latest mined block
    - `earliest`: for the earliest/genesis block
    - `pending`: for the pending state/transactions
    - `safe`: for the latest safe head block
    - `finalized`: for the latest finalized block
- cacheOnBlock (optional)
  - 現在のブロックに対して返されたデータをキャッシュする。 新しいブロックが到着すると、古いデータは更新される。
- watch (optional)
  - block 毎の変化を監視し、block が更新されると reponse も変更される(はず)。ただし頻繁なリクエストにより rate-limit に引っかかる恐れがある。
- cacheTime (optional)
  - Default: 0. Cache としての保持期間(ms)
- enabled (optional)
  - Defaults to `true`. これを`false`にすることで、自動的な query をコントロールする。
  - つまり、`enable`の値は固定値をセットするものではない。以下例`usePrepareContractWrite()`の例だが、特定の値が正しい場合のみ`true`になる

```ts
const { config } = usePrepareContractWrite({
  ...getSushiBarContractConfig(ChainId.ETHEREUM),
  functionName: stake ? 'enter' : 'leave',
  args: amount ? [BigNumber.from(amount.quotient.toString())] : undefined,
  enabled: !!amount?.quotient,
});

const { write, isLoading: isWritePending } = useContractWrite({
  ...config,
  onSettled,
});
```

- scopeKey (optional)
  - キャッシュの範囲を指定されたコンテキストに限定する。 同一のコンテキストを持つ Hook は同じキャッシュを共有する
- staleTime (optional)
  - Default: `0`, データが古いとみなされるまでの時間 (ミリ秒)。`Infinity` に設定すると、データは古いとはみなされない
- select (optional)
  - Contract によって返されたデータの一部を変換または選択する
- structuralSharing (optional)
  - データの参照 ID を保持し、再レンダリングを防ぐ
- suspense (optional)
  - `true`によって suspense モードを有効にする
- onSuccess (optional)
- onError (optional)
- onSettled (optional)

### [useContractWrite](https://wagmi.sh/react/hooks/useContractWrite)

- contract の状態変化が発生する function を呼び出す。内部的には[writeContarct](https://viem.sh/docs/contract/writeContract.html), さらには[sendTransaction()](https://viem.sh/docs/actions/wallet/sendTransaction.html)が呼ばれる
- write function オブジェクトを hook が返すため、button の click event などに bind して使うことができる
- その write function に動的にパラメータを渡すことができる。[Dynamic Arguments](https://wagmi.sh/react/hooks/useContractWrite)
  - ただし、[usePrepareContractWrite()](https://wagmi.sh/react/prepare-hooks/usePrepareContractWrite)は、そのまま実行される hook function のため、`enabled`パラメータをつかって、調整が必要
  - config の準備ができていない状態では、`write`は`undefined`になる

#### useContractWrite: 必須 Parameter

- address (optional とあるが必須では？)
  - contract アドレス
- abi (optional とあるが必須では？)
  - 呼びだす function を含む ABI ファイル
- functionName (optional とあるが必須では？)
  - 呼び出す function 名
- chainId(optional とあるが必須では？)
  - function の呼び出し先 chain である ID
- args (optional)
  - 呼び出す function に引数を渡す場合、こちらに設定する

#### useContractWrite: 状況によって使い分ける Parameter

- account (optional)
  - from address
- gas (optional)
  - Transaction 実行のための`gas limit`
- gasPrice (optional)
  - gas 毎に支払う gas 価格だが、Legacy Transaction にのみ適用できる
  - Deprecated されている？
- maxFeePerGas

## [Default で利用できる ABI (Application Binary Interface)](https://wagmi.sh/react/constants/abis)

- ERC-20
- ERC-721
- ERC-4626

## [Actions](https://wagmi.sh/react/actions)

React Hooks の宣言的な性質が、アプリの一部で機能しないことがある。`wagmi/core`の VanillaJS アクションはすべて、wagmi/actions エントリポイントを使ってインポートすることができる。多くのケースで、内部的に [Viem](./viem.md) の function を呼び出している。

- [connect](https://wagmi.sh/core/actions/connect)
- disconnect
- fetchBalance
- fetchBlockNumber
- fetchEnsAddress
- fetchEnsAvatar
- fetchEnsName
- fetchEnsResolver
- fetchFeeData
- fetchSigner
- fetchTransaction
- fetchToken
- getAccount
- getContract
- getNetwork
- getProvider
- getWebSocketProvider
- [multicall](https://wagmi.sh/core/actions/multicall)
  - 複数の"read-only" function (constant function) を呼び出すために使われる
  - [viem の multicall](https://viem.sh/docs/contract/multicall.html)が内部的に呼ばれる
- prepareSendTransaction
- prepareWriteContract
- [readContract](https://wagmi.sh/core/actions/readContract)
  - "read-only" function (constant function) のために使われる
  - [viem の readContract](https://viem.sh/docs/contract/readContract.html)が呼ばれるが、これは内部的に[viem の call](https://viem.sh/docs/actions/public/call.html)が呼ばれる
  - [eth_call](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_call)
- [readContracts](https://wagmi.sh/core/actions/readContracts)
  - 複数の"read-only" function (constant function) を呼び出すために使われる
  - [viem の multicall](https://viem.sh/docs/contract/multicall.html)が内部的に呼ばれる (eth_call を使って multicall function が呼ばれる)
- sendTransaction
- signMessage
- signTypedData
- switchNetwork
- waitForTransaction
- watchAccount
- watchBlockNumber
- watchContractEvent
- watchMulticall
- watchNetwork
- watchPendingTransactions
- watchProvider
- watchReadContract
- watchReadContracts
- watchSigner
- watchWebSocketProvider
- [writeContract](https://wagmi.sh/core/actions/writeContract)
  - Contract の状態を変更するための function を呼び出す
  - [viem の writeContract](https://viem.sh/docs/contract/writeContract.html)が呼ばれるが、これは内部的に ABI-encoded data と共に[viem の sendTransaction action](https://viem.sh/docs/actions/wallet/sendTransaction.html)が呼ばれる

### [Multicall](https://wagmi.sh/core/actions/multicall)

[multicall](../multicall3.md)

- [useContractReads](https://wagmi.sh/react/hooks/useContractReads)や[readContracts](https://wagmi.sh/core/actions/readContracts)は内部的に[viem の multicall](https://viem.sh/docs/contract/multicall.html)を呼び出し、[multicall3](https://github.com/mds1/multicall)コントラクト を介して複数のイーサコントラクトの読み取り専用メソッドを呼び出す。

```ts
import { multicall } from '@wagmi/core';

const wagmigotchiContract = {
  address: '0xecb504d39723b0be0e3a9aa33d646642d1051ee1',
  abi: wagmigotchiABI,
};
const mlootContract = {
  address: '0x1dfe7ca09e99d10835bf73044a23b73fc20623df',
  abi: mlootABI,
};

const data = await multicall({
  contracts: [
    {
      ...wagmigotchiContract,
      functionName: 'getAlive',
    },
    {
      ...wagmigotchiContract,
      functionName: 'getBoredom',
    },
    {
      ...mlootContract,
      functionName: 'getChest',
      args: [69],
    },
    {
      ...mlootContract,
      functionName: 'getWaist',
      args: [69],
    },
  ],
});
```

## [Module Types](https://wagmi.sh/core/module-types)

Default: Pure ESM

## [CLI](https://wagmi.sh/cli/getting-started)

Wagmi CLI は、

- ABI の管理（Etherscan/ブロックエクスプローラ、Foundry/Hardhat プロジェクトなど）
- コードの生成（React Hooks、VanillaJS アクションなど）
- 手作業を自動化することで、Ethereum での作業を容易にする（例えば、Etherscan から ABI をコピー＆ペーストする必要がなくなる）
- また、CLI をさらに拡張するためのプラグインを書くことも可能

## Examples

- [Connect Wallet](https://wagmi.sh/examples/connect-wallet)
- [Send Transaction](https://wagmi.sh/examples/send-transaction)
- [Sign Message](https://wagmi.sh/examples/sign-message)
- [Sign-In with Ethereum](https://wagmi.sh/examples/sign-in-with-ethereum)
- [Create Custom Connector](https://wagmi.sh/examples/custom-connector)
  - これによりカスタマイズしやすいのかもしれない。
  - sushiswap の wagmi package 内に[hooks](https://github.com/sushiswap/sushiswap/tree/master/packages/wagmi/hooks)があるので参考になる

## Wagmi 関連の記事

- [ウォレットとの接続を簡単にしてくれるライブラリ wagmi の使い方](https://zenn.dev/pokena/articles/3d53b52c2d441c)
- [TurboETH + WAGMI CLI - Automatically generate smart contract read, write and event hooks](https://www.youtube.com/watch?v=sBX79sPjRss)
