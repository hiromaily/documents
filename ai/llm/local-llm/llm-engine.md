# LLM Engine

LLM エンジンは、大規模言語モデル (LLM) の微調整と提供のために設計されたオープンソース エンジン。
LLMエンジンは、大規模な言語モデルの導入と微調整のプロセスを簡素化し、広範なインフラストラクチャや機械学習の専門知識を持たないユーザーでも利用しやすくすることを目的としている。これはPythonライブラリとHelmチャートとして利用可能で、基盤モデルの提供と微調整に必要なツールを提供する。

## 主要な機能

1. Deploymentと提供:
   LLM エンジンを使用すると、ユーザーは Llama-2、MPT、Falcon などのオープンソースの基盤モデルを展開して提供できる。
2. Fine-tuning 微調整:
   ユーザーは、独自のデータを使用してオープンソースの基盤モデルをカスタマイズし、パフォーマンスを最適化できる。
3. 推論の最適化:
   このエンジンは、応答のストリーミングと入力の動的なバッチ処理のための API を提供し、スループットの向上とレイテンシの削減に役立つ。
4. 柔軟性:
   LLM エンジンは、1 つのコマンドで任意の Hugging Face モデルの展開をサポートし、シンプルな API を使用して任意の Docker イメージを自動スケーリング展開に変換できる。
5. アクセシビリティ:
   Scale のホスト型インフラストラクチャで使用することも、Kubernetes を使用してユーザー独自のクラウド インフラストラクチャに展開することもできる。

## 種類

### [mlx-engine](https://github.com/lmstudio-ai/mlx-engine)

- [LM Studio 0.3.4 ships with Apple MLX](https://lmstudio.ai/blog/lmstudio-v0.3.4)
  - MacOSで利用する場合は、`mlx-community/`とあるModelsを利用するといい
