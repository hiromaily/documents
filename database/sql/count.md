# Count集約関数

- [COUNT(*), COUNT(1), COUNT(expr) の違いを SQL 標準から理解する](https://zenn.dev/indigo13love/articles/3d1c0be54f53fa)
  - COUNT(*): 常に集約内の行数を返す
  - COUNT(1): パフォーマンスの観点で COUNT(*) の代わりに使うといい、とよく言われている式
    - 実際にはほとんど変わらないが、COUNT(1) のほうが速いケースが出てくる
