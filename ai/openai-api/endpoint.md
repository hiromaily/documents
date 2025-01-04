# Endpoint (API)

- [Audio](https://platform.openai.com/docs/api-reference/audio)
  - オーディオをテキストに変換する、またはテキストをオーディオに変換する
  - `post: https://api.openai.com/v1/audio/speech`
- [Chat](https://platform.openai.com/docs/api-reference/chat)
  - 会話を構成するメッセージのリストが与えられると、モデルは応答を返す
  - `post: https://api.openai.com/v1/chat/completions`
- Embeddings
  - 機械学習モデルやアルゴリズムで簡単に使用できる、特定の入力のベクトル表現を取得する
- Fine-tuning
  - 微調整ジョブを管理して、特定のトレーニング データに合わせてモデルを調整する
- Batch
  - 非同期処理用の API リクエストの大規模なバッチを作成する。
  - バッチ API は 24 時間以内に完了を返すが、50%割引となるメリットがある
- Files
  - ファイルは、`Assistants`、`Fine-tuning`、`Batch API` などの機能で使用できるドキュメントをアップロードするために使用される。
- Uploads
  - 大きなファイルを複数回に分けてアップロードできる
- Images
  - プロンプトや入力画像が与えられると、モデルは新しい画像を生成する
- Models
  - API で利用できるさまざまなモデルを一覧表示して説明する
  - [利用可能なモデル](https://platform.openai.com/docs/models)
- Moderations
  - テキストや画像の入力が与えられた場合、それらの入力が複数のカテゴリにわたって潜在的に有害であるかどうかを分類する

## [Chat](https://platform.openai.com/docs/api-reference/chat)

指定されたチャット会話のモデル応答を作成する。
パラメータのサポートは、応答の生成に使用されるモデルによって異なる場合があります。特に新しい推論モデルの場合です。推論モデルでのみサポートされているパラメータについては、以下を参照してください。推論モデルでサポートされていないパラメータの現在の状態については、推論ガイドを参照してください。

`post: https://api.openai.com/v1/chat/completions`

### Chat `Request body`
