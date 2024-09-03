# Version Managerment Tools

[Docs: npmエコシステムのVersion Manager](../programming/javascript-typescript/version-manager.md)

## [volta](https://github.com/volta-cli/volta)

- jsツール専用
- Rust製
- Star: 10.8k

## [asdf](https://github.com/jdx/mise)

- Shell
- Star: 21.5k

- [Official](https://asdf-vm.com/ja-jp/guide/getting-started.html)

### Golangのinstall

bugっぽいので使わないほうがいい
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

### これならbrewのほうがいい

```sh
# check current environment
which go
> /opt/homebrew/bin/go
> /opt/homebrew/bin/go -> ../Cellar/go/1.23.0/bin/go

ls -al /opt/homebrew/Cellar/go

# uninstall
brew uninstall --ignore-dependencies go

# install
brew search "go@1"
brew install go@1.21

# brew link go
# > Warning: Already linked: /opt/homebrew/Cellar/go/1.23.0

brew unlink go
brew link --force --overwrite go@1.21

brew unlink go
brew link --force --overwrite go@1.23
```

- `go@1.21`に設定してもおかしい。。。
  - `brew install go@1.21`でinstallされない？
  - install先が、`/opt/homebrew/Cellar/go`ではなく、`/opt/homebrew/Cellar/go@1.21`

```sh
> go env
GOBIN='/opt/homebrew/Cellar/go/1.23.0/bin'
GOPATH='/Users/hiroki.yasui/go'
GOROOT='/opt/homebrew/Cellar/go/1.23.0/libexec'
GOTOOLDIR='/opt/homebrew/Cellar/go/1.23.0/libexec/pkg/tool/darwin_arm64'
GOVERSION='go1.21.13'
```

### Uninstall

以下から`go`関連のファイルを全て削除

- ~/.asdf/plugins
- ~/.asdf/installs
- ~/.asdf/shims

### asdfがsymlinkとして定義されている場所

```sh
find ~/ -type l -exec ls -l {} + 2>/dev/null | grep asdf
```

## [mise](https://github.com/jdx/mise)

- Rust製
- Star: 8.9k

- [mise ではじめる開発環境構築](https://zenn.dev/takamura/articles/dev-started-with-mise)

## [Nix](https://github.com/NixOS/nix)

- C++製
- Star: 12k
