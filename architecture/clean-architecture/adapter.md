# Adapter

ここでは、Repositoryの実装において、[データモデルをドメインモデルに変換する](./repository.md#データモデルをドメインモデルに変換する)ケースにおけるAdapterの役割を説明する。

1. **ドメインモデル**: ビジネスロジックに直接使用される主要な構造体。Repository層が返すべきオブジェクト
2. **データモデル（ORMエンティティ）**: データベースに永続化するための構造体。
3. **DTO（Data Transfer Object）**: 必要に応じて中間層として使用。
4. **アダプター**: データモデルとドメインモデルの変換を行うロジック。

## クリーンアーキテクチャに基づいたGoでのデータモデル（エンティティ）をドメインモデルに変換するアダプターの具体例

### ドメインモデル

まずは、ビジネスロジックに使用されるドメインモデルを定義する。

```go
// domain/user.go
package domain

type User struct {
  ID    int
  Name  string
  Email string
}
```

### データモデル（DBのエンティティ）

次に、データベースとのやりとりに使用されるデータモデルを定義

```go
// entity/user_entity.go
package entity

type UserEntity struct {
  ID    int    `gorm:"primary_key"`
  Name  string `gorm:"type:varchar(100)"`
  Email string `gorm:"type:varchar(100)"`
}
```

### アダプター

ドメインモデルとデータモデルの変換を行うアダプターを定義。

```go
// adapter/user_adapter.go
package adapter

import (
  "your_project/domain"
  "your_project/entity"
)

type UserAdapter struct{}

func (UserAdapter) EntityToDomain(userEntity entity.UserEntity) domain.User {
  return domain.User{
    ID:    userEntity.ID,
    Name:  userEntity.Name,
    Email: userEntity.Email,
  }
}

func (UserAdapter) DomainToEntity(user domain.User) entity.UserEntity {
  return entity.UserEntity{
    ID:    user.ID,
    Name:  user.Name,
    Email: user.Email,
  }
}
```

### リポジトリのインターフェース

リポジトリのインターフェースを定義。ビジネスロジックはこのインターフェースに依存。

```go
// repository/user_repository.go
package repository

import "your_project/domain"

type UserRepository interface {
  GetUserByID(userID int) (domain.User, error) // この戻り値はあくまでもドメインオブジェクト
}
```

### リポジトリの実装

データベースとのやりとりを実装するリポジトリを定義。

```go
// repository/user_repository_impl.go
package repository

import (
  "your_project/adapter"
  "your_project/domain"
  "your_project/entity"

  "gorm.io/gorm"
)

type UserRepositoryImpl struct {
  DB *gorm.DB
}

func (repo UserRepositoryImpl) GetUserByID(userID int) (domain.User, error) {
  var userEntity entity.UserEntity
  if err := repo.DB.First(&userEntity, userID).Error; err != nil {
    return domain.User{}, err
  }
  // 最後にアダプターの呼び出し
  return adapter.UserAdapter{}.EntityToDomain(userEntity), nil
}
```

### まとめ

1. **ドメインモデル**と**データモデル**を明確に分離。
2. 変換ロジックはアダプターにまとめ、個々の責任を分離。
3. リポジトリはインターフェースおよびその具体的な実装として定義し、ビジネスロジックはインターフェースを介してデータにアクセスする。

これにより、データベース技術や具体的なデータベーススキーマの変更が直接ビジネスロジックに影響を与えることがなくなり、変更に強い設計が実現される。また、各層が明確に分かれているため、ユニットテストやモックを使ったテストも容易になる。
