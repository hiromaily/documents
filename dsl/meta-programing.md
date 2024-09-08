# メタプログラミングとは

メタプログラミングは、`プログラムそのものを生成、変更、操作するためのプログラミング手法を指す`。簡単に言うと、「プログラムを操作するプログラム」を書くこと。これにより、コードの再利用性が高まり、柔軟性が増し、自動化が容易になる。

## メタプログラミングの基本概念

1. **リフレクション (Reflection)**

   - `プログラムが自分自身の構造を調査・変更できる能力`のこと。例えば、Java や C#ではリフレクションを使ってクラスのメタ情報（フィールド、メソッド、コンストラクタなど）にアクセスできる。

2. **マクロ (Macro)**

   - `コードの一部をテンプレート化し、それを実行時に展開する機能`のこと。多くの Lisp 系の言語や C/C++のプリプロセッサーマクロが代表例だ。マクロを使えば、コードの再利用と複雑な処理の簡略化が可能になる。

3. **コード生成 (Code Generation)**
   - `動的にコードを生成する`ことを指す。テンプレートエンジンやスクリプト言語でのコード生成、コンパイル時に実行するコード生成がここに含まれる。

## メタプログラミングの利点

1. **再利用性**

   - よく使うロジックやパターンをテンプレートやマクロとしてまとめることで、コードの再利用性が向上する。

2. **柔軟性**

   - 抽象度の高いコードを書くことで、異なるコンテクストや要件に容易に適応できる。

3. **自動化**
   - 手作業よりも効率的に大量のコードや特定のパターンのコードを自動生成できる。

## リフレクション

### Go のリフレクションの例

Go では、`reflect` パッケージを使ってリフレクション操作が可能。`reflect` パッケージを使用すると、型情報や値に動的にアクセスできる。

```go
package main

import (
  "fmt"
  "reflect"
)

type MyStruct struct {
  Name string
  Age  int
}

func main() {
  s := MyStruct{"Alice", 30}

  // 型情報を取得
  t := reflect.TypeOf(s)
  fmt.Println("Type:", t)

  // 値を取得
  v := reflect.ValueOf(s)
  fmt.Println("Value:", v)

  // フィールドにアクセス
  for i := 0; i < t.NumField(); i++ {
    field := t.Field(i)
    value := v.Field(i)
    fmt.Printf("%s: %v = %v\n", field.Name, field.Type, value)
  }
}
```

### Rust のリフレクション(風)の例

Rust では、リフレクションは他の言語ほど強力ではないが、一定のリフレクション機能が提供されている。Rust の標準ライブラリは型情報を動的に取得する機能を提供しておらず、通常はコンパイル時にすべての情報が確定するようになっている。ただし、`serde` や `syn` といったクレート（ライブラリ）を利用することで、リフレクションに類似した機能を実現することができる。

以下は `serde` を使って JSON シリアライゼーションとデシリアライゼーションを行う例だ。これは一種のリフレクションと言える。

1. まず、Cargo.toml に必要なクレートを追加する。

```toml
[dependencies]
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
```

2. 次に、コードを書く。

```rust
use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize, Debug)]
struct MyStruct {
    name: String,
    age: u8,
}

fn main() {
    // データを構造体にデシリアライズ
    let data = r#"{ "name": "Alice", "age": 30 }"#;
    let s: MyStruct = serde_json::from_str(data).unwrap();
    println!("{:?}", s);

    // 構造体をJSONにシリアライズ
    let json = serde_json::to_string(&s).unwrap();
    println!("{}", json);
}
```

### Python のリフレクション

Python ではリフレクションを使ってオブジェクトの型情報を取得したり、属性を動的に操作できる。

```python
class MyClass:
    def __init__(self):
        self.a = 1

    def method(self):
        return "A method"

obj = MyClass()

# クラスの属性を取得
attributes = dir(obj)
print(attributes)

# メソッドを呼び出す
method = getattr(obj, 'method')
print(method())  # "A method"と出力
```

## テンプレートメタプログラミング

### Goのテンプレートメタプログラミング

Goはサポートしていないため、`go generate`といった`コード生成ツール`を使うのが一般的

### Rustのテンプレートメタプログラミング

Rustもサポートしていないが、`マクロ`や`プロシージャルマクロ（proc-macro）`を使って、かなり強力なコード生成ができる

### TypeScriptのテンプレートメタプログラミング

JavaScriptと同様にクラスや関数、リフレクションに加えて、型システムを活用したジェネリクスやデコレーターを利用してテンプレートメタプログラミングに似た効果を得ることができる。

### C++のテンプレートメタプログラミング

C++はテンプレートメタプログラミング（TMP）を使ってコンパイル時にコードを操作する能力がある。

```cpp
#include <iostream>

// コンパイル時に計算するフィボナッチ数列
template<int N>
struct Fibonacci {
    static const int value = Fibonacci<N-1>::value + Fibonacci<N-2>::value;
};

template<>
struct Fibonacci<0> {
    static const int value = 0;
};

template<>
struct Fibonacci<1> {
    static const int value = 1;
};

int main() {
    std::cout << Fibonacci<10>::value << std::endl;  // 55を出力
    return 0;
}
```

## マクロ

### Goのマクロ

存在しないため、コード生成ツールやジェネリクスが代替え案となる

### Rustのマクロ

Rustにはマクロのサポートが非常に強力で、2種類のマクロが存在する。

1. **`macro_rules!` マクロ**：Rustの定義済みマクロで、コンパイル時に展開される。
2. **プロシージャルマクロ（proc-macro）**：より複雑なコード生成を行うためのマクロで、外部クレートとして提供されることが多い。

#### `macro_rules!` マクロの例

```rust
macro_rules! create_function {
    ($func_name:ident) => {
        fn $func_name() {
            println!("Function {:?} is called", stringify!($func_name));
        }
    };
}

create_function!(foo);
create_function!(bar);

fn main() {
    foo();
    bar();
}
```

#### プロシージャルマクロの例

`proc-macro`を使うには別のクレートを作成する必要がある。

`Cargo.toml`：

```toml
[dependencies]
syn = "1.0"
quote = "1.0"
proc-macro2 = "1.0"

[lib]
proc-macro = true
```

`src/lib.rs`：

```rust
extern crate proc_macro;
use proc_macro::TokenStream;
use quote::quote;
use syn;

#[proc_macro]
pub fn make_hello_function(input: TokenStream) -> TokenStream {
    let ast = syn::parse(input).unwrap();
    let name = &ast.ident;
    let gen = quote! {
        fn #name() {
            println!("Hello, world! This is {}.", stringify!(#name));
        }
    };
    gen.into()
}
```

使用例：

```rust
// main.rs
use my_macro::make_hello_function;

make_hello_function!(hello);

fn main() {
    hello();
}
```

### TypeScriptのマクロ

TypeScript自体にはマクロの機能はない

### Lisp のマクロ

Lisp は高いレベルのマクロ機能を持ち、コード自身をデータとして処理できる。

```lisp
(defmacro unless (condition &body body)
  `(if (not ,condition)
       (progn ,@body)))

;; 使用例
(unless (= 1 2)
  (print "1 and 2 are not equal"))
```

## 注意点

メタプログラミングは強力だが、その強力さゆえに`複雑になりやすい`し、コードの可読性が低下するリスクもある。メタプログラミングを使う際は、適切な設計とコメント、そしてリファクタリングを心がけることが重要。

## メタプログラミングの用途

- プログラミング言語の持つ、Generic や Template 機能など
- コード自動生成
- マクロによるコード埋め込み
- 動作の差し替え
