# Macro マクロ

`Rust コードを生成するコードを記述する` 機能であり、Rust におけるメタプログラミングを可能とする。

例えば`println!`は関数ではなくマクロであり、マクロの引数を展開して関数の呼び出しに置き換える処理をしている。内部的には、`std::io::println()`の関数呼び出しに置き換えられるのだが、これは`std::io`モジュールの`println`関数となる。

尚、`std::io`モジュールは default で import されるため、明示的な import は不要となる

## マクロの表し方

`!`を末尾につけることでマクロを表す

## マクロの目的

コード量を減らすため

## よく使われるマクロ

### `print!`, `println!`, `format!`

- `format!`: フォーマットされたテキストを文字列(String)型に書き込む
- `print!`: `format!` と同様ですが、コンソール (io::stdout) にそのテキストを出力する
- `println!`: `print!` と同じですが改行が付け加えられる
  - `std::println()`
- `eprint!`: `format!` と同様ですが、標準エラー出力 (io::stderr) にそのテキストを出力する
- `eprintln!`: `eprint!` と同じですが改行が付け加えられる

### `vec!`

```rs
let mut vec = Vec::new();
vec.push(1);
vec.push(2);
vec.push(3);

// macroにより以下のように記述できる
vec![1,2,3]
```

### `assert!`, `assert_eq!`, `assert_ne!`

- `assert!(c)`: c を評価
- `assert_eq!(a, b)`: a == b を評価
- `assert_ne!(a, b)`: a != b を評価

`assert!`, `assert_eq!`, `assert_ne!`はデバッグビルドでもリリースビルドでも常に有効だが、リリースビルドで無効にしたい場合は、`debug_assert!`, `debug_assert_eq!`, `debug_assert_ne!`を使う

### `unimplemented!`

未実装を表し、`panic!`マクロを呼び出す

### `todo!`

`unimplemented!`とほぼ同じだが、まだ未実装という意

### `dbg!`

式を評価してデバッグ表示する

## マクロの実装方法

## References

- [The Rust Programming Language 日本語版: マクロ](https://doc.rust-jp.rs/book-ja/ch19-06-macros.html)
- [Rust By Example 日本語版: macro_rules!](https://doc.rust-jp.rs/rust-by-example-ja/macros.html)
