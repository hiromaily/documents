# Sampling

[OpenTelemetry: Sampling](https://opentelemetry.io/docs/concepts/sampling/)

Sampling は`統計調査で、対象となる母集団から標本を抽出すること`

## 注意すべき点

リクエストの大部分が成功し、許容できる遅延でエラーもなく終了する場合は、アプリケーションとシステムを有意義に観察するために 100%トレースする必要はない。

## いつサンプルを取るか

次のいずれかの条件を満たす場合は、サンプリングを検討すること

- 1 秒あたり 1000 以上のトレースを生成する
- トレース データのほとんどは、データの変動がほとんどない正常なトラフィックを表す
- エラーや高レイテンシなどの一般的な基準があり、通常は何か問題があることを意味する
- エラーやレイテンシを超えた関連データを決定するために使用できるドメイン固有の基準がある
- データをサンプリングするかドロップするかを決定する一般的なルールをいくつか記述できる
- サービスを区別する方法があるので、ボリュームの多いサービスと少ないサービスが別々にサンプリングされる
- サンプリングされていないデータ（「万が一」のシナリオ用）を低コストのストレージ システムにルーティングすることができる

## Samplingパターン

### 1. Head Sampling

できるだけ早くサンプリングの決定を行うために使用されるサンプリング手法。最も一般的な形式は、 一貫性のある確率サンプリング。これは、決定論的サンプリングとも呼ばれる。

#### Head Sampling の利点

- わかりやすい
- 簡単に設定できる
- 効率的
- トレース収集パイプラインのどの時点でも実行可能

#### Head Sampling の欠点

トレース全体のデータに基づいてサンプリングの決定を行うことができないこと

### 2. Tail Sampling

トレース内のすべてのスパンまたはほとんどのスパンを考慮してトレースをサンプリングするかどうかを決定する。トレースのさまざまな部分から得られた特定の基準に基づいてトレースをサンプリングするオプションが提供される。

Tail Samplingの使用方法の例は、

- エラーを含むトレースを常にサンプリングする
- 全体的なレイテンシに基づいてトレースをサンプリングする
- トレース内の 1 つ以上のスパンの特定の属性の存在または値に基づいてトレースをサンプリングする
  - たとえば、新しくデプロイされたサービスから発生するトレースをさらにサンプリングする。
- 特定の基準に基づいてトレースに異なるサンプリング レートを適用する。
  - トレースが低ボリュームのサービスからのみ取得される場合と、高ボリュームのサービスからのトレースを取得する場合など

## Loop内におけるTracing

### 1. 統計的サンプリング

```go
if rand.Float32() < 0.1 { // 10%の確率でトレースを行う
    _, span := b.tracer.NewSpan(ctx, "rdbRepo.GetSMSStatusSending()", true)
    defer span.End()

    exampleOperation()
} else {
    exampleOperation()
}
```

### 2. レートリミットの実装

```go
rateLimit := time.Second // 1秒に1回しかトレースを取らない
lastTraceTime := time.Now()

for i := 0; i < 1000; i++ {
    now := time.Now()
    if now.Sub(lastTraceTime) >= rateLimit {
        lastTraceTime = now
        _, span := b.tracer.NewSpan(ctx, "rdbRepo.GetSMSStatusSending()", true)
        defer span.End()

        exampleOperation()
    } else {
        exampleOperation()
    }
}
```

### 3. 特定の条件に基づくトレース

```go
for i := 0; i < 1000; i++ {
    if i%100 == 0 { // 100回ごとにトレースを行う
        _, span := b.tracer.NewSpan(ctx, "rdbRepo.GetSMSStatusSending()", true)
        defer span.End()

        exampleOperation()
    } else {
        exampleOperation()
    }

    time.Sleep(1 * time.Millisecond) // サンプル実行の待機
}
```
