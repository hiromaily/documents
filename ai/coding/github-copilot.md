# GitHub Copilot

GitHub Copilotは開発者にとってさらに強力なツールとなり、開発プロセスを大幅に効率化する。

1. **マルチモデル対応**: AnthropicのClaude 3.5 Sonnet、GoogleのGemini 1.5 Pro、OpenAIのGPT-4o、o1-preview、o1-miniなどの業界トップクラスのモデルを選択可能なマルチモデル対応が可能。これにより、開発者は特定のタスクに最適なモデルを選択して使用できる。

2. **GitHub Spark**: GitHubはAIネイティブな開発ツール。これにより、自然言語を使用してカスタマイズされたウェブアプリを簡単に構築できるようになる。

3. **VS Code統合**:
   - **マルチファイル編集**: VS CodeでのCopilot Chatを使用して、自然言語のプロンプトに基づいて複数のファイルを同時に編集できる。
   - **パフォーマンス向上**: GitHub Code Searchを使用して、ブランチやプルリクエストに対しても高速な検索が可能。
   - **チャット機能**: チャットを使用してコードの差異を検証し、プルリクエストのレビューを自動化する機能が強化。

4. **拡張機能**:
   - **Copilot Extensions**: 開発者が独自の拡張を構築して内部ツールと連携することが可能。(2025年初頭に一般提供される予定)
   - **Xcodeサポート**: GitHub Copilotのコード補完機能がXcode用にパブリックプレビューで提供され、Appleプラットフォーム全体でアプリ開発をサポート。

5. **AIネイティブ開発**:
   - **Copilot Workspace**: Copilot Workspaceには、コード生成、修正、テストなどの機能が強化され、開発者が自然言語を使用してソフトウェア構築を効率化できる。
   - **GitHub Models**: Interactive Model Playgroundが拡張され、開発者がさまざまなAIモデルを比較・テストするための新しい機能が追加。

6. **セキュリティ**:
   - **Copilot Autofix**:large Code Auditを使用して脆弱性を自動的に修正する機能が強化。

## [GitHub Copilot Chat](https://docs.github.com/en/copilot/responsible-use-of-github-copilot-features/responsible-use-of-github-copilot-chat-in-your-ide?tool=vscode)

[https://github.com/copilot](https://github.com/copilot)
ここにアクセスすれば、チャット機能のみを単体で利用可能とのことだが、2024/12/19現在 何も表示されない？

## GitHub Copilotの設定

Githubページの設定内、[GitHub Copilot](https://github.com/settings/copilot)にアクセス

### GitHub Copilot内 ドキュメント

- [GitHub Copilot の使用についてのベスト プラクティス](https://docs.github.com/ja/copilot/using-github-copilot/best-practices-for-using-github-copilot)
  - Copilot の長所と短所を理解する
    - Copilot が最適な場合の一部を次に示します
      - テストと繰り返しコードの記述
      - デバッグと構文の修正
      - コードの説明とコメント
      - 正規表現の生成
  - 思慮深いプロンプトを作成する
    - 複雑なタスクを分割する
    - 要件について具体化する
    - 入力データ、出力、実装などの例を提供する
    - 適切なコーディング プラクティスに従う
- [GitHub Copilot のプロンプト エンジニアリング](https://docs.github.com/ja/copilot/using-github-copilot/prompt-engineering-for-github-copilot)

## References

- [GitHub Copilot のテクニック集](https://speakerdeck.com/rayuron/github-copilot-techniques)
