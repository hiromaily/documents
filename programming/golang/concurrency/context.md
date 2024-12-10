# context.Context

複数のGoroutinesを管理する場合、リソースを適切に管理し、不要なGoroutinesをキャンセルすることが重要。これには`context`パッケージを利用する。

## context.WithCancel()

```go
package main

import (
    "context"
    "fmt"
    "time"
)

func sayHello(ctx context.Context) {
    select {
    case <-ctx.Done():
        fmt.Println("Goroutine cancelled")
        return
    case <-time.After(2 * time.Second):
        fmt.Println("Hello from goroutine")
    }
}

func main() {
    ctx, cancel := context.WithCancel(context.Background())
    
    go sayHello(ctx)
    
    time.Sleep(1 * time.Second)
    cancel() // Goroutinesをキャンセル。`ctx.Done()`チャネルがクローズされる

    time.Sleep(2 * time.Second) // 少し待機してGoroutinesの完了を確認
    fmt.Println("Hello from main")
}
```

 `cancel()`実行後は、`ctx.Done()`チャネルがクローズされる
