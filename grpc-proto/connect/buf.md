# buf　CLI

gRPC開発におけるProtocol Bufferファイルの管理と操作を簡素化するツールで、linter, formatter, builderとなんでもできるprotoファイルを取り扱うユーティリティー。

## 特徴

- コード生成
- Linter, Format機能
- 破壊的変更の検出
- 依存関係の管理

## Install

```sh
brew install bufbuild/buf/buf
```

## Help

```sh
> buf --help
The Buf CLI

A tool for working with Protocol Buffers and managing resources on the Buf Schema Registry (BSR)

Usage:
  buf [flags]
  buf [command]

Available Commands:
  beta        Beta commands. Unstable and likely to change
  breaking    Verify no breaking changes have been made
  build       Build Protobuf files into a Buf image
  completion  Generate auto-completion scripts for commonly used shells
  config      Work with configuration files
  convert     Convert a message between binary, text, or JSON
  curl        Invoke an RPC endpoint, a la 'cURL'
  dep         Work with dependencies
  export      Export proto files from one location to another
  format      Format Protobuf files
  generate    Generate code with protoc plugins
  help        Help about any command
  lint        Run linting on Protobuf files
  ls-files    List Protobuf files
  plugin      Work with check plugins
  push        Push to a registry
  registry    Manage assets on the Buf Schema Registry

Flags:
      --debug               Turn on debug logging
  -h, --help                help for buf
      --help-tree           Print the entire sub-command tree
      --log-format string   The log format [text,color,json] (default "color")
      --timeout duration    The duration until timing out, setting it to zero means no timeout (default 2m0s)
      --version             Print the version

Use "buf [command] --help" for more information about a command.
```

## Reference

- [Buf CLI](https://buf.build/product/cli)
- [github](https://github.com/bufbuild/buf)
