# [マクロ](https://doc.rust-jp.rs/book-ja/ch19-06-macros.html)

- 例えば`println!`は関数ではなくマクロであり、マクロの引数を展開して関数の呼び出しに置き換える処理をしている
  - 内部的には、`std::io::println()`の関数呼び出しに置き換えられる。`std::io`モジュールの`println`関数
  - 尚、`std::io`モジュールは default で import されるため、明示的な import は不要となる
- `!`を末尾につけることでマクロを表す
