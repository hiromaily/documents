# Glossary 用語集

## 型パラメータ

ジェネリックに使われる`<T>`というシンボル
パラメータの型は推論可能

## Option<T>列挙体

失敗の可能性がある関数は多く、その戻り値によく使用される

```rs
enum Option<T>
    Some(T),
    None,
```

これは、T 型のオプション値で、T 型のどれかであるケースと、どれでもないの二者択一となる

## Result ＜ T， E ＞列挙型

Option 型が`結果がない場合`を`None`で表現するのに対して、Result 型ではエラーの条件や理由を記述した値を追加する

```rs
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

### unwrap 関数

Ok バリアントに適用されたらその値を返すが、そうでなければ Panic を起こす

### unwrap_err 関数

エラーが返ると確信している場合などに使う

### expect 関数

unwrap と似ているが、エラーメッセージを添えることができる

## クロージャー (環境をキャプチャできる無名関数)

syntax `|~|`

### `moveクロージャ`

クロージャの外のスコープの変数をクロージャ内から直接参照した場合、通常は借用されるが、move を指定することで所有権を移動することができる。
クロージャに引数で渡す場合には影響しない。

- [参考: Rust、クロージャ、move](https://zenn.dev/s_takashi/scraps/7f14e27783853c)

## `dyn`キーワード

dynamic の略で、実行時にトレイトの具体的な型を決めたいときに使う