# VectorDBの使い方

## 1. VectorDBの選定

主要なベクトル検索エンジンと特徴

| ミドルウェア                | 特徴                                                 | 適用例                           |
| --------------------------- | ---------------------------------------------------- | -------------------------------- |
| **Qdrant**                  | Rust製・高パフォーマンスメタデータフィルタリング対応 | リアルタイム更新が必要なECサイト |
| **Vertex AI Vector Search** | GoogleのScaNNアルゴリズムマネージドサービス          | 大規模データのクラウド処理       |
| **Elasticsearch**           | ハイブリッド検索（ベクトル+全文検索）                | 既存ES環境の拡張                 |
| **pgvector**                | PostgreSQL拡張・SQL連携容易                          | RDBMS統合型システム              |
| **FAISS**                   | メモリ内高速検索ローカル環境向け                     | 小規模PoC開発                    |

## 2. データ蓄積パイプライン

ベクトル検索データフロー

```python
# データ前処理の典型例（Vertex AI[5]を参考）
def data_processing_pipeline(text_data):
    # テキスト正規化
    cleaned_text = clean_html_tags(text_data)
    
    # チャンキング（Salesforce手法）
    chunks = recursive_text_splitter(
        text=cleaned_text,
        chunk_size=512,
        overlap=64
    )
    
    # ベクトル変換（Google Embeddings API）
    embeddings = vertexai.text_embedding(
        model="text-embedding-004",
        texts=chunks
    )
    
    # メタデータ付与（商品カタログ例）
    metadata = {
        "source": "product_db",
        "last_updated": datetime.now(),
        "category": classify_text(chunks)
    }
    
    # ベクトルDB登録
    qdrant_client.upsert(
        vectors=embeddings,
        payloads=[{"text": t, **metadata} for t in chunks]
    )
```

## 3. 検索実行プロセス

基本フロー

1. クエリベクトル化：`query_vec = embed(query_text)`
2. 近似最近傍探索：`results = vector_db.search(query_vec)`
3. 再ランキング：`reranked = cross_encoder.rerank(results)`

### 高度な検索例（ECサイト向け）

```rust
// Qdrant使用例（Rust実装）
async fn semantic_search(query: &str) -> Result> {
    let query_embedding = embedder.embed(query).await?;
    
    let results = qdrant_client
        .search(Query {
            vector: query_embedding,
            filter: Some(Filter::match_any(
                "category", 
                current_user.preferred_categories
            )),
            params: SearchParams {
                hnsw_ef: 128,
                exact: false,
                ..
            },
            limit: 50,
            ..Default::default()
        })
        .await?;

    boost_recent_items(&mut results); // 時系列ブースト
    apply_personalization(&mut results); // 個人化フィルタリング
    
    Ok(results.into_iter().take(10).collect())
}
```

## 4. 主要ユースケース別構成

### [カスタマーサポート（Zilliz事例）](pplx://action/followup)

```
[テキスト入力]
  → NLP前処理
  → ベクトル検索（ナレッジベース）
  → LLMによる回答生成
  → ランキングAPIで精度向上
```

### ECサイト検索

```
[商品クエリ]
  → マルチモーダル埋め込み（テキスト+画像）
  → ハイブリッド検索（ベクトル+ファセット）
  → リアルタイムパーソナライゼーション
```

## 5. パフォーマンス最適化手法

- **インデックス設計**: HNSW vs IVF（精度と速度のトレードオフ）
- **メモリ管理**: 部分ロード戦略（大規模データ向け）
- **キャッシュ層**: Redisによるクエリ結果キャッシュ
- **並列処理**: SIMD命令活用（FAISS[6]の特徴）

## 6. 運用監視指標

```python
monitoring_metrics = {
    "検索精度": calculate_ndcg(actual_results, expected),
    "レイテンシ": search_latency_p99,
    "コスト/クエリ": (embedding_cost + search_cost),
    "キャッシュヒット率": redis_hit_rate,
    "データ鮮度": timedelta(last_update)
}
```

ベクトル検索システムの構築では、Salesforce事例のようにハイブリッドアプローチ（ベクトル+メタデータ）を採用するのが現代のベストプラクティス。Google Vertex AIが提供するマネージドサービスか、QdrantのようなOSSソリューションの選択は、スケール要件と運用リソースで決定する。小規模システムでは`pgvector`が`RDBMS`連携で有利だが、大規模リアルタイムシステムではQdrantやVertex AIが適している。
