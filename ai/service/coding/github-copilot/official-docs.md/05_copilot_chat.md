# WIP: Copilot Chatを使う

チャットで質問してコードの提案を得たり、コードの理解を深めたり、エディターを構成したりすることができる。ドキュメントやオンライン フォーラムで回答を探す代わりに、VS Code で直接 Copilot に質問し、提案をコードベースにすぐに適用できる。
また、Copilot ではプロジェクト内の複数のファイルにわたって直接編集を行うこともできる。この場合、`Copilot Edits` の使用を検討すること。既存のチャット会話を Copilot Edits に簡単に移動できる。

## VS Code で Copilot Chat にアクセスする

1. チャット ビュー: 質問に答えたり、コードの提案をしたりする AI アシスタントがサイドに表示される ( ⌃⌘I )
2. インライン チャット: エディターまたは統合ターミナルから直接インライン チャット会話を開始して、その場で提案を取得する ( ⌘I )
3. クイック チャット: 簡単な質問をして、元の作業に戻る

## 最初のプロンプトを送信する

流れとしては、

1. チャット ビューを開く
2. チャット入力フィールドにプロンプ​​トを入力する
3. Copilot からの応答を確認
4. 必要に応じて、回答を絞り込むためにフォローアップの質問をする

チャット入力フィールドに`/help`と入力すると、GitHub Copilot に関するヘルプや、Copilot Chat とのやり取り方法が表示される

### チャット入力フィールドにプロンプ​​トを入力する場合

いくつか例を挙げる

- コーディングやテクノロジーの概念について質問する。
  - リンクリストとは何ですか？
  - 人気のウェブフレームワークトップ10
- コーディングの問題を最も効果的に解決する方法についてアイデアをブレインストーミングする
  - プロジェクトに認証を追加するにはどうすればいいですか?
- コードブロックを説明する
  - `@workspace /explain`
  - このコードは何をするのですか?
- コード修正を提案する
  - `@workspace /fix`
  - このメソッドは FileNotFoundException を発生します
- ユニットテストケースまたはコードドキュメントを生成する
  - `@workspace /tests`
  - `@workspace /doc`
- VS Code の設定について質問する
  - @vscode ミニマップを無効にするにはどうすればいいですか?

