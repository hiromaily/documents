# 並列処理におけるデザインパターン

並列処理は、プログラムの実行速度を向上させるために多くの場合に利用される。Golangには並列処理を行うための主要なツールとして`goroutine`と`channel`が用意されている。

以下のデザインパターンを活用することで、Golangを使った並列処理の効率と可読性を向上させることができる。

## 1. Worker Pool Pattern

Worker Pool Patternは、固定数のワーカ（ゴルーチン）がタスクを処理するパターン。これにより、タスクの処理速度を向上させつつ、リソースの使用を制御する。

```go
package main

import (
  "fmt"
  "sync"
  "time"
)

const numWorkers = 3
const numTasks = 10

func worker(id int, workQueue chan int, wg *sync.WaitGroup) {
    defer wg.Done()
    for task := range workQueue {
        fmt.Printf("Worker %d processing task %d\n", id, task)
        time.Sleep(time.Second) // simulating work
    }
}

func main() {
    workQueue := make(chan int, numTasks)
    var wg sync.WaitGroup

    // Start workers
    for i := 1; i <= numWorkers; i++ {
        wg.Add(1)
        go worker(i, workQueue, &wg)
    }

    // Send tasks to work queue
    for i := 1; i <= numTasks; i++ {
        workQueue <- i
    }
    close(workQueue)

    // Wait for all workers to finish
    wg.Wait()
    fmt.Println("All tasks completed.")
}
```

## 2. Fan-Out/Fan-In Pattern

Fan-Out/Fan-Inは複数のゴルーチンで並行して作業を行い、結果を集約するパターン。

```go
package main

import (
  "fmt"
  "sync"
  "time"
)

func worker(taskID int, results chan<- int, wg *sync.WaitGroup) {
    defer wg.Done()
    time.Sleep(time.Second) // Simulate work
    results <- taskID * 2   // Return some result
}

func main() {
    numTasks := 10
    results := make(chan int, numTasks)
    var wg sync.WaitGroup

    // Fan-Out: Start multiple goroutines
    for i := 1; i <= numTasks; i++ {
        wg.Add(1)
        go worker(i, results, &wg)
    }

    // Fan-In: Collect results
    go func() {
        wg.Wait()
        close(results)
    }()

    // Print results
    for result := range results {
        fmt.Printf("Result: %d\n", result)
    }

    fmt.Println("All tasks completed.")
}
```

## 3. Pipeline Pattern

Pipeline Patternは、一連のステージを持つ処理チェーンで各ステージがゴルーチンとして動作するパターン。

```go
package main

import (
  "fmt"
  "time"
)

func stage1(input <-chan int) <-chan int {
    output := make(chan int)
    go func() {
        defer close(output)
        for i := range input {
            output <- i * 2
        }
    }()
    return output
}

func stage2(input <-chan int) <-chan int {
    output := make(chan int)
    go func() {
        defer close(output)
        for i := range input {
            output <- i + 1
        }
    }()
    return output
}

func stage3(input <-chan int) <-chan int {
    output := make(chan int)
    go func() {
        defer close(output)
        for i := range input {
            output <- i * 3
        }
    }()
    return output
}

func main() {
    source := make(chan int)
    go func() {
        defer close(source)
        for i := 1; i <= 5; i++ {
            source <- i
        }
    }()

    p1 := stage1(source)
    p2 := stage2(p1)
    result := stage3(p2)

    for res := range result {
        fmt.Printf("Result: %d\n", res)
    }

    fmt.Println("Pipeline completed.")
}
```
