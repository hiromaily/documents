# Gemini

- 会話機能
- ファイル分析の機能

## Gemini Deep Research

主にリサーチ業務を効率化するために開発されており、リサーチ業務の時間と労力を大幅に軽減し、生産性の向上に役立つ。特にビジネスやアカデミックの現場で利用価値が高い機能。

1. **自律的な調査実行**:

   - ユーザーの質問に対して AI が自動的に調査計画を立案・実行し、必要な情報を収集する。

2. **包括的な情報収集**:

   - 複雑なトピックについて、数多くの Web ページの検索と中身の確認を AI が行い、包括的なレポートを生成する。

3. **マルチステップ・リサーチ**:

   - 複雑な質問に対して、自動で複数のサブトピックに分割して調査を実施する。

4. **大規模コンテキスト**:

   - Gemini の 1M トークンという大きなコンテキストウィンドウを活用し、豊富な情報を統合可能。

5. **ソースリンク付きレポート**:

   - 引用元の URL をまとめたレポートを生成し、Google ドキュメントで開いて編集することも可能。

6. **チャット形式での改良**:
   - レポート作成後も Gemini との対話形式で内容を改良・追記できるため、ユーザーは必要な情報をより深掘りすることができる。

### Ref for Deep Research

- [Gemini Advanced の新機能 Deep Research が日本語でも公開](https://blog.google/intl/ja-jp/company-news/technology/gemini-advanced-deep-research/)
- [Gemini Deep Research が日本語に対応したので使ってみた！複雑な調査も 5 分で分析・考察まで](https://www.lifehacker.jp/article/2501-gemini-how-to-deepresearch/)
- [Geminiの「Deep Research」が一部無料開放、ユーザーの趣味趣向に沿った回答生成も](https://k-tai.watch.impress.co.jp/docs/news/1670416.html)
- [グーグル、「Gemini」の「Deep Research」と「Gems」を無料提供へ](https://japan.zdnet.com/article/35230493/)

## Gemini Code Assist

[Refer to: Gemini Code Assist によるコーディング支援が無償で利用可能に](https://cloud.google.com/blog/ja/topics/developers-practitioners/gemini-code-assist?hl=ja)

Google Cloudの機能として、開発者向けに無償のAIコーディング支援ツール「Gemini Code Assist」が追加された。このツールは、世界中の開発者が利用できるように設計されいる。

- **無制限のコード補完:** Gemini Code Assistは、月に最大180,000回のコード補完を提供し、一般的な無料コーディングアシスタントの90倍の使用制限を持っている。
- **Gemini 2.0の活用:** 最新のAIモデルであるGemini 2.0を基盤にしており、さまざまなプログラミング言語をサポートしている。
- **コードレビューの効率化:** GitHub向けの機能を通じて、AIがコードレビューを支援し、スタイルの問題やバグを検出して自動的に修正提案を行う。
  - [gemini-code-assist](https://github.com/apps/gemini-code-assist)

### Gemini Code Assistの利用可能なプラットフォーム

- **IDEの統合:** Visual Studio CodeやJetBrains IDEで利用可能で、開発者はこれまでエンタープライズ向けに提供されていた機能を個人でも利用できる。
- **自然言語による操作:** 開発者は自然言語でプロンプトを入力することで、迅速にコードを生成したり、既存のコードを改善したりできる。
- [vscode extension](https://marketplace.visualstudio.com/items?itemName=Google.geminicodeassist)

### Ref for Gemini Code Assist

- [Google、「Gemini Code Assist」を無料公開　コード補完は月当たり18万回](https://www.itmedia.co.jp/aiplus/articles/2502/26/news125.html)
  - GitHubとの連携により、「Gemini Code Assist for GitHub」を通じて無料のAIによるコードレビューが提供される
  - IDE（Visual Studio CodeやJetBrains IDE）との統合により、コード補完、生成、チャット機能が利用可能

## [Gemini Canvas](https://gemini.google/overview/canvas/)

- [ドキュメント作成/コード生成特化！Gemini「Canvas」展開](https://jetstream.blog/archives/196521)

## AI Overview (旧 Google SGE)

### [生成 AI 検索](https://www.technologyreview.jp/s/352931/generative-ai-search-10-breakthrough-technologies-2025/)

生成 AI 検索がインターネット検索のあり方を根本的に変えつつある現状と、その未来について

- **実現済み**：Google の Gemini を活用した「AI による概要」のリリースは、すでに多くの人々の検索方法に影響を与えている。
- **AI エージェントへの第一歩**：生成 AI 検索は、質問やタスクを処理する AI エージェントの実現に向けた重要なステップ。
- **簡潔な回答**：「AI による概要」は、リンクのリストではなく、直接的な回答を提供し、ユーザーは迅速に知見を得ることができる。
- **広がる AI 検索**：Google だけでなく、Microsoft や OpenAI も生成 AI 検索を導入しており、画像、音声、動画を分析してカスタマイズされた回答を提供する AI 支援検索が普及している。
- **Google の優位性**：Google は検索における世界的な優位性を持っており、「AI による概要」を世界中で 10 億人以上に展開している。
- **会話のような検索**：ユーザーはより長い質問やフォローアップをするようになり、検索がより会話のように感じられるようになっている。
- **メディアへの影響**：生成 AI 検索は、ニュース記事などの情報を要約して回答するため、元のソースへのクリックが減少し、Web サイトの広告収入を奪う可能性がある。
- **新たな戦場**：多くの出版社やアーティストが、AI モデルの訓練にコンテンツが使用されたとして訴訟を起こしており、生成 AI 検索はメディアと巨大テック企業間の新たな対立の火種となっている。

### キープレイヤー

- Apple
- Google
- Meta
- マイクロソフト
- OpenAI
- Perplexity

生成 AI 検索は、私たちの情報収集方法を大きく変えようとしている。その利便性の高さから普及が進む一方で、メディアや広告業界への影響、著作権の問題など、解決すべき課題も多く存在する。今後は、これらの課題に対する取り組みが、生成 AI 検索の未来を左右することになるだろう。

## References

- [Talk naturally with Gemini Live](https://support.google.com/gemini/answer/15274899)
- [Gemini から欲しい回答を引き出すプロンプト術](https://note.com/google_gemini/n/n60a9c426694e)
- [全 Gemini プロダクトを徹底解説！](https://blog.g-gen.co.jp/entry/gemini-product-explained)
- [ChatGPT o1 と Gemini 2.0 の性能を比較してみた](https://note.com/it_navi/n/nb14063a4f6e0)
- [企業向け Gemini 活用ガイド pdf](../images/pdf/GeminiforBusiness_Handbook202406_eBook.pdf)
- [Google の最新型 AI「Gemini 2.0」って何ができるの？](https://www.lifehacker.jp/article/2412-google-announced-efficient-new-gemini/)
- [Gemini 2.0 Flashで実現する高コスパAI開発 〜実践的プロンプトエンジニアリングと文書管理システムの実装例](https://speakerdeck.com/erukiti/gemini-2-dot-0-flash-prompt-engineering)
