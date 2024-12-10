# Channel

## 挙動の整理

- 閉じられたチャネルに対して送信はできない。
  - 送信しようとすると panic が発生: `panic: send on closed channel`
- 閉じられたチャネルから受信
  - 即座にゼロ値が返ってくる
  - select の case で受信しても即座にその case が実行される
  - channel に`nil`がセットされている場合、その channel を使った case は実行されない
  - range の場合、loop はすぐに抜ける
- 複数回の同一の channel の close はできない
  - 閉じようとすると panic が発生: `panic: close of closed channel`

    ```go
    var closeOnce sync.Once
    closeOnce.Do(func() { close(resultCh) })
    ```

- close の処理は、ブロードキャストの役割を持つ

## Select 内における挙動

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
    if timeoutCtx.Err() != context.DeadlineExceeded {
        // MessageContentResponseのcapacityによってblockされることはない想定
        resultCh <- entity.MessageContentResponse{MessageID: msgID, MessageContentResponse: response, Err: err}
    }
}
```

## 複数のgoroutineで送信しているchannelがある場合、close処理は1箇所に限定すること

`for loop`を終了させてからchannelをcloseすること

```go
func (l *lineAPIConcurrentClient) getMessageContentsProducer(
    timeoutCtx context.Context,
    lineAPICaller LINEAPICaller,
    messageIDs []string,
) <-chan entity.MessageContentResponse {
    var closeOnce sync.Once
    resultCh := make(chan entity.MessageContentResponse, len(messageIDs))

    // Note: channelからの送信が終了していない中でcloseをすると、Race conditionの原因になる。
    // channelのcloseは一箇所に責務を持たせるべき。
    //
    // timeout detecter
    // 長時間APIのレスポンスが返ってこない場合、Loop内で処理をすると検知が遅れる
    // go func() {
    //     <-timeoutCtx.Done()
    //     closeOnce.Do(func() { close(resultCh) })
    // }()

    go func() {
        sem := make(chan struct{}, API_RATE_LIMIT) // 最大同時実行数

        var counter int
        var lastIndex int = len(messageIDs) / API_RATE_LIMIT
        if len(messageIDs)%API_RATE_LIMIT != 0 {
            lastIndex++
        }

    LOOP:
        for chunkMessageIDs := range slices.Chunk(messageIDs, API_RATE_LIMIT) {
            // timeout発生時は処理を終了させる
            if timeoutCtx.Err() == context.DeadlineExceeded {
                break LOOP
            }

            var wg sync.WaitGroup
            counter++

            startTime := time.Now()
            for _, messageID := range chunkMessageIDs {
                // timeout発生時は処理を終了させる
                if timeoutCtx.Err() == context.DeadlineExceeded {
                    break LOOP
                }

                wg.Add(1)
                sem <- struct{}{}

                go func(msgID string) {
                    defer func() {
                        wg.Done()
                        <-sem
                    }()
                    // GetMessageContent API呼び出し
                    response, err := lineAPICaller.GetMessageContent(msgID)
                    select {
                    case <-timeoutCtx.Done():
                        return
                    default:
                        if timeoutCtx.Err() != context.DeadlineExceeded {
                            // MessageContentResponseのcapacityによってblockされることはない想定
                            resultCh <- entity.MessageContentResponse{MessageID: msgID, MessageContentResponse: response, Err: err}
                        }
                    }
                }(messageID)
            }
            wg.Wait()

            // API_RATE_LIMIT制約のために、必要に応じて待機
            // - 最後のchunkのloopであれば待機は不要
            // - データ件数がAPI_RATE_LIMIT(同時並列数)以下であれば、待機は不要
            // - 1秒以上すでに経過している場合は待機は不要
            elapsed := time.Since(startTime)
            if counter < lastIndex && len(messageIDs) > API_RATE_LIMIT && elapsed < time.Second {
                remaining := time.Second - elapsed
                time.Sleep(remaining)
            }
        }
        closeOnce.Do(func() { close(resultCh) })
    }()

    return resultCh
}
```
