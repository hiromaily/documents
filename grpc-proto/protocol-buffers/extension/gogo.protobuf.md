# gogo/protobuf [Deprecated]

gogoprotoは、Protocol Buffers（プロトコル・バッファーズ、通称proto）を拡張するためのライブラリで、Go言語（Golang）と密接に関連している。主に効率性と開発者の生産性を向上させることを目的としている。

## 開発された背景

Go言語もプロトコルバッファー用のコード生成ツール（`protoc`）を提供しているが、Go用の標準プロトコルバッファー実装は、パフォーマンスの面で改善の余地があった。これを解決するために登場したのが`gogoprotobuf`ライブラリ。

Goのためのプロトコルバッファー実装で、Googleの標準ツールよりも高性能で高度な機能を提供していた。`gogoproto`はその中の機能で、.protoファイルのオプションを通じて追加の制御や最適化を可能にする。

## deprecatedされた理由

Googleの公式ライブラリの改善:

Googleは公式のProtobufのGo実装を継続的に改善しており、パフォーマンスや機能が向上してきた。公式のProtobufライブラリが改善されるにつれて、gogoprotobufの必要性が減少した。公式ライブラリが十分高性能かつ使いやすくなったことで、別のライブラリを使用する理由が薄れてきた。

## 主な特徴

1. **パフォーマンスの向上**:
   - プロトコルバッファーのシリアライズ・デシリアライズ処理が高速化される。

2. **柔軟なコード生成**:
   - オプションを使用して、生成されるGoコードをカスタマイズできる。例えば、文字列、マップ、カスタム型の代わりにより効率的な内蔵型を使用することができる。

3. **コードサイズの縮小**:
   - 必要のないフィールドやオプションの無効化により、生成されるコードのサイズを縮小できる。

4. **互換性の向上**:
   - Goの既存のコードベースに適応しやすいように、さまざまなフィールドタグや設定オプションが提供されている。

## 拡張機能の使用方法

`.proto`ファイルに特定のオプションを追加することで、`gogoproto`の機能を有効にできる。
具体的には、proto ファイル内で、`gogo/protobuf/gogoproto/gogo.proto` を import することで、proto 内における拡張記述が使えるようになる。

```proto
import "github.com/gogo/protobuf/gogoproto/gogo.proto";
```

### `proto`ファイルの例

```proto
syntax = "proto3";

package example;

import "github.com/gogo/protobuf/gogoproto/gogo.proto";

message MyMessage {
   option (gogoproto.marshaler_all) = true;
   option (gogoproto.sizer_all) = true;
   string id = 1 [(gogoproto.customname) = "ID"];
   // 他のフィールドやオプション
}
```

### `protoc`のコマンド

`.proto`ファイルをコンパイルするには、`protoc`コマンドを使用する。

```sh
protoc --gogofast_out=. myproto.proto
```

## Docs

- gogo/protobuf is deprectead. The folowing projects would be replacement.
  - [CrowdStrike/csproto](https://github.com/CrowdStrike/csproto)
- [docs](https://pkg.go.dev/github.com/gogo/protobuf/gogoproto)
- [github](https://github.com/gogo/protobuf)
  - [plugin](https://pkg.go.dev/github.com/gogo/protobuf/plugin)

### header option

```proto
option (gogoproto.marshaler_all) = true;
option (gogoproto.sizer_all) = true;
option (gogoproto.unmarshaler_all) = true;
option (gogoproto.goproto_getters_all) = false;
```

### filed option

```proto
message XXXXRequest {
  option (gogoproto.goproto_stringer) = false;
  option (gogoproto.equal)            = false;
  option (gogoproto.goproto_getters)  = false;

  string id = 1 [(gogoproto.casttype) = "ID"];
  bytes txID = 2 [(gogoproto.casttype) = "github.com/hiromaily/go-types/types.TxID"];
  Device device = 3 [(gogoproto.nullable) = false];
  string name = 4 [(gogoproto.moretags) = "yaml:\"name,omitempty\""];
  string url = 5 [(gogoproto.customname) = "URL"];
  google.protobuf.Timestamp time_stamp = 6
    [(gogoproto.moretags) = "yaml:\"time_stamp\"", (gogoproto.jsontag) = "time_stamp,omitempty", (gogoproto.nullable) = false];
}
```

### enum without additional prefix

```proto
enum HIROStatus {
  option (gogoproto.goproto_enum_prefix) = false;

  HIRO_STATUS_UNKNOWN = 0;
  HIRO_STATUS_OK      = 1;
  HIRO_STATUS_FAILED  = 2;
}
```

### any type

```proto
import "google/protobuf/any.proto";
message Account {
  string              address = 1;
  google.protobuf.Any pub_key = 2;
}
```
