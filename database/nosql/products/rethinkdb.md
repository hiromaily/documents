# RethinkDB

RethinkDBは、リアルタイムデータ更新を重視したアプリケーションに非常に適したNoSQLデータベース。シンプルなクエリ言語（ReQL）とスケーラビリティ、フルテキスト検索など多くの機能を備えており、ただ保存するだけでなく、リアルタイムにデータの変更を検知して処理する能力が強み。オープンソースとして多くのユーザーや開発者に支持されている。

[github](https://github.com/rethinkdb/rethinkdb)では、26.9k Starを誇るが、2023年12月で更新が止まっている

## 主な特徴

1. **リアルタイム更新**
   - RethinkDBは、データの変更をリアルタイムでクライアントにプッシュする機能を提供する。これにより、開発者はリアルタイムフィードやライブダッシュボードといったデータの即時性が求められるアプリケーションを容易に構築できる。

2. **スケーラビリティ**
   - 水平スケーラビリティを備えており、複数のノードにデータを分散して保存する。これにより、大規模なデータセットにも対応可能。

3. **シンプルなクエリ言語（ReQL）**
   - RethinkDBは、非SQLクエリ言語である`ReQL`を使用する。ReQLは、JavaScriptやPythonなどで直感的に記述できる。

4. **フルテキスト検索**
   - データベース内のドキュメントに対するフルテキスト検索機能を提供している。

5. **データモデル**
   - `ドキュメント指向のデータモデル`を採用しており、JSON形式でデータを保存する。スキーマレスな設計のため、柔軟なデータ構造を持つアプリケーションに適している。

## 基本的な使用法

1. **データベースの作成**

   ```py
   import rethinkdb as r
   r.connect("localhost", 28015).repl()
   r.db_create("test_db").run()
   ```

2. **テーブルの作成**

   ```py
   r.db("test_db").table_create("test_table").run()
   ```

3. **データの挿入**

   ```py
   r.db("test_db").table("test_table").insert({ "name": "Alice", "age": 30 }).run()
   ```

4. **データのクエリ**

   ```py
   cursor = r.db("test_db").table("test_table").filter(r.row["name"] == "Alice").run()
   for document in cursor:
       print(document)
   ```

5. **リアルタイム更新のリスニング**

   ```py
   feed = r.db("test_db").table("test_table").changes().run()
   for change in feed:
       print("Change detected:", change)
   ```

## ユースケース

- **リアルタイムチャットアプリケーション**： 例えば、チャットメッセージをリアルタイムで表示する機能を簡単に実装できる。
- **ライブダッシュボード**： データが更新されるたびに即時に反映するダッシュボードの構築が可能。
- **コラボレーションツール**： ドキュメントの共同編集やタスク管理など、複数ユーザーによるリアルタイムのデータ共有が求められるアプリケーション向け。

## コミュニティとサポート

RethinkDBは活発なコミュニティに支えられており、GitHub上でソースコードやドキュメントが公開されている。また、Stack OverflowやGitHub Issuesなどを通じて技術的な質問やサポートを受けることができる。

## References

- [内部Docs: Realtime Notification](../../realtime-notification/README.md)
