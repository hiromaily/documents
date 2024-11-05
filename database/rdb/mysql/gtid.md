# GTID (Global Transaction ID)

GTID（Global Transaction Identifier）とは、MySQL のレプリケーションにおいて、各トランザクションを一意に識別するための識別子。GTID を使用することで、レプリケーションの管理がより簡単で直感的になる。

## 基本的な概念

- **一意な識別子**: 各トランザクションには、サーバー全体（グローバル）で一意の識別子が付与される。
- **形式**: GTID の形式は一般的に `source_id:transaction_id` 。`source_id` はトランザクションを発行したサーバーの UUID、`transaction_id` はそのサーバー内でのトランザクションのシーケンス番号。
  - 例: `3E11FA47-71CA-11E1-9E33-C80AA9429562:23`

## 利点

1. **簡素化された障害回復**: GTID を使用することで、マスターとスレーブの間の一貫性を保持しやすくなる。障害が発生した場合、新しいマスターを選出しても GTID に基づいて同期を簡単に行える。

2. **自己修復レプリケーション**: GTID を有効にすることで、スレーブは自動的に自分がどのトランザクションを取得し、どのトランザクションを適用すべきかを判断できる。これにより、レプリケーションの管理が容易になる。

3. **簡易なスレーブのプロモーション**: GTID を使用すると、スレーブを簡易にマスターにプロモートすることが可能。設定が容易になるため、高可用性環境の実現がスムーズになる。

## 設定方法

GTID を有効にするには、MySQL の設定ファイル`my.cnf`に以下の設定を追加する。

```ini
[mysqld]
gtid_mode = ON
enforce_gtid_consistency = ON
log_slave_updates = ON
```

- **gtid_mode**: GTID モードを有効にする。
- **enforce_gtid_consistency**: GTID の一貫性を強制する。
- **log_slave_updates**: スレーブノードが受け取ったトランザクションをログに記録する。

## GTID の管理

- GTID はトランザクションごとに一意に付与されるため、各ノード間でのトランザクション状態が容易に管理できる。
- トランザクションの進行状況や同期のステータスを監視するためのコマンドも提供されている。

```sql
SHOW VARIABLES LIKE 'gtid_executed';
SHOW VARIABLES LIKE 'gtid_purged';
```
