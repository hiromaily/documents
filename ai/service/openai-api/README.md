# OpenAI API

OpenAI が提供する一連のツールとサービスであり、これらを使ってさまざまな自然言語処理タスクを実行することができる。

## 主な機能

1. **言語モデル（GPT-4o）**:

   - **テキスト生成**: 入力されたプロンプトに続くテキストを生成することができる。創造的な執筆、ストーリーテリング、コンテンツ作成に利用できる。
   - **会話型 AI**: 人間と対話するような形で自然な言語を生成できる。カスタマーサポートチャットボットや対話型アシスタントに適している。
   - **要約**: 長い文章や文書を短く要約することができる。ニュース記事の要約やレポートの簡潔化に役立つ。
   - **翻訳**: 異なる言語間でのテキスト翻訳をサポートする。
   - **質問応答**: 質問に対して関連する答えを提供することができる。FAQ ボットや教育ツールに利用される。

2. **コーディング補助（Codex）**:
   - **コード生成**: 自然言語の説明からプログラムコードを生成することができる。コードのスクリプト、機能追加、および自動化タスクに使用できる。
   - **バグ修正**: コードの問題を特定し修正する提案を行うことができる。

## APIによって実現可能なタスク

1. **テキスト生成**：自然言語生成モデル（GPT-3.5, GPT-4など）を利用して、文章生成、コード生成、質問への応答などが可能。
2. **音声変換**：音声をテキストに変換するモデル（Whisper）があり、音声認識システムや文字起こしサービスなどに利用できる。
3. **画像生成**：テキストから画像を生成するモデル（DALL）があり、プロンプトに基づいた画像作成が可能。
4. **感情分析・テキスト分析**：テキストを数値に変換するモデル（Embeddings）があり、感情分析、テキスト分析などに利用できる。
5. **コンテンツフィルタリング**：センシティブなテキストを検出するモデル（Moderation）があり、コンテンツのフィルタリングに役立つ。
6. **チャットボットの開発**：自然言語生成モデルを活用して、企業向けの問い合わせ対応システムの開発が可能。
7. **翻訳**：大規模言語モデルを活用して、テキストの翻訳にも応用できる。

これらの機能を利用することで、ビジネスやサービスで高度な自然言語処理機能を統合することができる。

## 使用例

- **カスタマーサポートチャットボット**: 質問応答機能を活用して、ユーザーからの問い合わせに対して自動でレスポンスを提供。
- **コンテンツ作成支援**: ブログ記事、製品説明、クリエイティブライティングの補助。
- **教育ツール**: 授業の説明文や問題集の作成、教育内容の個別指導。

## 料金プラン

OpenAI API には使用量に応じた料金体系が存在する。API 呼び出しの数や生成されたトークンの量に基づいて課金される。
Minimumで`$5` per Month

## [利用可能なモデル](https://platform.openai.com/docs/models)

- gpt-4.5-preview
- o1
- o3-mini
- gpt-4o
- gpt-4o-mini
- gpt-4
- gpt-3.5-turbo

## 利用上の注意

- **エシカルな利用**: AI の生成するコンテンツが誤情報や偏見を含まないように注意する必要がある。
- **データプライバシー**: API に送信するデータの取り扱いについても配慮が必要。

## ライブラリ

- [Go: openai-go](https://github.com/openai/openai-go)
- [Python: openai-python](https://github.com/openai/openai-python)
- [Js/Ts: openai-node](https://github.com/openai/openai-node)

## 利用方法

1. **API キーの取得**:

   - [OpenAI のウェブサイト](https://platform.openai.com/login?launch)にアクセスし、アカウントを作成する。
     - `ChatGPT`と`API`のうち、`API`を選択
   - ダッシュボードから API キーを取得する。このキーは API にアクセスするために必要。

2. **API の呼び出し**:

   - HTTP リクエストを通じて、または公式のクライアントライブラリ（Python, Node.js など）を使って API を呼び出す。
   - 使用例（Python の場合）:

     ```python
     import openai

     openai.api_key = 'YOUR_API_KEY'

     response = openai.Completion.create(
         model="text-davinci-003",
         prompt="Tell me a joke",
         max_tokens=50
     )

     print(response.choices[0].text.strip())
     ```

3. **API の設定**:
   - **モデルの選択**: 使用するモデルを選択する（例: text-davinci-003）。
   - **プロンプトの設定**: 入力テキスト（プロンプト）を提供する。
   - **パラメータ設定**: max_tokens、temperature（生成されるテキストのランダムさ）、presence_penalty などのパラメータを設定して出力を調整する。

## [OpenAI.fm](https://www.openai.fm/)

An interactive demo for developers to try the new text-to-speech model in the OpenAI API.

OpenAIは2025年3月20日に次世代音声モデルをAPIに導入した。このAPIは[OpenAI.fm](https://www.openai.fm/)で試すことができる。この新しいモデルは「GPT-4o」および「GPT-4o-mini」アーキテクチャに基づいており、以下の特徴がある。

- **精度の向上**: 
   新しい音声モデルは、以前の「Whisper」モデルを上回る精度を持ち、特に単語の誤り率が改善されている。これにより、訛りや騒音、異なるスピードの発話が混在する状況でも高い認識精度が期待できる。

- **モデルの種類**:
  - **音声テキスト変換モデル**:
    - `gpt-4o-transcribe`
    - `gpt-4o-mini-transcribe`
  - **テキスト音声変換モデル**:
    - `gpt-4o-mini-tts`
  
- **カスタマイズ機能**: 
   新しいテキスト音声変換モデルでは、話す内容だけでなく、話し方を指定することが可能。例えば、「親身に話す」や「感情豊かに読み聞かせる」といった指示ができる。
- **開発者向けの提供**: 
   これらの音声モデルはAPIを通じて全ての開発者が利用でき、会話型エージェントの開発を支援する新しいSDKも提供される。

新しい技術は、カスタマーサービスや教育など、さまざまな分野での応用が期待されている。

[OpenAI、次世代音声モデルをAPIに導入 ～「親身なカスタマー担当のように話して」も可能](https://forest.watch.impress.co.jp/docs/news/1671860.html)

## References

- [OpenAI APIを使ってgit commitメッセージやコードレビューをAIに任せましょう！](https://recruit.gmo.jp/engineer/jisedai/blog/ai-gitcommit-message-codereview/)
- [OpenAIが「Responses API」「Agents SDK」を発表 ～AIエージェント構築を容易にする新ツール](https://forest.watch.impress.co.jp/docs/news/1670067.html)
