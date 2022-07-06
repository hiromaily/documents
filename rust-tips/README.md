# Rust Tips

## References

- [Rust by Example 日本語版](https://doc.rust-jp.rs/rust-by-example-ja/)
- [Rust 入門](https://zenn.dev/mebiusbox/books/22d4c1ed9b0003)
- [とほほの Rust 入門](https://www.tohoho-web.com/ex/rust.html)

## Install on MacOS

```
brew install rustup-init
rustup-init
exec $SHELL -l

rustup --version
rustc --version
cargo --version

# install cargo-edit (https://crates.io/crates/cargo-edit)
cargo install cargo-edit

# install rust-analyzer
rustup component add rls rust-src rust-analysis

# update all
rustup update

# create project
cargo new foo_bar
```

## cargo-edit

- [cargo-edit](https://crates.io/crates/cargo-edit)

```
# add package
cargo add <package-name>
cargo add <package-name>@<version>

# add package for development
cargo add <package-name> --dev

# upgrade package
cargo upgrade <package-name>

# remove package
cargo rm <package-name>
```
