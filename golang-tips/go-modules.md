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

monorepo など、複数の module で構成されたプロジェクトなどで、local のファイルを参照したい場合など、

```
# e.g.
replace golang.org/x/tools => ../../tools
```

## go module の versioning

1. バージョニングしていないパッケージを取得
   - このとき、main ブランチから取得される

```
cd go-crypto-wallet
go get -u github.com/hiromaily/ripple-lib-proto

# go.mod
require github.com/hiromaily/ripple-lib-proto v0.0.0-20200615012248-6990db627c3d
```

2. パッケージをバージョニングするには、タグを用意する必要がある。

```
cd ripple-lib-proto
git tag -a v1.0.0 -m "Version 1.0.0"
git push --tags
```

3. 再度、パッケージを取得してみる
   - パッケージにバージョンが指定される

```
cd go-crypto-wallet
go get -u github.com/hiromaily/ripple-lib-proto

# go.mod
require github.com/hiromaily/ripple-lib-proto v1.0.0
```

4. パッケージのマイナーバージョンをアップグレードしてみる

```
cd ripple-lib-proto
git tag -a v1.1.0 -m "Version 1.1.0"
git push --tags
```

5. 再度、パッケージを取得してみる

```
cd go-crypto-wallet
go clean --modcache
go get -u github.com/hiromaily/ripple-lib-proto

# go.mod
require github.com/hiromaily/ripple-lib-proto v1.0.0
=> 予想外にもキャッシュを消しても、バージョンは`v1.1.0`に上がらなかった。

# 明示的にバージョンを指定して取得することでうまくいった
go get -u github.com/hiromaily/ripple-lib-proto@v1.1.0
```

6. パッケージのメジャーバージョンをアップグレードしてみる

```
cd ripple-lib-proto
git tag -a v2.0.0 -m "Version 2.0.0"
git push --tags
```

7. 再度、パッケージを取得してみる
   - メジャーバージョンは `go get -u` ではアップグレードされない

```
cd go-crypto-wallet
go clean --modcache
go get -u github.com/hiromaily/ripple-lib-proto

# go.mod
require github.com/hiromaily/ripple-lib-proto v1.1.0
=> バージョンは`v2.0.0`に上がらなかった。

# 明示的にバージョンを指定して取得することでうまくいった
go get -u github.com/hiromaily/ripple-lib-proto@v2.0.0
=> errorが起きる。`go get: github.com/hiromaily/ripple-lib-proto@v2.0.0: invalid version: module contains a go.mod file, so major version must be compatible: should be v0 or v1, not v2`
```

- [参考:Go modules で依存モジュールのメジャーバージョンが v2 以上の時の対応](https://christina04.hatenablog.com/entry/go-modules-major-version)

8. go.mod 内のパッケージの module 名を以下のように修正

```
module github.com/hiromaily/ripple-lib-proto/v2
```

9. 再度、パッケージを取得してみる

```
cd go-crypto-wallet
go get -u github.com/hiromaily/ripple-lib-proto/v2
```

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
