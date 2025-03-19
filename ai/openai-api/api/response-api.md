# [Response API](https://platform.openai.com/docs/api-reference/responses)

従来の Chat Completions API および Assistants API の機能を統合した新しい API で、モデル応答を生成するための OpenAI の最も高度なインターフェース。`テキストと画像の入力`、およびテキスト出力をサポートする。以前の応答の出力を入力として使用して、モデルとのステートフルなインタラクションを作成する。`ファイル検索`、`Web 検索`、`コンピューターの使用`などの組み込みツールを使用して、モデルの機能を拡張する。関数呼び出しを使用して、モデルが外部システムやデータにアクセスできるようにする。

Note: Assistants API は 2026 年中頃に廃止予定。

## 機能\*

- **Web 検索**: 最新の情報を迅速に取得し、回答を生成。
- **ファイル検索**: 大量のドキュメントから必要な情報を取得。
- **コンピューター操作**: Web ブラウザーや GUI アプリを直接操作し、ワークフローを自動化。

## Sample Code

```py
import os
from openai import OpenAI

client = OpenAI(
    # This is the default and can be omitted
    api_key=os.environ.get("OPENAI_API_KEY"),
)

response = client.responses.create(
    model="gpt-4o",
    instructions="You are a coding assistant that talks like a pirate.",
    input="How do I check if a Python object is an instance of a class?",
)

print(response.output_text)
```

## `Request body`

- input: string or array, Required
  応答を生成するために使用される、モデルへの text, image, file
- model: string, Required
  応答を生成するために使用されるモデル ID (e.g. gpt-4o)
- include: array or null
  モデル応答に含める追加の出力データを指定
  - file_search_call.results`: ファイル検索ツール呼び出しの検索結果を含める。
  - message.input_image.image_url: 入力メッセージから画像の URL を含める。
  - computer_call_output.output.image_url: コンピュータ呼び出し出力からの画像 URL を含める。
- instructions: string or null
  モデルのコンテキストの最初の項目としてシステム (または開発者) メッセージを挿入する。
  e.g. `You are a coding assistant.`
- max_output_tokens: integer or null
  表示可能な出力トークンと推論トークンを含む、応答に対して生成できるトークンの数の上限
- metadata: map
  オブジェクトに添付できる 16 個のキーと値のペアのセット。
  これは、オブジェクトに関する追加情報を構造化された形式で保存し、API またはダッシュボード経由でオブジェクトをクエリする場合に役立つ。
- parallel_tool_calls: boolean or null (Defaults: true)
  モデルがツール呼び出しを並列で実行できるようにするかどうか
- previous_response_id: string or null
  モデルに対する以前の応答の一意の ID。これを使用して、複数ターンの会話を作成する
- reasoning: object or null
  Oシリーズモデルのみ
- store: boolean or null (Defaults: true)
  生成されたモデル応答を後で API 経由で取得するために保存するかどうか
- stream: boolean or null (Defaults: false)
  true に設定すると、モデル応答データは、サーバー送信イベントを使用して生成されるとクライアントにストリーミングされる
- temperature: number or null (Defaults: 1)
  使用するサンプリング温度は 0 から 2 まで。0.8 などの高い値を指定すると出力はよりランダムになり、0.2 などの低い値を指定すると出力はより集中的かつ決定論的になる
- text: object
  モデルからのテキスト応答の構成オプション。プレーンテキストまたは構造化された JSON データにすることができる
- tool_choice: string or object
  モデルが応答を生成するときに使用するツール (複数可) を選択する方法
- tools: array
  モデルが応答を生成する際に呼び出す可能性のあるツールの配列
- top_p: number or null (Defaults: 1)
  temperatureによるサンプリングの代替として、coreサンプリングと呼ばれるモデルがあり、このモデルでは top_p 確率質量を持つトークンの結果が考慮される。
  つまり、0.1 は、上位 10% の確率質量を構成するトークンのみが考慮されることを意味する
- truncation: string or null (Defaults: "disabled")
  モデル応答に使用する切り捨て戦略
- user: string
  エンドユーザーを表す一意の識別子
  OpenAI が不正使用を監視および検出するのに役立つ

## [組み込みツール](https://platform.openai.com/docs/guides/tools?api-mode=chat)

```py
from openai import OpenAI
client = OpenAI()

completion = client.chat.completions.create(
    model="gpt-4o-search-preview",
    web_search_options={},
    messages=[
        {
            "role": "user",
            "content": "What was a positive news story from today?",
        }
    ],
)

print(completion.choices[0].message.content)
```

### [Web search](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat)

### [File search](https://platform.openai.com/docs/guides/tools-file-search)

### [Computer use](https://platform.openai.com/docs/guides/tools-computer-use)
