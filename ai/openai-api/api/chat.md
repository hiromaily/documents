# [Chat](https://platform.openai.com/docs/api-reference/chat) Completion API

指定されたチャット会話のモデル応答を作成する。
パラメータのサポートは、応答の生成に使用されるモデルによって異なる場合があります。特に新しい推論モデルの場合です。推論モデルでのみサポートされているパラメータについては、以下を参照してください。推論モデルでサポートされていないパラメータの現在の状態については、推論ガイドを参照してください。

`post: https://api.openai.com/v1/chat/completions`

## Chat `Request body`

以下は一部のみ抜粋

| 項目              | Type            | Required/Optional | 説明                                                                                                                                                                                            |
| ----------------- | --------------- | ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| messages          | array           | Required          | これまでの会話を構成するメッセージのリスト。使用するモデルに応じて、テキスト、画像、音声などがサポートされる。                                                                                  |
| model             | string          | Required          | 使用するモデルの ID。(e.g. gpt-4o)                                                                                                                                                              |
| store             | boolean or null | Optional (false)  | このチャット完了リクエストの出力を保存するかどうか                                                                                                                                              |
| reasoning_effort  | string          | Optional (medium) | o1 model 限定。推論モデルの推論にかかる労力を制限する                                                                                                                                           |
| metadata          | object or null  | Optional          | ダッシュボードで補完をフィルタリングするために使用される、開発者用のタグと値                                                                                                                    |
| frequency_penalty | number or null  | Optional (0)      | -2.0 から 2.0 までの数値。正の値は、これまでのテキスト内の既存の頻度に基づいて新しいトークンにペナルティを課し、モデルが同じ行を逐語的に繰り返す可能性を減らす。                                |
| stream            | boolean or null | Optional (false)  | 設定されている場合、ChatGPT 部分的なメッセージ が送信される。トークンは、利用可能になるとデータのみの`server-sent events`として送信され、ストリームは `data: [DONE]` メッセージによって終了する |
| response_format   | object          | Optional          | モデルが出力する必要がある形式を指定するオブジェクト(e.g. {"type": "json_object"})                                                                                                              |

## Request 例

```sh
curl https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d '{
    "model": "gpt-4o",
    "messages": [
      {
        "role": "developer",
        "content": "You are a helpful assistant."
      },
      {
        "role": "user",
        "content": "Hello!"
      }
    ]
  }'
```

## messages

### role の種類

1. **[developer](https://platform.openai.com/docs/guides/text-generation/system-messages#developer-messages)**:

   - `system`という名前から変更されたもの
   - 会話の初期設定として使用され、AI の振る舞いや態度など会話の全体的な文脈を設定するために使用する
   - モデルに特定のルールや人格を持たせたい場合、system メッセージを使用してその指針を与えることができる

   ```json
   {
     "role": "system",
     "content": "You are a helpful assistant of software engineer."
   }
   ```

2. **[user](https://platform.openai.com/docs/guides/text-generation/system-messages#user-messages)**:

   - ユーザーからの入力を表す
   - これはアシスタントに指示を与えるためのメッセージ

   ```json
   {
     "role": "user",
     "content": "Can you explain about OpenAPI in detail?"
   }
   ```

3. **[assistant](https://platform.openai.com/docs/guides/text-generation/system-messages#assistant-messages)**:

   - AI チャットの過去のレスポンス履歴
   - この指示があることで、AI は過去の会話の内容や履歴（コンテキスト）を参考にしながら、より適切な回答を生成できるようになる
   - 過去の履歴を input として与えるためには、`user`と`assistant`を交互に設定していく

   ```json
   {
     "role": "user",
     "content": "Can you explain about OpenAPI in detail?"
   },
   {
     "role": "assistant",
     "content": "OpenAPI is xxxxxxx"
   },
   ```
