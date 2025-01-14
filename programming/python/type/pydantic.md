# pydantic ライブラリ

Pydantic は、Python のデータバリデーションと設定管理を簡素化するためのライブラリ。`Python の標準ライブラリの型ヒントと統合され`、高速かつユーザーフレンドリーにデータをバリデートおよび変換するために使用される。特に、FastAPI などのフレームワークと一緒に使われることが多い。

## 主な機能

1. **データバリデーション**: 入力されたデータが正しい型や値を持っているか確認。
2. **データ変換**: データの変換（例：文字列を整数に変換など）が自動的に行われる。
3. **モデル定義**: データモデルを Python のクラスとして定義できる。
4. **エラーメッセージの管理**: バリデーションエラーをカスタマイズ可能。
5. **デフォルト値の設定**: モデルフィールドにデフォルト値を設定可能。
6. **ネストされたモデル**: ネストされた構造のデータモデルもサポート。

## インストール

```bash
pip install pydantic
```

## 基本的な使い方

Pydantic の基本的な使い方はモデルの定義から始まる

```python
from pydantic import BaseModel, ValidationError

# ユーザーモデルの定義
class User(BaseModel):
    id: int
    name: str
    is_active: bool = True

# モデルのインスタンスを生成
try:
    user = User(id=123, name="Alice")
    print(user)
except ValidationError as e:
    print(e)

# モデルインスタンスの属性にアクセス
print(user.id)          # 123
print(user.name)        # Alice
print(user.is_active)   # True (デフォルト値)
```

## データバリデーションと変換

Pydantic は自動でデータのバリデーションと変換を行う。
たとえば、文字列を整数に変換するなど：

```python
from pydantic import BaseModel, ValidationError

class Item(BaseModel):
    quantity: int

try:
    item = Item(quantity="10")
    print(item)
except ValidationError as e:
    print(e)

# 変換後のデータ
print(item.quantity)   # 10（文字列が整数に変換される）
```

## ネストモデル

ネストされたモデルもサポートしている

```python
class Address(BaseModel):
    street: str
    city: str

class User(BaseModel):
    id: int
    name: str
    address: Address

user = User(id=123, name="Alice", address={"street": "123 Main St", "city": "Wonderland"})
print(user)
```

## カスタムバリデーション

独自のバリデーションロジックを追加することも可能

```python
from pydantic import BaseModel, validator

class User(BaseModel):
    id: int
    name: str

    @validator('name')
    def name_must_be_alphanumeric(cls, value):
        if not value.isalnum():
            raise ValueError('name must be alphanumeric')
        return value

try:
    user = User(id=123, name="Alice123")
    print(user)
except ValidationError as e:
    print(e)

try:
    user = User(id=123, name="Alice@123")
except ValidationError as e:
    print(e)
```

その他、設定モデルの定義（`dataclass`のように簡単に設定ファイルを読み込むための機能）や環境変数のサポートなどの多機能も備えている。

## References

- [Pydantic入門 – Pythonでシンプルかつ強力なバリデーションを始めよう](https://qiita.com/Tadataka_Takahashi/items/8b28f49d67d7e1d65d11)
