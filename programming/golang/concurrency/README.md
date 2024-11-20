# Concurrency

- [内部Docs: 並行処理](../../../architecture/concurrency/README.md)
- [Sample Code: go-concurrency](https://github.com/hiromaily/go-concurrency)

## Go 言語による並行処理 要約

### 1. 並行処理入門

- 並行性: 通常 1 つ以上の処理が同時に発生する処理のこと
- アムダールの法則: ある問題を並列化したプログラムで解いたときに得られる潜在的なパフォーマンスの向上をモデル化したもの
  - そのプログラムの何割を並列化できないかによって、並列化による性能向上の限界が決まる
- アプリケーションは水平にスケールできるように書くべき
- Go のランタイムは自動的に並行処理の操作を OS スレッドにマルチプレキシングする

#### なぜ並行処理が難しいのか

##### 競合状態

- 競合状態はいわゆるデータ
- ある並行処理の操作が変数を読み込もうとしているときに、ほかの並行処理の操作が副アク亭のタイミングで同じ変数に書き込みを行おうとすると発生
- 並行処理において順序は保証されない

##### アトミック性

- アトミック性があるということは、それが操作されている特定のコンテキストの中では分割不能もしくは中断不可であることを意味する
- ある操作のアトミック性は、スコープもしくはコンテキストによって変わり得る
- 様々なテクニックを使うことでアトミック性を強制できる
- コツはコードのどの部分をアトミックにするか、どの粒度でアトミックにするかを決めること

##### メモリアクセス同期

- プログラム内で共有リソースに対する排他的なアクセスが必要な場所を`クリティカルセクション`と呼ぶ
- データ競合問題の解決策の 1 つに、`クリティカルセクション間でのメモリへのアクセスを同期すること`がある
- go では、`syncMutex`の、`Lock()`と`UnLock()`を使う
- しかし、データ競合を解決しても順序は非決定的
- `メモリへの同期的アクセスをすると、パフォーマンスが悪化する`
- どうしても使う場合は、クリティカルセクションだけに留めておく

##### デッドロック・ライブロック・リソース枯渇

- デッドロック
  - すべての並行なプロセスがお互いの処理を待ち合っている状況
  - デッドロックが発生するために存在しなければならない条件 (すべて満たしたときデッドロックが発生する)
    - 相互排他
    - 条件待ち
    - 横取り不可
    - 循環待ち
- ライブロック
  - 並行操作を行っているけれど、その操作はプログラムの状態をまったく進めていない
  - これを発見することは難しい
- リソース枯渇
  - 並行プロセスが仕事をするのに必要なリソースを取得できない状況
  - リソース枯渇を見つける方法は`計測`

##### [sync.atomic](https://pkg.go.dev/sync/atomic)

- atomic な操作を提供する package

```go
var count int64
var lock sync.Mutex

// increment := func() {
//   lock.Lock()
//   defer lock.Unlock()
//   count++
//   fmt.Println("incrementing: %d\n", count)
// }

increment := func() {
  atomic.AddInt64(&count, 1)
}
```

- atomic.Value という構造体を使えば、Load と Store というメソッドによって、任意の型の読み込みと書き込みをアトミックにできる

### 2. 並行性をどうモデル化するか: CSP とは何か

#### 並行性と並列性の違い

- 平行性はコードの性質を指し、並列性は動作しているプログラムの性質を指す
- つまり、並列性はプログラムのランタイムの性質であって、コードの性質ではない

#### CSP とは何か

- CSP: Communicating Sequential Processes
- Go は CSP の原理を言語の中核として具現化している

#### これがどう約に立つのか

- ゴルーチンは問題空間を並列性の観点で考えなければならない状況から開放し、かわりにそのような問題を自然な並行性の問題として構築できるようにしてくれる
- ゴルーチンは軽量で、通常ゴルーチンの作成にかかるコストを気にする必要はない
- Go のランタイムはゴルーチンを OS スレッドへ自動的にマルチプレキシングし、そのスケジューリングもしてくれる

#### Go の並行処理における哲学

- sync パッケージでは排他制御といった基本的な同期のためのプリミティブを提供する
- Once 型と WaitGroup 型以外は、低水準ライブラリ内で利用されることを想定
- 高水準の同期はチャネルや通信によって行われたほうが良い、そして高水準の技術を使うことが推奨されている
- メモリを共有することで通信してはいけない、そのかわりに通信することでメモリを共有する

### 3. Go における並行処理の構成要素

#### ゴルーチン (goroutine)

- すべての Go のプログラムには最低 1 つのゴルーチンがある。それがメインゴルーチン
- ゴルーチンはコルーチン(coroutine)として知られる高水準の抽象化
  - コルーチンはプリエンプティブ(コンピュータ上で実行中のプログラム（タスク）を強制的に一時中断し、他をプログラムの実行に切り替えること)ではない並行処理の関数
- ゴルーチンが独特なのは、ゴルーチンが Go のランタイムと密結合していること
- Go がゴルーチンをホストするする機構は、いわゆる`M:Nスケジューラー`と呼ばれる実装になっている
  - M 個のグリーンスレッドを N 個の OS スレッドに対応させるもの
  - ゴルーチンはグリーンスレッドにスケジュールされる
- ゴルーチンは未来の任意のタイミングにスケジュールされる
- 新しく生成されたゴルーチンには数キロバイトのメモリが与えられる
- CPU のオーバーヘッドとしては関数呼び出しごとにコストの低い処理が走る
- ガベージコレクターは何かしらの理由で破棄されたゴルーチン(例えばブロックした状態になっているものなど)を回収するようなことは何もしない
  - このゴルーチンはプロセスが終了するまで存在し続ける
- コンテキストスイッチ
  - 並行プロセスをホストしているものが別の並行プロセスに切り替えるために状態を保存しなければならないときに起こるもの
  - go ではほとんど時間がかからない
- `make(chan struct{})`は channel によく使われるが、`struct{}`は空構造体とよばれるもので、メモリを消費しない

#### sync パッケージ

- 低水準のメモリアクセス同期に便利な並行処理のプリミティブ
- 小さなスコープでのみ使用する

##### WaitGroup

- 処理の完了を待つ手段として有効
- Wait()を呼び出すとカンターがゼロになるまでブロックする
- Add()の呼び出しはできるかぎり監視対象のゴルーチンの直前に書くというのが慣習

```go
var wg sync.WaitGroup

wg.Add(1)
go func() {
  defer wg.Done()
  //something
}
wg.Add(1)
go func() {
  defer wg.Done()
  //something
}
wg.Wait()
```

##### Mutex と RWMutex

- Mutex は相互排他を表す英語の`mutual exclusion`の略
- Mutex は並行処理で共有リソースに対する排他的アクセスを提供する
- クリティカルセクションの範囲を減らす必要がある
- `Mutex`は`Lock`のみ
  - Mutex を Lock()している間、他の goroutine は Mutex を Lock()できない
- `RWMutex`の場合、`RLock`があり、これは複数の読み込みを許可するもので、RLock() 同士はブロックしない。解除時は`RUnlock`

```go
var count int
var lock sync.Mutex

increment := func() {
  lock.Lock()
  defer lock.Unlock()
  count++
}
```

##### Cond

- Cond は「条件」の略で、goroutine 間の調整を行うためのもの
- 条件変数を管理するためのプリミティブのひとつ
- 条件変数は、あるゴルーチンから別のゴルーチンへの状態変化を知らせるために使われる
- `Signal`はシグナルを一番長く待っているゴルーチンを見つけてそのゴルーチンにシグナルを伝える
- `Broadcast`

```go
package main

import (
    "fmt"
    "sync"
    "time"
)

var (
    mu       sync.Mutex
    condVar  = sync.NewCond(&mu)
    resource string // 状態変数
)

func producer() {
    mu.Lock()
    resource = "data"
    fmt.Println("Producer: produced data")
    condVar.Signal() // 条件を待っているgoroutineに状態変化が起きたことを通知する
    mu.Unlock()
}

func consumer() {
    mu.Lock() // Wait()が自動的にUnlockを呼び出すために、事前に必要
    for resource == "" {
        condVar.Wait() // ブロックと同時にこのゴルーチンを一時停止する
    }
    fmt.Println("Consumer: consumed", resource)
    resource = ""
    mu.Unlock() // Wait()の呼び出しが終わると、Lockを呼び出すため、必要となる
}

func main() {
    go consumer()
    time.Sleep(1 * time.Second) // give consumer a chance to start

    go producer()
    time.Sleep(1 * time.Second) // wait for producer and consumer to finish

    fmt.Println("Done")
}
// Producer: produced data
// Consumer: consumed data
// Done
```

##### Once

- `Once.Do()`が呼ばれる回数に関係なく、渡された function は一度しか実行されない
- Do に渡した function が異なっても、Do の実行自体に制限がかかるため、2 回実行されることはない

```go
package main

import (
    "fmt"
    "sync"
)

var (
    once     sync.Once
    resource string
)

func setup() {
    fmt.Println("Initializing resource...")
    resource = "initialized"
}

func main() {
    // Perform setup exactly once
    once.Do(setup)

    // Attempting to perform setup again should have no effect
    once.Do(setup)

    fmt.Println("Resource:", resource)
}
```

##### Pool

- `オブジェクトプールパターン`を並行処理で安全な形で実装したもの
- オブジェクトプールパターンは、使うものを決まった数だけプールを生成し、生成したオブジェクトを再利用する
  - オブジェクトの生成と破棄はコストが高いため
  - コストが高いもの(DB 接続など)を作るときに数を制限して、決まった数しか作られないようにしつつ、予測できない数の操作がこれらにアクセスをリクエストできるようにする
- `Get()`メソッド
  - プール内に使用可能なインスタンスがあるか確認し、あれば呼び出し元に返す。なければ New()で新しいインスタンスを生成する
- `Put()`メソッド
  - 使用し終わったインスタンスをプールに戻す

```go
package main

import (
    "fmt"
    "sync"
)

type Object struct {
    value int
}

func main() {
    var pool = sync.Pool{
        New: func() interface{} {
            // Create a new object when the pool is empty
            return new(Object)
        },
    }

    // Put objects into the pool
    for i := 0; i < 5; i++ {
        obj := &Object{value: i}
        pool.Put(obj)
    }

    // Get objects from the pool
    for i := 0; i < 5; i++ {
        obj := pool.Get().(*Object)
        fmt.Println("Got object with value:", obj.value)
    }
}
```

#### チャネル (channel)

- チャネルを使うときは値を chan 型の変数に渡し、受取側はその値をチャネルから読み込む。これはチャネルが存在しているメモリの同じ場所を参照している。
- チャネルには、送信専用、受信専用、双方向がある

```go
dataStream := make(chan interface{}) // 双方向channel

dataStream := make(<-chan interface{}) // 読み込み専用channel

dataStream := make(chan<-> interface{}) // 送信専用channel
```

- Go のチャネルはブロックする性質を持つ
  - キャパシティがいっぱいのチャネルに書き込もうとするあらゆるゴルーチンはチャネルに空きができるまで待機する
  - 空のチャネルから読み込もうとしているあらゆるゴルーチンは少なくとも要素が 1 つ入るまで待機する
- チャネルの close: これ以上チャネルから値がおくられてこないということを示す

```go
intStream := make(chan int)
close(intStream) // 閉じる

// この方法は無限に読み込ませることもできる
integer, ok := <- intStream // 0, false
```

```go
intStream := make(chan int)
go func() {
  defer close(intStream) // goroutineを抜けるタイミングでcloseする
  for i := 1; i <= 5; i++ {
    intStream <- i
  }
}()

// closeによってloopは抜ける
// 送信側はgoroutineを抜ける前にdeferでcloseを呼び出すとよい
for integer := range intStream {
  //
}
```

- チャネルを閉じることは複数のゴルーチンに同時にシグナルを送信する方法の１つでもある
- キャパシティが n のバッファ付きチャネルの場合、n 回まで書き込みができる
- バッファ付きチャネルは並行プロセスが通信するためのインメモリの FIFO キュー

#### select 文

- 複数のチャネルをまとめて受け取ったり、送信したりできる

```go
var c1, c2 <-chan interface{}
var c3 chan<- interface{}

select {
  case <- c1:
    // do something
  case <- c2:
    // do something
  case c3<- struct{}{}
    // do something
}
```

- select ブロックの case 文は上から順番に評価されるわけではない。1 つ条件を通ると、そこから select は抜けることになる。
  - そのため、長時間待ち受けたいときは、for loop で select を囲むことになる
- 1 つも条件に該当しない場合には自動的に実行されない。select 全体がブロックする
- 読み込みや書き込みのチャネルはすべて同時に取り扱われる

```go
// timeout
var c <-chan int
select {
  case <-c:
  case <-time.After(1 * time.Second);
    fmt.Println("Timed out")
}
```

```go
// loopが必要な処理
done := make(chan interface{})
go func() {
  time.Sleep(5*time.Second)
  close(done)
}

workCounter := 0
loop:
for {
  select {
    case <-done:
      break loop
    default:
  }

  workCounter++
  time.Sleep(1*time.Second)
}

```

#### GOMAXPROCS レバー

`GOMAXPROCS` は、同時に実行できる CPU の最大数を設定し、前の設定を返す。デフォルトは runtime.NumCPU の値。 n < 1 の場合、現在の設定は変更されない。スケジューラが改善されると、この呼び出しはなくなる。

- [runtime#GOMAXPROCS](https://pkg.go.dev/runtime#GOMAXPROCS)
- `func GOMAXPROCS(n int) int`

### 4. Go での並行処理パターン

#### 4.1. 拘束

- 並行なコードを扱うときに、安全な操作をするための方法
  - メモリを共有するための同期のプリミティブ (sync.Mutex)
  - 通信による同期 (channel)
  - イミュータブルなデータ
- `拘束`は情報をたった 1 つの並行プロセスからのみ得られることを確実にしてくれるシンプルな考え方
- これが行われたとき、並行プログラムは暗黙的に安全であり、同期が必要なくなる
- 2 種類の拘束
  - アドホック (ad hoc: 特別の、その場その場の)
  - レキシカル: コンパイラを駆使して拘束を矯正するというもの
- レキシカル拘束はレキシカルスコープを使って適切なデータと並行処理のプリミティブだけを複数の並行プロセスが使えるように公開すること

```go
chanOwner := func() <- chan int {
  // チャネルは関数内のレキシカルスコープ内で初期化
  // これにより、チャネルへの書き込みができるスコープを制限
  results := make(chan int, 5)
  go func() {
    defer close(results)
    for i := 0; i <= 5; i++ {
      result <- i
    }
  }()
  return results
}

// intチャネルの読み込み専用のコピーを受け取る
consumer := func(results <-chan int) {
  for result := range results {
    fmt.Printf("Received: %d\n", result)
  }
  fmt.Println("Done receiving!")
}

// チャネルへの読み込み権限を受け取って、それをconsumer()にわたす
results := chanOwner()
consumer(results)
```

- レキシカル拘束を利用する並行処理のコードは可読性が高く理解しやすくなる

#### 4.2. for-select ループ

```go
for { // 無限ループまたは何かのイテレーションを回す
  select {
    // チャネルに対して何かを行う
  }
}
```

- チャネルから繰り返しの変数を送出する

```go
for _, s := range []string{"a", "b", "c"} {
  select {
    case <-done:
      return
    case stringStream <- s:
  }
}
```

- 停止シグナルを待つ無限ループ
  - done チャネルが閉じられていなければ、select 文を抜けた先の処理を行う

```go
for {
  select {
    case <-done:
      return
    default:
      // do something
  }

  // do something
}
```

#### 4.3. goroutine リークを避ける

- goroutine を確実に片付けるにはどうすればよいか？
- goroutine が終了に至るまでの流れ
  - ゴルーチンが処理を完了する場合
  - 回復できないエラーにより処理を続けられない場合
  - 停止するように命令された場合
    - ゴルーチンの親子間で親から子にキャンセルのシグナルを送れるようにする
    - 慣習としてこのシグナルは通常`done`という名前の読み込み専用チャネルにする
    - 親ゴルーチンからこのチャネルを子ゴルーチンに渡して、キャンセルしたいときにチャネルを close する
    - producer の goroutine に終了を伝えるチャネルを提供すること

```go
doWork := func(
  done <-chan interface{},
  strings <-chan string,
) <-chan interface{} {
  terminated := make(chan interface{})
  go func() {
    defer fmt.Println("doWork exited.")
    defer close(terminated) // 3. terminatedをclose
    for {
      select {
        case s := <-strings:
          // do something
          fmt.Println(s)
        case <-done: // 2. done channelが閉じられた後、この処理を通る
          return
      }
    }
  }()
  return terminated
}

done := make(chan interface{})
terminated := doWork(done, nil)

go func() {
  time.Sleep(1 * time.Second)
  fmt.Println("Canceling doWork goroutine...")
  close(done) // 1. close
}()

<-terminated // doWork内で処理が終わったら、terminatedがcloseされることによって受信する
fmt.Println("Done")
```

```go
newRandStream := func(done <-chan interface{}) <-chan int {
  randStream := make(chain int)
  go func() {
    defer fmt.Println("newRandStream closure exited.")
    defer close(randStream)
    for {
      select {
        case randStream <- rand.Int(): // 1. 送信を繰り返す
        case <-done: // 3. doneのcloseによりreturn
          return
      }
    }
  }()
  return randStream
}

done := make(chan interface{})
randStream := newRandStream(done)
fmt.Println("3 random ints:")
for i := 1; i <= 3; i++ {
  fmt.Printf("%d: %d\n", i, <-randStream)
}
close(done) // 2. 3つ受信したらforを抜け、channel doneをclose
```

#### 4.4. or チャネル

1 つ以上の done チャネルを 1 つの done チャネルにまとめて、まとめているチャネルのうちのどれか 1 つのチャネルが閉じられたら、まとめて閉じられるようにしたいとき、`orチャネルパターン`を使ってチャネルをまとめるとよい

割愛

#### 4.5. エラーハンドリング

- エラーハンドリングで発生する疑問は、`誰がそのエラーを処理する責任を持つべきか`
- 重要なのは、`関心事を分けること`
- エラーも正常系と同じ経路を渡って返されるべき

```go
type Result struct {
  Error error
  Response *http.Response
}
checkStatus := func(done <-chan interface{}, urls ...string) <-chan Result {
  results := make(chan Result)
  go func() {
    defer close(results)

    for _, url := range urls {
      var result Result
      resp, err := http.Get(url)
      result = Result{Error: err, Response: resp}
      select {
        case <-done:
          return
        case results <- result: // エラーも結果もstructとしてまとめて返す
      }
    }
  }()
  return results;
}

done := make(chan interface{})
defer close(done)

urls := []string{"https://www.google.com", "https://foobar"}
for result := range checkStatus(done, urls...) {
  if result.Error != nil {
    fmt.Printf("error: %v", result.Error)
    continue
  }
  fmt.Printf("Response: %v\n", result.Response.Status)
}
```

#### 4.6. [パイプライン](https://go.dev/blog/pipelines)

- パイプラインはシステムの抽象化に使える道具の１つ（データストリームやバッチ処理を扱うときなど）
- パイプラインはデータを受け取って何かしらの処理を行って、どこかに渡すという一連の作業
- パイプラインを使うことで各ステージでの懸念事項を切り分けられる
- パイプラインのステージの性質
  - ステージは受け取るものと返すものが同じ型
  - ステージは引き回せるように具体化されてなければならない
  - `高階関数`や`モナド`
- `バッチ処理`: 個別の値を 1 つずつ処理していくのではなく、データの塊をいっぺんに処理する
- `ストリーム処理`: ステージが要素を１つずつ受け取って、１つずつ渡すやり方

```go
// ストリーム志向
multiply := func(value, multiplier int) int {
  return value * multiplier
}
add := func(value, additive int) int {
  return value + additive
}
ints := []int{1, 2, 3, 4}
for _, v := range ints {
  fmt.Println(multiply(add(multiply(v, 2), 1) 2))
}
```

##### パイプライン構築のためのベストプラクティス

- go のチャネルはパイプラインの構築に必要な要件を揃えている

```go
// generator関数
// 個別の値の塊をチャネル上を流れるデータのストリームに変換する
// パイプラインの始めには常にチャネルへの変換を必要とするデータの塊がある
generator := func(done <-chan interface{}, integers ...int) <-chan int {
  intStream := make(chan int, len(integers))
  go func() {
    defer close(intStream)
    for _, i := range integers {
      select {
        case <-done:
          return
        case intStream <- i: // 渡された配列をchannelで送信
      }
    }
  }()
  return intStream
}

multiply := func(
  done <-chan interface{},
  intStream <-chan int,
  multiplier int,
) <-chan int {
  multipliedStream := make(chan int)
  go func() {
    defer close(multipliedStream)
    for i := range intStream {　// 渡されたchannelから受信
      select {
        case <-done:
          return
        case multipliedStream <- i*multiplier:　// 新しい値としてchannelから送信
      }
    }
  }()
  return multipliedStream
}

add := func(
  done <-chan interface{},
  intStream <-chan int,
  additive int,
) <-chan int {
  addedStream := make(chan int)
  go func() {
    defer close(addedStream)
    for i := range intStream { // 渡されたchannelから受信
      select {
        case <-done:
          return
        case addedStream <- i+additive: // 新しい値としてchannelから送信
      }
    }
  }()
  return addedStream
}

done := make(chan interface{})
defer close(done)

intStream := generator(done, 1, 2, 3, 4)
pipeline := multiply(done, add(done, multiply(done, intStream, 2), 1), 2)

// 最後に値を取り出す
for v := range pipeline {
  fmt.Println(v)
}
```

#### 4.7. ファンアウト、ファンイン

- ファンアウト
  - パイプラインからの入力を扱うために複数のゴルーチンを起動するプロセスを説明する用語
- ファンイン
  - 複数の結果を 1 つのチャネルに結合するプロセスを説明する用語

#### 4.8. or-done チャネル

#### 4.9. tee チャネル

#### 4.10. bridge チャネル

#### 4.11. キュー

#### 4.12. [context パッケージ](https://pkg.go.dev/context)

- 並行処理のプログラムではタイムアウトやキャンセル、あるいはシステムの別の箇所での失敗により、しばしば中断をする必要がある
- Context 型は done チャネルのようにシステム内を流れる
- context パッケージを使う場合には並行処理の呼び出し元の最上位より下流の各関数は Context を第一引数として受け取る
- context のメソッド
  - Done メソッド: 関数がランタイムにより割り込みされたときに閉じるチャネルを返す
  - Deadline メソッド: ゴルーチンが一定の時刻以降にキャンセルされるかを返す
  - Err メソッド: ゴルーチンがキャンセルされたら非 nil な値を返す
- 関数内でのキャンセルには 3 つの側面がある
  - ゴルーチンの親がキャンセルをしたい場合
  - ゴルーチンが子をキャンセルしたい場合
  - ゴルーチン内のブロックしている処理がキャンセルされるように中断できる必要がある場合
- Context を受け取っても、それをキャンセルさせることができる関数が備わっているわけではない
- done チャネルを提供する Done メソッドと組み合わせることで、Context 型がその祖先からのキャンセルを安全に管理できるようになる
- Context 生成 function
  - WithCancel: 返された cancel 関数が呼ばれたときにその done チャネルを閉じる新しい Context を返す
  - WithDeadline: マシンの時計が与えられた deadline の時刻を経過したらその done チャネルを閉じる新しい Context を返す
    - ctx.Deadline()で確認できる
  - WithTimeout: 与えられた timeout だけ経過したらその done チャネルを閉じる新しい Context を返す
  - TODO: 上流のコードが未実装だが Context がくることがわかっているときにプレースホルダーを提供するためのもの
- context.Context のインスタンスは内部的にはスタックフレームごとに変化する
- Context のためにあるリクエストの範囲でのデータを保管し受け取るためのデータバッグ

```go
func main() {
  ProcessRequest("jane", "abc123")
}
type ctxKey int

const (
  ctxUserID ctxKey = iota
  ctxAuthToken
)

func UserID(c context.Context) string {
  return c.Value(ctxUserID).(string)
}

func AuthToken(c context.Context) string {
  return c.Value(ctxAuthToken).(string)
}

func ProcessRequest(userID, authToken string) {
  ctx := context.WithValue(context.Background(), ctxUserID, userID)
  ctx = context.WithValue(ctx, ctxAuthToken, authToken)
  HandleResponse(ctx)
}

func HandleResponse(ctx context.Context) {
  fmt.Printf(
    "handling response for %v (%v)",
    UserID(ctx),
    AuthToken(ctx),
  )
}
```

[sample code](https://gist.github.com/littlefuntik/37b04e1e97510877485ec6856ecdc33c)

```go
package main

import (
  "context"
  "io/ioutil"
  "log"
  "net"
  "net/http"
  "time"
)

// Connect timeout error:
//  panic: Cannot do request: Get http://localhost:3000: dial tcp: i/o timeout
// Request timeout error:
//  panic: Cannot do request: Get http://localhost:3000: context deadline exceeded
// Example output
//  Do request
//  Read body
//  Read response took: 154.884µs
//  {"ip":"*.*.*.*","country":"Ukraine","cc":"UA"}
func main() {
  const ConnectMaxWaitTime = 1 * time.Second
  const RequestMaxWaitTime = 5 * time.Second

  client := http.Client{
    Transport: &http.Transport{
      DialContext: (&net.Dialer{
        Timeout: ConnectMaxWaitTime,
      }).DialContext,
    },
  }

  ctx, cancel := context.WithTimeout(context.Background(), RequestMaxWaitTime)
  defer cancel()

  // create request with context
  req, err := http.NewRequestWithContext(ctx, http.MethodGet, "https://api.myip.com", nil)
  if err != nil {
    log.Panicf("Cannot create request: %s\n", err)
  }

  // request
  log.Println("Do request")
  rsp, err := client.Do(req)
  if rsp != nil {
    defer rsp.Body.Close()
  }
  // handle timeout error and something else error
  if e,ok := err.(net.Error); ok && e.Timeout() {
    log.Panicf("Do request timeout: %s\n", err)
  } else if err != nil {
    log.Panicf("Cannot do request: %s\n", err)
  }

  // read body from response body
  log.Println("Read body")
  startRead := time.Now()
  body, err := ioutil.ReadAll(rsp.Body)
  if err != nil {
    log.Panicf("Cannot read all response body: %s\n", err)
  }
  endRead := time.Now()
  log.Printf("Read response took: %s\n", endRead.Sub(startRead))

  log.Printf("%s\n", body)
}
```

### 5. 大規模開発での並行処理

### 6. goroutine と Go runtime

