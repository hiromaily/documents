# rustfmt

- [github](https://github.com/rust-lang/rustfmt)
- [Configuring Rustfmt](https://rust-lang.github.io/rustfmt/)

## nightly を使うべきか

設定によっては以下のメッセージが表示される

```sh
unstable features are only available in nightly channel
```

この場合、[rustfmt-nightly](https://crates.io/crates/rustfmt-nightly)

## rustfmt.toml

```toml
merge_imports = true
```
