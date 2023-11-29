# Foundry

Ethereum のアプリケーション開発のための toolkit で、構成は以下の通り

- [Forge](https://github.com/foundry-rs/foundry/tree/master/forge)
  - Ethereum testing framework
- [Cast](https://github.com/foundry-rs/foundry/tree/master/cast)
  - EVM smart contracts に対して、transactions 送信や、データの取得ができる
- [Anvil](https://github.com/foundry-rs/foundry/tree/master/anvil)
  - Local の Ethereum ノード
- [Chisel](https://github.com/foundry-rs/foundry/tree/master/chisel)
  - solidity REPL

## Reference

- [github](https://github.com/foundry-rs/foundry)
- [Docs](https://book.getfoundry.sh/)

## Install

```
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### Options

```
❯ forge --help
Build, test, fuzz, debug and deploy Solidity contracts.

Usage: forge <COMMAND>

Commands:
  bind               Generate Rust bindings for smart contracts.
  build              Build the project's smart contracts. [aliases: b, compile]
  cache              Manage the Foundry cache.
  clean              Remove the build artifacts and cache directories. [aliases: cl]
  completions        Generate shell completions script. [aliases: com]
  config             Display the current config. [aliases: co]
  coverage           Generate coverage reports.
  create             Deploy a smart contract. [aliases: c]
  debug              Debugs a single smart contract as a script. [aliases: d]
  doc                Generate documentation for the project.
  flatten            Flatten a source file and all of its imports into one file. [aliases: f]
  fmt                Formats Solidity source files.
  geiger             Detects usage of unsafe cheat codes in a foundry project and its dependencies.
  generate-fig-spec  Generate Fig autocompletion spec. [aliases: fig]
  help               Print this message or the help of the given subcommand(s)
  init               Create a new Forge project.
  inspect            Get specialized information about a smart contract. [aliases: in]
  install            Install one or multiple dependencies. [aliases: i]
  remappings         Get the automatically inferred remappings for the project. [aliases: re]
  remove             Remove one or multiple dependencies. [aliases: rm]
  script             Run a smart contract as a script, building transactions that can be sent onchain.
  snapshot           Create a snapshot of each test's gas usage. [aliases: s]
  test               Run the project's tests. [aliases: t]
  tree               Display a tree visualization of the project's dependency graph. [aliases: tr]
  update             Update one or multiple dependencies. [aliases: u]
  upload-selectors   Uploads abi of given contract to https://sig.eth.samczsun.com function selector database. [aliases: up]
  verify-check       Check verification status on Etherscan. [aliases: vc]
  verify-contract    Verify smart contracts on Etherscan. [aliases: v]

Options:
  -h, --help     Print help
  -V, --version  Print version
```

## 機能

- Solidity コンパイラのバージョン自動検出とインストール (~/.svm)
- インクリメンタルコンパイルとキャッシュ：変更されたファイルのみ再コンパイル
- 並列コンパイル
- 非標準的なディレクトリ構造のサポート
- テストは Solidity で書く（DappTools と同様）
- fuzz-test を高速化
- 柔軟なデバッグロギング
  - `DsTest`の吐き出されるログを利用した`DappTools`スタイル
  - `console.sol`のコントラクトを使用した Hardhat スタイル
- Foundry GitHub アクションによる高速 CI。

## `foundry.toml`による構成

## Test

- [Test](https://book.getfoundry.sh/forge/tests)

## Forge Standard Library

Forge Standard Library is a collection of helpful contracts and libraries for use with Forge and Foundry.

- [github](https://github.com/foundry-rs/forge-std)
- [Docs: Forge Standard Library Overview](https://book.getfoundry.sh/forge/forge-std)

## 使い方の例
