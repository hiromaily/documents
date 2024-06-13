# actix-web

## [State](https://actix.rs/docs/application#state)

アプリケーションの状態は、同じスコープ内のすべての routes とリソースで共有される。ステートには`web::Data<T>`エクストラクタでアクセスできる。ステートにはミドルウェアからもアクセスできる。

- [Struct actix_web::web::Data](https://docs.rs/actix-web/latest/actix_web/web/struct.Data.html)

```rs
#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .app_data(web::Data::new(AppState {
                app_name: String::from("Actix Web"),
            }))
            .service(index)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
```

### Shared Mutable State: 変更可能な State の共有化

HttpServer は、アプリケーションインスタンスではなく、アプリケーションファクトリを受け入れる。HttpServer は、スレッドごとにアプリケーション・インスタンスを構築するため、アプリケーションデータを複数回構築する必要がある。異なるスレッド間でデータを共有したい場合は、共有可能なオブジェクトを使用する必要がある。
内部的には、`web::Data`は `Arc`を使う。そのため、2 つの Arc を作成するのを避けるために、App::app_data()を使って登録する前に Data を作成する必要がある。

```rs
type DbPool = r2d2::Pool<r2d2::ConnectionManager<SqliteConnection>>;

#[actix_web::main]
async fn main() -> io::Result<()> {
    // connect to SQLite DB
    let manager = r2d2::ConnectionManager::<SqliteConnection>::new("app.db");
    let pool = r2d2::Pool::builder()
        .build(manager)
        .expect("database URL should be valid path to SQLite DB file");

    // start HTTP server on port 8080
    HttpServer::new(move || {
        App::new()
            .app_data(web::Data::new(pool.clone()))
            .route("/{name}", web::get().to(index))
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
```

## References

- [actix-web](https://github.com/actix/actix-web): Star: 20.5k
- [Official Docs](https://actix.rs/docs/)
- [Crates.io](https://crates.io/crates/actix-web): DL: 45k per day, **upward trend**
- [Actix 非公式 日本語ドキュメント](https://actix-website.pages.dev/)

### Example

- [github で検索し、Recently updated でソート](https://github.com/search?q=use+actix_web+language%3ARust&type=repositories&l=Rust&s=updated&o=desc)
  - [actix-web-rest-api-with-jwt](https://github.com/SakaDream/actix-web-rest-api-with-jwt)
