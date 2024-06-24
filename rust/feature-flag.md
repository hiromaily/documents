# Feature flag

```cargo.toml
[features]
# デフォルトでenabled
default = ["webp"]

# Defines a feature named `webp` that does not enable any other features.
webp = []

# Features can list other features to enable
ico = ["bmp", "png"]
```

## コマンドライン

```sh
RUST_LOG=debug cargo run --no-default-features --features "scrypt" -- ./config/settings.toml -d
```

## [crates: cfg-if](https://crates.io/crates/cfg-if)

conditional に`cfg`を設定できる。`else`により feature 指定がない場合の挙動も可能。

```rs
cfg_if! {
    if #[cfg(feature = "pbkdf2")] {
        fn new_hash() -> hash::HashPbkdf2 {
            debug!("hash crate is pbkdf2");

            // for now, only 1 implementation
            hash::HashPbkdf2::new()
        }
    } else if #[cfg(feature = "scrypt")] {
        fn new_hash() -> hash::HashScrypt {
            debug!("hash crate is scrypt");

            // for now, only 1 implementation
            hash::HashScrypt::new()
        }
     } else {
        compile_error!("One of the features 'pbkdf2' or 'scrypt' must be enabled");
    }
}
```

## cfg-if

## References

- [The Cargo Book: Features](https://doc.rust-lang.org/cargo/reference/features.html)
- [The Rust Reference: Conditional compilation](https://doc.rust-lang.org/reference/conditional-compilation.html)
- [crates.io: Cargo.toml](https://github.com/rust-lang/crates.io/blob/main/Cargo.toml)
