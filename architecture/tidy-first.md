# Tidy First ?

これは、コードリファクタリングとソフトウェアのメンテナンスに特化した内容になっている。開発者がコードベースをクリーンで保守しやすくするための具体的な手法とベストプラクティスを提供している。

`リファクタリングよりも小さな単位でコードを整理する考え方`で、これを Tidying と呼び、リファクタリングのサブセットと定義付けている。当然、片づけはコードの振る舞いは変えない。

- [Oreilly: Tidy First](https://www.oreilly.com/library/view/tidy-first/9781098151232/)
- [日本語まとめ](https://qiita.com/kawasima/items/c31e9f770bb042a92254)

## 主なポイント

1. **コードのクリーンアップ**: 新しい機能を追加する前に既存のコードをクリーンアップする重要性が強調されている。これは、後々のバグ修正や追加機能の実装を容易にするため。

2. **リファクタリングの手法**: 効果的なリファクタリング手法やパターンについて詳述されている。リファクタリングはコードの動作を変えずに内部構造を改善するプロセス。

3. **テスト駆動開発 (TDD)**: リファクタリングとテスト駆動開発との関係や、テストを書くことでリファクタリングが安全に行えることが説明されている。

4. **コードの保守性と可読性の向上**: コードの読みやすさや理解しやすさを向上させるためのガイドラインやテクニック。

5. **技術債の管理**: 「技術債」とは、短期的な利益のために妥協したことで将来的に問題が発生する可能性が高い部分を意味する。この技術債を管理し、減少させる方法についても説明されている。

## 書籍の主要な章やテーマ

`Tidy First`マーチン・ファウラーの影響を受けているものの、独自の視点からコードリファクタリングとソフトウェアメンテナンスの実践を詳しく解説している

実践的かつ具体的なアプローチを提供し、ソフトウェア開発者がコードベースをクリーンで保守しやすいものにするためのガイドラインを詳細に説明している。

### 1. はじめに – Tidy First の意味と意義

- **「Tidy First」アプローチの基本概念**: 「Tidy First」は、問題を解決する前にコードをクリーンアップすることを奨励する。新しい機能を追加する際やバグを修正する前にコードの整然さを確保することで、後々の開発が容易になる。
- **技術債との関連性**: 技術債が蓄積すると、開発速度や品質に悪影響を及ぼす。この章では、技術債を減少させる意義が強調されている。

### 2. リファクタリングの基本

- **リファクタリングとは**: リファクタリングの定義とその目的について。
- **リファクタリングの手法**: 具体的なリファクタリングテクニック（例：メソッドの抽出、変数のリネーム、クラスの分割など）を紹介。
- **コード臭 (Code Smells)**: リファクタリングが必要な「臭い」の見つけ方と、その対応方法を解説。

### 3. テスト駆動開発（TDD）とリファクタリングの協力関係

- **TDD の基本概念とプロセス**: テスト駆動開発の導入とそのベストプラクティスを解説。
- **テストとリファクタリング**: リファクタリングを安全に行うためのユニットテストの重要性と、その具体的な書き方。

### 4. クリーンコードの原則

- **ソフトウェア設計の基本原則（SOLID 原則等）**: 可読性と保守性を高めるための設計原則。
- **リーダブルコード**: コードの可読性を向上させるテクニック（コメントの使い方、ネーミング規則、コードフォーマットなど）。

### 5. 実践的リファクタリング

- **大規模リファクタリングの戦略**: 大規模なコードベースをリファクタリングする際のアプローチと戦略。
- **継続的リファクタリング**: 日常的にリファクタリングを行い、常にコードをクリーンに保つ方法。
- **リファクタリングツールの紹介**: 具体的なツール（例：IDE のリファクタリング機能、静的分析ツールなど）を紹介し、その使い方を解説。

### 6. 組織とリファクタリング

- **リファクタリングの文化**: チーム全体でリファクタリングを取り入れるための文化づくり。
- **コードレビューの重要性**: 同僚のコードレビューによる品質向上と相互学習の促進。

### 7. リファクタリングのケーススタディ

- **具体的なリファクタリング事例**: 実世界のプロジェクトを題材に、リファクタリングを通じてどのようにコードが改善されるかを具体的に解説。

### 8. 課題と解決策

- **リファクタリングの障害とその対策**: リファクタリングを進める上で遭遇する一般的な問題とその解決策。

### 9. まとめと将来展望

- **リファクタリングの重要性の再確認**: 本書のまとめと、今後のソフトウェア開発におけるリファクタリングの重要性を再確認。
