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

```
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

## require ディレクティブ内の、パッケージのバージョン指定について

- 通常のバージョン指定

```
github.com/friendsofgo/errors v0.9.2
```

- そのパッケージは tag で管理されておらず、`疑似バージョン`となる
  - 疑似バージョン：リビジョン識別子（Git コミットハッシュなど）とバージョン管理システムからのタイムスタンプをエンコードするバージョン

```
github.com/hiromaily/ripple-lib-proto v0.0.0-20200615012248-6990db627c3d
```

- `// indirect` .... 直接依存しているモジュールではないことを意味する

```
github.com/go-stack/stack v1.8.1 // indirect
```

- `+incompatible`
  - このタグが最新のタグだが、commit は進んでいる状況

```
github.com/uber/jaeger-client-go v2.30.0+incompatible
```

## 依存関係の取得

```
go get ./...
```

## module 作成

```
go mod init [module name]
# e.g.
go mod init github.com/hiromaily/documents
```

- go mod 内の`module`に定義されたパスによって、他の go のコードが参照可能になる。

## go ディレクティブの更新

```
go mod tidy -go=1.17
```

## 依存関係の表示

```
go mod graph

# 特定のパッケージの依存関係を調べる
go mod graph | grep github.com/Shopify/sarama
```

## replace ディレクティブ
- VCS (GitHub など) にある別のモジュールや、ローカルファイルシステム上の相対ファイルパスや絶対ファイルパスを指定して、別のインポートパスを指定することができる
- replaceディレクティブによる新しいインポートパスは、実際のソースコードでインポートパスを更新する必要なく使用される
  - monorepo など、複数の module で構成されたプロジェクトなどで、local のファイルを参照したい場合など、
  - forkされたrepositoryを使う場合、向き先をfork先の名前に差し替えるなど

```
# e.g.
replace golang.org/x/tools => ../../tools
```

### forked repositoryの参照
例えば、[quorum](https://github.com/ConsenSys/quorum)は[go-ethereum](https://github.com/ethereum/go-ethereum)のforkで、
`quorum`の内部は、go.modのmodule名から、importパスまで、`go-ethereum`のまあ  
このforkされた`quorum`を他のプロジェクトからimportしたい場合、
go.mod内の`replace`ディレクティブで、以下のように修正することで参照することができる
```
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

```

# cache 先

go env | grep GOCACHE

# cache のクリア

go clean -cache

# module cache 先

go env | grep GOMODCACHE

# module cache のクリア

go clean -modcache

```

```

```
