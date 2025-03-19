# OpenAI API Docs

[API Reference](https://platform.openai.com/docs/api-reference/introduction)

OpenAI API は、OpenAI が提供するさまざまサービスが含まれる

- 自然言語処理タスク
- テキスト生成
- テキスト要約
- 質問への回答

この API を使用すると、開発者はさまざまなアプリケーションで OpenAI の強力な AI モデルにアクセスできる。この API は、柔軟性が高く、既存のアプリケーションやサービスに簡単に統合できるように設計されている。

## [Response API](https://platform.openai.com/docs/api-reference/responses)

Response API は、AI アシスタントを構築するためのより新しく包括的なソリューション。これは、同社のサービスの進化形となる。主な機能は次のとおり。

- 合理化された会話履歴管理
- OpenAI がホストするツールへのアクセス
- サードパーティ ツールの関数呼び出しの改善
- 幅広いタスクを実行できる堅牢な AI アシスタントを構築するために設計されている

## [Chat Completions API](https://platform.openai.com/docs/api-reference/chat)

Chat Completions API は、会話のコンテキストで直接応答を生成することに重点を置いている。その特徴は次のとおり。

- 提供されたメッセージ履歴に基づいて、特定のダイアログに対する応答を生成する
- 機敏で直接的な応答に適している
- 迅速で簡単なやり取りに最適
- 軽量で効率的であるため、シンプルな AI アプリケーションに適している

Chat Completions API は、`temperature`、`max_tokens`、`top_p` など、出力を制御するためのさまざまなパラメーターを受け入れる。また、テキスト、画像、音声など、さまざまな種類の入力を処理することもできる。

## Outdated

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
