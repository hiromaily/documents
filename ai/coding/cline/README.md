# Cline (Claude Dev)

Cline(シーライン)は、`Anthropic社`が開発したAIエージェントで、Visual Studio Code（VS Code）などの統合開発環境（IDE）上で動作する。オープンソースとして提供され、開発者の生産性向上を目的としている。主な機能にはコードの修正、プロジェクトの構造解析、タスク自動化などが含まれる。

- [Official](https://cline.bot/)
- [github](https://github.com/cline/cline)
- [日本語Document](https://github.com/cline/cline/blob/main/locales/ja/README.md)

## 主な特徴

- **コードのサイクル自動実行**: Clineは、チャットを通じてプログラミングコードのサイクルをAIが自動で実行する。最新のLLMを活用し、コードの賢い提案や自動補完、インラインでのドキュメント表示などを行う。
- **複数のAIモデル選択可能**: Clineは、Claude 3.5 Sonnetモデルを基盤に、Google、AWSなど主要なLLMを利用可能にするため、プロジェクトに最適なサービスを選択して利用できる。
- **オープンソースでカスタマイズ可能**: Clineはオープンソースとして提供されているため、開発者が自由にカスタマイズすることができる。
- **様々な操作**: ファイルの作成・編集、プロジェクトの調査、ターミナルコマンドの実行が可能

## 機能

- **プロジェクトの初期設定を簡略化**: Clineは、新しいプロジェクトを始める際に必要なファイルやフォルダ構造をプロンプトで自動的に作成可能。
- **エラー修正とバージョン管理の効率化**: コード内のエラーを自動で検出・修正し、Gitを利用したバージョン管理もサポートする。
- **多様なAIサービスとの連携**: 複数のLLMを利用可能にし、プロジェクトに最適なサービスを選んで利用できるため、柔軟な開発を実現する。
- **繰り返し作業の自動化**: マウス操作やキーボード入力など、UI上の操作を自動化し、テストやデバッグ作業を効率化する。
- **プロジェクト毎のカスタム設定**: `.clinerules`を使ってプロジェクトごとのカスタム設定ができる
  - プロジェクト内のコード構造
  - コーディングルールの設定
  - コミットメッセージ, プルリクエストのタイトル・サマリーを生成するルール

## 種類

- **Cline（旧Claude Dev）**: オリジナル版のツールで、Visual Studio CodeなどのIDE内で動作する自律型コーディングエージェント。ファイルの作成・編集、ターミナルコマンドの実行、MCP（Model Context Protocol）によるカスタムツール作成などが可能。
- **Roo Cline**: Clineのフォーク版で、新しい実験的な設定や自動化機能を追加したバージョン。特定のプロジェクトや環境に最適化されている可能性がある。

## Clineで利用可能なAPI Provider (2025/1現在)

- OpenRouter
  - OpenRouterは、エージェントAIを提供するプロバイダーで、ClineはOpenRouterから最新のモデルリストを取得し、そのモデルを使用できる
- Anthropic
  - Anthropicは、AIモデルの提供会社で、主にClaude 3.5 Sonnetなどの高性能なLLMを提供している
- Google Gemini
  - Googleが開発した大規模言語モデルで、高性能な言語処理機能を提供する
- DeepSeek
  - オープンソースで公開されているAIモデルで、同等の性能を低コストで提供している (中華製)
- Mistral
  - Mistral AIは、フランス発のスタートアップで、Mixture of Experts (MoE) アーキテクチャを採用し、企業がカスタマイズ可能なLLMを提供している
- GCP Vertex AI
  - GCP Vertex AIは、Google Cloud PlatformのAIサービスで、AIのビジネス適用を支援するためのプラットフォーム
- AWS Bedrock
  - Amazon Web Servicesが提供するAI基盤で、AI開発を簡素化するためのサービス
- OpenAI
  - GPTなどの大規模言語モデルを提供する企業
- OpenAI Compatible
  - OpenAI互換のAPIを設定して、Clineで使用することができる
- VS Code LM API
  - VS Codeの Language Model APIで、Clineで使用するための一連のツールを提供する
- LM Studio
  - LM Studioは、ローカルモデルを使用するための環境で、そのモデルをClineで使用することができる

## 使用上の注意点

- API料金が予想以上に高くなる可能性がある
- APIのレートリミットに注意が必要
- コード変更中の画面操作でバグが発生する可能性がある
- 長いコードの場合、全行出力されないことがある

## 利用準備

1. [VscodeのClineのextension](https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev)をダウンロード
2. vscodeからCLINEを開き、`API Provider`を選ぶ
3. API Keyを設定する

## What can I do for you?の説明

```txt
Thanks to Claude 3.5 Sonnet's agentic coding capabilities, I can handle complex software development tasks step-by-step. With tools that let me create & edit files, explore complex projects, use the browser, and execute terminal commands (after you grant permission), I can assist you in ways that go beyond code completion or tech support. I can even use MCP to create new tools and extend my own capabilities.

Claude 3.5 Sonnet のエージェント コーディング機能のおかげで、複雑なソフトウェア開発タスクを段階的に処理できます。ファイルの作成と編集、複雑なプロジェクトの調査、ブラウザーの使用、ターミナル コマンドの実行 (許可後) ができるツールにより、コード補完やテクニカル サポートを超えた方法でお客様を支援できます。MCP を使用して新しいツールを作成し、独自の機能を拡張することもできます。
```

- [X上のDemo](https://x.com/sdrzn/status/1881761978986934582)

## References

- [Clineを使用した次世代AIコーディング。もうCursorは要らない？](https://qiita.com/noshut/items/0c1de89c766106b204a8)
- [claude.aiとclineを活用したコストと精度を両立するAI駆動開発手法](https://zenn.dev/sunwood_ai_labs/articles/ai-driven-development-cost-accuracy)
  - ステップ1: Web UIベースで要件を固める
    - 定額制で無制限に試行錯誤が可能
    - プロジェクトの構成を練りやすい
    - フォルダ構成とコアコードの生成が容易
  - ステップ2: clineに生成物を投入する
    - コスト削減が可能
    - 不足部分の自動補完
    - 変更ファイルの自動コミットとロールバック
    - ファイル作成とコマンド実行が得意
- [思いつきで作ったAIツールが5000スターを獲得した話](https://zenn.dev/yamadashy/articles/ai-tool-repomix-5000-star)
  - GitHubリポジトリのコードを1つのファイルにまとめるツール「Repomix」の開発と成功について説明
  - Repomixの主な特徴と利点:
    - GitHubリポジトリのコードを1つのファイルにまとめる
    - AIサービス（特にClaude）との相性が良い
    - CLIツールとして使いやすい
    - Webサイトでも同様の機能を提供
  - 現在の状況と今後
    - 個人開発や小規模プロジェクトでは十分な機能を提供
    - 中規模以上のプロジェクトへの対応が今後の課題
- [VS CodeとAIチャットの往復いらず！ 話題の拡張機能Clineで爆速開発してみよう](https://qiita.com/minorun365/items/b2990a7228e8cc4ed025)
  - Clineの特徴
    - VS Codeに拡張機能を追加するだけで使用可能
    - AIチャットとエディタの往復が不要になり、効率的な開発が可能
    - 自動/手動の補助レベルを調整可能
  - Clineの使用中の注意点:
    - API利用料が発生する
    - AIの回答にハルシネーション (人工知能（AI）が誤った情報や事実とは異なる情報を生成する現象) が含まれる可能性がある
    - コストを抑えるには、こまめに新規スレッドを開始することが推奨される
- [Reclineという庶民の味方！！GitHub CopilotでClineが使える](https://sitochablog.pages.dev/posts/recline/)
  - ReclineというClineをフォークしたプロジェクトの使い方
- [Clineを利用した開発が超快適なので、使っている.clinerulesを解説します](https://zenn.dev/berry_blog/articles/c72564d4d89926)
  - `.clinerules`の使い方について
- [「プログラマとCLINE - これはパンドラの箱なのか」を観た](https://laiso.hatenablog.com/entry/2025/01/27/125645)
  - CLINEの特徴と設計思想
    - 人間の介入を最小限に抑えながら自動的にコードを生成する
    - タスクランナーとして設計され、AIに主導権を与える
    - VSCode上で動作し、チャットUIを効果的に実装
  - CLINEの機能と実装
    - 複数のAIモデルを柔軟に切り替えて利用可能
    - プレーンテキストXMLを使用し、モデルの移植性を向上
    - MCPサーバーとの連携機能を持つ
  - CLINEの影響と課題
    - コード生成やテスト自動化により生産性が向上する可能性
    - AIの自律性に依存することによるリスクも存在
    - メタ情報の不足や実行環境の安全性に関する課題がある
  - 今後の展望
    - コードベースのメタ情報管理の改善
    - AIエージェント最適化アーキテクチャの可能性
    - プログラマー人口の増加に貢献する可能性
  - CLINEが従来のコーディング支援ツールとは異なるアプローチを取っており、プログラミングの未来に大きな影響を与える可能性がある
