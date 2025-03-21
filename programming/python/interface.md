# PythonのInterface型

Interface型をPythonで実現するためには、Pythonの抽象基底クラス（Abstract Base Classes, ABC）を使うことが一般的。

以下はDatabaseを環境ごとに切り替えるようにするための例を示す。

## 1. 抽象基底クラスの定義

まずは、共通のインターフェースを定義する。`abc` モジュールを使って抽象基底クラスを作成する。

```python
from abc import ABC, abstractmethod

class DatabaseInterface(ABC):

    @abstractmethod
    def connect(self):
        pass

    @abstractmethod
    def execute_query(self, query: str):
        pass
```

## 2. 具体的なデータベースクラスの実装

抽象基底クラスを実装した具象クラスをそれぞれのデータベース向けに作成する。

- **PostgreSQL用のClassの例**

```python
import psycopg2

class PostgreSQLDatabase(DatabaseInterface):
    
    def __init__(self, dsn: str):
        self.dsn = dsn
        self.connection = None

    def connect(self):
        self.connection = psycopg2.connect(self.dsn)

    def execute_query(self, query: str):
        with self.connection.cursor() as cursor:
            cursor.execute(query)
            results = cursor.fetchall()
        return results
```

- **SQLite用のClassの例**

```python
import sqlite3

class SQLiteDatabase(DatabaseInterface):
    
    def __init__(self, db_path: str):
        self.db_path = db_path
        self.connection = None

    def connect(self):
        self.connection = sqlite3.connect(self.db_path)

    def execute_query(self, query: str):
        cursor = self.connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        return results
```

## 3. Dependency Injectionによって環境に応じて初期化する

具体的なデータベースクラスを環境に応じて注入する、Dependency Injectionの仕組みを利用する。

```python
# Interface型をプロパティに持つClass
class DatabaseClient:
    
    def __init__(self, database: DatabaseInterface):
        self.database = database

    def run_query(self, query: str):
        return self.database.execute_query(query)

# 環境設定やDIコンテナの設定部分 (例)
def main(environment):
    if environment == 'production':
        db = PostgreSQLDatabase(dsn="dbname=mydb user=myuser password=mypass host=myhost port=myport")
    elif environment == 'development':
        db = SQLiteDatabase(db_path="dev.db")
    else:
        raise ValueError("Unknown environment")

    # DI によりクライアントインスタンスを生成
    client = DatabaseClient(database=db)
    client.database.connect()
    
    results = client.run_query("SELECT * FROM my_table")
    print(results)

if __name__ == "__main__":
    import os
    environment = os.getenv('ENV', 'development')
    main(environment)
```

## abc モジュール

`abc` モジュールは、Pythonの標準ライブラリの一部であり、`抽象基底クラス（Abstract Base Classes, ABC）を定義するために使用される`。抽象基底クラスを使用することで、クラスのインターフェースや継承関係をより厳密に定義し、特定のメソッドがサブクラスで実装されるべきであることを強制することができる。

### 主な機能

1. **抽象基底クラスの定義**
2. **抽象メソッドの定義**

### 主なクラスとデコレータ

- `ABC` クラス: これを基底クラスとして新しい抽象基底クラスを定義します。
- `abstractmethod` デコレーター: これを使って、サブクラスで必ず実装されるべきメソッドを定義します。

### 使用例

```python
# `abc` モジュールのインポート
from abc import ABC, abstractmethod

# `Animal` クラスは抽象基底クラスであり、`make_sound` と `move` メソッドは抽象メソッドになる。
# 抽象基底クラスはインスタンス化できない。

# 抽象基底クラスの作成
class Animal(ABC):
    
    # 抽象メソッド
    @abstractmethod
    def make_sound(self):
        pass
    
    # 抽象メソッド
    @abstractmethod
    def move(self):
        pass

# サブクラスでの具象実装
class Dog(Animal):
    
    def make_sound(self):
        return "Bark"
    
    def move(self):
        return "Run"

class Cat(Animal):
    
    def make_sound(self):
        return "Meow"
    
    def move(self):
        return "Jump"
```

具象実装である`Dog` と `Cat` クラスが `Animal` 抽象基底クラスを継承し、抽象メソッドを実装している。
このように、すべての抽象メソッドを具体的に実装しない限り、`Dog` や `Cat` のような具象クラスはインスタンス化できない。

### 例外の発生

抽象メソッドを実装しない場合にどのようなエラーが出るか

```python
class Fish(Animal):
    def make_sound(self):
        return "Blub"

# Fish クラスは move メソッドを実装していないのでエラーが発生する
fish = Fish()  # TypeError: Can't instantiate abstract class Fish with abstract method move
```

このようにして、`abc` モジュールを使うことで、サブクラスに特定のメソッドの実装を強制でき、インターフェースに対する期待を明示的にすることができる。
