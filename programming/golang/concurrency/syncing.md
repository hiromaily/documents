# Goroutinesの同期

Goroutinesは独立して動作するため、異なるGoroutines間での同期が必要になることが多くある。これには`sync.WaitGroup`やチャネルを利用する。

## `sync.WaitGroup`を使った同期

```go
package main

import (
    "fmt"
    "sync"
)

func sayHello(wg *sync.WaitGroup) {
    defer wg.Done() // 完了通知
    fmt.Println("Hello from goroutine")
}

func main() {
    var wg sync.WaitGroup
    
    wg.Add(1) // Goroutinesの数を追加
    go sayHello(&wg)
    
    wg.Wait() // 全てのGoroutinesが完了するまで待機 (Counterが0になるまで待機)
    fmt.Println("Hello from main")
}
```

## `チャネル`を使ったコミュニケーション

```go
package main

import (
    "fmt"
)

func sayHello(ch chan string) {
    ch <- "Hello from goroutine" // チャネルにデータを送信
}

func main() {
    ch := make(chan string)
    
    go sayHello(ch)
    
    msg := <-ch // チャネルからデータを受信
    fmt.Println(msg)
    fmt.Println("Hello from main")
}
```
