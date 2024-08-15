# PostgreSQL

[PostgreSQL 14](https://www.postgresql.jp/document/14/html/index.html)

## 行更新時に自動で updated_at に現在時刻を設定する関数を定義する

```sql
-- triggerを定義
-- 行が更新された時に、updated_atに現在時刻を設定
CREATE FUNCTION set_updated_at() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        NEW.updated_at := now();
        return NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- updated_atをもったtestsテーブルを作成
CREATE TABLE tests (
    id serial primary key,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UNIQUE(block_height)
);

-- testsテーブル更新時に自動でupdated_atが更新されるようにトリガーを設定
CREATE TRIGGER trg_tests_updated_at BEFORE UPDATE ON tests FOR EACH ROW EXECUTE PROCEDURE set_updated_at();
```

## [同時実行制御: MVCC](https://www.postgresql.jp/document/14/html/mvcc.html)

## GUI for MacOS

### [pgAdmin](https://www.pgadmin.org/)

The most popular and feature-rich open-source management tool for PostgreSQL. It provides a comprehensive suite of tools for database management, query execution, and data visualization.

- open-source

### [TablePlus](https://tableplus.com/)

Supports multiple databases, including PostgreSQL. It offers a modern, native interface with powerful features like query editing, data management, and database structure visualization.

- 有償
- multiple databases

### [DBeaver](https://dbeaver.io/)

An open-source tool that supports a wide range of databases including PostgreSQL. It offers a powerful SQL editor, data visualization tools, and a user-friendly interface.

- open-source
- multiple databases

### [Postico](https://eggerapps.at/postico2/)

A macOS-only client that provides a simple and intuitive interface for PostgreSQL. It's known for its ease of use and visually appealing design.

- 有償

### [DataGrip](https://www.jetbrains.com/datagrip/)

A premium database IDE by JetBrains that supports multiple databases, including PostgreSQL. It offers advanced features like intelligent query assistance, version control integration, and database refactoring tools.

- 有償
- multiple databases

### [Navicat for PostgreSQL](https://www.navicat.com/en/products/navicat-for-postgresql)

A premium database management tool with a wide range of features for development, administration, and maintenance.

- 有償

### Beekeeper Studio

An open-source SQL editor and database manager with support for PostgreSQL. It offers a modern and clean interface with essential database management features.

- 有償
- open-source ??
