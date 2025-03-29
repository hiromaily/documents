# LM Studio

LM Studio は、コンピューター上で大規模言語モデル (LLM) をローカルに実行して実験するために設計された多目的デスクトップ アプリケーション。
LM Studio は、ローカルのプライバシー重視の環境で LLM の機能を活用したいと考えている開発者、研究者、愛好家にとって強力なツール。

## 主要な機能

- **ローカル モデル実行**: LM Studio を使用すると、ユーザーは LLM を完全にオフラインで実行できるため、プライバシーと利便性が確保される。
- **モデル検出**: このアプリケーションを使用すると、ユーザーは Hugging Face リポジトリからさまざまな LLM を検索、ダウンロード、操作できる。
- **ユーザー フレンドリなインターフェイス**: LM Studio は ChatGPT のようなインターフェイスを提供するため、さまざまなモデルを簡単に操作できる。
- **互換性**: LLaMa、Falcon、MPT、StarCoder、Replit、GPT-Neo-X など、幅広いモデルをサポートしている。
- **OpenAI 互換サーバー**: LM Studio は、他のアプリケーションとのシームレスな統合を可能にする OpenAI 互換のローカル サーバー オプションを提供する。

## 技術仕様

- **プラットフォーム サポート**: Apple Mac Silicon (M1/M2/M3)、AVX2 対応の Windows PC、Linux (ベータ版) と互換性がある。
- **ハードウェア要件**: 最低 16 GB の RAM を推奨。PC の場合は 6 GB 以上の VRAM が必要。
- **GPU サポート**: 処理能力を高めるために NVIDIA/AMD GPU がサポートされている。

## プライバシーと使用方法

LM Studio は、データを収集したりユーザーの操作を監視したりしないことでユーザーのプライバシーを優先する。すべてのデータはユーザーのマシンにローカルに残る。個人使用は無料ですが、ビジネス ユーザーは具体的な取り決めについては要問い合わせ。

## ユースケース

- プライベートな研究プロジェクト用にローカル LLM を実行する
- AI をオフラインで使用してドキュメントを操作する
- ローカル モデル サポートを使用して AI アプリケーションを開発する
- クラウドに依存しない新しい LLM を探索する

## `lms` CLI

`.lmstudio/bin`を$PATHに追加

```sh
> lms --help
lms <subcommand>

where <subcommand> can be one of:

- status - Prints the status of LM Studio
- server - Commands for managing the local server
- ls - List all downloaded models
- ps - List all loaded models
- get - Searching and downloading a model from online.
- load - Load a model
- unload - Unload a model
- create - Create a new project with scaffolding
- log - Log operations. Currently only supports streaming logs from LM Studio via `lms log stream`
- import - Import a model file into LM Studio
- bootstrap - Bootstrap the CLI
- version - Prints the version of the CLI
```

## [Local LLM API Server](https://lmstudio.ai/docs/app/api)

1. Open LM Studio and go to `Developer` tab on the left.
2. ~~Click `Settings` and enable `Serve on Local Network`.~~
3. Enable `Status: Running`.
4. Check installed models by `lms ps`.
5. Load modules by lms `load <model_key> --identifier "my-custom-identifier"`
   - e.g. `lms load gemma-3-27b-it --identifier "gemma3"`
   - `lms load llama-3.2-3b-instruct --identifier "llama3"`

```sh
curl http://localhost:1234/v1/chat/completions \
    -H "Content-Type: application/json" \
    -d '{
        "model": "llama3",
        "messages": [
            {
                "role": "system",
                "content": "You are a helpful assistant."
            },
            {
                "role": "user",
                "content": "Can you explain about OpenAPI in detail?"
            }
        ]
    }'
```

### 使用上の注意

Macbook ProM3で`gemma-3-27b-it` modelをloadして、curlコマンドを1回実行しただけでマシンがめちゃくちゃ熱くなる。。。さらにレスポンスにも時間を要するため、かなりハイスペックなマシンが必要。[mlx-engine](./llm-engine.md)に対応したmodelのほうがいいと思われる。

### OpenAPI互換 API

OpenAPI互換のEndpointが備わっているが、2024/3時点では以下

- [`/v1/models`](https://platform.openai.com/docs/api-reference/models)
- [`/v1/chat/completions`](https://platform.openai.com/docs/api-reference/chat)
- `/v1/completions`
- [`/v1/embeddings`](https://platform.openai.com/docs/api-reference/embeddings)

-[参考: OpenAI Compatibility endpoints](https://lmstudio.ai/docs/app/api/endpoints/openai)

   ```py
   from openai import OpenAI

   client = OpenAI(
     base_url="http://localhost:1234/v1"
   )   
   ```

## MacOSで利用する際のパフォーマンスの最適化

1. MLX エンジンを使用する
   LM Studio 0.3.4 では Apple の MLX エンジンのサポートが導入された。これは Apple Silicon 向けに最適化されており、モデルの応答時間を大幅に改善できる。
2. 最適化されたモデルを使用する
   MLX 形式を使用するモデルなど、Apple Silicon 向けに特別に最適化されたモデルを探します[1]。
3. モデル サイズを最適化する
   MacBook Air のリソースに適した中規模のモデルまたは大規模モデルの抽出バージョンを選択する。
4. BLAS バッチ サイズを調整する
   BLAS バッチ サイズをデフォルトの 512 ではなく 256 に設定すると、プロンプトの処理速度がわずかに向上する。
5. コンテキストの長さを管理する
   コンテキストの長さが短いほど、一般的に応答時間が速くなる。
6. 他のアプリケーションを閉じる
   LLM で利用可能なリソースを最大化するために、LM Studio をバックグラウンド プロセスを最小限に抑えて実行する。

## References

- [LM Studio](https://lmstudio.ai/)
  - [Gemma3](https://blog.google/technology/developers/gemma-3/)のダウンロードが可能
  - [LM Studio REST API](https://lmstudio.ai/docs/app/api/endpoints/rest) (new, in beta)
  - [TypeScript SDK](https://lmstudio.ai/docs/typescript) - lmstudio-js
  - [Python SDK](https://lmstudio.ai/docs/python) - lmstudio-python
- [ローカルLLM時代到来！Gemma 3の導入・活用ガイド(LMStudio)](https://note.com/swiftwand/n/n7446b89763f0)
- [LM Studio + Gemma 3 + Cline + VSCode](https://tech.mntsq.co.jp/entry/2025/03/25/102902)
  - 一番軽量の`Gemma 3 4B Instruct`を利用している
