# AssemblyScript

[Official](https://www.assemblyscript.org/)

AssemblyScript は[binaryen](https://github.com/WebAssembly/binaryen)を使って、TypeScript の変異モデルをコンパイルして WebAssembly に変換する

```ts
export function fib(n: i32): i32 {
  var a = 0,
    b = 1;
  if (n > 0) {
    while (--n) {
      let t = a + b;
      a = b;
      b = t;
    }
    return b;
  }
  return a;
}
```

TypeScript に似ているが、`WebAssembly 型`を持ち、厳格に型付けされたコードを先取りしてコンパイルするため、いくつかの制約がある。 TypeScript のすべてをサポートできるわけではないが、JavaScript と密接な関係があるため、すでに Web 向けのコードを書くことに慣れている開発者にとっては馴染みのある選択肢であり、また、無駄のない平均的な WebAssembly モジュールを作成するために、既存の Web Platform の概念とシームレスに統合できる可能性がある。

## WebAssembly の観点から

AssemblyScript は WebAssembly とコンパイラの基礎を組み込み関数として提供し、生の WebAssembly の上の薄い層として適している。 たとえば、WebAssembly 命令に直接コンパイルされる組み込み関数を使用して、メモリにアクセスできる

```
store<i32>(ptr, load<i32>(ptr) + load<i32>(ptr, 4), 8)
```

ほとんどの WebAssembly 命令は、AssemblyScript コードで直接記述することもできる

```
i32.ctz(...)             // ctz<i32>(...)
f64.reinterpret_i64(...) // reinterpret<f64>(...)
i64.load32_u(...)        // <i64>load<u32>(...)
...
```

## JavaScript の観点から見ると

低レベルの機能の上に実装された AssemblyScript は、JavaScript のような標準ライブラリを提供する
