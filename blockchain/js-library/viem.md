# viem

wagmiのdevチームが開発しているEthereum用の TypeScript Interface モジュールで、多くのBridge Applicationでの採用実績がある。  
[Ethers v5 → viem Migration Guide](https://viem.sh/docs/ethers-migration.html)のセクションを見る限り、ethersjsの代替え手段となり得る。

## References
- [Official](https://viem.sh/)
- [github](https://github.com/wagmi-dev/viem)

## 機能
- JSON-RPC API の抽象化により作業が容易になる
- コントラクトと対話するためのファーストクラス API
- Ethereumの公式用語に厳密に準拠した言語
- ブラウザ拡張機能、WalletConnect、またはPrivate key ウォレットをインポートします
- 大規模な BigNumber ライブラリではなく、ブラウザ ネイティブの BigInt
- ABI を操作するためのユーティリティ (エンコード/デコード/検査)
- TypeScript 対応 (ABI および EIP-712 型付きデータから型を推測)
- Anvil, Hardhat & Ganacheに対する一流のサポート
- フォークされた Ethereum ネットワークに対して実行されるTest suite

## Provider
- [Ethers v5 → viem Migration Guide](https://viem.sh/docs/ethers-migration.html)
