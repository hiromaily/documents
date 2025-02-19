# 効果的なプロンプトエンジニアリングについて

プロンプトエンジニアリングは、生成 AI からの望ましい出力を得るために、指示や命令（プロンプト）を設計し、最適化するスキル。

## 基本原則

- **具体性**：指示の内容を具体的にすることで、AI が正確に理解しやすくなる
- **明確化**：複雑でわかりにくい命令を避け、明確な指示を与えることが重要
- **背景情報の提供**：AI に対して適切な背景情報を提供することで、出力の精度を高めることができる

## プロンプトの要素

- **命令・指示**：AI に対する具体的なタスクの指示
- **背景・文脈**：タスクに関連する背景情報や文脈
- **入力データ**：AI が処理するための具体的なデータ

## 主なテクニック

1. **Zero-shot プロンプト**：例を示さずに直接指示を与える方法
2. **Few-shot プロンプト**：AI に具体例を示してから指示を出す方法
3. **Chain-of-Thought(CoT)**：ステップバイステップで考えるよう指示する方法
4. **Tree of Thoughts(ToT)**：問題解決のための次のステップの生成とその実行
5. **ReAct**：質問に対するタスクの実行に外部サービスを利用する方法
6. **方向性刺激プロンプティング**：目的に沿った推論結果を返すように言語モデルを誘導するために、適切な方向性を持つ「刺激（ヒント）」を与えるテクニック

### [5 LLM Prompting Techniques Every Developer Should Know](https://www.kdnuggets.com/5-llm-prompting-techniques-every-developer-should-know)

## 開発者なら知っておくべき 5 つの LLM プロンプティングテクニック

1. **ゼロショットプロンプティング**：例やトレーニングなしでタスクを実行するテクニック。明確かつ具体的に指示することで、LLM はタスクを実行する。
   - 利用場面：明確な出力形式が求められる単純なタスク、迅速な結果が必要な場合、モデルが一般的によく理解しているタスク。
2. **フューショットプロンプティング**：モデルにいくつかの例を示し、同じパターンに従うように指示するテクニック。
   - 利用場面：非常に具体的な出力形式が必要な場合、一貫性が重要なタスク、ゼロショットでは望ましい結果が得られない場合。
3. **チェインオブソートプロンプティング**：複雑な問題を段階的に分解するようにモデルを促すテクニック。
   - 利用場面：複雑な推論タスク、正確性が重要な場合、モデルのロジックを検証したい場合、エラーのデバッグや理解に役立てたい場合。
4. **ツリーオブソートプロンプティング**：チェインオブソートプロンプティングをさらに発展させ、複数の推論パスを同時に探索する高度なテクニック。問題をより小さいステップに分解し、各ステップで複数のアプローチを生成、評価し、有望なパスのみを保持する。
   - 利用場面：複数の可能なアプローチが存在する問題、異なる解決策を比較する必要がある場合、創造的なタスク、最適なアプローチがすぐにわからない場合。
5. **ロールプロンプティング**：特定の視点や専門知識を想定して応答するようにモデルに指示するテクニック。
   - 利用場面：専門的な知識が必要な場合、問題に対する異なる視点を得たい場合、特定の技術的レベルを確保したい場合、創造的な問題解決。

これらのテクニックは相互に排他的ではなく、組み合わせることができる。重要なのは、各テクニックの強みを理解し、いつ適用するかを知ること。優れたプロンプティングは反復的なプロセスであることを忘れずに、実験と改良を重ねること。

## プロンプトの設計

- **複数のステップに分ける**：複雑なタスクを小さな段階に分けて、より正確で詳細な結果を得る
- **具体的な指示を与える**：AI に何をしてほしいのか、できるだけ明確に伝えることが重要
- **コンテキストを提供する**：AI に背景情報や状況を説明することで、より適切な回答を得る

## その他のコツ

- **スタイルやトーンの指定**：生成される文章のスタイルやトーンをある程度意図した方向に導くことができる
- **深津式プロンプト**：対象・条件・構造・敬語の 4 要素から成り立つプロンプト構成法で、簡潔でわかりやすい指示が特徴
