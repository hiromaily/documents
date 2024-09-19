# Problems which I faced

## Trait への Clone 実装

まず、以下のように`Clone`を満たす Trait を作成する

```rs
pub trait TodoRepository:
    std::fmt::Debug + std::clone::Clone + std::marker::Send + std::marker::Sync + 'static
{
    fn create(&self, payload: CreateTodo) -> Todo;
    fn find(&self, id: i32) -> Option<Todo>;
    fn find_all(&self) -> Vec<Todo>;
    fn update(&self, id: i32, payload: UpdateTodo) -> anyhow::Result<Todo>;
    fn delete(&self, id: i32) -> anyhow::Result<()>;
}
```

そうすると、trait を返す function の`Box<dyn todo_repository::TodoRepository>`でエラーが発生するようになる。`TodoRepository`Trait から`Clone`を外すと問題ない

```rs
    fn new_repository(&self) -> Box<dyn todo_repository::TodoRepository> {
        if self.conf.pg.enabled {
            return Box::new(todo_repository::TodoRepositoryForDB::new());
        } else {
            return Box::new(todo_repository::TodoRepositoryForMemory::new());
        }
    }
```

```rs
pub struct AppState {
    pub app_name: String,
    pub repository: Box<dyn todo_repository::TodoRepository>,
}
```

エラー

```sh
the trait `TodoRepository` cannot be made into an object
the following types implement the trait, consider defining an enum where each variant holds one of these types, implementing `TodoRepository` for this new enum and using it instead:
  repositories::todo_repository::TodoRepositoryForDB
  repositories::todo_repository::TodoRepositoryForMemory
```

```sh
for a trait to be "object safe" it needs to allow building a vtable to allow the call to be resolvable dynamically; for more information visit <https://doc.rust-lang.org/reference/items/traits.html#object-safety>
```

```sh
26 | pub trait TodoRepository:
   |           -------------- this trait cannot be made into an object...
27 |     std::fmt::Debug + std::clone::Clone + std::marker::Send + std::marker::Sync + 'static
   |                       ^^^^^^^^^^^^^^^^^ ...because it requires `Self: Sized`
   = help: the following types implement the trait, consider defining an enum where each variant holds one of these types, implementing `TodoRepository` for this new enum and using it instead:
             repositories::todo_repository::TodoRepositoryForDB
             repositories::todo_repository::TodoRepositoryForMemory
```

- [stackoverflow: "this trait cannot be made into an object because it requires `Self: Sized`", except it has Sized](https://stackoverflow.com/questions/70377145/this-trait-cannot-be-made-into-an-object-because-it-requires-self-sized-ex)
- [How to clone a struct storing a boxed trait object?](https://stackoverflow.com/questions/30353462/how-to-clone-a-struct-storing-a-boxed-trait-object)
- [Why can’t traits require Clone?](https://users.rust-lang.org/t/why-cant-traits-require-clone/23686/1)

### `Trait への Clone 実装` 解決方法

- trait から、Clone 実装を外す
  - 問題は clone が必要な場合
- `dyn Trait` を使うときはコンパイル時にサイズが分からないので何かしらの参照の形で渡してあげる必要がある
  - [actix-web で `Data<dyn trait>` を使い回す](https://teratail.com/questions/kb8b224km8a6hl)
