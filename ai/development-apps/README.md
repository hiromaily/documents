# 生成AIアプリケーション開発

- [エンジニアチームの生成AIアプリ開発、ハッカソンから始めた理由](https://zenn.dev/smartshopping/articles/deea9b5570f79f)
  - CursorとDevinという2つのAIコーディング環境
- [個人開発したサービスが２日で3 万リーチした話](https://zenn.dev/nogu66/articles/release-satorify-beta-version)
  - サーバーサイド(API): Dify
  - LLM: DeepSeek V3
  - プロトタイピング: Bold
  - Editor: Cursor
- [AIエージェントで前から欲しかったツールを作ってみた](https://knqyf263.hatenablog.com/entry/2025/02/25/120141)
- [QGIS・Claude・MCPで誰でも簡単に自然言語で地理情報解析ができる！！！](https://qiita.com/nokonoko_1203/items/1e841cbecf6895273f5d)

## LINEヤフー「データアワード」生成AI部門

[“非エンジニア”でも生成AIで効率化ツール量産　LINEヤフーで社内表彰グランプリを獲得したAI活用術とは](https://www.itmedia.co.jp/aiplus/articles/2503/13/news071.html)

LINEヤフーが社内表彰制度「データアワード」を開催し、2024年には生成AI部門が設けられた。グランプリ受賞者は非エンジニアでありながら生成AIを活用して業務効率化ツールを開発した。彼の取り組みは、特にマーケティングリサーチ業務において顕著。

### AI活用術

以下の3つの効率化ツールを開発した。

1. **FA分類ツール**
   - **目的**: アンケートの自由回答を属性別に分類。
   - **機能**: ユーザーの回答を自動で分類し、処理速度は250件を1～2分で完了。
   - **特徴**: 結果をグラフ化し、ビジュアライズ化が可能。

2. **テキストフィルター検索ツール**
   - **目的**: アンケートの自由回答から特定のワードをフィルタリング。
   - **機能**: 縦軸に自由回答、横軸にキーワードを設定し、自動分析を実施。
   - **特徴**: 8000件のデータを数分で処理。

3. **Zoom文字起こし要約ツール**
   - **目的**: Zoom会議の発言を文字起こしし、要約を提供。
   - **機能**: 会議中に発言を記録し、要約機能をワンクリックで使用。
   - **特徴**: 会議の振り返りを助け、議事録作成をサポート。

### 生成AIの重要性

生成AIを活用することで業務の効率化が可能であると強調している。彼は、生成AIを使わないことが企業にとって大きな差になる可能性があると述べ、実際に手を動かして試すことが重要であるとアドバイスしている。彼の取り組みは、社内エンジニアからも高く評価されており、今後の企業における生成AIの導入が期待されている。

## AIシステム例

- RAG（Retrieval-Augmented Generation）： 検索と生成モデルを組み合わせた応答生成
- マルチエージェントシステム： 複数のAIエージェント間で協調動作するシステム
- 埋め込みベースの検索： ユーザー入力と類似したコンテンツを高速で検索
- カスタマイズ可能なLLMアプリケーション： 特定ユースケース向けに調整されたLLMアプリケーション構築

## RAG（Retrieval-Augmented Generation）： 検索と生成モデルを組み合わせた応答生成

RAG（Retrieval-Augmented Generation）システムと検索エンジンを統合したLLM応答生成システムの開発例を、実装パターン別に3つのケースで解説する。

### 1. クラウドネイティブ型RAGシステム（Azure AI Search統合例）

検索エンジンとしてAzure AI Searchを活用するプロダクション向けアーキテクチャ：

```python
# ユーザークエリ処理の基本フロー
def rag_workflow(user_query):
    # Azure AI Searchで関連ドキュメント検索
    search_results = azure_search.query(
        query=user_query,
        top_k=5,
        vector_field="embedding"
    )
    
    # LLMプロンプトの構築
    context = "\n".join([doc.content for doc in search_results])
    prompt = f"""
    以下の文脈に基づき質問に回答せよ:
    {context}
    
    質問: {user_query}
    """
    
    # Azure OpenAIで応答生成
    response = openai.ChatCompletion.create(
        model="gpt-4-turbo",
        messages=[{"role": "user", "content": prompt}]
    )
    
    return response.choices[0].message.content
```

**実装特徴**：

- インデックス更新バッチ処理（毎時更新）
- ハイブリッド検索（ベクトル＋キーワード）
- セキュリティ層（RBAC対応）

### 2. オープンソース統合型（LlamaIndex + Brave Search）

検索エンジンにBrave Searchを利用するハイブリッド方式

```python
from langchain_community.retrievers import BraveSearchRetriever
from llama_index.core import VectorStoreIndex

# Brave Search統合レトリーバー
brave_retriever = BraveSearchRetriever(
    api_key="YOUR_KEY",
    search_kwargs={"count": 3}
)

# ローカルベクトルDBの構築
documents = load_enterprise_docs()
vector_index = VectorStoreIndex.from_documents(documents)

def hybrid_retrieval(query):
    # ウェブ検索結果取得
    web_results = brave_retriever.get_relevant_documents(query)
    
    # 内部ナレッジ検索
    local_results = vector_index.as_retriever().retrieve(query)
    
    return combine_results(web_results, local_results)

# Mixtral-8x7Bを用いた応答生成
response = mixtral.generate(
    context=hybrid_retrieval(user_query),
    query=user_query
)
```

**最適化ポイント**：

- 検索結果の再ランキング（Cross-Encoder採用）
- コスト最適化（無料APIと有料APIのルーティング）
- リアルタイムウェブ情報×社内ナレッジの統合

### 3. ドメイン特化型システム（医療向け事例）

MirascopeとLlamaIndexを活用した専門領域向け実装

```python
from mirascope.rag import RagToolkit
from llama_index.core import KnowledgeGraphIndex

# 医療オントロジーを活用した知識グラフ構築
kg_index = KnowledgeGraphIndex(
    documents=medical_docs,
    ontology=load_medical_ontology()
)

# RAGチェーン構成
med_rag = RagToolkit(
    retriever=kg_index.as_retriever(
        similarity_top_k=3,
        graph_traversal_depth=2
    ),
    llm=MedLlama2()
)

# セキュアなアクセス制御付き検索
@access_control(roles=["doctor"])
def handle_query(user, query):
    context = med_rag.retrieve(query)
    return med_rag.generate(
        context=context,
        query=query,
        safety_filters=load_safety_guidelines()
    )
```

**ドメイン特化機能**：

- HL7/FHIR規格準拠のデータ処理
- 自動コンプライアンスチェック
- 専門用語辞書連携

### 主要コンポーネント設計ガイド

| コンポーネント  | 技術選択肢                 | 最適化ポイント                           |
| --------------- | -------------------------- | ---------------------------------------- |
| データ取得層    | Scrapy, BeautifulSoup      | 動的ページ対応（JavaScriptレンダリング） |
| 検索エンジン    | Elasticsearch, Meilisearch | 分散インデシング設計                     |
| ベクトルDB      | Pinecone, Qdrant           | メタデータフィルタリング機能             |
| LLMゲートウェイ | LangChain, LlamaIndex      | フォールバックルーティング機構           |

**評価メトリクス設計例**：

```python
# 包括的評価指標の実装
def evaluate_rag_system(query, response):
    return {
        "retrieval_score": calculate_ndcg(
            retrieved_docs, ground_truth
        ),
        "generation_accuracy": bert_score(
            response, reference_answer
        ),
        "latency": system_latency,
        "cost_per_query": calculate_cost(
            search_api_calls + llm_tokens
        )
    }
```

### 開発プロセスにおける重要考慮事項

1. **検索品質の最適化**  
   - クエリリライティング（例：`"頭痛の対処法" → "成人の片頭痛 応急処置 医療ガイドライン"`）
   - マルチモーダル検索（CT画像×テキスト報告書の連携）

2. **LLM出力制御**  

   ```python
   # 安全な出力生成のためのプロンプト設計
   safety_prompt = """
   以下の制約を厳守せよ：
   1. 医学的アドバイスは提供しない
   2. 出典の明示（[1][2]形式）
   3. 不確実な情報は可能性の範囲で提示
   """
   ```

3. **継続的改善メカニズム**  
   - データフライホイール（ユーザーフィードバックの自動取り込み）
   - A/Bテスト基盤（検索アルゴリズム比較）

実装例で使用した技術スタックは、`AWS Bedrock`や`Google Vertex AI`などクラウドサービスへの移植が可能。最新の実装では検索エンジンとベクトルDBの連携（例：Elasticsearchのベクター検索機能）により、システムアーキテクチャが簡素化される傾向にある。
