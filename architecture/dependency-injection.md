# Dependency Injection / 依存の注入

## 1. 概要

Dependency Injection（DI）とは、コンポーネント間の依存関係を設計しやすくするために、オブジェクトの依存関係をそのオブジェクト自身ではなく外部から注入する設計パターン。依存関係を外部から注入することで、コードの柔軟性と再利用性が向上し、テストもしやすくなる。

## 2. 利点

- **疎結合（Loose Coupling）**: オブジェクト間の依存関係が明示的となり、個々のコンポーネントが独立して動作可能に。
- **再利用性**: 依存性を外部から注入するため、コンポーネントを他のプロジェクトやモジュールで再利用しやすい。
- **テスト容易性**: モックオブジェクトやスタブを簡単に挿入できるので、単体テストが容易になる。
- **コードの可読性向上**: 依存関係が明示的になるため、コードの理解が容易になる。

## 3. 主なDIパターン

DIには主に以下の3種類があります:

- コンストラクタインジェクション
  - クラスのコンストラクタを通じて依存オブジェクトを注入する方法。最も一般的でおすすめされる方法
- Setterインジェクション
  - セッターメソッドを使用して依存オブジェクトを注入する方法。
- Interfaceインジェクション
  - インターフェースを用いて依存オブジェクトを注入する方法。あまり一般的ではないが、特定のニーズに応じて使われることがある

## Goによる実装例

### 1. シンプルな依存関係の例

Imagine you have a `Database` interface and a `UserService` that relies on this `Database` to get user information.

```go
package main

import "fmt"

// Database インタフェース
type Database interface {
    GetUser(id int) string
}

// MySQLDatabase 実装
type MySQLDatabase struct {}

func (db MySQLDatabase) GetUser(id int) string {
    // 実際のデータベースアクセスロジックは省略
    return fmt.Sprintf("User %d from MySQL", id)
}
```

次に、`UserService`を定義し、このサービスが`Database`に依存することを示す。

```go
package main

type UserService struct {
    db Database
}

// コンストラクタ関数
func NewUserService(db Database) *UserService {
    return &UserService{
        db: db,
    }
}

func (s *UserService) GetUserName(id int) string {
    return s.db.GetUser(id)
}
```

そして、これらを結び付ける実行コードを書く。

```go
package main

import "fmt"

func main() {
    // 依存性（Database具体実装）を作成
    db := MySQLDatabase{}

    // 依存性注入を使用してUserServiceを作成
    userService := NewUserService(db)

    // UserServiceの機能をテスト
    userName := userService.GetUserName(1)
    fmt.Println(userName)  // Output: User 1 from MySQL
}
```

## References

- [なぜ依存を注入するのか DI の原理・原則とパターンを読んだ感想](https://blog.ymgyt.io/entry/dependency-injection/)
