# Go Modules

- [Go Modules Reference](https://go.dev/ref/mod)
- [Tutorial: Create a Go module](https://go.dev/doc/tutorial/create-module)
- [Developing and publishing modules](https://go.dev/doc/modules/developing)
- [Module release and versioning workflow](https://go.dev/doc/modules/release-workflow)
- [Managing module source](https://go.dev/doc/modules/managing-source)
- [Developing a major version update](https://go.dev/doc/modules/major-version)
- [Publishing a module](https://go.dev/doc/modules/publishing)
- [Module version numbering](https://go.dev/doc/modules/version-numbers)
- [Using Go Modules](https://go.dev/blog/using-go-modules)

## About help

```sh
$ go mod help                                                                                                                                                           (git)-[main]
Go mod provides access to operations on modules.

Note that support for modules is built into all the go commands,
not just 'go mod'. For example, day-to-day adding, removing, upgrading,
and downgrading of dependencies should be done using 'go get'.
See 'go help modules' for an overview of module functionality.

Usage:

 go mod <command> [arguments]

The commands are:

 download    download modules to local cache
 edit        edit go.mod from tools or scripts
 graph       print module requirement graph
 init        initialize new module in current directory
 tidy        add missing and remove unused modules
 vendor      make vendored copy of dependencies
 verify      verify dependencies have expected content
 why         explain why packages or modules are needed
```

### `go mod download`について

- `-x`オプションは、downloadによって実行したコマンドを出力する

```sh
> go help mod download
usage: go mod download [-x] [-json] [-reuse=old.json] [modules]

Download downloads the named modules, which can be module patterns selecting
dependencies of the main module or module queries of the form path@version.

With no arguments, download applies to the modules needed to build and test
the packages in the main module: the modules explicitly required by the main
module if it is at 'go 1.17' or higher, or all transitively-required modules
if at 'go 1.16' or lower.

The go command will automatically download modules as needed during ordinary
execution. The "go mod download" command is useful mainly for pre-filling
the local cache or to compute the answers for a Go module proxy.

By default, download writes nothing to standard output. It may print progress
messages and errors to standard error.

The -json flag causes download to print a sequence of JSON objects
to standard output, describing each downloaded module (or failure),
corresponding to this Go struct:

    type Module struct {
        Path     string // module path
        Query    string // version query corresponding to this version
        Version  string // module version
        Error    string // error loading module
        Info     string // absolute path to cached .info file
        GoMod    string // absolute path to cached .mod file
        Zip      string // absolute path to cached .zip file
        Dir      string // absolute path to cached source root directory
        Sum      string // checksum for path, version (as in go.sum)
        GoModSum string // checksum for go.mod (as in go.sum)
        Origin   any    // provenance of module
        Reuse    bool   // reuse of old module info is safe
    }

The -reuse flag accepts the name of file containing the JSON output of a
previous 'go mod download -json' invocation. The go command may use this
file to determine that a module is unchanged since the previous invocation
and avoid redownloading it. Modules that are not redownloaded will be marked
in the new output by setting the Reuse field to true. Normally the module
cache provides this kind of reuse automatically; the -reuse flag can be
useful on systems that do not preserve the module cache.

The -x flag causes download to print the commands download executes.

See https://golang.org/ref/mod#go-mod-download for more about 'go mod download'.
```

## 同一プロジェクト内のpackageのimportについて

```txt
project
  cmd
    app1
      main.go
    app2
      main.go
  pkg
    package1
      something.go
    package2
      something.go
```

```go

import (
 "project/pkg/logger"
    // or
 "github.com/org/project/pkg/logger"
)
```

### Pattern 1: Relative import

```go
import (
 "batch/pkg/logger"
)
```

- go mod

```mod
module batch
```

#### メリットがあるケース

- ローカル開発
  - このパターンは、プロジェクトがまだリモートリポジトリにない場合や、完全修飾パスにこだわらない場合に、ローカル開発で特に便利
- 内部プロジェクト
  - プロジェクトが公開されたり、GitHubのようなリモート・リポジトリでホストされたりしないことがわかっている場合
- 単純化
  - ローカル開発時のインポートパスを単純化できる

#### デメリット

このパターンは、インポートパスを完全修飾インポートパスに従うように変更する必要があるため、リモートリポジトリにコードを移動したときに問題につながる可能性がある。

### Pattern 2: Fully Qualified Import

```go
import (
 "github.com/org/project/pkg/logger"
)

- go mod

```mod
module github.com/org/project
```

#### メリット

- ベストプラクティス
  - これは一般的にベストプラクティスと考えられており、特にバージョン管理システムやリモートリポジトリを使用する場合、コードベースの管理が容易になる。
- リモート・リポジトリ
  - プロジェクトがリモート リポジトリ（GitHub など）でホストされている場合は、完全修飾インポート パスを使用するのが一般的
  - これにより、Go モジュールと Go ツールが依存関係を正しく解決してダウンロードできるようになる
- 一貫性
  - リモート リポジトリにコードをプッシュするときに変更する必要のない一貫したインポート パスを提供する
- チームコラボレーション
  - 全員が同じインポートパスを使用するため、チームでの共同作業が容易になる

## go moduleによるbinary toolの管理

例えば、`golangci-lint`を使っていて、おsれを`go.mod`で管理したいケース。

```sh
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.60.3
```

### go.modによるtool管理方法

```go
// tools.go
// +build tools

package tools

import (
    _ "github.com/golangci/golangci-lint/cmd/golangci-lint"
)
```

- go.modの更新-

```sh
go mod tidy
```

- linterの実行

```sh
go run github.com/golangci/golangci-lint/cmd/golangci-lint run
```

## require ディレクティブ内の、パッケージのバージョン指定について

- 通常のバージョン指定

```mod
github.com/friendsofgo/errors v0.9.2
```

- そのパッケージは tag で管理されておらず、`疑似バージョン`となる
  - 疑似バージョン：リビジョン識別子（Git コミットハッシュなど）とバージョン管理システムからのタイムスタンプをエンコードするバージョン

```mod
github.com/hiromaily/ripple-lib-proto v0.0.0-20200615012248-6990db627c3d
```

- `// indirect` .... 直接依存しているモジュールではないことを意味する

```mod
github.com/go-stack/stack v1.8.1 // indirect
```

- `+incompatible`
  - このタグが最新のタグだが、commit は進んでいる状況

```mod
github.com/uber/jaeger-client-go v2.30.0+incompatible
```

## 依存関係の取得

```sh
go get ./...

go mod download
```

## module 作成

```sh
go mod init [module name]
# e.g.
go mod init github.com/hiromaily/documents
```

- go mod 内の`module`に定義されたパスによって、他の go のコードが参照可能になる。

## go ディレクティブの更新

```sh
go mod tidy -go=1.17
```

## 依存関係の表示

```sh
go mod graph

# 特定のパッケージの依存関係を調べる
go mod graph | grep github.com/Shopify/sarama
```

## replace ディレクティブ

- VCS (GitHub など) にある別のモジュールや、ローカルファイルシステム上の相対ファイルパスや絶対ファイルパスを指定して、別のインポートパスを指定することができる
- replace ディレクティブによる新しいインポートパスは、実際のソースコードでインポートパスを更新する必要なく使用される
  - monorepo など、複数の module で構成されたプロジェクトなどで、local のファイルを参照したい場合など、
  - fork された repository を使う場合、向き先を fork 先の名前に差し替えるなど

```mod
# e.g.
replace golang.org/x/tools => ../../tools
```

### forked repository の参照

例えば、[quorum](https://github.com/ConsenSys/quorum)は[go-ethereum](https://github.com/ethereum/go-ethereum)の fork で、
`quorum`の内部は、go.mod の module 名から、import パスまで、`go-ethereum`のまあ  
この fork された`quorum`を他のプロジェクトから import したい場合、
go.mod 内の`replace`ディレクティブで、以下のように修正することで参照することができる

```mod
# e.g.
replace github.com/ethereum/go-ethereum => github.com/ConsenSys/quorum
```

## go module の versioning

1. バージョニングしていないパッケージを取得
   - このとき、main ブランチから取得される
2. パッケージをバージョニングするには、参照側でタグを用意する必要がある。

- experimental branch
  - [version-test](https://github.com/hiromaily/version-test)

### 作成したパッケージのバージョニングと、その参照方法

## Cache について

```sh
# cache 先
go env | grep GOCACHE

# cache のクリア
go clean -cache

# module cache 先
go env | grep GOMODCACHE

# module cache のクリア
go clean -modcache
```

## Pprivate repository

- [How to set GOPRIVATE environment variable](https://stackoverflow.com/questions/58305567/how-to-set-goprivate-environment-variable)

add the below setting in ~/.gitconfig

```config
[url "git@github.com:private-repo-name/"]
 insteadOf = https://github.com/private-repo-name/
```

or

```config
[url "git@github.yourhost.com:"]
 insteadOf = https://github.yourhost.com/
```
