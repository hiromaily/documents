# 分散トレーシングで使われる用語

分散トレーシングにおいて、`Span`および`Tag` (他のシステムでは`Attribute`や`Label`と呼ばれることもある) は中心的な概念。これらの機能は、システム内のリクエストのフローを詳細に追跡し、パフォーマンスやトラブルシューティングの情報を収集するために使用される。

## 1. Span (スパン)

Spanは分散トレーシングの基本単位で、特定の操作やタスクの実行期間を表す。分散システムにおける各リクエストのライフサイクルを追跡するために使用される。

### Spanの主要な特徴

1. **Span ID**:
   - 各Spanは一意のID（識別子）を持ちます。これにより個々の操作やタスクを一意に識別できます。

2. **Trace ID**:
   - SpansはTraceという大きなコンテキストの一部です。Trace IDは全ての関連するSpanを一つのリクエストのフローとしてまとめるための識別子です。

3. **Parent Span ID**:
   - Spanは階層構造で表現されることが多く、親子関係を持ちます。Parent Span IDは現在のSpanの親Spanを示します。

4. **開始時間と終了時間**:
   - Spanは特定の時間範囲をカバーします。タイムスタンプが開始時と終了時に記録されることで、処理の持続時間が計測されます。

5. **名前（Operation Name）**:
   - 各Spanには操作の名前が付けられており、どのような操作が行われたのかを示します。たとえば「HTTP GET /api/resource」などです。

## 2. Tag/Attribute/Label (タグ)

Tag（またはAttribute、Label）は、Spanに付加情報を追加するために使用される。タグはキーとバリューのペアで構成され、Spanに関するさまざまなメタデータを記録する。

### Tagの例

1. **HTTP関連のタグ**:
   - `http.method`: HTTPリクエストのメソッド（例：GET, POST）
   - `http.url`: リクエストされたURL
   - `http.status_code`: HTTPステータスコード

2. **データベース関連のタグ**:
   - `db.system`: データベースの種類（例：mysql, postgresql）
   - `db.statement`: 実行されたSQLクエリ
   - `db.operation`: 実行された操作（例：SELECT, INSERT）

3. **汎用的なタグ**:
   - `error`: エラーの発生を示す真偽値
   - `component`: 操作を実行したソフトウェアコンポーネント

## 3. Span Logs/Events (スパン ログ/イベント)

Spanはそのライフサイクル中に発生した特定のイベントやログメッセージを記録することもできる。これらは時系列の詳細な情報を提供し、問題の診断やデバッグに役立つ。

### Span Logs/Eventsの特徴

- **タイムスタンプ**: 各イベントはタイムスタンプを持ち、いつ発生したかを示す。
- **イベント名**: イベントの名前を指定し、どのような種類のイベントが発生したかを示す。
- **属性**: イベントに付加情報を追加するための属性を持つことができる。

## 4. Baggage

Baggageは、サーバー間をまたいで伝播されるキーとバリューのペアのセット。これにより、分散コンテキスト全体で共有されるデータを保持することができる。

### Baggageの使用例

- **ユーザー情報**: リクエストが複数のマイクロサービスを通過する際に、ユーザーのIDや権限情報などを伝播させることができる。
- **トランザクション情報**: 特定のトランザクションやセッションに関する詳細情報を保持し、関連するすべてのサービスに伝えることが可能です。

## まとめ

分散トレーシングにおいて、Span、Tag、Log/Event、およびBaggageはそれぞれ重要な役割を果たしている：

- **Span**: 操作やタスクの期間と詳細を表す基本単位。
- **Tag**: Spanにメタデータを追加するキー-バリューペア。
- **Log/Event**: Spanのライフサイクル中に発生した特定のイベントやログメッセージを記録。
- **Baggage**: 分散コンテキスト全体で共有されるデータを保持し伝播。

これらの機能を組み合わせて使用することで、分散システム内でのリクエストのフローを詳細に追跡し、効率的な監視とトラブルシューティングを行うことができるようになる。

## [opentelemetry-goのtraceパッケージ](https://github.com/open-telemetry/opentelemetry-go/blob/main/trace/span.go)

```go
type Span interface {
    // Users of the interface can ignore this. This embedded type is only used
    // by implementations of this interface. See the "API Implementations"
    // section of the package documentation for more information.
    embedded.Span

    // End completes the Span. The Span is considered complete and ready to be
    // delivered through the rest of the telemetry pipeline after this method
    // is called. Therefore, updates to the Span are not allowed after this
    // method has been called.
    End(options ...SpanEndOption)

    // AddEvent adds an event with the provided name and options.
    AddEvent(name string, options ...EventOption)

    // AddLink adds a link.
    // Adding links at span creation using WithLinks is preferred to calling AddLink
    // later, for contexts that are available during span creation, because head
    // sampling decisions can only consider information present during span creation.
    AddLink(link Link)

    // IsRecording returns the recording state of the Span. It will return
    // true if the Span is active and events can be recorded.
    IsRecording() bool

    // RecordError will record err as an exception span event for this span. An
    // additional call to SetStatus is required if the Status of the Span should
    // be set to Error, as this method does not change the Span status. If this
    // span is not being recorded or err is nil then this method does nothing.
    RecordError(err error, options ...EventOption)

    // SpanContext returns the SpanContext of the Span. The returned SpanContext
    // is usable even after the End method has been called for the Span.
    SpanContext() SpanContext

    // SetStatus sets the status of the Span in the form of a code and a
    // description, provided the status hasn't already been set to a higher
    // value before (OK > Error > Unset). The description is only included in a
    // status when the code is for an error.
    SetStatus(code codes.Code, description string)

    // SetName sets the Span name.
    SetName(name string)

    // SetAttributes sets kv as attributes of the Span. If a key from kv
    // already exists for an attribute of the Span it will be overwritten with
    // the value contained in kv.
    SetAttributes(kv ...attribute.KeyValue)

    // TracerProvider returns a TracerProvider that can be used to generate
    // additional Spans on the same telemetry pipeline as the current Span.
    TracerProvider() TracerProvider
}
```
