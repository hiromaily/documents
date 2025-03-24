# Ollama

Ollamaとは、ローカル環境でオープンソースの大規模言語モデル（LLM）を実行できるツール

## 特徴

1. **モデルのダウンロードと実行**: Ollamaは、`LLaMA-2`、`Mistral`、`DeepSeek R1`などのさまざまなモデルのダウンロードと実行をサポートしている。

2. **GPUアクセラレーション**: ハードウェアアクセラレーションに対応しており、NVIDIA GPUやIntel AVX/AVX2などのCPU命令セットを使用してモデルの実行を高速化する。

3. **効率的なモデル管理**: モデルの重み、設定、データセットを一つのモデルファイルで管理し、自動的なメモリ割り当てを行う.

4. **幅広いモデルへの対応**: 様々なLLMに対応しており、ユーザーはスムーズにモデルを切り替えることができる.

5. **Web UIオプション**: Ollamaは、ユーザーフレンドリーなWeb UIオプションを提供し、簡単にモデルを使用できる.

6. **CLIリファレンスとAPI**: モデルの作成、更新、削除など、さまざまなCLIコマンドを提供し、REST APIも利用可能.

7. **ツールコール機能**: Ollamaは、LLMが外部ツールやAPIと連携するためのメカニズムを提供する。これにより、リアルタイムでのデータ取得や特定のタスクの実行が可能となる.

Ollamaは、開発者や研究者がローカルでLLMを効率的に扱うことができるツールであり、AIの進化に大きな役割を果たしている。

## 使い方

[公式](https://ollama.com/download)からtoolをダウンロード

**コマンド**:

```sh
> ollama --help
Large language model runner

Usage:
  ollama [flags]
  ollama [command]

Available Commands:
  serve       Start ollama
  create      Create a model from a Modelfile
  show        Show information for a model
  run         Run a model
  stop        Stop a running model
  pull        Pull a model from a registry
  push        Push a model to a registry
  list        List models
  ps          List running models
  cp          Copy a model
  rm          Remove a model
  help        Help about any command

Flags:
  -h, --help      help for ollama
  -v, --version   Show version information
```  

### サブコマンド

- **serve**:
   デフォルトではポート `11434` で実行される Ollama サーバーを起動する。このコマンドは、OLLAMA_DEBUG や OLLAMA_HOST などのさまざまな環境変数を使用して構成できる。
- **create**:
   ベース モデルと変更を指定する Modelfile を使用してカスタム モデルを作成できる。
- **show**:
   特定のモデルに関する詳細情報 (サイズ、作成日、構成など) を表示する。
**run**:
   推論のためにモデルを実行します。モデルがまだダウンロードされていない場合は、最初に自動的にプルされる]。
**stop**:
   現在実行中のモデルを停止する。
**pull**:
   レジストリからローカル マシンにモデルをダウンロードする。
**push**:
   ローカルマシンからモデルをレジストリにアップロードする。
**list**:
   ローカルマシンで現在利用可能なすべてのモデルのリストを表示する。
**ps**:
   現在実行中のモデルのリストを表示する。
**cp**:
   既存のモデルのコピーを作成する。
**rm**:
   ローカルマシンからモデルを削除する。

## WIP: [Local LLM API Server](https://lmstudio.ai/docs/app/api)

- [githhub:API](https://github.com/ollama/ollama/blob/main/docs/api.md)
- [Docs: OpenAI compatibility](https://ollama.com/blog/openai-compatibility)

```sh
ollama pull llama3.3
ollama serve
```

```sh
curl http://localhost:11434/v1/chat/completions \
    -H "Content-Type: application/json" \
    -d '{
        "model": "llama3.3",
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

## References

- [OllamaでローカルLLMを稼働させAPIサーバ化する](https://zenn.dev/oyashiro846/articles/797312443fb506)
