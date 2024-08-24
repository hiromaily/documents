# クロージャ

無名関数

```rs
fn main() {
  let mut arr = [4, 8, 1, 10, 0, 45, 12, 7];
  arr.sort; // 昇順
  arr.sort_by(|a, b| b.cmp(a)); // 降順
  // このクロージャは内部的にa, bを参照として受け取る
}
```

様々な構文

```rs
let factor = 2;
let multiply = |a| a * factor;
let multiply_ref = &multiply;
print!(
  " {} {} {} {} {} {}",
  multiply(13)
  multiply_ref(13)
  (*multiply_ref)(13),
  (|a| a * factor)(13),
  (|a: i32| a * factor)(13),
  (|a| -> i32 { a * factor })(13),
);

```

## References

- [Rust By Example 日本語版: クロージャ](https://doc.rust-jp.rs/rust-by-example-ja/fn/closures.html)
