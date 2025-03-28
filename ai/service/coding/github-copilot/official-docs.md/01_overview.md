# GitHub Copilot in VS Code

- 入力時にコードの候補を表示
- 複数のファイルに変更を加える
- コードについて質問する
- コードをリファクタリングして改善する
- コードの問題をデバッグして修正する
- 新しいプロジェクトやファイルをscaffoldする(足場を作る)
- テストの設定と生成
- コードのドキュメントを生成する
- VS Codeで生産性を向上

## キーボードショートカット

- `Ctrl+Cmd+I`: チャット ビューを開き、自然言語を使用して Copilot とのチャット会話を開始する。
- `Shift+Cmd+I`: Copilot Editビューを開き、複数のファイルにわたるコード編集セッションを開始する。
- `Shift+Option+Cmd+L`: クイックチャットを開いて、Copilot に簡単な質問する。
  - 狭いboxでは利用しづらいため、この機能は使わなくてもよい。チャットビューを使えばいい。
- `Cmd+I`: インライン チャットを開始して、エディターから直接 Copilot にチャットする。
  - リクエストを送信する。自然言語を使用するか、/コマンドを使用して Copilot に指示を与える。

## VS Code での GitHub Copilot の使用例

### 1. エディタでのコード補完

- Copilot は、入力時にコードを提案する
- `tab`キーを押して決定

### 2. 複数のファイルにわたる変更を反復する

- `Copilot Edits` (Shift+Cmd+I)から実行する
- TODO: どうやって実施するか不明

### 3. コーディングに関する質問に答える

- 構文や一般的なプログラミングの概念について Copilot に質問できる
- また、コードを選択して説明させることもできる (コードを選択して、`Cmd+I`)
- Copilot はワークスペースのコンテキストを持つことができるので、実装したいコードの質問ができる。
  - e.g. 連絡先ページを追加するにはどうすればいいですか?
  - e.g. データベースから顧客データを読み取るにはどうすればよいですか?

### 4. コードのリファクタリングと改善

- コードを選択して、`Cmd+I`でインラインチャットを表示し、可読性の向上やパフォーマンスの向上を依頼すればよい

### 5. 問題を修正

- `/fix`コマンドを使用して、エラーメッセージに対しての修正の提案ができる
- `/fixTestFailure`コマンドで、失敗したテストのコード修正の提案ができる
- ターミナル コマンドの修正を提案する
- TODO: 使い方はよくわからない

### 6. プロジェクトをスタートさせる

- `/new`コマンド
  - [内部Docs: prompt例](../prompt-example.md)

### 7. ユニットテストケースを生成する

- `/tests`コマンド？

### 8. コードドキュメントを生成する

- `/doc`コマンドでドキュメントを生成する
- TODO: 使い方はよくわからない

### 9. 生産性の向上

- コミット内のコード変更またはプル リクエスト内の変更に基づいて、AI によって生成されたコミット メッセージと PR の説明を作る
- ソース コード内のシンボルの名前変更を AI が提案する
