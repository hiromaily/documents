# panic

`unwrap()`を使っている処理はpanicを起こす可能性があり、productionでは利用すべきではない。
しかし外部ライブラリにおいては利用されている可能性もある

## 1. パニックをキャッチする

Rustの`std::panic`モジュールを利用して、パニックをキャッチし、それに適切に対処することが可能。ただし、これは本来非常に例外的な状況で利用する手法。

```rs
use std::panic;

fn call_external_lib() {
    // パニックをキャッチするために 'catch_unwind' を利用
    let result = panic::catch_unwind(|| {
        external_crate::function_that_might_panic();
    });

    match result {
        Ok(_) => println!("Function executed successfully."),
        Err(_) => eprintln!("Caught a panic! The external function called `unwrap` and it failed."),
    }
}

fn main() {
    call_external_lib();
}
```

## 2. ライブラリのラッパーを作成する

外部ライブラリの使用をラップする安全な関数を提供し、エラーハンドリングを行う。

```rs
pub fn safe_function_call() -> Result<(), Box<dyn std::error::Error>> {
    let result = std::panic::catch_unwind(|| {
        external_crate::function_that_might_panic();
    });

    match result {
        Ok(_) => Ok(()),
        Err(_) => Err("Caught a panic! The external function called `unwrap` and it failed.".into()),
    }
}

fn main() {
    match safe_function_call() {
        Ok(_) => println!("Function executed successfully."),
        Err(e) => eprintln!("{}", e),
    }
}
```
