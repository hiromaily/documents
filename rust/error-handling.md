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
- [Box<dyn error::Error>とは？](https://zenn.dev/torohash/articles/5264df373d50af)
