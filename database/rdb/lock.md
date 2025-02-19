# 排他制御 Lock

排他制御（Exclusive Control）は、データベース管理システム（DBMS）において、複数のユーザーやトランザクションが同時にデータを操作する際に、データの整合性と安全性を確保するためのメカニズム。排他制御は主にロック機構を使って実現される。

## 排他制御の基本概念

1. **トランザクション**：

   - データベース操作の一連の手続きを意味する。例えば、データの読み込み、更新、削除などが含まれる。一つのトランザクションは、全ての操作が完了するか、全て取り消される（ロールバックされる）かのいずれかを保証する。

2. **ロック**：
   - データベースの特定のリソース（行、ページ、テーブルなど）に対するアクセス権を制御するための仕組み。ロックによって、トランザクションが現在の状態を他のトランザクションから保護する。

## ロックの種類

1. **共有ロック（Shared Lock, S ロック）**：

   - データの読み込みを行うトランザクションが取得する。共有ロックは複数のトランザクションが同時に取得することができるが、その間、データの更新はできない。

2. **排他ロック（Exclusive Lock, X ロック）**：
   - データの更新を行うトランザクションが取得する。排他ロックは他のトランザクションが同時に取得することはできない。つまり、あるトランザクションが排他ロックを取得している間、そのデータへの他のトランザクションからの読み込みも更新もできない状態になる。

## ロックの粒度

1. **行レベルロック（Row-level Lock）**：

   - 個々のデータ行に対してロックをかける。競合を最小限に抑えながら、高い並行性を実現できる。

2. **ページレベルロック（Page-level Lock）**：

   - データベースのページ（複数の行を含むブロック）に対してロックをかける。行レベルよりも粗く、テーブルレベルよりも細かい粒度。

3. **テーブルレベルロック（Table-level Lock）**：
   - 全テーブルに対してロックをかける。大量のデータ操作を行う場合に有効だが、並行性は低くなる。

## デッドロック（Deadlock）

- 複数のトランザクションが相互にロックを待機し合ってしまう状況。これが発生すると、いずれのトランザクションも進行できなくなる。デッドロックを回避および解決するためには、デッドロック検出アルゴリズムやタイムアウト機能が利用される。

## 排他制御の実装方法

1. **悲観的ロック（Pessimistic Locking）**：

   - トランザクションがデータにアクセスする際にあらかじめロックを取得し、他のトランザクションが同じデータにアクセスできないようにする。競合が予測される場合に効果的。

2. **楽観的ロック（Optimistic Locking）**：
   - トランザクションの最後に整合性チェックを行う方法です。データの操作回数が少ない場合や競合が少ない場合に効果的です。楽観的ロックでは通常、バージョン番号やタイムスタンプを利用して整合性を確認する。

## 排他制御が必要な理由

- データの一貫性と整合性を保つために、複数のトランザクションが同時にデータを操作する際に競合が発生する可能性があるため。排他制御を適切に行わないと、データ破損や不整合が発生するリスクが高まる。排他制御はデータベースシステムのパフォーマンスと信頼性を確保するための重要な要素であり、適切に実装・管理される必要がある。

## References

- [排他制御（楽観ロック・悲観ロック）の基礎](https://qiita.com/NagaokaKenichi/items/73040df85b7bd4e9ecfc)
