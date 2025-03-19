# AI Agent framework

## AI エージェント開発におすすめのフレームワーク

### 1. [LangChain](https://www.langchain.com/)

- **使用言語**: Python、JavaScript
- **主な特徴**:
  - **LLMインターフェース**: GPTやBard、PaLMなどの大規模言語モデル（LLM）と簡単に接続可能。
  - **プロンプトテンプレート**: 一貫したフォーマットでクエリを構成。
  - **エージェント**: クエリに対して最適なアクションシーケンスを決定する特別なチェーン。
  - **メモリ機能**: 短期および長期メモリをサポートし、会話型アプリケーションに最適。
  - **RAG（リトリーバル強化生成）モジュール**: 情報の保存と取得を可能にするツールを提供。
  - **リアルタイムデータ処理**: チャットボット、パーソナライズされた推奨システム、自動コンテンツ生成に最適。

### 2. [CrewAI](https://www.crewai.com/)

- **使用言語**: Python
- **主な特徴**:
  - 複数エージェントが役割分担して協力するマルチエージェントシステム。
  - 共有メモリとタスクの委任機能。
  - チームシミュレーションや研究ワークフロー向けの簡易オーケストレーション。
  - エージェント間での効率的な情報共有が可能。

### 3. [Phidata](https://docs.phidata.com/introduction)

- **使用言語**: Python
- **主な特徴**:
  - **マルチモーダルAIエージェント**: テキスト、画像、音声データを統合的に処理可能。
  - **ドメイン固有知識の統合**: ビジネスや業界特化型の知識をLLMに組み込む機能。
  - **長期メモリ機能**: 会話やセッションのコンテキストを保持。
  - **ツール統合**: API呼び出しやデータベース操作など、現実世界でのアクション実行が可能。
  - BYOC（Bring Your Own Cloud）対応で柔軟なデプロイメントが可能。

### 4. [Rig](https://rig.rs/)

- **使用言語**: Rust
- **主な特徴**:
  - **統一されたLLMインターフェース**: 複数のLLMプロバイダーに対応し、ベンダーロックインを回避。
  - **型安全な操作**: Rustの強力な型システムを活用し、コンパイル時にエラー検出が可能。
  - **高性能設計**: Rust特有のメモリ安全性とゼロコスト抽象化による効率的なAIワークフロー。
  - ベクトルストアとのシームレスな統合（RAGシステムやセマンティック検索に最適）。

### 5. [Dify](https://dify.ai/)

### 6. [Mastra](https://mastra.ai/)

- **使用言語**: TypeScript（JavaScriptのスーパーセット）
- **主な特徴**:
  - **型安全性**: TypeScriptを使用することで、開発中のエラーを減らし、コードの保守性を向上。
  - **モジュール性**: 必要なコンポーネントだけを選択して使用可能。
  - **エージェント開発**: 自律的にタスクを実行するインテリジェントエージェントを簡単に構築。
  - **ワークフロー構築**: グラフベースのステートマシンを使用して複雑な処理フローを管理。
  - **RAG（検索拡張生成）**: ドキュメントをチャンク化し、ベクトルデータベースと統合して関連情報を取得。
  - **評価機能**: 毒性、バイアス、関連性、事実の正確性などの自動テストを提供。
  - **サーバーレス対応**: VercelやCloudflare Workersなどで簡単にデプロイ可能。

- [Ref: Mastra入門 〜AIエージェント開発ツールの概要と使い方〜](https://zenn.dev/yosh1/articles/mastra-ai-agent-framework-guide)

### 7. [Vertex AI](https://cloud.google.com/vertex-ai)

- **使用言語**: 主にPython（他言語もサポート）
- **主な特徴**:
  - Google Cloudサービスとの統合が容易。
  - スケーラブルなAIエージェント開発向けのモジュラーアーキテクチャ。
  - NLP（自然言語処理）、画像認識、翻訳タスク向けの事前学習済みAPIを提供。
  - RAGシステムや生成AIワークフローとの強力な互換性。

### 8. [Amazon Bedrock Agent](https://aws.amazon.com/jp/bedrock/agents/)

- **使用言語**: 主にPython（複数言語対応）
- **主な特徴**:
  - マルチエージェント協調機能（タスクオーケストレーションはスーパーバイザー方式）。
  - GPTやClaudeなどのファウンデーションモデルをサポート。
  - エージェント間通信用の高度なデバッグツール。
  - AWSサービスとの緊密な統合。

- [AWS、「Amazon Bedrock」でRAGワークフロー構築を支援する「データオートメーション機能」を提供開始](https://atmarkit.itmedia.co.jp/ait/articles/2503/07/news069.html)

### 9. [Microsoft AutoGen](https://www.microsoft.com/en-us/research/project/autogen/)

- **使用言語**: Python、.NET（クロスランゲージ対応）
- **主な特徴**:
  - エージェント間通信用の非同期メッセージング機能。
  - ツール、メモリ、モデルなどプラグイン可能なモジュール設計。
  - OpenTelemetryを活用したワークフロー追跡ツール。
  - 組織全体でスケーラブルな分散型エージェントネットワーク構築が可能。
  - Microsoft WordやExcel、Azureサービスとの統合。

## 比較表

| フレームワーク       | 使用言語     | 主な特徴                                                  | 人気度                        |
| -------------------- | ------------ | --------------------------------------------------------- | ----------------------------- |
| LangChain            | Python, JS   | LLMインターフェース、エージェント構築、RAG対応            | 非常に高い                    |
| CrewAI               | Python       | マルチエージェント協調、タスク委任                        | 急速に成長中                  |
| Phidata              | Python       | マルチモーダル対応、業界特化型知識統合                    | 中程度                        |
| Rig                  | Rust         | 型安全、高性能設計                                        | 新興                          |
| Mastra               | TypeScript   | サーバーレス対応、RAG統合、グラフベースのワークフロー管理 | TypeScript開発者間で注目      |
| Vertex AI            | Python       | モジュラー設計、Google Cloudとの連携                      | Google Cloudユーザー間で高い  |
| Amazon Bedrock Agent | Python       | マルチエージェントオーケストレーション                    | AWSユーザー間で高い           |
| Microsoft AutoGen    | Python, .NET | 分散型ワークフロー構築、Azure連携                         | Microsoftエコシステム内で高い |

## おすすめポイント

1. 幅広い用途に対応する汎用フレームワークが必要なら:
   - 「LangChain」が最適。チャットボットやRAGシステム開発に非常に適している。

2. マルチエージェントシステム構築を重視する:
   - 「CrewAI」または「Amazon Bedrock」が良い選択。

3. 高性能かつRustで開発したい場合:
   - 「Rig」が最適です。型安全性と効率性が求められるプロジェクト向け。

4. クラウドサービスとの連携が必要なら:
   - Google Cloudユーザーなら「Vertex AI」
   - AWSユーザーなら「Amazon Bedrock」
   - Azureユーザーなら「Microsoft AutoGen」を選ぶと良い。

5. 業界特化型やマルチモーダル対応が必要なら:
   - 「Phidata」が最適です。企業向けアプリケーション開発に向いている

## References

- [AIエージェントフレームワークの概要と比較](https://qiita.com/masterpiecehack/items/fd6f9ea4a91ecd8933ab)
  - Agno (Python製)
  - Mastra (TypeScript製)
  - AutoGPT
  - CrewAI
  - Semantic Kernel
