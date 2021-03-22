# Clean Architecture
## References
- [Clean Architecture using Golang](https://eminetto.medium.com/clean-architecture-using-golang-b63587aa5e3f)
    - exampleのディレクトリ構成は整っている
  ```
  pkg/user
  - entity.go ...userモデルの構造体を定義
  - mongodb.go ...DB操作の実装
  - repository.go　...DB操作のinterface
  - service.go ...ビジネスロジックを担うベースとなる構造体を定義
  ```
- [bxcodec/go-clean-arch](https://github.com/bxcodec/go-clean-arch)
    - 多くのレビュアーの意見を取り入れてブラッシュアップされてきた感があるので、良いModelかもしれないが、分割の概念がディレクトリ名として表現されているのが、golangの思想に反する気がする。
- [Trying Clean Architecture on Golang](https://hackernoon.com/golang-clean-archithecture-efd6d7c43047)

## 日本語 (Architectureの要でもあるディレクトリ構造が全然駄目)
- [Go(Echo), Gorm, Mysql, Docker, Swaggerで、クリーンアーキテクチャなAPIサーバーを作ったメモ](https://zenn.dev/ulwlu/scraps/170d2d2412daf7)


## アーキテクチャの変遷
- [ドメイン駆動 + オニオンアーキテクチャ概略](https://qiita.com/little_hand_s/items/2040fba15d90b93fc124)

- レイヤードアーキテクチャ
- ヘキサゴナルアーキテクチャ
- オニオンアーキテクチャ
