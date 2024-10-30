# Version Managerment Tools

- [Docs: npm エコシステムの Version Manager](../programming/javascript-typescript/version-manager.md)
- [awesome-version-managers](https://github.com/bernardoduarte/awesome-version-managers)

## [volta](https://github.com/volta-cli/volta)

- js ツール専用
- Rust 製
- Star: 10.8k

## [asdf](https://github.com/asdf-vm/asdf)

- Shell
- Star: 21.5k

- [Official](https://asdf-vm.com/ja-jp/guide/getting-started.html)

### Golang の `asdf`での install

```sh
which go
> /opt/homebrew/bin/go

asdf plugin add golang
asdf list all golang

asdf install golang 1.23.0
asdf global golang 1.23.0
exec zsh -l

which go
> ${HOME}/.asdf/shims/go
```

- go env を調べると、設定がおかしい
- bug っぽいので Go のバージョン管理に`asdf`は使わないほうがいい

### `asdf`で install した`go`の Uninstall

以下から`go`関連のファイルを全て削除

- ~/.asdf/plugins
- ~/.asdf/installs
- ~/.asdf/shims

### asdf が symlink として定義されている場所

```sh
find ~/ -type l -exec ls -l {} + 2>/dev/null | grep asdf
```

## [mise](https://github.com/jdx/mise)

- Rust 製
- Star: 8.9k

- [mise ではじめる開発環境構築](https://zenn.dev/takamura/articles/dev-started-with-mise)

## [Nix](https://github.com/NixOS/nix)

- C++製
- Star: 12k
