# Lambdaの定期実行

`Amazon EventBridge`を使用する方法が一般的

1. **Amazon EventBridgeの設定:**
   - AWSマネジメントコンソールにログイン。
   - サービスリストから「EventBridge」を選択。
   - 左側のナビゲーションペインで「ルール」を選択し、「ルールの作成」ボタンをクリック。

2. **ルールの作成:**
   - ルールの名前とオプションで説明を入力。
   - 「パターンを定義」（Define pattern）で「スケジュール」を選択。
   - 「ルールタイプの指定」で「スケジュール式を使用」を選択し、cronまたはrate式を設定（例：`rate(5 minutes)`は5分ごと、`cron(0 12 * * ? *)`は毎日UTCの12時に実行）。
     - `rate(5 minutes)`：5分ごと
     - `cron(0 12 * * ? *)`：毎日UTC12時に実行
   - 次へボタンを押す。

3. **ターゲットの設定:**
   - 「ターゲットの追加」で「Lambda関数」を選択。
   - Lambda関数の名前を選択。
   - 必要に応じて、他の設定（例：対象Lambdaに渡す入力データなど）を行う。
   - 次へボタンを押す。

4. **ルールの作成の確認:**
   - ルールの設定を確認し、「ルールの作成」ボタンをクリック。
