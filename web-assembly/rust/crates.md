# WASMで利用するCrates

- [wasm-bindgen](https://crates.io/crates/wasm-bindgen)
  - JavascriptとRustで双方でやり取りするために必要なもの
- [serde-wasm-bindgen](https://crates.io/crates/serde-wasm-bindgen)
  - `Serde`をwasm-bindgenに組み込んだもの
- [wasm-bindgen-futures](https://crates.io/crates/wasm-bindgen-futures)
  - JavascriptとRustで双方でやり取りするうえでの非同期処理を扱うもの (Rust: Future, Javascript: Promise)
- [web-sys](https://crates.io/crates/web-sys)
  - [web-sys](https://github.com/rustwasm/wasm-bindgen/tree/main/crates/web-sys)も`wasm-bindgen`のgithub repository内に存在する
  - wasm-bindgenを使っているプロジェクトにおいて、ブラウザのWeb APIへのbindingを行うもの
  - これにより様々なWeb APIが利用できるようになる
- [wee_alloc](https://crates.io/crates/wee_alloc)
  - [rustwasmのページによる説明](https://rustwasm.github.io/docs/wasm-pack/tutorials/npm-browser-packages/template-deep-dive/wee_alloc.html)
  - 小さなコードサイズのために最適化されたアロケータ
  - 相当昔に更新が止まっているが大丈夫なのだろうか？
- [console_error_panic_hook](https://crates.io/crates/console_error_panic_hook)
  - `wasm32-unknown-unknown`ターゲットでビルドした環境(例えばWASM)で`panic`をハンドリングできるようにしたもの

## `#[wasm_bindgen(start)]` について

これは自動で起動されることになる

- [start](https://rustwasm.github.io/wasm-bindgen/reference/attributes/on-rust-exports/start.html)

## web-sys

機能はDefaultでOffなので、利用したいAPI毎に`Cargo.toml`で`features`を設定する必要がある

```toml
web-sys = { version = "0.3", features = [
    "console",
    "Window",
    "Document",
    "Element",
    "HtmlCanvasElement",
    "CanvasRenderingContext2d",
] }
```
