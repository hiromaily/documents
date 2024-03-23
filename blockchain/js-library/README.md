# React Library

- [Web3 フロントエンド Tips](https://zenn.dev/yujiym/articles/web3-frontent-tips)

## [Wagmi](./wagmi.md)

React Hooks for Ethereum

- [Docs](https://wagmi.sh/)
- [Github](https://github.com/wagmi-dev/wagmi)
- [Awesome wagmi](https://github.com/wagmi-dev/awesome-wagmi)
- [wagmi による各ライブラリとの比較(web3-react-useDApp)](https://wagmi.sh/react/comparison)

## useDApp

- [Official](https://usedapp.io/)
- [Github](https://github.com/TrueFiEng/useDApp)
- [Docs](https://usedapp-docs.netlify.app/docs/)

### 機能一覧

- Ethers.js と合わせて使われる React Hook のコレクション
- Auto refresh や Multicall の機能を持つ
  - 複数 chain の情報も`Multi chain`という機能で管理できる (TODO: 要検証)
  - https://usedapp-docs.netlify.app/docs/Guides/Connecting/Multi%20Chain
- wallet は Metamask を default で利用する仕様だが、WalletConnect のための機能もある
- 主要な chain の情報はライブラリとしてデータを保持しており、独自の定義は不要
- `switchNetwork()`実行時に、そのネットワークが wallet に追加されていない場合は、metamask 側で自動で追加が可能。
- Version1.0 以前では`Web3-React`に依存していた (Document にたまに名前があがってくるが情報が古いだけ）

### 考察

- メリット
  - 後発だが高機能
  - ドキュメントも豊富
  - 機能が各種 Custom Hook として用意されていて、使いやすい
  - メンテナンス, commit 頻度は高い
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
- [v6 タグには docs がある](https://github.com/Uniswap/web3-react/tree/v6/docs)

### 機能一覧

- web3 インスタンスを hook, context で、各コンポーネントで共有するためのもの
- Web3ReactProvider … web3 インスタンス
- useWeb3React … web3 インスタンスの hook バージョン
- createWeb3ReactRoot … 複数 chain への接続を保持したい場合に使用する
- getWeb3ReactContext … hook を使わないで、web3 インスタンスを context 化したもの

### 考察

- メリット
  - メンテナンス, commit 頻度はそれなりに高い(しかし、最後の更新は 8 月)
- デメリット
  - status としては、`Beta`バージョン
  - issue が大量にあがっている

### Demo Site

- [https://web3-react-mu.vercel.app/](https://web3-react-mu.vercel.app/)
- MetaMask, WalletConnectV2, Coinbase Wallet に対応している
- [Example](https://github.com/Uniswap/web3-react/tree/main/example)内のコードがベース？

## WIP: Web3Modal (V2)

- [Github](https://github.com/WalletConnect/web3modal)
- [Docs](https://docs.walletconnect.com/2.0/web3modal/react/installation)
  - walletconnect 内の Docs であり、親和性が高い？
- [npm: npm だと 1.9 が最新](https://www.npmjs.com/package/web3modal)
