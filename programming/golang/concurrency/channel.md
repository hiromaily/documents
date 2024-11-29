# Channel

## 挙動の整理

- 閉じられたチャネルに対して送信
  - panic: `panic: send on closed channel`
- 閉じられたチャネルから受信
  - 即座にゼロ値が返ってくる
  - selectのcaseで受信しても即座にそのcaseが実行される
  - channelに`nil`がセットされている場合、そのchannelを使ったcaseは実行されない
  - rangeの場合、loopはすぐに抜ける
- 複数回のchannelのclose
  - panic: `panic: close of closed channel`
- closeの処理は、ブロードキャストの役割を持つ

## Select内における挙動

```go
// この場合、どちらかのcaseのうち、実行できるほうが実行される
// どちらも実行できない場合はBlockされる
// 注意すべきは、複数のケースが同時に準備完了状態（実行可能）である場合、
// Goのランタイムはその中の1つをランダムに選んで実行する
select {
case <-timeoutCtx.Done():
    return
case resultCh <- entity.MessageContentResponse{MessageID: msgID, MessageContentResponse: response, Err: err}:
}

// defaultがある場合、どちらのcaseも実行できない場合、defaultが実行される
select {
case <-timeoutCtx.Done():
    return
case resultCh <- entity.MessageContentResponse{MessageID: msgID, MessageContentResponse: response, Err: err}:
default:
    // ここに処理を追加
}
```

// if timeoutCtx.Err() != context.DeadlineExceeded {
//     // MessageContentResponseのcapacityによってblockされることはない想定
//     resultCh <- entity.MessageContentResponse{MessageID: msgID, MessageContentResponse: response, Err: err}
// }
