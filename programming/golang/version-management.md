# Golang version management

## [Managing Go installations](https://go.dev/doc/manage-install)

- [download できる Go の version](https://go.dev/dl/)

### Installing multiple Go versions

複数の Go バージョンでコードをテストしたい場合など、同じマシンに複数の Go バージョンをインストールできる。ただし、`git`が必要になる。
追加の Go バージョンをインストールするには、インストールするバージョンのダウンロード場所を指定して、`go install` コマンドを実行する。

```sh
go install golang.org/dl/go1.21.13@latest
go1.21.13 download

# installしたgoコマンドは、バージョンまで指定して実行する
go1.21.13 version
```

## brew による install

- 状態を調べる

```sh
# check current environment
which go
> /opt/homebrew/bin/go

ll /opt/homebrew/bin/go
> /opt/homebrew/bin/go -> ../Cellar/go/1.22.4/bin/go

ls -al /opt/homebrew/Cellar/go
> 1.22.4
```

- uninstall, install, symlink

```sh
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

### 問題点

- `go@1.21`に設定してもおかしい。。。

  - `brew install go@1.21`で install されない？
  - install 先が、`/opt/homebrew/Cellar/go`ではなく、`/opt/homebrew/Cellar/go@1.21`になる (仕様)

- 環境変数の設定に矛盾がある

```sh
> go env
GOBIN='/opt/homebrew/Cellar/go/1.23.0/bin'
GOPATH='/Users/hiroki.yasui/go'
GOROOT='/opt/homebrew/Cellar/go/1.23.0/libexec'
GOTOOLDIR='/opt/homebrew/Cellar/go/1.23.0/libexec/pkg/tool/darwin_arm64'
GOVERSION='go1.21.13'
```
