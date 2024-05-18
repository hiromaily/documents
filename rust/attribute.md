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

### `#[allow(dead_code)]`

使用されていない関数が存在するときに警告が出るが、この機能を無効化することができる

```rs
#[allow(dead_code)]
fn unused_function() {}
```

### crate

`crate_type`属性は、そのクレートがライブラリ、バイナリのいずれにコンパイルされるべきかをコンパイラに伝えるために使用する。ライブラリの場合は、どのタイプのライブラリであるかも伝えることができる。
`crate_name`はクレートの名前を決定するのに使用する。
しかし、`crate_type`属性も`crate_name`属性も、Rust のパッケージマネージャ Cargo を利用している場合は不要

```rs
#![crate_type = "lib"]
#![crate_name = "rary"]
```

### cfg

環境に応じたコンパイルをするには 2 種類の方法がある

- cfg 属性: `#[cfg(...)]`を属性として使用する
- cfg!マクロ: `cfg!(...)`を Boolean として評価する

- トレイトの既定実装を示す `#[derive(...)]`
- ユニットテストの `#[test]`, `#[should_panic]`, `#[ignore]`，
- コンパイラに伝える `#[allow(...)]` や `#[cfg(...)]`

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
- [100 日後に Rust をちょっと知ってる人になる: [Day 42]属性 (アトリビュート)](https://zenn.dev/shinyay/articles/hello-rust-day042)
