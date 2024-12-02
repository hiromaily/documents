# Timeout

## ContextのTimeout

Goの`context`パッケージでタイムアウトを設定する場合、通常は`context.WithTimeout`関数を使用する。この関数は指定した期限（タイムアウト期間）を過ぎると自動的にキャンセル信号を送信するコンテキストを生成する。

```go
timeoutCtx, cancel := context.WithTimeout(ctx, time.Duration(l.timeoutSec)*time.Second)
defer cancel()

// timeout発生後、channelを受け取る
<-timeoutCtx.Done()
```

### 実行順序

1. **新しいコンテキストの生成**: `context.WithTimeout(parent, timeout)`は、指定したタイムアウトを持つ新しい子コンテキストを生成する。この子コンテキストは、親コンテキスト（`parent`）のキャンセルまたはタイムアウトに依存する。

2. **タイマーの設定**: 指定された`timeout`期間が経過するとアラームが発生するタイマーを内部で生成する。これは`time.AfterFunc(timeout, cancel)`のように実現される。このタイマーは指定された期間の後にキャンセル関数を呼び出す。

3. **キャンセル関数の呼び出し**: タイマーが発火すると、対応するキャンセル関数が呼び出され、この子コンテキストへのキャンセル信号が伝播する。この状態は子コンテキストの`Done()`チャネルを通じて通知される。

4. **リソースのクリーンアップ**: タイムアウトまたはキャンセルが発生すると、関連するリソースのクリーンアップが行われることが期待される。このプロセスには外部リソースへのアクセスの中断、ゴルーチンの停止などが含まれる。

### ctx.Err()

タイムアウトが発生した場合、`ctx.Err()`は`context.DeadlineExceeded`となり、タイムアウトが原因であることを示す。
厳密に言うと`ctx.Done()`チャネルが先にクローズされ、その後に`ctx.Err()`が設定される。

```go
// timeoutエラーが発生しているかどうか
if timeoutCtx.Err() == context.DeadlineExceeded {
    break LOOP
}

// これは冗長か？
select {
case <-timeoutCtx.Done():
    return
default:
    if timeoutCtx.Err() != context.DeadlineExceeded {
        // MessageContentResponseのcapacityによってblockされることはない想定
        resultCh <- entity.MessageContentResponse{MessageID: msgID, MessageContentResponse: response, Err: err}
    }
}
```
