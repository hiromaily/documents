# エラーハンドリング

## バックトレース

エラー発生に至るまでに呼び出された全関数の一覧

```sh
RUST_BACKTRACE=1 cargo run
```

## デバッグシンボル

プログラムやライブラリの多くは、デフォルトでは`デバッグシンボル`を含めてコンパイルされる。デバッグ情報を含めてコンパイルされたプログラムやライブラリは、デバッグ時にメモリアドレスが参照できるだけでなく、処理ルーチンや変数の名称も知ることができる。しかしそういったデバッグ情報は、プログラムやライブラリのファイルサイズを極端に大きくする。

デバッグシンボルは、`--release`オプション無しで、 `cargo build` や `cargo run` 実行時に自動で有効になる

## Result 型による回復可能なエラー

```rs
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

```rs
use std::fs::File;

fn main() {
    let f = File::open("hello.txt");

    let f = match f {
        Ok(file) => file,
        Err(error) => {
            // ファイルを開く際に問題がありました
            panic!("There was a problem opening the file: {:?}", error)
        },
    };
}
```

### 異なるエラーを取り扱う

```rs
use std::fs::File;
use std::io::ErrorKind;

fn main() {
    let f = File::open("hello.txt");

    let f = match f {
        Ok(file) => file,
        Err(ref error) if error.kind() == ErrorKind::NotFound => {
            match File::create("hello.txt") {
                Ok(fc) => fc,
                Err(e) => {
                    panic!(
                        //ファイルを作成しようとしましたが、問題がありました
                        "Tried to create file but there was a problem: {:?}",
                        e
                    )
                },
            }
        },
        Err(error) => {
            panic!(
                "There was a problem opening the file: {:?}",
                error
            )
        },
    };
}
```

### エラー時にパニックするショートカット: unwrap と expect

Result 値が Ok 列挙子なら、`unwrap`は Ok の中身を返し、Result が Err 列挙子なら、 `unwrap`は`panic!`マクロを呼ぶ

```rs
use std::fs::File;

fn main() {
    let f = File::open("hello.txt").unwrap();

    // エラーメッセージを指定する
    let f = File::open("hello.txt").expect("Failed to open hello.txt");
}
```

### エラーを委譲する

```rs
use std::io;
use std::io::Read;
use std::fs::File;

fn read_username_from_file() -> Result<String, io::Error> {
    let f = File::open("hello.txt");

    let mut f = match f {
        Ok(file) => file,
        Err(e) => return Err(e),
    };

    let mut s = String::new();

    match f.read_to_string(&mut s) {
        Ok(_) => Ok(s),
        Err(e) => Err(e),
    }
}

// エラー委譲のショートカット: ?演算子 を使った場合
fn read_username_from_file2() -> Result<String, io::Error> {
    let mut f = File::open("hello.txt")?;
    let mut s = String::new();
    f.read_to_string(&mut s)?;
    Ok(s)
}
```

## カスタムエラー/エラー型の定義

- [Rust By Example 日本語版: エラー型を定義する](https://doc.rust-jp.rs/rust-by-example-ja/error/multiple_error_types/define_error_type.html)

## [anyhow](https://crates.io/crates/anyhow)によるエラー処理

- [github](https://github.com/dtolnay/anyhow)
- [crates.io](https://crates.io/crates/anyhow): 400k dl per day
- [ライブラリ辞典: Rust の複数のエラー型のエラーハンドリングを楽にする anyhow の使い方](https://libdict.com/rust/anyhow/introduction)

### anyhow の利点

- `std::result::Result<T, E>`型を使いやすくした`anyhow::Result<T>`型が便利
  - `E`を省略して書くことができる
- `context()`や`with_context()`でエラーに簡単にコンテキスト情報を付与できる
  - Result および Option に対して使えるもので、詳細をエラーメッセージに追加できる
  - `context()`はエラーにコンテキスト情報を付与
  - `with_context()`はエラーに遅延評価でコンテキスト情報を付与
- `anyhow!`や`bail!`マクロで`anyhow::Result<T>`型のエラーを簡単に作成できる
  - わかりやすい

### example

```rs
use anyhow::{anyhow, Context, Result};

pub trait TodoRepository {
  fn update(&self, id: i32, payload: UpdateTodo) -> anyhow::Result<Todo>;
  fn delete(&self, id: i32) -> anyhow::Result<()>;
}

impl TodoRepository for TodoRepositoryForMemory {
    fn update(&self, id: i32, payload: UpdateTodo) -> anyhow::Result<Todo> {
        if id == 0 {
            // anyhow!マクロで`anyhow::Result`型のエラーを簡単に作成できる
            return Err(anyhow!("id must not be zero: {:?}", id));
            // bail!マクロで`anyhow::Result`型のエラーをより簡単に作成できる
            //bail!("id must not be zero: {:?}", id);
        }

        let mut store = self.write_store_ref();
        let todo = store.get(&id).context(RepositoryError::NotFound(id))?; // contextでエラー情報を追加
        let text = payload.text.unwrap_or(todo.text.clone());
        let completed = payload.completed.unwrap_or(todo.completed);
        let todo = Todo {
            id,
            text,
            completed,
        };
        store.insert(id, todo.clone());
        Ok(todo)
    }

    fn delete(&self, id: i32) -> anyhow::Result<()> {
        let mut store = self.write_store_ref();
        store.remove(&id).ok_or(RepositoryError::NotFound(id))?;
        Ok(())
    }
}
```

## [thiserror](https://crates.io/crates/thiserror)によるエラー処理

- [github](https://github.com/dtolnay/thiserror)
- [crates.io](https://crates.io/crates/thiserror): 500k dl per day
- [ライブラリ辞典: Rust で独自のエラータイプの実装を楽にする thiserror の使い方](https://libdict.com/rust/thiserror/introduction)

### thiserror の利点

- thiserror は、標準ライブラリの `std::error::Error` トレイトの便利な`deriveマクロ`を提供している
- カスタムエラータイプ実装時に `fmt::Display`、`std::error::Error`、`From<T>`トレイトの実装をほぼ省略できる
  - `#error("...")`: fmt::Display を実装
  - `#[from]`: From トレイトを実装
  - `#[source]` : 自動的に source()メソッドを実装

```rs
// thiserrorを利用してカスタムエラータイプを定義
#[derive(thiserror::Error)]
pub enum DataStoreError {
    // thiserrorのerrorを利用して、エラー時のメッセージを定義
    #[error("data store disconnected")]
    Disconnect(#[from] io::Error),
    #[error("the data for key `{0}` is not available")]
    Redaction(String),
    #[error("invalid header (expected {expected:?}, found {found:?})")]
    InvalidHeader { expected: String, found: String },
    #[error("unknown data store error")]
    Unknown,
}
```

## `Box<dyn error::Error>`

Error トレイトの実装を持つ何らかのエラーを返す

### 概念

- `Box`: ヒープ上にデータを格納するためのスマートポインタ
- `dyn`: dynamic の略。実行時にトレイトの具体的な型を決めたいときに使う
- `error::Error`: Rust の標準ライブラリの error モジュールにある Error トレイト
- `スマートポインタ`: Rust の文脈ではメモリや所有権を扱う概念・モノを指す
  - 例えば`Box<T>`は`T`をヒープ上で扱うためのスマートポインタといえる。

## References

- [Rust By Example 日本語版: Boxing Errors](https://doc.rust-jp.rs/rust-by-example-ja/error/multiple_error_types/boxing_errors.html)
- [`Box<dyn error::Error>`とは？](https://zenn.dev/torohash/articles/5264df373d50af)
