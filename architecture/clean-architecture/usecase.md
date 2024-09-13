# Usecase

`ユースケース層（Use Cases Layer）`は、クリーンアーキテクチャにおいてアプリケーション固有のビジネスロジックを扱う層。この層は、エンティティ層のビジネスルールを使用して、実際のユーザーインタラクションやアプリケーションの操作を行う。ユースケースは、一つのエンドツーエンドのビジネスプロセスを表し、具体的な要求に応じたアクションを定義する。

ユースケース層（Use Case Layer）はアプリケーション固有のビジネスロジックを実装するための重要な層。この層はエンティティ層やインフラストラクチャ層から独立しており、リポジトリのインターフェースを利用してデータの操作を行う。クリーンアーキテクチャでは、各層の責務が明確に分かれているため、システム全体の保守性と柔軟性が向上する。

## ユースケース層の役割と特徴

1. **アプリケーション固有のビジネスロジック**:

   - この層は、エンタープライズ全体のルールではなく、アプリケーション固有のビジネスロジックを含む。たとえば、ユーザーの登録、注文の作成、レポートの生成など。

2. **インターフェースの利用**:

   - ユースケース層は、リポジトリのインターフェースを使用してデータを取得・保存する。具体的なデータアクセス技術には依存しない。

3. **トランザクション管理**:

   - 必要に応じてデータの一貫性を保つためのトランザクション管理を行う。

4. **DTO（データ転送オブジェクト）**:
   - データの受け渡しには `DTO` を使用し、異なる層間でのデータ伝達を定義する。

## Golang での具体的な例

ユーザーの情報を取得するシンプルなユースケース（GetUser）

### 1. エンティティ層

エンティティ層は、ビジネスルールとドメインオブジェクトを含む。

```go
// domain/user.go
package domain

type User struct {
  ID   string
  Name string
}
```

#### 2. リポジトリインターフェース

リポジトリインターフェースは、エンティティ層に置かれる。

```go
// domain/user_repository.go
package domain

type UserRepository interface {
  FindByID(userID string) (*User, error)
}
```

#### 3. ユースケース層

ユースケース層は、アプリケーション固有のビジネスロジックを実装する。

```go
// usecase/get_user.go
package usecase

import "example.com/project/domain"

type GetUser struct {
  userRepository domain.UserRepository
}

func NewGetUser(userRepository domain.UserRepository) *GetUser {
  return &GetUser{userRepository: userRepository}
}

func (u *GetUser) Execute(userID string) (*domain.User, error) {
  return u.userRepository.FindByID(userID)
}
```

#### 4. インターフェースアダプター層（リポジトリの具体的な実装）

インフラストラクチャ層では、具体的なリポジトリの実装を行う。ここでは、メモリ内のリポジトリの例。

```go
// infrastructure/memory_user_repository.go
package infrastructure

import (
  "errors"
  "example.com/project/domain"
)

type MemoryUserRepository struct {
  users map[string]*domain.User
}

func NewMemoryUserRepository() *MemoryUserRepository {
  return &MemoryUserRepository{
    users: make(map[string]*domain.User),
  }
}

func (r *MemoryUserRepository) FindByID(userID string) (*domain.User, error) {
  user, exists := r.users[userID]
  if !exists {
    return nil, errors.New("user not found")
  }
  return user, nil
}

// ユーザーを追加するためのヘルパーメソッドも提供
func (r *MemoryUserRepository) AddUser(user *domain.User) {
  r.users[user.ID] = user
}
```

#### 5. 結束例（メイン関数）

この部分では、ユースケースとリポジトリを実際に使用するコードを示す。

```go
// main.go
package main

import (
  "fmt"
  "example.com/project/domain"
  "example.com/project/infrastructure"
  "example.com/project/usecase"
)

func main() {
  // リポジトリの具体的実装を作成
  userRepo := infrastructure.NewMemoryUserRepository()

  // サンプルユーザーを追加
  userRepo.AddUser(&domain.User{ID: "1", Name: "John Doe"})

  // ユースケースを初期化
  getUser := usecase.NewGetUser(userRepo)

  // ユースケースを実行
  user, err := getUser.Execute("1")
  if err != nil {
    fmt.Println("Error:", err)
    return
  }

  fmt.Println("User found:", user.Name)
}
```
