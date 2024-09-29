# Solidity bytes

## References

- [Solidity Tutorial : all about Bytes](https://jeancvllr.medium.com/solidity-tutorial-all-about-bytes-9d88fdb22676)
- [solidity-examples: Bytes](https://github.com/ethereum/solidity-examples/blob/master/docs/bytes/Bytes.md)

## byte 文字列を変数にセットする

```sol
# TypeError: Type int_const 5084...(10552 digits omitted)...6129 is not implicitly convertible to expected type bytes memory
bytes memory byteData = 0xf0f1f2f3f4f5f6f7f8f9e0e1e2e3e4e5e6e7e8e9d0d1d2d3d4d5d6d7d8d9c0c1c2c3c4c5c6c7c8c9b0b1b2b3b4b5b6b7b8b9a0a1a2a3a4a5a6a7a8a999989796;

# will be successful
bytes memory byteData = hex"0xf0f1f2f3f4f5f6f7f8f9e0e1e2e3e4e5e6e7e8e9d0d1d2d3d4d5d6d7d8d9c0c1c2c3c4c5c6c7c8c9b0b1b2b3b4b5b6b7b8b9a0a1a2a3a4a5a6a7a8a999989796";
```
