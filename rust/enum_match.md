# enum と match 構造

enum: 列挙型

```rs
enum IpAddr {
    V4(String),
    V6(String),
}

enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}
```

## Option enum

```rs
enum Option<T> {
    Some(T),
    None,
}

let some_number = Some(5);
let some_string = Some("a string");

let absent_number: Option<i32> = None;
```

## Result<T, E> enum

```rs
enum Result<T, E> {
    Ok(T),
    Err(E)
}
```

## match 式

```rs
enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter,
}

fn value_in_cents(coin: Coin) -> u32 {
    match coin {
        Coin::Penny => 1,
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter => 25,
    }
}
```

## enum 標準ユーティリティー関数

Option や Result の値を簡単にデコードするためのもの

### `is_some()`, `is_none()`, `is_some_and()`

Option で使う

```rs
let n = Some(5);
n.is_some() // true
n.is_none() // false

x.is_some_and(|x| x > 1) // true
x.is_some_and(|x| x > 10) // false

```

### `is_ok()`, `os_err()`

Result で使う

```rs
let n = Ok(5);
n.is_ok() // true
n.is_err() // false
```

### `unwrap()`, `unwrap_err()`, `unwrap_or()`, `expect()`

- `unwrap()`: `Ok` もしくは `Some` なら value を返し、`Err` もしくは `None` なら panic
- `unwrap_err()`: `Err`なら Err を返し、`Ok`なら panic
- `unwrap_or()`: `Ok` もしくは `Some` なら value を返し、それ以外は default 値を返す。e.g. `Some("car").unwrap_or("bike")`

```rs
// unwrap
let n = Ok(5);
let ret = n.unwrap() // ret: 5

let n = Err("something error");
let ret = n.unwrap() // panic

// unwrap_err
let n = Err("something error");
let ret = n.unwrap_err() // return error value

// unwrap_or
// Returns the contained Some value or a provided default.

// expect
let n = Err("something error");
n.expect("additional error message") // panic + error message
```

## References

- [Enum std::option::Option](https://doc.rust-lang.org/std/option/enum.Option.html)
- [Enum std::result::Result](https://doc.rust-lang.org/std/result/enum.Result.html)
- [Rust By Example 日本語版: 標準ライブラリの型: Option](https://doc.rust-jp.rs/rust-by-example-ja/std/option.html)
- [The Rust Programming Language 日本語版: option-enum と null 値に勝る利点](https://doc.rust-jp.rs/book-ja/ch06-01-defining-an-enum.html?highlight=Option#option-enum%E3%81%A8null%E5%80%A4%E3%81%AB%E5%8B%9D%E3%82%8B%E5%88%A9%E7%82%B9)
