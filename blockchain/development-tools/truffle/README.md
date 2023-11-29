# truffle

- [Docs](https://trufflesuite.com/)

## Commands

```
❯ npx truffle --help
Truffle v5.7.4 - a development framework for Ethereum

Usage: truffle <command> [options]

Commands:
  truffle build      Execute build pipeline (if configuration present)
  truffle compile    Compile contract source files
  truffle config     Set user-level configuration options
  truffle console    Run a console with contract abstractions and commands
                     available
  truffle create     Helper to create new contracts, migrations and tests
  truffle dashboard  Start Truffle Dashboard to sign development transactions
                     using browser wallet
  truffle db         Database interface commands
  truffle debug      Interactively debug any transaction on the blockchain
  truffle deploy     (alias for migrate)
  truffle develop    Open a console with a local development blockchain
  truffle exec       Execute a JS module within this Truffle environment
  truffle help       List all commands or provide information about a specific
                     command
  truffle init       Initialize new and empty Ethereum project
  truffle migrate    Run migrations to deploy contracts
  truffle networks   Show addresses for deployed contracts on each network
  truffle obtain     Fetch and cache a specified compiler
  truffle opcode     Print the compiled opcodes for a given contract
  truffle preserve   Save data to decentralized storage platforms like IPFS and
                     Filecoin
  truffle run        Run a third-party command
  truffle test       Run JavaScript and Solidity tests
  truffle unbox      Download a Truffle Box, a pre-built Truffle project
  truffle version    Show version number and exit
  truffle watch      Watch filesystem for changes and rebuild the project
                     automatically

Options:
  --help     Show help                                                 [boolean]
  --version  Show version number                                       [boolean]
```

## Compile

- build crtifacts and files are generated in `build/contracts/`
- [Compiling contracts](https://trufflesuite.com/docs/truffle/getting-started/compiling-contracts/)

```
truffle compile
# ignore cache
truffle compile --all
```

### compile によって生成される `artifacts` について

- [Compilation artifacts](https://hardhat.org/hardhat-runner/docs/advanced/artifacts)

  - これは、Hardhat によるものなので、Truffle によって生成された output と異なる

- truffe によって生成された json ファイルの構造について
  - contractName
  - abi
    - contract の ABI (Application Binary Interface)
  - metadata
  - bytecode
    - deployment bytecode
  - deployedBytecode
    - runtime/deployed bytecode
  - immutableReferences
  - generatedSources
  - deployedGeneratedSources
  - sourceMap
  - deployedSourceMap
  - source
  - sourcePath
  - ast
  - compiler
  - networks
  - schemaVersion
  - updatedAt
  - userdoc

### test や migration 時に読み込む `artifacts.require` について

[truffle: artifacts.require()](https://trufflesuite.com/docs/truffle/how-to/contracts/run-migrations/#artifactsrequire)

- Truffle に `artifacts.require()` メソッドで対話したいコントラクトを教える。これによってコントラクトの抽象化を返す。
- 指定する名前は、そのソース・ファイル内のコントラクト定義の名前と一致する必要がある。
- ファイルには複数のコントラクトを含めることができるため、ソース ファイル名は渡してはならない。
- Documents には、ただ`コントラクト名`を渡すだけでよい、とある
- ターゲットは`solファイル`であって、compile によって生成される artifacts ではない？
  - github内を`artifacts.require`で検索した[結果](https://github.com/search?l=JavaScript&q=artifacts.require&type=Code)によると、コントラクト名、もしくは、solidityファイルを指定している様子 
- これによって自動的に読み込まれるパスは、
  - contracts
  - test
  - node_modules
- ファイルパスが正しくない場合、`Could not find artifacts`エラーが出る
- こちらの issue: [Allow artifacts loading from outside contracts and test folders](https://github.com/trufflesuite/truffle/issues/3436)がまだ Open なので、これらのディレクトリ外のコントラクトは読み込めないのかもしれない。

```js
const ERC1400ContractModule = artifacts.require('ERC1400ContractModule');
```

## Migration

```
npx truffle migrate --network development

npx truffle migrate --network development --reset
# migrationファイルの番号を指定
npx truffle migrate -f 2 --to 2 --network development --reset
```

## Debug

[Use the Truffle debugger](https://trufflesuite.com/docs/truffle/how-to/debug-test/use-the-truffle-debugger/)

- txHash を取得後、以下のコマンドを実行する
  - network name は`truffle-config.js`の定義より取得

```
npx truffle debug <txHash> --network <network-name>
```

- この debug サブコマンドを実行する環境には、ソースコードも必要となる。

### Debug Command

```
Commands:
(enter) last command entered (step next)
(o) step over, (i) step into, (u) step out, (n) step next
(c) continue until breakpoint, (Y) reset & continue to previous error
(y) (if at end) reset & continue to final error
(;) step instruction (include number to step multiple)
(g) turn on generated sources, (G) turn off generated sources except via `;`
(p) print instruction & state (`p [mem|cal|sto]*`; see docs for more)
(l) print additional source context, (s) print stacktrace, (h) print this help
(q) quit, (r) reset, (t) load new transaction, (T) unload transaction
(b) add breakpoint (`b [[<source-file>:]<line-number>]`; see docs for more)
(B) remove breakpoint (similar to adding, or `B all` to remove all)
(+) add watch expression (`+:<expr>`), (-) remove watch expression (-:<expr>)
(?) list existing watch expressions and breakpoints
(v) print variables and values, (:) evaluate expression - see `v`
```

## Test

- [Test your contracts](https://trufflesuite.com/docs/truffle/how-to/debug-test/test-your-contracts/#test-your-contracts)
- [Write Solidity tests](https://trufflesuite.com/docs/truffle/how-to/debug-test/write-tests-in-solidity/)
  - これは、solidity で test を書くパターン
  - あまり使うことはないはず
- [Write JavaScript tests](https://trufflesuite.com/docs/truffle/how-to/debug-test/write-tests-in-javascript/)

### Javascript(Typescript)での test の書き方

- `test` directory に js(ts)ファイルを入れる
- Mocha test framework ベース
- `describe()`の代わりに、`contract()`を使用する (必ずしも、というわけではない)
  - これにより、truffle の[Clean-room environment](https://trufflesuite.com/docs/truffle/how-to/debug-test/test-your-contracts/#clean-room-environment)が利用できる
  - これは、`Ganache`か`Truffle Develop`を使って test を行う場合、state を外部に共有しない。
    - Ganacheの場合、workspace毎にcleanなstateを持つ
  - `contract()`実行前に、contracts が redeploy される
  - `contract()`によって accounts が渡される
    - 外部のcontractを参照しようとした場合、以下のようなエラーがでるはず
      - `Error: ERC1400 has not been deployed to detected network (network/artifact mismatch)` 

### Ganacheの特徴
- workspace毎にcleanなstateを持つ

### solidityLog
`truffle test`にて、`console.log`が使える

```
pragma solidity >=0.4.25 <0.9.0;
import "truffle/console.sol";
```

### [web3](https://trufflesuite.com/docs/truffle/how-to/debug-test/write-tests-in-javascript/#using-web3)

- test ファイル内で、web3 インスタンスが利用可能なため、`web3.eth.getBalance`と記述するだけで利用可能

### test コマンド

```
# test with specific network
$ truffle test --debug --network test

# test with stacktrace
$ truffle test --stacktrace --network test
$ truffle test --stacktrace-extra

# test for specific file
$ truffle test --debug test/ERC1400.test.js --network test
```

## Networks

Show addresses for deployed contracts on each network

```
❯ npx truffle networks

The following networks are configured to match any network id ('*'):

    dashboard
    development
    quickstartWallet
    test

Closely inspect the deployed networks below, and use `truffle networks --clean` to remove any networks that don't match your configuration. You should not use the wildcard configuration ('*') for staging and production networks for which you intend to deploy your application.

Network: UNKNOWN (id: 5777)
  CrossSimpleModule: 0x4E009eab5A60734303A81b7d0200e6F3b6cc5215
  ERC1400ContractModule: 0x21877416CeEC7cC453fb3367F2ef488262C8ebbb
  IBCChannel: 0x1eABC6bAc7D38C564ba267D413238a1135ece19e
  IBCClient: 0x732Fe10862fa54898e0aeA49C37BC17AC45856e4
  IBCCommitment: 0x864CbE7834B79F0743f6267487505B4e54fC6d8b
  IBCConnection: 0xd6C5a2555b587Fe81dBDE28C4aF5a9084A65a49e
  IBCMsgs: 0xd973eE141e2f88B1dEa04de331a4dD401Ba4114A
  LCPClient: 0x08a145602F6922a001900e12F994E84fB2B52cb5
  Migrations: 0x24f587cc12A305Ae6aE54CF3528056F1157889B9
  MockClient: 0x633f031b6Dbba10C143F55B80100a8C11F6437f7
  OwnableIBCHandler: 0x0b91f6e4125ea096449acE720F50eF01aA1E126d
  Report: 0xfeb599b73802c615e811993F16857BC50d0bF366
  SolRsaVerify: 0xCF8D5f5E88b84C1b4a20431e72D04026efE4df62

```

異なるディレクトリ（異なる truffle-config.js)毎に、`truffle networks`コマンドによって表示される contract は異なる。

## Configuration
- [Configuration](https://trufflesuite.com/docs/truffle/reference/configuration/)
- `truffle-config.js`ファイルはprojectのrootディレクトリに置く必要がある
- network名の`test`は`truffle test`で、`develop`は`truffle develop`で使われるので注意が必要
  - 逆に`test`の設定は不要
  - `host, port, url, or provider`が設定されていない場合に限り、optionが適用される
- contract, migration, buildのディレクトリパスも設定で変更可能  

- config例
```
networks: {
  development: {
    host: "127.0.0.1",
    port: 8545,
    network_id: "*", // match any network
    websockets: true
    // optional config values:
    // gas                  - use gas and gasPrice if creating type 0 transactions
    // gasPrice             - all gas values specified in wei
    // maxFeePerGas         - use maxFeePerGas and maxPriorityFeePerGas if creating type 2 transactions (https://eips.ethereum.org/EIPS/eip-1559)
    // maxPriorityFeePerGas -
    // from - default address to use for any transaction Truffle makes during migrations
    // provider - web3 provider instance Truffle should use to talk to the Ethereum network.
    //          - function that returns a web3 provider instance (see below.)
    //          - if specified, host and port are ignored.
    // production: - set to true if you would like to force a dry run to be performed every time you migrate using this network (default: false)
    //             - during migrations Truffle performs a dry-run if you are deploying to a 'known network'
    // skipDryRun: - set to true if you don't want to test run the migration locally before the actual migration (default: false)
    // confirmations: - number of confirmations to wait between deployments (default: 0)
    // timeoutBlocks: - if a transaction is not mined, keep waiting for this number of blocks (default: 50)
    // deploymentPollingInterval: - duration between checks for completion of deployment transactions
    // networkCheckTimeout: - amount of time for Truffle to wait for a response from the node when testing the provider (in milliseconds)
    //                      - increase this number if you have a slow internet connection to avoid connection errors (default: 5000)
    // disableConfirmationListener: - set to true to disable web3's confirmation listener
  }
}