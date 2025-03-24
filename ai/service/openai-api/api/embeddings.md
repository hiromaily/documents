# [Embeddings API](https://platform.openai.com/docs/api-reference/embeddings)

機械学習モデルやアルゴリズムで簡単に使用できる、特定の入力のベクトル表現を取得する。

```py
client.embeddings.create(
  model="text-embedding-ada-002",
  input="The food was delicious and the waiter...",
  encoding_format="float"
)
```

## [Vector embeddings](https://platform.openai.com/docs/guides/embeddings) 埋め込み

OpenAI のテキスト埋め込みは、テキスト文字列の関連性を測定する。埋め込みは、主に次のような目的で使用される

- 検索:（結果はクエリ文字列との関連性によってランク付けされる）
- クラスタリング:（テキスト文字列を類似性によってグループ化する）
- おすすめ:（関連するテキスト文字列を持つアイテムがおすすめされる）
- 異常検出:（関連性の低い外れ値を特定する）
- 多様性測定:（類似性分布を分析する）
- 分類:（テキスト文字列が最も類似したラベルによって分類される）

`embeddings`の実体は、浮動小数点数のベクトル (リスト) であり、2つのベクトル間の距離はそれらの関連性を測定する。距離が小さいと関連性が高く、距離が大きいと関連性が低いことを示す。

### 埋め込みの[料金](https://openai.com/ja-JP/api/pricing/)

リクエストは、入力内のトークンの数に基づいて課金される

### `embeddings`を取得する方法

`embeddings API`で`embedding model`名と一緒に文字列を送信する

```py
from openai import OpenAI
client = OpenAI()

response = client.embeddings.create(
    input="Your text string goes here",
    model="text-embedding-3-small"
)

print(response.data[0].embedding)
```

レスポンスには、埋め込みベクトル (浮動小数点数のリスト) と追加のメタデータが含まれる。埋め込みベクトルを抽出してベクトル データベースに保存し、さまざまなユース ケースに使用できる。

```json
{
  "object": "list",
  "data": [
    {
      "object": "embedding",
      "index": 0,
      "embedding": [
        -0.006929283495992422,
        -0.005336422007530928,
        -4.547132266452536e-05,
        -0.024047505110502243
      ],
    }
  ],
  "model": "text-embedding-3-small",
  "usage": {
    "prompt_tokens": 5,
    "total_tokens": 5
  }
}
```

デフォルトでは、埋め込みベクトルの長さは `text-embedding-3-small` の場合は `1536`、`text-embedding-3-large` の場合は `3072`。概念を表すプロパティを失うことなく埋め込みの次元を縮小するには、`dimension` パラメータを渡す。

### Embedding models

OpenAI は、`text-embedding-3-small`、`text-embedding-3-large`、`text-embedding-ada-002` という 3 つの主要なテキスト埋め込みモデルを提供している。

- text-embedding-3-small
- text-embedding-3-large
- text-embedding-ada-002

#### modelsの機能

1. **text-embedding-3-large**:
   - 英語と非英語の両方のタスクで最も優れた埋め込みモデル
   - ベンチマークで最高のパフォーマンス (MTEB スコア: 64.6%、MIRACL スコア: 54.9%)
   - 出力次元 3,072
   - ディープ セマンティック検索や高度なテキスト分析などの複雑なアプリケーションに最適
   - 100 万トークンあたり 0.13 ドル
2. **text-embedding-3-small**:
   - text-embedding-ada-002 よりもパフォーマンスが向上
   - パフォーマンスと効率のバランスが取れている
   - 出力次元 1,536
   - リアルタイム アプリケーションや計算リソースが限られている場合に適している
   - 100 万トークンあたり 0.10 ドル
3. **text-embedding-ada-002**:
   - 3 シリーズ モデルが導入される前の最高のパフォーマンス
   - 出力次元1,536
   - 依然として幅広い NLP タスクを処理可能
   - 100 万トークンあたり 0.02 ドル

`text-embedding-3-small` と `text-embedding-3-large` はどちらも、概念表現プロパティを失うことなく埋め込みの次元を縮小できる新機能を提供する。この柔軟性は、ストレージと処理要件の最適化に役立つ。

要約すると、text-embedding-3-large は最高のパフォーマンスを提供するが、コストが高くなる。text-embedding-3-small はパフォーマンスと効率のバランスが良く、text-embedding-ada-002 は多くの NLP タスクにとってコスト効率の高いオプションとなる。

#### パフォーマンスとベンチマークは以下の通り

| モデル                 | MTEB スコア | MIRACL スコア |
| ---------------------- | ----------- | ------------- |
| text-embedding-3-large | 64.6%       | 54.9%         |
| text-embedding-3-small | 62.3%       | 44.0%         |
| text-embedding-ada-002 | 61.0%       | 31.4%         |

### [Use cases](https://platform.openai.com/docs/guides/embeddings#use-cases)
