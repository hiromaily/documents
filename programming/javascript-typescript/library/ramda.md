# Ramda

関数型プログラミング スタイルに特化して設計されたライブラリで、関数型パイプラインを簡単に作成できる。
RamdaはJavaScript用の関数型ライブラリで、関数型プログラミングのパラダイムをサポートするために設計されている。

## 特徴

1. **不変性（Immutable）**: データは変更されず、新しいデータ構造が作られる。
2. **カリー化（Currying）**: Ramdaのすべての関数は自動的にカリー化されている。カリー化とは、関数に一つずつ引数を渡せるようにするテクニック。
3. **関数の合成（Function Composition）**: 小さな関数を組み合わせて複雑な処理を行うことが容易。
4. **データの処理**: 配列やオブジェクトの操作が直感的に行える。

```js
const R = require('ramda');

// カリー化の例：add関数
const add = R.add;
const addFive = add(5);
console.log(addFive(3)); // 8

// map関数の例
const doubled = R.map(x => x * 2, [1, 2, 3]);
console.log(doubled); // [2, 4, 6]

// compose関数の例：関数合成
const increment = x => x + 1;
const double = x => x * 2;
const incrementAndDouble = R.compose(double, increment);

console.log(incrementAndDouble(2)); // 6 ((2 + 1) * 2)
```

Ramdaを使用すると関数型プログラミングの利点を享受しながら、コードをより短く、読みやすく保つことができる

## References

- [Docs](https://ramdajs.com/)
