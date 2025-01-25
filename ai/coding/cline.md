# Cline (Claude Dev) 

Cline(シーライン)は、Anthropic社が開発したAIエージェントで、Visual Studio Code（VS Code）などの統合開発環境（IDE）上で動作する。オープンソースとして提供され、開発者の生産性向上を目的としている。主な機能にはコードの修正、プロジェクトの構造解析、タスク自動化などが含まれる。

## 主な特徴

- **コードのサイクル自動実行**: Clineは、チャットを通じてプログラミングコードのサイクルをAIが自動で実行する。最新のLLMを活用し、コードの賢い提案や自動補完、インラインでのドキュメント表示などを行う。
- **複数のAIモデル選択可能**: Clineは、Claude 3.5 Sonnetモデルを基盤に、Google、AWSなど主要なLLMを利用可能にするため、プロジェクトに最適なサービスを選択して利用できる。
- **オープンソースでカスタマイズ可能**: Clineはオープンソースとして提供されているため、開発者が自由にカスタマイズすることができる。

## 機能

- **プロジェクトの初期設定を簡略化**: Clineは、新しいプロジェクトを始める際に必要なファイルやフォルダ構造をプロンプトで自動的に作成可能。
- **エラー修正とバージョン管理の効率化**: コード内のエラーを自動で検出・修正し、Gitを利用したバージョン管理もサポートする。
- **多様なAIサービスとの連携**: 複数のLLMを利用可能にし、プロジェクトに最適なサービスを選んで利用できるため、柔軟な開発を実現する。
- **繰り返し作業の自動化**: マウス操作やキーボード入力など、UI上の操作を自動化し、テストやデバッグ作業を効率化する。

## 種類

- **Cline（旧Claude Dev）**: オリジナル版のツールで、Visual Studio CodeなどのIDE内で動作する自律型コーディングエージェント。ファイルの作成・編集、ターミナルコマンドの実行、MCP（Model Context Protocol）によるカスタムツール作成などが可能。
- **Roo Cline**: Clineのフォーク版で、新しい実験的な設定や自動化機能を追加したバージョン。特定のプロジェクトや環境に最適化されている可能性がある。

## 利用法

- **Clineの利用**: VS Code上で「Hi, I’m Cline」欄からAPI Providerを選択し、APIキーを入力して使用を開始する。プロンプトを通じてファイル作成・コード生成・ターミナルでの実行までの一連作業を実行できる。

## References

- [Clineを使用した次世代AIコーディング。もうCursorは要らない？](https://qiita.com/noshut/items/0c1de89c766106b204a8)
- [claude.aiとclineを活用したコストと精度を両立するAI駆動開発手法](https://zenn.dev/sunwood_ai_labs/articles/ai-driven-development-cost-accuracy)
- [思いつきで作ったAIツールが5000スターを獲得した話](https://zenn.dev/yamadashy/articles/ai-tool-repomix-5000-star)
- [VS CodeとAIチャットの往復いらず！ 話題の拡張機能Clineで爆速開発してみよう](https://qiita.com/minorun365/items/b2990a7228e8cc4ed025)
- [Reclineという庶民の味方！！GitHub CopilotでClineが使える](https://sitochablog.pages.dev/posts/recline/)
