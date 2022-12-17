# YUI Relayer
- [yui-relayer](https://github.com/hyperledger-labs/yui-relayer)

## 対応Chain
- Cosmos/Tendermint with [ibc-go](https://github.com/cosmos/ibc-go)
- EVM chains with [ibc-solidity](https://github.com/hyperledger-labs/yui-ibc-solidity)
- Hyperledger Fabric with [fabric-ibc](https://github.com/hyperledger-labs/yui-fabric-ibc)
- Corda with [corda-ibc](https://github.com/hyperledger-labs/yui-corda-ibc)

## 用語集
- Chain ... チェーンへのトランザクションの送信とその状態の問い合わせをサポートする
- Prover ... ターゲットチェーンの状態に関する証明を生成または照会する。この証明は、相手側のチェーンに配置されたOn-chain Light Clientによって検証される。
- ProvableChain ... ChainとProverから構成される
- Path ... パケットを中継する2つのProvableChainのパス
- ChainConfig ... Chainを生成するための設定
- ProverConfig ... Prover を生成するための設定

## Commands
### Sub Commands
```

Usage:
  yrly [command]

Available Commands:
  config      manage configuration file
  chains      manage chain configurations
  tx          IBC Transaction Commands
  paths       manage path configurations
  query       IBC Query Commands
  modules     show an info about Relayer Module
  service     Relay Service Commands

  tendermint  manage tendermint configurations
  help        Help about any command
  completion  Generate the autocompletion script for the specified shell

Flags:
  -d, --debug         debug output
  -h, --help          help for yrly
      --home string   set home directory (default "/Users/hiroki.yasui/.yui-relayer")
```
### Config Sub Commands
```
manage configuration file

Usage:
  yrly config [command]

Aliases:
  config, cfg

Available Commands:
  show        Prints current configuration
  init        Creates a default home directory at path defined by --home
```

### Chains Sub Commands
```
manage chain configurations

Usage:
  yrly chains [command]

Available Commands:
  add-dir     Add new chains to the configuration file from a directory
		full of chain configuration, useful for adding testnet configurations
```

### Tx Sub Commands
```
Commands to create IBC transactions on configured chains.
		Most of these commands take a '[path]' argument. Make sure:
	1. Chains are properly configured to relay over by using the 'rly chains list' command
	2. Path is properly configured to relay over by using the 'rly paths list' command

Usage:
  yrly tx [command]

Available Commands:
  transfer               Initiate a transfer from one chain to another
  relay                  relay any packets that remain to be relayed on a given path, in both directions
  relay-acknowledgements relay any acknowledgements that remain to be relayed on a given path, in both directions

  clients                create a clients between two configured chains with a configured path
  update-clients         update the clients between two configured chains with a configured path
  connection             create a connection between two configured chains with a configured path
  channel                create a channel between two configured chains with a configured path
```

### Paths Sub Commands
```
A path represents the "full path" or "link" for communication between two chains. This includes the client,
connection, and channel ids from both the source and destination chains as well as the strategy to use when relaying

Usage:
  yrly paths [command]

Aliases:
  paths, pth

Available Commands:
  list        print out configured paths
  add         add a path to the list of paths
```

### Query Sub Commands
```
Commands to query IBC primitives, and other useful data on configured chains.

Usage:
  yrly query [command]

Available Commands:
  balance                    Query the account balances
  unrelayed-packets          Query for the packet sequence numbers that remain to be relayed on a given path
  unrelayed-acknowledgements Query for the packet sequence numbers that remain to be relayed on a given path

  client                     Query the state of a client in a given path
  connection                 Query the connection state for the given connection id
  channel                    Query the connection state for the given connection id
```

### Modules Sub Commands
```
show an info about Relayer Module

Usage:
  yrly modules [command]

Available Commands:
  show        Shows a list of modules included in the relayer
```

### Service Sub Commands
```
Commands to manage the relay service

Usage:
  yrly service [command]

Available Commands:
  start
```

### Tendermint Sub Commands
```
manage tendermint configurations

Usage:
  yrly tendermint [command]

Available Commands:
  config      manage configuration file
  keys        manage keys held by the relayer for each chain
  light       manage light clients held by the relayer for each chain
```

## Relayの確認方法
- [test-tx](https://github.com/hyperledger-labs/yui-relayer/blob/main/tests/cases/tm2tm/scripts/test-tx)

```
# transfer tx 
${RLY} tx transfer ibc01 ibc0 ibc1 100samoleans ${TM_ADDRESS1}
# relay packet
${RLY} tx relay ibc01
# relay acks
${RLY} tx acks ibc01
```

## Relayの挙動について