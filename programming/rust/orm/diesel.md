# Diesel

## diesel の derive 属性

- check_for_backend
- table_name

## Reference

- [diesel](https://github.com/diesel-rs/diesel): Star: 12.1k
- [Crates.io](https://crates.io/crates/diesel): DL: 16k per day
- [Official Docs](https://diesel.rs/)
- [docs](https://docs.diesel.rs/master/diesel/index.html)
  - [feature flag](https://docs.diesel.rs/master/diesel/index.html#crate-feature-flags)
- [Building a High-Performance REST API in Rust with Diesel and Axum](https://www.civo.com/learn/high-performance-rest-api-rust-diesel-axum)

## 利用される Components

自動生成される schema

```sh
diesel print-schema > crates/components/src/schemas/diesel/schema.rs
```

```rs
diesel::table! {
    users (id) {
        id -> Int4,
        #[max_length = 50]
        first_name -> Varchar,
        #[max_length = 50]
        last_name -> Varchar,
        #[max_length = 50]
        email -> Varchar,
        #[max_length = 100]
        password -> Varchar,
        is_admin -> Bool,
        created_at -> Nullable<Timestamp>,
    }
}
```

別途作成する`select`用の model or `diesel_cli_ext`で生成して修正する
各 model には用途に合わせて適宜必要な`Derive Macro`を追加する必要がある

```rs
use crate::schemas::diesel::schema::users as diesel_users;
use chrono::NaiveDateTime;
use diesel::deserialize::{self, FromSql, Queryable};
use diesel::prelude::*;

#[derive(Debug, Queryable, Selectable)]
#[diesel(table_name = diesel_users)]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct User {
    pub id: i32,
    pub first_name: String,
    pub last_name: String,
    pub email: String,
    pub password: String,
    pub is_admin: bool,
    pub created_at: Option<NaiveDateTime>,
}
```

### enum など独自の型を利用する場合

自動生成される schema

```rs
pub mod sql_types {
    #[derive(diesel::query_builder::QueryId, Clone, diesel::sql_types::SqlType)]
    #[diesel(postgres_type(name = "todo_status"))]
    pub struct TodoStatus;
}

diesel::table! {
    use diesel::sql_types::*;
    use super::sql_types::TodoStatus;
    ...
}
```

- `Queryable`, `Insertable` の trait を満たすために必要な実装
  - `serialize::ToSql`
  - `deserialize::FromSql`
- `Selectable`の trait を満たすために必要な実装

## 必要な Derive Macro

### [Queryable](https://docs.rs/diesel/latest/diesel/deserialize/derive.Queryable.html)

- [Queryable trait](https://docs.rs/diesel/latest/diesel/deserialize/trait.Queryable.html)
- [get_result](https://docs.rs/diesel/latest/diesel/prelude/trait.RunQueryDsl.html#method.get_result)を利用する場合、必要

### [Selectable](https://docs.rs/diesel/latest/diesel/expression/derive.Selectable.html)

- [Selectable trait](https://docs.rs/diesel/latest/diesel/expression/trait.Selectable.html)
- [as_returning](https://docs.rs/diesel/latest/diesel/expression/trait.SelectableHelper.html#method.as_returning)を利用する場合、必要

### [Insertable](https://docs.rs/diesel/latest/diesel/prelude/derive.Insertable.html)

- [Insertable trait](https://docs.rs/diesel/latest/diesel/prelude/trait.Insertable.html)
- Insert 時の[values](https://docs.diesel.rs/master/diesel/prelude/trait.Insertable.html#tymethod.values)を利用する場合、必要

### [AsChangeset](https://docs.diesel.rs/master/diesel_derives/derive.AsChangeset.html)

- [AsChangeset trait](https://docs.diesel.rs/master/diesel/prelude/trait.AsChangeset.html)
- Update 時の[set](https://docs.diesel.rs/master/diesel/query_builder/struct.UpdateStatement.html#method.set)を利用する場合、必要
