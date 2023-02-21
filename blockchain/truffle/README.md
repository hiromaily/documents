# truffle

- [Docs](https://trufflesuite.com/)

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

### testやmigration時に読み込む `artifacts.require` について
[truffle: artifacts.require()](https://trufflesuite.com/docs/truffle/how-to/contracts/run-migrations/#artifactsrequire)

- Truffle に `artifacts.require()` メソッドで対話したいコントラクトを教える。これによってコントラクトの抽象化を返す。
- 指定する名前は、そのソース・ファイル内のコントラクト定義の名前と一致する必要がある。
- ファイルには複数のコントラクトを含めることができるため、ソース ファイル名は渡してはならない。
- Documentsには、ただ`コントラクト名`を渡すだけでよい、とある
- [FIXME] ターゲットは`solファイル`であって、compileによって生成されるartifactsではない？
- これによって自動的に読み込まれるパスは、
  - contracts
  - test
  - node_modules
- ファイルパスが正しくない場合、`Could not find artifacts`エラーが出る
- こちらのissue: [Allow artifacts loading from outside contracts and test folders](https://github.com/trufflesuite/truffle/issues/3436)がまだOpenなので、これらのディレクトリ外のコントラクトは読み込めないのかもしれない。

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
- このdebugサブコマンドを実行する環境には、ソースコードも必要となる。

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
  - これは、solidityでtestを書くパターン
  - あまり使うことはないはず
- [Write JavaScript tests](https://trufflesuite.com/docs/truffle/how-to/debug-test/write-tests-in-javascript/)


### Javascript(Typescript)でのtestの書き方
- `test` directoryにjs(ts)ファイルを入れる 
- Mocha test frameworkベース
- `describe()`の代わりに、`contract()`を使用する (必ずしも、というわけではない)
  - これにより、truffleの[Clean-room environment](https://trufflesuite.com/docs/truffle/how-to/debug-test/test-your-contracts/#clean-room-environment)が利用できる
  - これは、`Ganache`か`Truffle Develop`を使ってtestを行う場合、stateを外部に共有しない。
  - `contract()`実行前に、contractsがredeployされる
    - [FIXME] これは、おそらく別途deployが必要な外部のcontractを利用したい場合、contract()の利用を止める必要がある
    - `Error: ERC1400 has not been deployed to detected network (network/artifact mismatch)` といったエラーがでるのは、おそらく上記に起因いしているはず
  - `contract()`によってaccountsが渡される

### [web3](https://trufflesuite.com/docs/truffle/how-to/debug-test/write-tests-in-javascript/#using-web3)
- testファイル内で、web3インスタンスが利用可能なため、`web3.eth.getBalance`と記述するだけで利用可能

### コマンド
```
# test with specific network
$ truffle test --debug --network test

# test with stacktrace
$ truffle test --stacktrace --network test
$ truffle test --stacktrace-extra

# test for specific file
$ truffle test --debug test/ERC1400.test.js --network test
```
