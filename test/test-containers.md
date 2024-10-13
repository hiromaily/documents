# [Test Containers](https://testcontainers.com/)

Testcontainers は、ソフトウェア開発と自動化されたテストプロセスをサポートするために、Docker コンテナを簡単に扱えるようにするツール。これにより、テスト環境を迅速に構築・破棄でき、よりリアルなテストが可能になる。Testcontainers を使用すると、実際のコンテナを利用して依存関係（データベース、メッセージブローカー、Web サーバーなど）を設定できる。これにより、より信頼性の高いテストを実行できる。

以下は、Go のプログラム環境で Testcontainers を使用するための基本的なステップ

## 必要な前提条件

1. **Docker のインストール**: Testcontainers は Docker を利用するため、Docker がインストールされている必要がある。
2. **estcontainers for Go のインストール**: Testcontainers for Go のライブラリをインストールする

   ```bash
   go get github.com/testcontainers/testcontainers-go
   ```

### 基本的な使用方法

以下に、PostgreSQL のコンテナを使用してテストを行う基本的なコード例を示す

```go
package main

import (
    "context"
    "testing"
    "github.com/testcontainers/testcontainers-go"
    "github.com/testcontainers/testcontainers-go/wait"
    "github.com/stretchr/testify/assert"
)

func TestPostgresContainer(t *testing.T) {
    ctx := context.Background()

    req := testcontainers.ContainerRequest{
        Image:        "postgres:13",  // 使用したいPostgreSQLのイメージ
        ExposedPorts: []string{"5432/tcp"},
        Env: map[string]string{
            "POSTGRES_USER":     "test",
            "POSTGRES_PASSWORD": "test",
            "POSTGRES_DB":       "testdb",
        },
        WaitingFor: wait.ForListeningPort("5432/tcp"),
    }

    postgresC, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
        ContainerRequest: req,
        Started:          true,
    })

    if err != nil {
        t.Fatal(err)
    }
    defer postgresC.Terminate(ctx)

    // コンテナのポート情報を取得する
    host, err := postgresC.Host(ctx)
    if err != nil {
        t.Fatal(err)
    }

    port, err := postgresC.MappedPort(ctx, "5432")
    if err != nil {
        t.Fatal(err)
    }

    // ここでは、PostgreSQLコンテナに対するテストを実行する
    dsn := "host=" + host + " port=" + port.Port() + " user=test password=test dbname=testdb sslmode=disable"
    db, err := sql.Open("postgres", dsn)
    if err != nil {
        t.Fatal(err)
    }

    // 接続が成功したかどうか確認する
    err = db.Ping()
    assert.NoError(t, err, "Database should be reachable")

    // ここにその他のテストロジックを追加できる
}
```

## 詳細な設定

Testcontainers for Go は、さまざまな設定オプションを提供しており、以下のような詳細な依存関係を管理することができる。

- **ネットワークの管理**: 複数のコンテナを同じネットワーク上に配置して、相互通信をテストすることができる。
- **ボリュームのマウント**: データを持続化するためのボリュームをマウントすることが可能。
- **カスタムイメージの使用**: デフォルトイメージだけでなく、自分で作成したカスタム Docker イメージを使用できる。

## 最後に

Testcontainers を使用すると、非常に柔軟でリアリスティックなテスト環境を実現できる。Docker を利用するため、ホストシステムへの依存を最小限に抑えてテストを実行できる。Go のプログラム環境での利用も簡単で、各種データベースやサービスのテストが手軽に行えるのが魅力。

## References

- [github](https://github.com/testcontainers/)
- [Testcontainers for Go](https://golang.testcontainers.org/)
