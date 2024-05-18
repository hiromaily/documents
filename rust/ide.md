# Rust IDE

## VSCode

### [rust.analyzer](https://rust-analyzer.github.io/)

以下の方法は古いかもしれない。VSCode の場合、[Extension](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)が存在する

```sh
# install rust-analyzer
## rls: Rust Language Server
rustup component add rls rust-src rust-analysis
```

### フォーマッターの設定

add `rustfmt.toml` in project root

```toml
tab_spaces = 2
max_width = 160
chain_width = 160
```
