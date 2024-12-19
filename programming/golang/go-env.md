# `go env`コマンドによって表示される環境変数

Goのコンパイラおよびランタイムの動作に関するさまざまな環境設定

```sh
> go env
GO111MODULE=''
GOARCH='arm64'
GOBIN=''
GOCACHE='${HOME}/Library/Caches/go-build'
GOENV='${HOME}/Library/Application Support/go/env'
GOEXE=''
GOEXPERIMENT=''
GOFLAGS=''
GOHOSTARCH='arm64'
GOHOSTOS='darwin'
GOINSECURE=''
GOMODCACHE='${HOME}/go/pkg/mod'
GONOPROXY=''
GONOSUMDB=''
GOOS='darwin'
GOPATH='${HOME}/go'
GOPRIVATE=''
GOPROXY='https://proxy.golang.org,direct'
GOROOT='/opt/homebrew/Cellar/go/1.23.3/libexec'
GOSUMDB='sum.golang.org'
GOTMPDIR=''
GOTOOLCHAIN='local'
GOTOOLDIR='/opt/homebrew/Cellar/go/1.23.3/libexec/pkg/tool/darwin_arm64'
GOVCS=''
GOVERSION='go1.23.3'
GODEBUG=''
GOTELEMETRY='local'
GOTELEMETRYDIR='${HOME}/Library/Application Support/go/telemetry'
GCCGO='gccgo'
GOARM64='v8.0'
AR='ar'
CC='cc'
CXX='c++'
CGO_ENABLED='1'
GOMOD='${HOME}/go/org/repo/go.mod'
GOWORK=''
CGO_CFLAGS='-O2 -g'
CGO_CPPFLAGS=''
CGO_CXXFLAGS='-O2 -g'
CGO_FFLAGS='-O2 -g'
CGO_LDFLAGS='-O2 -g'
PKG_CONFIG='pkg-config'
GOGCCFLAGS='-fPIC -arch arm64 -pthread -fno-caret-diagnostics -Qunused-arguments -fmessage-length=0 -ffile-prefix-map=/var/folders/lt/szvzh4d91p3122bthpd1_55h0000gp/T/go-build3355362106=/tmp/go-build -gno-record-gcc-switches -fno-common'
```

## GODEBUG

Goランタイムのデバッグ設定に関するもので、Goプログラムのランタイム挙動を制御するためのデバッグオプション。通常は環境変数として設定され、特定のデバッグオプションやトレース情報を有効にするのに使う。

- allocfreetrace: メモリアロケーションと解放のトレース
- gctrace: ガベージコレクションのトレース
- schedtrace および scheddetail: スケジューラのデバッグ情報の出力

設定例

```sh
GODEBUG=gctrace=1,schedtrace=1000
```
