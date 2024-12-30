# google/protobuf

Google の GitHub リポジトリである [google/protobuf](https://github.com/protocolbuffers/protobuf) には、Protocol Buffers の`公式実装`が含まれている。このリポジトリには多くのファイルとディレクトリがあり、それぞれが異なる目的を持っている。

[github: source](https://github.com/protocolbuffers/protobuf/tree/main/src/google/protobuf)

## `google/protobuf`リポジトリ内で広く利用されている主要なディレクトリ

1. **src/google/protobuf/**:

   - Protocol Buffers の主要なソースコードが含まれている。このディレクトリには、Message 型や Enum 型、各種ユーティリティ関数が定義されている。
   - `descriptor.proto`: Protocol Buffers のスキーマをシリアライズするのに使用されるメタデータ定義ファイル。このファイルは、他の Protocol Buffers の定義ファイルを記述するためにしばしば使用される。

2. **src/google/protobuf/compiler/**:

   - コンパイラ関連のコードが含まれている。`protoc`コマンドラインツールの実装部分がここにある。

3. **src/google/protobuf/util/**:
   - Protocol Buffers のユーティリティ関数が含まれている。例えば、JSON との相互変換を行うための関数がここにある。
   - `json_util.h`, `json_util.cc`: Protocol Buffers メッセージを JSON 形式に変換したり、その逆を行ったりするための関数が定義されている。

## `google/protobuf`リポジトリ内で広く利用されている主要なファイル

1. **src/google/protobuf/any.proto**:

   - 任意のメッセージ型を含むことができる`Any`型の定義。任意のメッセージを動的に格納するために使用される。

2. **src/google/protobuf/struct.proto**:

   - JSON オブジェクトを Protocol Buffers メッセージとして表現するための定義。動的 JSON コンテンツを格納する場合に使用する。

3. **src/google/protobuf/timestamp.proto**:

   - `Timestamp`メッセージ型の定義で、一般的な日時情報を格納するために使用される。

4. **src/google/protobuf/duration.proto**:

   - `Duration`メッセージ型の定義で、経過時間を格納するために使用される。

5. **src/google/protobuf/wrappers.proto**:
   - プリミティブ型をラッピングするための各種メッセージ型の定義。これにより、プリミティブ型をオプションとして扱うことができる。
