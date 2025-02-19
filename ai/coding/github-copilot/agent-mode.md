# Github Copilot エージェントモード

高度なAIによるコーディング支援を提供する新しい機能。
`Cursor Composer`や`Cline`と概ね似たことができ、エージェントに指示をすると目的を達成するまで自律的にコードの編集等をエディタ上で行ってくれる。

1. **複数ファイルへの対応**:
   - 単一のコマンドから複数のファイルにわたるコードの生成、リファクタリング、デプロイを実行できる.

2. **反復実行とエラー修正**:
   - AIがコードを実行し、テスト結果を評価して、必要に応じて修正を試みる。ランタイムエラーやコンパイルエラーを自動的に検知し修正する.

3. **セルフヒーリング機能**:
   - 自動的にエラーを認識し、修正を試みる。これにより、開発者のデバッグ工数を大幅に削減する.

4. **タスクの理解と計画**:
   - ユーザーの指示を理解し、必要なタスクを推測して補完する。単にコードを書くだけでなく、関連するファイルの作成と修正を包括的に行うことができるため、開発者の作業効率を向上させる.

5. **IDEとの統合**:
   - [Visual Studio Code Insiders版](https://code.visualstudio.com/insiders/)やJetBrains系IDEなどで利用可能。専用のチャットUIを使用して、自然言語で指示を出すことができる.

6. **カスタムエージェントの拡張**:
   - 外部ツールを直接呼び出す機能「Copilot Extensions」を使用して、自作のエージェントを組み込むことができる。社内のビルドツールやデプロイスクリプトをAIの指示で実行することができる.

## エージェントモードを有効にする

- **前提条件**: `Visual Studio Code Insiders版`が必要です。通常版のVS Codeではサポートされていない.
- **有効化手順**:
  1. **GitHub Copilotの設定を開く**:
     - VS Code Insidersの設定画面で「GitHub Copilot」を検索し、「GitHub Copilot: Enable Agent」を有効する.
  2. **コマンドパレットからの有効化**:
     - `Ctrl+Shift+P`（macOSの場合は`Cmd+Shift+P`）でコマンドパレットを開き、「GitHub Copilot: Toggle Agent Mode」を実行する.
  3. **サイドバーからの操作**:
     - VS Code Insidersのサイドバーで「GitHub Copilot」アイコンをクリックし、エージェントモードの切り替えスイッチをオンにする.

## References

- [GitHub Copilot Agent Modeが登場。タスクを与えると自律的にプログラミング、テストコードも修正、テストが失敗すればデバッグも](https://www.publickey1.jp/blog/25/github_copilot_agent_mode.html)
- [GitHub Copilot:エージェントの覚醒](https://github.blog/jp/2025-02-07-github-copilot-the-agent-awakens/)
- [「GitHub Copilot」のエージェントモードは、開発をどこまで自動化するのか？](https://atmarkit.itmedia.co.jp/ait/articles/2502/12/news060.html)
- [Github Copilot Agentでパワーが4倍に、1週間を振り返る](https://note.com/sys1yagi/n/n9a7b93554e3a)
