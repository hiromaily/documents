# WebAssembly

WebAssembly (abbreviated Wasm) is a binary instruction format for a stack-based virtual machine.  
Wasm is designed as a portable compilation target for programming languages, enabling deployment on the web for client and server applications.

Web ブラウザ上で高速に動作するバイナリコードの仕様で、WebAssembly の頭文字を取って、`Wasm`と略される。Web ブラウザでコンパイルされた C/C++や Rust を実行する仕組み（アセンブラ）を指すもの。

## WASM でできること

- JavaScript 以上の高速処理
- 既存のソースコードのブラウザでの実行
  - ネイティブアプリケーションを Web アプリケーションへ容易に移行できるメリットになる

### できないこと

- WebAssembly は、DOM 操作が出来ない

## 利用シーン

- ビデオまたはオーディオ編集
- Web ブラウザでのゲーム
- 科学分野での視覚化とシミュレーション
- コンピュータゲームのエミュレーター

### 利用されているアプリケーション

- Unity
- Google Earth
- AutoCAD
- Figma

## 使用できる言語

- Rust
- Go
- Java
- PHP
- C# .NET
- C++
- Ruby
- C
- Swift
- R

## よく使われる用語

- WASM
  - WebAssembly の略称で、バイナリコードのフォーマット
- WAT
  - WASM ではテキスト形式での表現が可能で、テキストエディターや開発ツールにて、レビューや編集を実行できるように設計されている
  - WASM をテキスト形式にフォーマットしたものを、WAT（WebAssembly Text Format）
- WASI
  - WebAssembly System Interface

## References

- [Docs](https://webassembly.org/)
- [Wasm By Example](https://wasmbyexample.dev/home.en-us.html)
- [MDN: WebAssembly](https://developer.mozilla.org/en-US/docs/WebAssembly)
- [Can I use WASM](https://caniuse.com/wasm)
- [Web­Assembly Rust](https://www.rust-lang.org/ja/what/wasm)
  - [Docs](https://rustwasm.github.io/docs/book/)
- [WebAssembly 開発環境構築の本](https://wasm-dev-book.netlify.app/)
  - Rust を用いた WebAssembly の開発環境を構築する
- [Linux コンテナの「次」としての WebAssembly、の解説](https://zenn.dev/koduki/articles/9f86d03cd703c4)
