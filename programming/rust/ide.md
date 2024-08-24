# Rust IDE

## VSCode

### [rust.analyzer](https://rust-analyzer.github.io/)

以下の方法は古い。VSCode を使う場合、[Extension](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)が存在する

```sh
# install rust-analyzer
## rls: Rust Language Server: これは既に非推奨になっている
rustup component add rls rust-src rust-analysis
```

### フォーマッターの設定

add `rustfmt.toml` in project root

```toml
tab_spaces = 2
max_width = 160
chain_width = 160
```
