# Github References

- [Go-Clean-Architecture-REST-API](https://github.com/AleksK1NG/Go-Clean-Architecture-REST-API)
- [Clean Architecture using Golang](https://eminetto.medium.com/clean-architecture-using-golang-b63587aa5e3f)
  - example のディレクトリ構成は整っているが、わかりにくい。機能単位のほうがわかりやすいものまでドメインレベルに分離されてしまっている

  ```txt
  pkg/user
  - entity.go ...userモデルの構造体を定義
  - mongodb.go ...DB操作の実装
  - repository.go　...DB操作のinterface
  - service.go ...ビジネスロジックを担うベースとなる構造体を定義
  ```

- [bxcodec/go-clean-arch](https://github.com/bxcodec/go-clean-arch)
  - 多くのレビュアーの意見を取り入れてブラッシュアップされてきた感があるので、良い Model かもしれないが、分割の概念がディレクトリ名として表現されているのが、golang の思想に反する気がする。
- [Trying Clean Architecture on Golang](https://hackernoon.com/golang-clean-archithecture-efd6d7c43047)

## Typescriptの例

```txt
app/
├── src/
│   ├── application/
│   │   ├── interfaces/
│   │   │   └── todoRepository.ts
│   │   └── services/
│   │       └── todoService.ts
│   ├── domain/
│   │   ├── entities/
│   │   │   └── todo.ts
│   │   └── usecases/
│   │       └── todoUseCase.ts
│   ├── infrastructure/
│   │   ├── persistence/
│   │   │   ├── postgresTodoRepository.ts
│   │   │   └── mockTodoRepository.ts
│   │   └── web/
│   │       └── todoController.ts
│   ├── config/
│   │   └── diContainer.ts
│   └── index.ts
├── package.json
└── tsconfig.json
```
