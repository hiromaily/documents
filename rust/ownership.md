# Ownership 所有権

所有権は、プログラムのある部分がリソース（主にメモリ）を所有することを表す。Rust にはガベージコレクタがなく、その代わりに所有権を使っている。Rust では、あるリソース（主にメモリ）の所有権がスコープから抜けると、そのリソースは自動的に解放されるようになっている。
所有権は、メモリ安全性を保証しつつ、ガーベジコレクタなしで高速な実行を可能にし、これによりデータ競合や無効なメモリへの参照を防ぐことができる。

## 所有権の規則

### Rust の各値は「所有者」と呼ばれる変数と対応している

```rs
fn main() {
    let s1 = String::from("hello"); // 変数s1は"hello"という値の所有権をもっている
    let s2 = String::from("hi");    // 変数s2は"h1"という値の所有権をもっている
}
```

### 一度に存在できる所有者は 1 人だけ

```rs
fn main() {
    let s1 = String::from("hello");
    let s2 = s1; // 変数s1から変数s2に所有権の移動が発生（一度に存在できる所有者は1人だけ）

    // 所有権が移動しているので、変数s1を利用するとコンパイルエラーが起きる
    // println!("{}, world!", s1); // value borrowed here after move

    println!("{}, world!", s2);
}
```

### 所有者がスコープから外れたら値は破棄される

```rs
fn main() {
    let s1 = String::from("hello");

    {
        let s2 = String::from("hi");
        println!("{}, world!", s2);
    } // 値"hi"の所有者であるs2がスコープが外れるので、"hi"は破棄される

    println!("{}, world!", s1);
}  // 値"hello"の所有者であるs1がスコープが外れるので、"hello"は破棄される
```

## 所有権の move（所有権の移動）

- 所有権が移動することをムーブと呼ぶ。所有権が移動すると、移動元の変数は無効化される。
- 整数値やブール値といったスタック領域に格納される値はコピーされるので、所有権は移動しない。

[所有者がスコープから外れたら値は破棄される](./ownership.md#所有者がスコープから外れたら値は破棄される)のセクションを参考

## 参照・借用（所有権は移動しない）

`参照`は、ポインタと似ており、他のデータへのアクセスを提供する。参照は `&` 記号を使って作成される。参照もデフォルトではイミュータブル（不変）であり、ミュータブル（可変）にするには`&mut`を使う。

値を受け渡された側は、参照を使って他の部分から値を`借用`できる。`&`で渡された場合は、借用している値を変更はできない。借用している値を変更したい場合は`&mut`で渡す必要がある。

```rs
fn main() {
    let mut s1 = String::from("hello");
    change(&mut s1); // &mut 参照を渡しているので書き込み可能。所有権は移動しない

    let len = calculate_length(&s1); // & で参照させているので読み取りのみ可能。所有権は移動しない
    println!("The length of '{}' is {}.", s1, len);
    // The length of 'hello, world' is 12.
}

fn change(some_string: &mut String) {
    some_string.push_str(", world");
}

fn calculate_length(s: &String) -> usize {
    s.len()
}
```

ミュータブルな参照は（&mut を利用）はスコープ内で１つしかもてない制約がある。

```rs
fn main() {
    let mut s = String::from("hello");

    // 同じスコープ内でsのミュータブルな参照を2つ宣言しているためコンパイルエラーが起きる
    let r1 = &mut s;
    let r2 = &mut s;

    println!("{}, {}", r1, r2);
}
```

## References

- [The Rust Programming Language 日本語版: 所有権を理解する](https://doc.rust-jp.rs/book-ja/ch04-00-understanding-ownership.html)
