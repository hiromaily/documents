# Distributed Tracing / 分散トレーシング

分散トレーシングは、特定のリクエストやトランザクションが複数のサービスやコンポーネントを経由して処理される過程を追跡する技術。  
これを使うことで、特定のリクエストがどのサービスでどれだけ時間をかけたか、どこでボトルネックが発生しているかを詳細に把握できる。
つまり、パフォーマンスのボトルネックを特定しやすくなって、システム全体の最適化がしやすくなる。

現代のアプリケーションは、`マイクロサービスアーキテクチャ`とか`サーバーレスアーキテクチャ`みたいに、たくさんの小さなサービスやコンポーネントが組み合わさって構成されてる。だから、一つのリクエストやトランザクションがどこで遅延してるのかを見つけるのは難しい。分散トレーシングを使うと、その全部の流れを可視化できるため、問題の特定が容易になる。

## 主なコンポーネント

1. **トレース（Trace）**

   - 一つのリクエストやトランザクション全体を通しての記録のこと。

2. **スパン（Span）**

   - トレースの中の一つ一つの操作や処理のこと。スパンには開始時間、終了時間、タグ（メタデータ）などが含まれる。

3. **タグ（Tags）**

   - スパンに追加されるメタデータ。たとえば、HTTP ステータスコードとか、エラーメッセージなどを保存する。

4. **ログ（Logs）**
   - 特定のイベントが発生したときの詳細情報を記録するもの。

## 分散トレーシングの仕組み

1. **トレース ID**

   - リクエストが発生した時点でユニークなトレース ID が生成される。これが全てのスパンに付与されることで、一連の流れを一つのトレースとしてまとめられる。

2. **スパン ID**

   - 各スパンごとにユニークな ID が生成される。親子関係（どのスパンがどのスパンの子供か）を管理するために使われる。

3. **プロパゲーション**
   - トレース ID とスパン ID がサービス間で伝播される。この情報は HTTP ヘッダーや RPC メッセージに追加して他のサービスに渡される。

## 代表的なツール

### Jaeger

- CNCF（Cloud Native Computing Foundation）のプロジェクト。分散トレーシング用のオープンソースツールで、Uber が開発した。

### Zipkin

- Twitter から始まったオープンソースプロジェクト。分散トレーシング用の強力なツールセットを持っている。

### AWS X-Ray

- AWS が提供する分散トレーシングサービス。AWS 環境との連携が強力。

### Datadog APM

- 分散トレーシング機能も含んでおり、他の監視ツールとシームレスに統合できる。トレースをリアルタイムで可視化するダッシュボードも提供。