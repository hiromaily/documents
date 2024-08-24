# Attribute 属性

`Attribute 属性`とは追加情報（メタデータ）のことで，宣言やコンテキストに対して付与することができる

```rs
#[derive(Debug, PartialEq)]
struct Point {
    x: i32,
    y: i32,
}
```

## 使用目的

- コンパイル時の条件分岐
- クレート名、バージョン、種類（バイナリか、ライブラリか）の設定
- リントの無効化
- コンパイラ付属の機能（マクロ、グロブ、インポートなど）の使用
- 外部ライブラリへのリンク
- ユニットテスト用の関数を明示
- ベンチマーク用の関数を明示

## よく使われる Attribute

### `#[derive(...)]`

derive 属性に対応したトレイトの実装を自動的に構造体や列挙型に実装することのできる属性。具体的には Rust の標準ライブラリに含まれる一部のトレイトの実装を自動的に生成することができる。
1 例として以下に`Debug` トレイトの実装を示す

```rs
#[derive(Debug)]
struct Point{ x: i32, y: i32, z: i32 }

fn main(){
    let some_point = Point {x: 10, y: 20, z: 0};
    println!("Debug: {:?}", some_point);
}
```

### `#[allow(dead_code)]`

Rust には Lint チェックというソースコードの静的解析をしてくれるしくみがあり、そのチェック対象とされているリント項目を無視するようにするための属性。
`dead_code`は使用されていない関数が存在するときに警告が出るが、`allow`属性によりこの機能を無効化することができる。

```rs
#[allow(dead_code)]
fn unused_function() {}
```

### `#[deny(...)]`

allow 属性とは逆に、Lint チェックの内容を全てエラーとする属性

### `#[warn(...)]`

Lint チェックの内容を全て警告とする属性

### cfg

- [参考: feature-flag](./feature-flag.md)

条件付きコンパイル機能を持つ。

環境に応じたコンパイルをするには 2 種類の方法がある

- cfg 属性: `#[cfg(...)]`を属性として使用する
- cfg!マクロ: `cfg!(...)`を Boolean として評価する

```rs
// This function only gets compiled if the target OS is linux
// この関数はターゲットOSがLinuxの時のみコンパイルされる。
#[cfg(target_os = "linux")]
fn are_you_on_linux() {
    println!("You are running linux!");
}

// And this function only gets compiled if the target OS is *not* linux
// そしてこの関数はターゲットOSがLinux *ではない* ときのみコンパイルされる。
#[cfg(not(target_os = "linux"))]
fn are_you_on_linux() {
    println!("You are *not* running linux!");
}

fn main() {
    are_you_on_linux();

    println!("Are you sure?");
    if cfg!(target_os = "linux") {
        println!("Yes. It's definitely linux!");
    } else {
        println!("Yes. It's definitely *not* linux!");
    }
}
```

### Unittest 用

- `#[test]`
- `#[should_panic]`
- `#[ignore]`，

`test`属性を使うことで、テスト関数をマークすることができる。テスト関数はテストモードのとき（`rustc --test`や`cargo test`など）のみコンパイルされ、テスト時に自動的にテスト関数が実行される。

test 属性と一緒に使われるアトリビュート

- `ignore`: テストを実行しないようにする
- `should_panic`: テストでパニックが発生した場合のみパスさせる

#### `#[cfg(test)]`

- コンパイラに cargo build を走らせた時ではなく、cargo test を走らせた時にだけ、 テストコードをコンパイルし走らせるよう指示する

```rs
#[cfg(test)]
mod tests {
    #[test]
    fn exploration() {
        assert_eq!(2 + 2, 4);
    }

    #[test]
    fn another() {
        panic!("Make this test fail");
    }
}
```

### crate

`crate_type`属性は、そのクレートがライブラリ、バイナリのいずれにコンパイルされるべきかをコンパイラに伝えるために使用する。ライブラリの場合は、どのタイプのライブラリであるかも伝えることができる。  
`crate_name`はクレートの名前を決定するのに使用する。
しかし、`crate_type`属性も`crate_name`属性も、Rust のパッケージマネージャ Cargo を利用している場合は不要

```rs
#![crate_type = "lib"]
#![crate_name = "rary"]
```

## Attribute の適用範囲

クレート全体に適用される場合、`#![crate_attribute]`という書き方になる。
モジュールないしは要素に適用される場合は`#[item_attribute]`になる。（!がないことに注目）
例えば、クレートルート( src/main.rs など)の先頭に `#![allow(...)]` を指定すると，すべてのモジュールに適用される

## 引数

- `#[attribute = "value"]`
- `#[attribute(key = "value")]`
- `#[attribute(value)]`
- `#[attribute(value, value2)]` # 複数の値をとることもできる

## References

- [Rust By Example 日本語版: Attribute](https://doc.rust-jp.rs/rust-by-example-ja/attribute.html)
- [The Rust Programming Language 日本語版: 導出可能なトレイト](https://doc.rust-jp.rs/book-ja/appendix-03-derivable-traits.html)
- [100 日後に Rust をちょっと知ってる人になる: [Day 42]属性 (アトリビュート)](https://zenn.dev/shinyay/articles/hello-rust-day042)
- [ライブラリ辞典: Rust のアトリビュートとは](https://libdict.com/rust/lang-attributes)
