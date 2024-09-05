# WebAssembly

WebAssembly (abbreviated Wasm) is a binary instruction format for a stack-based virtual machine.  
Wasm is designed as a portable compilation target for programming languages, enabling deployment on the web for client and server applications.

Web ブラウザ上で高速に動作するバイナリコードの仕様で、WebAssembly の頭文字を取って、`Wasm`と略される。Web ブラウザでコンパイルされた C/C++や Rust を実行する仕組み（アセンブラ）を指すもの。

## WASM でできること (ブラウザ上)

ブラウザの場合、ブラウザの JS エンジン上で動く

- JavaScript 以上の高速処理
- 既存のソースコードのブラウザでの実行
  - ネイティブアプリケーションを Web アプリケーションへ容易に移行できるメリットになる
- Wasm と Javascript 間でデータのやり取りができる
- JS と Wasm 間で関数の相互呼び出しができる
  - console.log を Wasm 側に import することもできる

### 対応ブラウザ (一部抜粋)

- Chrome
- Edge
- Safari
- Firefox
- Chrome for Android
- iOS Safari

### できないこと

- WebAssembly は、DOM 操作が出来ない
- ブラウザ API の実行

### 利用シーン

- ビデオまたはオーディオ編集
- Web ブラウザでのゲーム
- 科学分野での視覚化とシミュレーション
- コンピュータゲームのエミュレーター

### 利用されているアプリケーション

- Unity
- Google Earth
- Google Meet
- AutoCAD
- Figma
- Amazon Prime Video

## ブラウザ以外での Wasm の利用

WASM Runtime 上 で実行される

- cloud servers (serverless platforms)
- IoT devices
- Rust で書かれた Blockchain Node ではスマートコントラクトを Wasm として実装できるものが多い
  - プラグインとしての利用

### Wasm ランタイム

- [Wasmtime](https://wasmtime.dev/)
- [WasmEdge](https://wasmedge.org/)
- [Wasmer](https://wasmer.io/)

### Wasm の埋め込み　(plugin としての利用)

- Node.js
- Go, Rust

## [使用できる言語 (抜粋)](https://github.com/appcypher/awesome-wasm-langs)

ほとんどの言語が対応しているが、production use としては以下の言語

- Rust
- C
- C++
- Go (ファイルサイズが大きい)
  - TinyGo を使ったほうがいいかもしれないが未検証

### 向いている言語

- クロスコンパイルができる
- ランタイムが軽い
  - GC がない方が良い
  - 標準ライブラリを省ける

そうなってくるとやはり Rust になる

### ビルド後のファイルサイズは？

WebAssembly（Wasm）のビルド後のファイルサイズは、使用するプログラミング言語、および言語ごとのコンパイラやツールチェインによって大きく異なることがある。

1. **C/C++:**
   - 非常に小さなファイルサイズを生成することができる。`Emscripten`を使用することで、通常数百キロバイト程度のファイルが生成されることが多い。また、さらに最適化オプションを使用すると、ファイルサイズを数十キロバイトまで減らすことも可能。

2. **Rust:**
   - Rustも効率的なバイトコードを生成することで知られており、C/C++に近いサイズのWasmファイルを生成できる。Rustの標準ライブラリを使用しない場合や、最適化を行うことで数百キロバイト程度のファイルサイズに抑えることができる。

3. **AssemblyScript:**
   - TypeScript派生のこの言語は、比較的小さめのWasmファイルを生成する。実際のサイズはアプリケーションの複雑さによるが、通常は数十キロバイトから数百キロバイト程度に収まる。

4. **Go:**
   - Go言語はランタイムとガベージコレクション（GC）のため、比較的大きめのWasmファイルを生成する。標準的なGoプログラムの場合、ファイルサイズは数メガバイト（数MB）になることが多い。

5. **TinyGo:**
   - Goの軽量版であるTinyGoは、Go言語と同様の機能を提供しつつ、非常に小さなWasmファイルを生成する。通常は数百キロバイト程度のファイルを生成する。

6. **JavaScript:**
   - JavaScript自体は直接Wasmバイトコードを生成しないが、各種ツールを使用してWasmに変換することが可能。ただし、オーバーヘッドが大きくなることが一般的。

### 最適化

最適化手法（デッドコードの削除、圧縮、圧縮アルゴリズムの使用など）を駆使することでファイルサイズをさらに小さくすることが可能。最適化の結果には言語の特徴や使用ライブラリ、ビルドオプションの設定が大きく影響するため、これらの要素も考慮する必要がある。

## [WebAssembly 2.0](https://webassembly.github.io/spec/core/)

- Sign extension instruntions（整数における符号拡張命令）
- Non-trapping float-to-int conversions（浮動小数点型から整数型への変換時のトラップ処理なし）
- Multiple values（関数が複数の値を返せる）
- Reference types（参照型の追加）
- Table instructions（参照型を要素に持つテーブル型に対する操作命令）
- Multiple tables （複数テーブルの処理）
- Bulk memory and table instructions （一定範囲のメモリやテーブルに対する操作）
- Vector instructions（並行処理が可能なベクトル処理命令の追加）

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
