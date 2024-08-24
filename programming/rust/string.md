# 文字列 String

Rust には文字列を扱う型が 2 つある。`String`と`&str`。

`String`は有効な UTF-8 の配列であることを保証されたバイトのベクタ(`Vec<u8>`)として保持され、ヒープ上に保持され伸長可能で末端に null 文字を含まない。
`&str`は有効な UTF-8 の配列のスライス(`&[u8]`)で、いつでも String に変換することができる

## str

```rs
let pangram = "the quick brown fox jumps over the lazy dog";
// 型の実体は以下
// let pangram: &'static str = "the quick brown fox jumps over the lazy dog";
```

`&'static str`: type annotation that indicates pangram is a reference to a string slice with a 'static lifetime.

`'static Lifetime`: 'static is a special lifetime that indicates the reference can live for the entire duration of the program. In this context, it means the string slice pangram references a string that is hardcoded into the program's binary and therefore available for the entire runtime of the program.

## String

`String`は文字列の伸長や変更ができる

```rs
let mut s = String::from("Hello, ");
s.push_str("world!");
```

## References

- [Rust By Example 日本語版: 文字列](https://doc.rust-jp.rs/rust-by-example-ja/std/str.html)
