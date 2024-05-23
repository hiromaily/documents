# Style Guide

[rust-lang/rfcs/text/0430-finalizing-naming-conventions.md](https://github.com/rust-lang/rfcs/blob/master/text/0430-finalizing-naming-conventions.md)

| Item                    | Convention                                                     |
| ----------------------- | -------------------------------------------------------------- |
| Crates                  | `snake_case` (but prefer single word)                          |
| Modules                 | `snake_case`                                                   |
| Types                   | `UpperCamelCase`                                               |
| Traits                  | `UpperCamelCase`                                               |
| Enum variants           | `UpperCamelCase`                                               |
| Functions               | `snake_case`                                                   |
| Methods                 | `snake_case`                                                   |
| General constructors    | `new` or `with_more_details`                                   |
| Conversion constructors | `from_some_other_type`                                         |
| Local variables         | `snake_case`                                                   |
| Static variables        | `SCREAMING_SNAKE_CASE`                                         |
| Constant variables      | `SCREAMING_SNAKE_CASE`                                         |
| Type parameters         | concise `UpperCamelCase`, usually single uppercase letter: `T` |
| Lifetimes               | short, lowercase: `'a`                                         |

## References

- [The Rust Style Guide](https://doc.rust-lang.org/nightly/style-guide/)
