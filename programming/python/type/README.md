# Pythonの型

[組み込み型](https://docs.python.org/ja/3.13/library/stdtypes.html)

1. **数値型 (Numeric Types)**
    - `int`: 整数型。例: `10`, `-3`
    - `float`: 浮動小数点数型。例: `3.14`, `-0.001`
    - `complex`: 複素数型。例: `1+2j`, `3-4j`

2. **シーケンス型 (Sequence Types)**
    - `str`: 文字列型。例: `"Hello"`, `'World'`
    - `list`: リスト型。可変な配列。例: `[1, 2, 3]`, `['a', 'b', 'c']`
    - `tuple`: タプル型。変更不可の配列。例: `(1, 2, 3)`, `('a', 'b', 'c')`
    - `range`: 整数範囲型。例: `range(5)`, `range(1, 10, 2)`

3. **マッピング型 (Mapping Type)**
    - `dict`: 辞書型。キーと値のペアの集合。例: `{'key1': 'value1', 'key2': 'value2'}`

4. **集合型 (Set Types)**
    - `set`: 集合型。重複のない要素の無順序コレクション。例: `{1, 2, 3}`, `{'a', 'b', 'c'}`
    - `frozenset`: 凍結集合型。変更不可能な集合。例: `frozenset([1, 2, 3])`

5. **ブール型 (Boolean Type)**
    - `bool`: 真理値型。例: `True`, `False`

6. **None 型**
    - `NoneType`: `None`。例: `None`

それ以外にも、Pythonでは様々なカスタムデータ型や、標準ライブラリを使用してさらに複雑なデータ型を扱うことができる。また、クラスを使って独自のデータ型を定義することもできる。
