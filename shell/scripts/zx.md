# zx

JavaScriptでスクリプトを書くためのツール。zxは、Node.js環境でシェルスクリプトを書くことをより簡単かつ効率的にするためのツールキット。
`zx`を使うことで、複雑なスクリプトを簡単に作成し、メンテナンスしやすいコードにすることが可能になる。

## 利点

1. **シンプルなシンタックス**：従来のシェルスクリプトのように簡潔な記述が可能で、JavaScriptの知識があればすぐに使い始められる。
2. **非同期のサポート**：JavaScriptの非同期機能 (async/await) を使用して、より効果的に非同期操作を行うことができる。
3. **標準ライブラリへのアクセス**：Node.jsの標準ライブラリを直接利用できるため、複雑なタスクも処理可能。
4. **モジュールの使用**：npmを介して多くのパッケージやモジュールを簡単に取り入れることができる。

## 書き方

以下の例では、従来のシェルコマンドと同じように `echo` コマンドを実行しているが、JavaScriptのテンプレートリテラルや非同期処理のサポートを活用している。

```javascript
#! /usr/bin/env zx

await $`echo "Hello, world!"`;
```

## References

- [Offical](https://google.github.io/zx/)
  - [github](https://github.com/google/zx)
