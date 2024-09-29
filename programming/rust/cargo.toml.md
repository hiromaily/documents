# Cargo.toml

[rust-lang/crates.io/Cargo.toml](https://github.com/rust-lang/crates.io/blob/main/Cargo.toml)

```toml
[package]
name = "crates_io"
authors = ["my name"]
version = "0.0.0"
license = "MIT"
repository = "https://github.com/rust-lang/crates.io"
description = "Backend of crates.io"
edition = "2021"
default-run = "server"

[workspace]
members = ["crates/*"]

[workspace.lints.rust]
future_incompatible = "warn"
nonstandard_style = "warn"
rust_2018_idioms = "warn"
rust_2018_compatibility = "warn"
rust_2021_compatibility = "warn"
unused = "warn"

[workspace.lints.rustdoc]
unescaped_backticks = "warn"

[workspace.lints.clippy]
dbg_macro = "warn"
todo = "warn"

[lints]
workspace = true

[profile.release]
opt-level = 2

[lib]
name = "crates_io"
doctest = true

[features]
default = ["slow-tests"]

# The `slow-tests` enables tests that take a long time to finish. It is enabled
# by default but the test suite can be run via `cargo test --no-default-features`
# to disable these tests.
slow-tests = []

[dependencies]

[dev-dependencies]
```
