# Race Condition 競合状態

Go言語におけるRace Conditionは、複数のGoroutineが競合して共有データにアクセス・操作する際に発生する問題。これは、実行結果がアクセス順序やタイミングに依存するために、一貫性のない結果や予期しない動作を引き起こす可能性がある。

## Race Conditionの検知

レースコンディションを検出するための組み込みツール`race detector`が用意されており、以下のように`go run`や`go test`コマンドに`-race`オプションを付けることで使用できる。

```sh
go run -race main.go
```

```sh
go test -race -v -run TestGetMessageContents github.com/org/repo/pkg/race -count=1

WARNING: DATA RACE
Write at 0x00c000188160 by goroutine 13:
  runtime.recvDirect()
      /opt/homebrew/Cellar/go/1.23.3/libexec/src/runtime/chan.go:388 +0x7c

Previous read at 0x00c000188160 by goroutine 2765:
  runtime.chansend1()
      /opt/homebrew/Cellar/go/1.23.3/libexec/src/runtime/chan.go:157 +0x2c

Goroutine 13 (running) created at:

Goroutine 2765 (finished) created at:
==================
panic: send on closed channel
```

上記の例では、`panic: send on closed channel` 閉じられたチャネルを使って送信しようとした場合に起きるエラー

### `-race`オプション利用時の、注意点

- `-race`オプションをつけると、実行コストがあがるため、testでは実行時間が増加する点に注意
- 稀に`ld: warning`が発生する。Macの場合、XCodeのlinkerの問題によって発生している
  - [cmd/link: issues with Apple's new linker in Xcode 15 beta](https://github.com/golang/go/issues/61229)
  - [go test --race causes linker warning: undefined symbols to start](https://github.com/golang/go/issues/65940)
  - 解決策は、goコマンド実行時に、`CGO_ENABLED=0`をつけて実行することで解決する。 `CGO_ENABLED=0 go test -race -v ./...`

#### Go実行時における `ld: warning`の意味

Goのコンパイルまたはリンクプロセス中に何かが失敗したことを示している。具体的には、ld（リンカ）がいくつかの未定義のシンボルまたは不正なバイナリ形式を検出している。この問題は、コンパイラやリンカ、または使用されているライブラリまたは依存関係のいずれかにバグがある場合に発生する可能性がある。

## Race Conditionの防止

共有データへのアクセスを同期する必要がある

### 1. Mutexを使用

`sync.Mutex`を使用して、クリティカルセクションを排他制御する

```go
package main

import (
    "fmt"
    "sync"
    "time"
)

func main() {
    var counter int
    var mu sync.Mutex

    for i := 0; i < 1000; i++ {
        go func() {
            mu.Lock()
            counter++
            mu.Unlock()
        }()
    }

    // Wait for a while to let all goroutines complete
    time.Sleep(1 * time.Second)
    fmt.Println(counter) // This should reliably print 1000
}
```

### 2. Channelを使用

Goのchannelを使ってゴルーチン間の通信と同期を管理することもできる。

```go
package main

import (
    "fmt"
    "time"
)

func main() {
    counter := make(chan int)
    done := make(chan bool)

    go func() {
        sum := 0
        for i := 0; i < 1000; i++ {
            sum += <-counter
        }
        fmt.Println(sum) // This should reliably print 1000
        done <- true
    }()

    for i := 0; i < 1000; i++ {
        go func() {
            counter <- 1
        }()
    }

    // Wait for a while to let all goroutines complete
    <-done
}
```

## References

- [Goでの並行処理を徹底解剖！](https://zenn.dev/hsaki/books/golang-concurrency)
- [Understanding and Resolving Race Conditions in Golang Applications](https://thinhdanggroup.github.io/golang-race-conditions/)
- [Go言語でdata raceが起きるときに起きる（かもしれない）こと](https://zenn.dev/nobishii/articles/go-data-corruptions)
- [終了したことを他の複数のゴルーチンに伝えるのにチャネルのcloseを使う #golang](https://qiita.com/tenntenn/items/dd6041d630af7feeec52)
- [Goでスレッド（goroutine）セーフなプログラムを書くために必ず注意しなければいけない点](https://qiita.com/ruiu/items/54f0dbdec0d48082a5b1)
