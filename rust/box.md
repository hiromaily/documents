# Box

Rust において、すべての値はデフォルトで`スタック`に割り当てられるが、`Box<T>`を作成することで、値を ボックス化 、すなわちヒープ上に割り当てることができる。ボックスとは正確には`ヒープ上におかれたTの値へのスマートポインタ`。ボックスがスコープを抜けると、デストラクタが呼ばれて内包するオブジェクトが破棄され、ヒープメモリが解放される。
ボックス化された値は`*`オペレータを用いてデリファレンスすることができ、これにより一段と直接的な操作が可能になる。

## Box をどのタイミングで利用するか？

[参考: Box の使いどころ](https://zenn.dev/woden/articles/46e0b4a0c8264d)

### 1. trait オブジェクトを関数の戻り値として返すような場合

```rs
fn foo() -> Box<dyn t>
```

戻り値の`t`は`trait t`を実装したオブジェクトとなるので、実行時にサイズが決定される。スタックに値を積む場合、コンパイル時にサイズが決定されている必要があるが、Box を使うとヒープ上に確保されたメモリへの参照(=ポインタ)のサイズとなるため、コンパイル時に（スタックに積むべき）サイズが固定となる。
つまり、`Boxを使うとコンパイル時にサイズが決定できる`、という性質があるため、このように trait オブジェクトを返す用途以外にも、trait 境界に Sized が指定されている引数を渡すような場合に Box で包む事で渡す事ができるようなったりする。

補足: `dyn`キーワードは、dynamic の略で、実行時にトレイトの具体的な型を決めたいときに使うもの

### 2. （ジェネリックではない）struct 内に dyn で trait オブジェクトを持たせたい場合

struct 内のオブジェクトを実行時に動的に変える必要があるケース

```rs
struct Foo{
	bar:Box<dyn Bar>
}
```

Box を使わなければ、Foo 全体が Sized ではなくなってしまうので、trait 境界で Sized が要求される場合に、Foo オブジェクトを渡せない、という事態が発生するが、Box を使えば Sized になってくれるので、そういう事態も防ぐことができる。

## References

- [Rust By Example 日本語版: Box, スタックとヒープ](https://doc.rust-jp.rs/rust-by-example-ja/std/box.html)