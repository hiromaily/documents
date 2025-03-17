# [typing: 型ヒントのサポート](https://docs.python.org/ja/3.13/library/typing.html)

Python の型付けモジュールは型ヒントをサポートしており、開発者はオプションで静的型付けをコードに追加できます。Python の型付けの使用方法は次のとおり。

1. Basic Type Annotations:
   変数、関数パラメータ、戻り値に基本型で注釈を付けることができる。

   ```python
   age: int = 20
   name: str = "Alice"
   is_active: bool = True
   
   def greet(name: str) -> str:
       return f"Hello, {name}!"
   ```

2. Complex Types:
   より複雑な型の場合は、typingモジュールを使用する。

   ```python
   from typing import List, Dict, Union, Optional
   
   def process_items(items: List[str]) -> None:
       for item in items:
           print(item)
   
   def handle_data(data: Dict[str, Union[int, str]]) -> Optional[str]:
       # Function implementation
       pass
   ```

3. Union Types:
  変数が複数の型を持つことができることを示すには、Unionを使用する。

   ```python
   from typing import Union
   
   def process_item(item: Union[int, str]):
       print(item)
   ```

4. Optional Types:
   Noneになる可能性のある値にはOptionalを使用する

   ```python
   from typing import Optional

   def say_hi(name: Optional[str] = None):
       if name is not None:
           print(f"Hey {name}!")
       else:
           print("Hello World")
   ```

5. Type Aliases:
   読みやすさを向上させるために複合型のエイリアスを作成する

   ```python
   from typing import Dict, List, Union
   
   JSONObject = Dict[str, Union[str, int, float, bool, None, List[Any], 'JSONObject']]
   ```

6. Generic Types:
   ジェネリック型ヒントにはTypeVarを使用する:

   ```python
   from typing import TypeVar, List
   
   T = TypeVar('T')
   
   def first(l: List[T]) -> T:
       return l[0]
   ```

7. Type Checking:
mypy、pyright、Pytypeなどのツールを使用して、コードの静的型チェックを実行する。
