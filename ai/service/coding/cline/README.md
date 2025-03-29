# Cline (Claude Dev)

Cline(シーライン)は、`Anthropic社`が開発した AI エージェントで、Visual Studio Code（VS Code）などの統合開発環境（IDE）上で動作する。オープンソースとして提供され、開発者の生産性向上を目的としている。主な機能にはコードの修正、プロジェクトの構造解析、タスク自動化などが含まれる。

- [Official](https://cline.bot/)
- [github](https://github.com/cline/cline)
- [日本語 Document](https://github.com/cline/cline/blob/main/locales/ja/README.md)

## 主な特徴

- **コードのサイクル自動実行**: Cline は、チャットを通じてプログラミングコードのサイクルを AI が自動で実行する。最新の LLM を活用し、コードの賢い提案や自動補完、インラインでのドキュメント表示などを行う。
- **複数の AI モデル選択可能**: Cline は、`Claude 3.5 Sonnet` モデルを基盤に、Google、AWS など主要な LLM を利用可能にするため、プロジェクトに最適なサービスを選択して利用できる。
- **オープンソースでカスタマイズ可能**: Cline はオープンソースとして提供されているため、開発者が自由にカスタマイズすることができる。
- **様々な操作**: ファイルの作成・編集、プロジェクトの調査、ターミナルコマンドの実行が可能

## 機能

- **プロジェクトの初期設定を簡略化**: Cline は、新しいプロジェクトを始める際に必要なファイルやフォルダ構造をプロンプトで自動的に作成可能。
- **エラー修正とバージョン管理の効率化**: コード内のエラーを自動で検出・修正し、Git を利用したバージョン管理もサポートする。
- **多様な AI サービスとの連携**: 複数の LLM を利用可能にし、プロジェクトに最適なサービスを選んで利用できるため、柔軟な開発を実現する。
- **繰り返し作業の自動化**: マウス操作やキーボード入力など、UI 上の操作を自動化し、テストやデバッグ作業を効率化する。
- **プロジェクト毎のカスタム設定**: `.clinerules`を使ってプロジェクトごとのカスタム設定ができる
  - プロジェクト内のコード構造
  - コーディングルールの設定
  - コミットメッセージ, プルリクエストのタイトル・サマリーを生成するルール

## Cline で利用可能な API Provider (2025/1 現在)

- OpenRouter
  - OpenRouter は、エージェント AI を提供するプロバイダーで、Cline は OpenRouter から最新のモデルリストを取得し、そのモデルを使用できる
- Anthropic
  - Anthropic は、AI モデルの提供会社で、主に Claude 3.5 Sonnet などの高性能な LLM を提供している
- Google Gemini
  - Google が開発した大規模言語モデルで、高性能な言語処理機能を提供する
- DeepSeek
  - オープンソースで公開されている AI モデルで、同等の性能を低コストで提供している (中華製)
- Mistral
  - Mistral AI は、フランス発のスタートアップで、Mixture of Experts (MoE) アーキテクチャを採用し、企業がカスタマイズ可能な LLM を提供している
- GCP Vertex AI
  - GCP Vertex AI は、Google Cloud Platform の AI サービスで、AI のビジネス適用を支援するためのプラットフォーム
- AWS Bedrock
  - Amazon Web Services が提供する AI 基盤で、AI 開発を簡素化するためのサービス
- OpenAI
  - GPT などの大規模言語モデルを提供する企業
- OpenAI Compatible
  - OpenAI 互換の API を設定して、Cline で使用することができる
- VS Code LM API
  - VS Code の Language Model API で、Cline で使用するための一連のツールを提供する
- LM Studio
  - LM Studio は、ローカルモデルを使用するための環境で、そのモデルを Cline で使用することができる

## 使用上の注意点

- API 料金が予想以上に高くなる可能性がある
- API のレートリミットに注意が必要
- コード変更中の画面操作でバグが発生する可能性がある
- 長いコードの場合、全行出力されないことがある

## 利用準備

1. [Vscode の Cline の extension](https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev)をダウンロード
2. vscode から CLINE を開き、`API Provider`を選ぶ
3. API Key を設定する

## What can I do for you?の説明

```txt
Thanks to Claude 3.7 Sonnet's agentic coding capabilities, I can handle complex software development tasks step-by-step. With tools that let me create & edit files, explore complex projects, use the browser, and execute terminal commands (after you grant permission), I can assist you in ways that go beyond code completion or tech support. I can even use MCP to create new tools and extend my own capabilities.

Claude 3.7 Sonnet のエージェント コーディング機能のおかげで、複雑なソフトウェア開発タスクを段階的に処理できます。ファイルの作成と編集、複雑なプロジェクトの調査、ブラウザーの使用、ターミナル コマンドの実行 (許可後) ができるツールにより、コード補完やテクニカル サポートを超えた方法でお客様を支援できます。MCP を使用して新しいツールを作成し、独自の機能を拡張することもできます。
```

## Demo

- [X 上の Demo](https://x.com/sdrzn/status/1881761978986934582)

## References

- [2024/10: Cline を使用した次世代 AI コーディング。もう Cursor は要らない？](https://qiita.com/noshut/items/0c1de89c766106b204a8)
- [2024/10: claude.ai と cline を活用したコストと精度を両立する AI 駆動開発手法](https://zenn.dev/sunwood_ai_labs/articles/ai-driven-development-cost-accuracy)
  - ステップ 1: Web UI ベースで要件を固める
    - 定額制で無制限に試行錯誤が可能
    - プロジェクトの構成を練りやすい
    - フォルダ構成とコアコードの生成が容易
  - ステップ 2: cline に生成物を投入する
    - コスト削減が可能
    - 不足部分の自動補完
    - 変更ファイルの自動コミットとロールバック
    - ファイル作成とコマンド実行が得意
- [2025/01: 思いつきで作った AI ツールが 5000 スターを獲得した話](https://zenn.dev/yamadashy/articles/ai-tool-repomix-5000-star)
  - GitHub リポジトリのコードを 1 つのファイルにまとめるツール「Repomix」の開発と成功について説明
  - Repomix の主な特徴と利点:
    - GitHub リポジトリのコードを 1 つのファイルにまとめる
    - AI サービス（特に Claude）との相性が良い
    - CLI ツールとして使いやすい
    - Web サイトでも同様の機能を提供
  - 現在の状況と今後
    - 個人開発や小規模プロジェクトでは十分な機能を提供
    - 中規模以上のプロジェクトへの対応が今後の課題
- [2025/01: VS Code と AI チャットの往復いらず！ 話題の拡張機能 Cline で爆速開発してみよう](https://qiita.com/minorun365/items/b2990a7228e8cc4ed025)
  - Cline の特徴
    - VS Code に拡張機能を追加するだけで使用可能
    - AI チャットとエディタの往復が不要になり、効率的な開発が可能
    - 自動/手動の補助レベルを調整可能
  - Cline の使用中の注意点:
    - API 利用料が発生する
    - AI の回答にハルシネーション (人工知能（AI）が誤った情報や事実とは異なる情報を生成する現象) が含まれる可能性がある
    - コストを抑えるには、こまめに新規スレッドを開始することが推奨される
- [2025/01: Cline を利用した開発が超快適なので、使っている`.clinerules` を解説します](https://zenn.dev/berry_blog/articles/c72564d4d89926)
  - `.clinerules`の使い方について
- [2025/01: 「プログラマと CLINE - これはパンドラの箱なのか」を観た](https://laiso.hatenablog.com/entry/2025/01/27/125645)
  - CLINE の特徴と設計思想
    - 人間の介入を最小限に抑えながら自動的にコードを生成する
    - タスクランナーとして設計され、AI に主導権を与える
    - VSCode 上で動作し、チャット UI を効果的に実装
  - CLINE の機能と実装
    - 複数の AI モデルを柔軟に切り替えて利用可能
    - プレーンテキスト XML を使用し、モデルの移植性を向上
    - MCP サーバーとの連携機能を持つ
  - CLINE の影響と課題
    - コード生成やテスト自動化により生産性が向上する可能性
    - AI の自律性に依存することによるリスクも存在
    - メタ情報の不足や実行環境の安全性に関する課題がある
  - 今後の展望
    - コードベースのメタ情報管理の改善
    - AI エージェント最適化アーキテクチャの可能性
    - プログラマー人口の増加に貢献する可能性
  - CLINE が従来のコーディング支援ツールとは異なるアプローチを取っており、プログラミングの未来に大きな影響を与える可能性がある
- [2025/01: Cline ＋ローカル版 DeepSeek R1 で AI コーディングを使い放題にする（高スペックマシン向け）](https://note.com/cppp_cpchan/n/n92c7795f5939)
- [2025/01:【完全版】Clineとは何かを徹底解説します](https://zenn.dev/aimasaou/articles/d5dfb5a5382440)
  - Clineを補助的に利用という考え
- [2025/02: [Slide] Cline+Claude SonnetでのAIプログラミングが心地よい](https://speakerdeck.com/tomohisa/cline-plus-claude-sonnetdenoaipuroguramingugaxin-di-yoi)
- [2025/02: Clineに自分をエミュレートさせて技術記事を代筆させてみたらビビった](https://zenn.dev/mizchi/articles/auto-mizchi-writer)
- [2025/02: Cline 試してみた](https://voluntas.ghost.io/try-cline/)
- [2025/02: CLINEに全部賭けろ](https://zenn.dev/mizchi/articles/all-in-on-cline)
- [2025/03: Clineに全部賭ける前に　〜Clineの動作原理を深掘り〜](https://zenn.dev/codeciao/articles/6d0a83e234a34a)
- [2025/03: Cline+Claudeでの開発を試してみた感想](https://zenn.dev/razokulover/articles/768337f838a110)
- [わざわざ言語化されないClineのコツ](https://zenn.dev/watany/articles/85af6cfb8dccb2)
- [色々なことをClineにやらせてみた](https://karaage.hatenadiary.jp/entry/2025/03/05/073000)
- [オレを救った Cline を紹介する](https://speakerdeck.com/codehex/orewojiu-tuta-cline-woshao-jie-suru)
- [VS Code拡張「Cline」、DeepSeek R1とV3を無料で利用可能に　AIコーディングアシスタントがより安価で使いやすく](https://www.itmedia.co.jp/aiplus/articles/2503/12/news182.html)
- [MCPで広がるLLM　~Clineでの動作原理~](https://zenn.dev/codeciao/articles/cline-mcp-server-overview)
- [ClineとAIエージェント時代のプログラミングに関する所感](https://zenn.dev/trysmr/articles/vscode_cline)
- [Slide: エンジニアに許された特別な時間の終わり](https://speakerdeck.com/watany/the-end-of-the-special-time-granted-to-engineers)
- [ゼロからコーディングエージェントを作るならこんなふうに](https://zenn.dev/minedia/articles/11822c2b509a79)
- [Cline、めっちゃ便利、お金が飛ぶ](https://speakerdeck.com/iwamot/cline-so-convenient-money-flies)
  - PlanをDeepSeek-R1に変更: コスト削減のためのモデル選択。
  - プロンプトキャッシュの利用:
- [ClineでMemory Bankをやめてタスクリストを使うことによってコンテキストを最適化してる](https://zenn.dev/jtechjapan_pub/articles/a1cace00f7f96f)

### Ref: derivative

- [2025/01: Recline という庶民の味方！！GitHub Copilot で Cline が使える](https://sitochablog.pages.dev/posts/recline/)
  - Recline という Cline をフォークしたプロジェクトの使い方
- [2025/03: AIコーディング時代の開発環境構築：VS Code × Cline（Roo Code）で爆速開発！](https://zenn.dev/mkj/articles/cf8536923d9cd7)
