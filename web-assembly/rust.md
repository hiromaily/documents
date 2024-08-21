# WASM by Rust

- [Rust WebAssembly](https://www.rust-lang.org/what/wasm)
- [Rust🦀 and WebAssembly Docs](https://rustwasm.github.io/docs/book/introduction.html)
- [mdn: Compiling from Rust to WebAssembly](https://developer.mozilla.org/en-US/docs/WebAssembly/Rust_to_Wasm)

## Install

- [wasm-bindgen](https://github.com/rustwasm/wasm-bindgen)
  - for interactions between Wasm modules and JavaScript

```sh
# wasm-pack to build package
cargo install wasm-pack

# wasm_bindgen
cargo install wasm-bindgen-cli
```

## Procedure

1. create project by `cargo new --lib hello-wasm`
2. add `wasm-bindgen` in `hello-wasm` by `cargo add wasm-bindgen`
3. write code
4. build code by `wasm-pack build --target web` then `pkg` is generated
5. put `index.html`
6. check HTML. recommend [Simple Web Server](https://apps.apple.com/us/app/simple-web-server/id1625925255?mt=12&itsct=apps_box_badge&itscg=30200)
