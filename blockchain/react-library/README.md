# React Library

## TODO: wagmi
React Hooks for Ethereum

- [Docs](https://wagmi.sh/)
- [Github](https://github.com/wagmi-dev/wagmi)
- [Awesome wagmi](https://github.com/wagmi-dev/awesome-wagmi)

### 機能一覧
- Ethers.jsと合わせて使うReact Hooks
- Wallet Connectorにより、MetaMask, WalletConnect, Coinbase Wallet, Injectedなどに接続ができる
- キャッシュ機能,リクエストの重複排除, multicall, バッチ処理, 持続性
- Wallet, block, networkのAuto-refresh data
- ABI管理やコード生成のためのCLI
- Test suite running against forked Ethereum network
- TypeScript ready (infer types from ABIs and EIP-712 Typed Data)
- Web3Modalでも使われている

### wagmiのhooks
- [hooks](https://github.com/wagmi-dev/wagmi/tree/main/packages/react/src/hooks)
  - [accounts](https://github.com/wagmi-dev/wagmi/tree/main/packages/react/src/hooks/accounts)
    - useAccount.ts
    - useBalance.ts
    - useConnect.ts
    - useDisconnect.ts
    - useNetwork.ts
    - useSignMessage.ts
    - useSignTypedData.ts
    - useSigner.ts
    - useSwitchNetwork.ts
  - [contracts](https://github.com/wagmi-dev/wagmi/tree/main/packages/react/src/hooks/contracts)
    - useContract.ts
    - useContractEvent.ts
    - useContractInfiniteReads.ts
    - useContractRead.ts
    - useContractReads.ts
    - useContractWrite.ts
    - usePrepareContractWrite.ts
    - useToken.ts
  - [ens](https://github.com/wagmi-dev/wagmi/tree/main/packages/react/src/hooks/ens)
    - useEnsAddress.ts
    - useEnsAvatar.ts
    - useEnsName.ts
    - useEnsResolver.ts
  - [network-status](https://github.com/wagmi-dev/wagmi/tree/main/packages/react/src/hooks/network-status)
    - useBlockNumber.ts
    - useFeeData.ts
  - [providers](https://github.com/wagmi-dev/wagmi/tree/main/packages/react/src/hooks/providers)
    - useProvider.ts
    - useWebSocketProvider.ts
  - [transactions](https://github.com/wagmi-dev/wagmi/tree/main/packages/react/src/hooks/transactions)
    - usePrepareSendTransaction.ts
    - useSendTransaction.ts
    - useTransaction.ts
    - useWaitForTransaction.ts
    - useWatchPendingTransactions.ts
  - [utils](https://github.com/wagmi-dev/wagmi/tree/main/packages/react/src/hooks/utils)
    - [query](https://github.com/wagmi-dev/wagmi/tree/main/packages/react/src/hooks/utils/query)
      - useBaseQuery.ts
      - useInfiniteQuery.ts
      - useMutation.ts
      - useQuery.ts
      - useQueryClient.ts
      - utils.ts
    - useChainId.ts
    - useForceUpdate.ts
    - useInvalidateOnBlock.ts
    - useSyncExternalStore.ts
    - useSyncExternalStoreWithTracked.ts

### Examples
- [Connect Wallet](https://wagmi.sh/examples/connect-wallet)
- [Send Transaction](https://wagmi.sh/examples/send-transaction)
- [Sign Message](https://wagmi.sh/examples/sign-message)
- [Sign-In with Ethereum](https://wagmi.sh/examples/sign-in-with-ethereum)
- [Create Custom Connector](https://wagmi.sh/examples/custom-connector)
  - これによりカスタマイズしやすいのかもしれない。
  - sushiswapのwagmi package内に[hooks](https://github.com/sushiswap/sushiswap/tree/master/packages/wagmi/hooks)があるので参考になる

## useDApp
- [Official](https://usedapp.io/)
- [Github](https://github.com/TrueFiEng/useDApp)
- [Docs](https://usedapp-docs.netlify.app/docs/)

### 機能一覧
- Ethers.jsと合わせて使われるReact Hookのコレクション
- Auto refreshやMulticallの機能を持つ
  - 複数chainの情報も`Multi chain`という機能で管理できる (TODO: 要検証)
  - https://usedapp-docs.netlify.app/docs/Guides/Connecting/Multi%20Chain
- walletはMetamaskをdefaultで利用する仕様だが、WalletConnectのための機能もある
- 主要なchainの情報はライブラリとしてデータを保持しており、独自の定義は不要
- `switchNetwork()`実行時に、そのネットワークがwalletに追加されていない場合は、metamask側で自動で追加が可能。
- Version1.0以前では`Web3-React`に依存していた (Documentにたまに名前があがってくるが情報が古いだけ）

### 考察
- メリット
  - 後発だが高機能
  - ドキュメントも豊富
  - 機能が各種Custom Hookとして用意されていて、使いやすい
  - メンテナンス, commit頻度は高い
- デメリット
  - 特にない

### Demo Site
- [https://example.usedapp.io/](https://example.usedapp.io/)


## web3-react (beta)
- [Github](https://github.com/Uniswap/web3-react)
  - 4.8K
- [How to use Web3-react to develop DApp](https://dev.to/yakult/how-to-use-web3-react-to-develop-dapp-1cgn)
  - これによると、
  - Front-end: React, Next.js, TypeScript
  - Blockchain API: Ethers.js
- [v6タグにはdocsがある](https://github.com/Uniswap/web3-react/tree/v6/docs)

### 機能一覧
- web3インスタンスをhook, contextで、各コンポーネントで共有するためのもの
- Web3ReactProvider … web3インスタンス
- useWeb3React … web3インスタンスのhookバージョン
- createWeb3ReactRoot … 複数chainへの接続を保持したい場合に使用する
- getWeb3ReactContext … hookを使わないで、web3インスタンスをcontext化したもの

### 考察
- メリット
  - メンテナンス, commit頻度はそれなりに高い(しかし、最後の更新は8月)
- デメリット
  - statusとしては、`Beta`バージョン
  - issueが大量にあがっている

### Demo Site
- [https://web3-react-mu.vercel.app/](https://web3-react-mu.vercel.app/)
- MetaMask, WalletConnectV2, Coinbase Walletに対応している
- [Example](https://github.com/Uniswap/web3-react/tree/main/example)内のコードがベース？


## WIP: Web3Modal (V2) 
- [Github](https://github.com/WalletConnect/web3modal)
- [Docs](https://docs.walletconnect.com/2.0/web3modal/react/installation)
  - walletconnect内のDocsであり、親和性が高い？
- [npm: npmだと1.9が最新](https://www.npmjs.com/package/web3modal)

