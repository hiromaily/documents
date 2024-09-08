# Data フォーマット

これらのフォーマットは用途やシナリオによって使い分けるべき。それぞれに利点と欠点があるので、自分のプロジェクトに合ったものを選ぶことが重要。
特定の用途に最適なフォーマットを選ぶことが、効率的なデータ処理や通信を実現するカギとなる。

## テキストデータ

### JSON (JavaScript Object Notation)

- **用途**: データの構造化や交換によく使われる。特に Web API のレスポンスやフロントエンドとバックエンド間のデータ交換で多い。
- **利点**: 人間が読みやすく、ほとんどのプログラミング言語でサポートされている。
- **例**:

  ```json
  {
    "name": "Alice",
    "age": 30,
    "isStudent": false
  }
  ```

### YAML (YAML Ain't Markup Language)

- **用途**: 設定ファイルやデータシリアライゼーションに使われることが多い。特に、Kubernetes などの設定ファイルに多用されている。
- **利点**: 人間が非常に読みやすい構造で、多くのプログラミング言語でサポートされている。
- **例**:

  ```yaml
  name: Alice
  age: 30
  isStudent: false
  ```

### XML (eXtensible Markup Language)

- **用途**: データ交換、特に設定データや文書データの保存によく使われる。SOA（サービス指向アーキテクチャ）や一部の Web サービスで多用される。
- **利点**: 拡張性が高く、データの構造とデータを同時に保持できる。スキーマ (XSD) を使用してデータのバリデーションも可能。
- **例**:

  ```xml
  <person>
    <name>Alice</name>
    <age>30</age>
    <isStudent>false</isStudent>
  </person>
  ```

### CSV (Comma-Separated Values)

- **用途**: 表形式のデータを簡単に保存・交換するために使われる。データベースのエクスポートやインポート、スプレッドシートでのデータ操作によく利用される。
- **利点**: シンプルでほぼすべてのプログラミング言語やツールでサポートされている。
- **例**:

  ```csv
  name,age,isStudent
  Alice,30,false
  ```

### INI ファイル

- **用途**: シンプルな設定ファイル形式。Windows の初期設定ファイルなどでよく見られる。
- **利点**: 人間が読みやすく書きやすい。簡単な設定データに適している。
- **例**:

  ```ini
  [person]
  name=Alice
  age=30
  isStudent=false
  ```

## バイナリデータ

### Protocol Buffers

- **用途**: Google が開発したシリアライズフォーマットで、構造化データを効率的にシリアライズ、デシリアライズするために使われる。特に分散システムやマイクロサービス間の通信でよく使われる。
- **利点**: 非常に高速で、省メモリ。スキーマ（.proto ファイル）を使ってデータの定義とバリデーションが可能。
- **例**:

  ```proto
  // example.proto
  syntax = "proto3";

  message Person {
    string name = 1;
    int32 age = 2;
    bool is_student = 3;
  }
  ```

  ```python
  import example_pb2

  person = example_pb2.Person()
  person.name = "Alice"
  person.age = 30
  person.is_student = False

  serialized_data = person.SerializeToString()
  deserialized_person = example_pb2.Person().FromString(serialized_data)
  ```

### MessagePack

- **用途**: バイナリ形式でデータを効率的にシリアライズおよびデシリアライズするために使われる。ネットワーク通信やパフォーマンスが重要な場面でよく使われる。
- **利点**: コンパクトなバイナリ形式のため、高速で省メモリ。
- **例**:

  ```python
  import msgpack

  data = {
    "name": "Alice",
    "age": 30,
    "isStudent": False
  }
  packed = msgpack.packb(data)
  unpacked = msgpack.unpackb(packed)
  ```

### BSON (Binary JSON)

- **用途**: JSON のバイナリ形式。MongoDB などの NoSQL データベースで使用される。
- **利点**: バイナリ形式のため、JSON よりも高速に読み書きできる。
- **例**:

  ```python
  import bson

  data = {
    "name": "Alice",
    "age": 30,
    "isStudent": False
  }
  serialized_data = bson.dumps(data)
  deserialized_data = bson.loads(serialized_data)
  ```

### Avro

- **用途**: Apache・Hadoop のプロジェクトで開発されたデータシリアライゼーションシステム。大規模データ処理システムで使われることが多い。
- **利点**: スキーマを使ったデータの定義とバリデーションができる。スキーマ進化（バージョン対応）がサポートされている。
- **例**:

  ```json
  {
    "type": "record",
    "name": "Person",
    "fields": [
      { "name": "name", "type": "string" },
      { "name": "age", "type": "int" },
      { "name": "isStudent", "type": "boolean" }
    ]
  }
  ```

### Thrift

- **用途**: Apache・ソフトウェア財団が開発したシリアライゼーション形式。分散システムやクロスランゲージの RPC で使用される。
- **利点**: インターフェース記述言語（IDL）を使ってサービスとデータ型を定義できる。高速かつ軽量。
- **例**:

  ```thrift
  struct Person {
    1: string name,
    2: i32 age,
    3: bool isStudent
  }
  ```

### CBOR (Concise Binary Object Representation)

- **用途**: JSON のようなデータ構造をバイナリ形式で表現するためのフォーマット。IoT デバイスや小規模なデバイスでよく使われる。
- **利点**: コンパクトで高速、省メモリ。
- **例**:

  ```python
  import cbor2

  data = {
    "name": "Alice",
    "age": 30,
    "isStudent": False
  }
  serialized_data = cbor2.dumps(data)
  deserialized_data = cbor2.loads(serialized_data)
  ```