[Copilot Chat Cookbook](https://docs.github.com/en/copilot/copilot-chat-cookbook)には様々なユースケースがあるため要参照

## AIモデルを変更する

## チャットプロンプトにコンテキストを追加する

- 具体的には、`特定のファイル`、`特定のコード シンボル`、`現在のエディターの選択`などを添付する
- `#codebase`プロンプトに追加することで、Copilotが適切なファイルを自動的に見つけられるようにする

[参照: チャット プロンプトにコンテキストを追加する方法](https://code.visualstudio.com/docs/copilot/copilot-chat-context)
Adding Chat Context

## チャット参加者: Chat participants

`Chat participants`は、あなたを助けることができる専門分野を持つドメイン エキスパートのようなもの。チャット入力フィールドに`@`と入力し、その後に`Chat participants名`を入力すると、`Chat participants`を呼び出すことができる。
組み込みの`Chat participants`はいくつかあるが、拡張機能によって`Chat participants`を追加することもできる。

インストールされているすべてのチャット参加者を一覧表示するには、`@`をチャット入力フィールドに入力する。

1. **@workspace**:
   - ワークスペース内のコードについて認識している。
   - これを使用してコードベースをナビゲートし、関連するクラスやファイルなどを検索する
   - e.g. @workspace how are notifications scheduled?
   - e.g. @workspace add form validation, similar to the newsletter page
2. **@vscode**:
   - VS Code の機能、設定、API について知っている。
   - e.g. @vscode the name of that thing when vscode fake opens a file? And how to disable it?
3. **@terminal**:
   - 統合ターミナル シェルとその内容について認識している。
   - e.g. @terminal how to undo the last commit
   - e.g. @terminal help with #terminalLastCommand
4. **@github**:
   - GitHub リポジトリの問題、PR などについて理解し、スキルを持っている
   - Bing API を使用して Web 検索を実行することもできる
   - e.g. @github What are all of the open PRs assigned to me?
   - e.g. @github #web what is the latest VS Code version
   - [参照: Using GitHub skills for Copilot](https://docs.github.com/en/copilot/using-github-copilot/copilot-chat/asking-github-copilot-questions-in-your-ide#using-github-skills-for-copilot)

### 実際に`@`入力後に補完されたもの

- @terminal
- @vscode
- @workspace
- @terminal /explain
- @vscode /search
- @vscode /startDebugging
- @workspace /explain
- @workspace /fix
- @workspace /fixTestFailure
- @workspace /new
- @workspace /newNotebook
- @workspace /setupTests
- @workspace /tests
- /help
- clear
- install Chat Extensions...

### 拡張機能を利用した `Chat participants` の例

- GitHub Pull Request
- Remote - SSH
- Github Copilit Chat
- MongoDB for VS Code
- Console Ninja
- Refex Previewer
- Github Copilot for Azure

## スラッシュコマンド

スラッシュ コマンドは、複雑なプロンプトを記述する必要をなくすために、`特定の指示へのショートカット`を提供する。プロンプトでスラッシュ コマンドを使用するには、`/`文字に続いてコマンドを入力する。`Chat participants`は独自のスラッシュ コマンドを提供できる。

たとえば、`@workspace /new Express app with pug and typescript` は新しいワークスペースを生成し、Pug ビュー エンジンを使用する TypeScript で新しい Express アプリをスキャフォールディングするためのショートカットとなる。

### 一般的な組み込みスラッシュ コマンド

- `/clear`: 新しいチャットセッションを開始する
- `/help`: GitHub Copilot の使用に関するヘルプを取得する
- `@workspace /explain（または/explain）`: 選択したコードがどのように機能するかを説明する
- `@workspace /fix（または/fix）`: 選択したコードの問題に対する修正を提案する
- `@workspace /new（または/new）`: 新しいワークスペースまたは新しいファイルのスキャフォールディングコード

利用可能なすべてのスラッシュ コマンドを一覧表示するには、`/`をチャット入力フィールドに入力する。

### 実際に`/`入力後に補完されたもの

- `/search`
- `/startDebugging`
- `/explain`
- `/fix`
- `/fixTestFailure`
- `/new`
- `/newNotebook`
- `/setupTests`
- `/tests`
- `/explain`
- `/help`
- `/clear`

## チャット変数

チャット変数を使用して、`プロンプトに特定のコンテキストを含める`。チャット変数を使用するには、チャット プロンプト ボックスに `#` を入力し、その後にチャット変数を入力する。

例

- `#codebaseCopilot`: コンテキストとして追加する関連ファイルを見つけるようにする
- `#selection`: 現在のエディターの選択内容をチャット プロンプトに追加する。

## インラインチャット

`エディターで直接編集する`には、インライン チャットを使用してプロンプトを送信する。Copilot は、エディター内のコードに合わせてコードの候補を提供する。エディターでコード ブロックを選択した場合、Copilot は質問の範囲をその選択範囲に限定する。

提案を受け取る場合は、`Enter`をクリック。

- コードの変更を尋ねる
- コードの説明依頼

## チャットビュー

- チャット ビューは、コード作業中に開いたままにしておくと便利な専用ビューであり、Copilot と複数ターンの会話を行うことができる。
- チャット ビューを別の場所にドラッグしたり、エディターとして開いたりできる。

**機能**:

- チャットからコードブロックを適用する
- チャット履歴

## クイックチャット

Copilot に簡単な質問をしたいが、完全なチャット ビュー セッションを開始したり、エディターでインライン チャットを開いたりしたくない場合に利用する

## ターミナルインラインチャット

ターミナルで Copilot インライン チャットを起動して、ターミナルやシェル コマンドに関連する質問に答えることができる

## スマートアクション (GUI)

いくつかの一般的なシナリオでは、スマート アクションを使用して、プロンプトを記述せずに Copilot からヘルプを取得できる。
これらのスマート アクションの例

- コミット メッセージの生成
- ドキュメントの生成
- コードの修正
- コードの説明コードの変更の確認

これらのスマート アクションは、VS Code UI 全体で利用できる。

## 音声対話を使用する

`VS Code Speech拡張機能`によって提供される VS Code の音声制御機能を使用すると、音声を使用してチャット会話を開始できる

「Hey Code」音声コマンドを使用

## プライバシーと透明性

プライベート リポジトリのワークスペース検索機能をさらに有効にするには、追加の権限が必要

## よくある質問

- コパイロット編集、インライン チャット、チャット ビュー、クイック チャットの中から選択するにはどうすればよいですか?
