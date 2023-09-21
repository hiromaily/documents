# gogo/protobuf [Deprecated]

- gogo/protobuf is deprectead. The folowing projects would be replacement.
  - [CrowdStrike/csproto](https://github.com/CrowdStrike/csproto)
- [docs](https://pkg.go.dev/github.com/gogo/protobuf/gogoproto)
- [github](https://github.com/gogo/protobuf)

## 拡張機能の使い方

- proto ファイル内で、`gogo/protobuf/gogoproto/gogo.proto` を import することで、proto 内における拡張記述が使えるようになる。

```proto
import "github.com/gogo/protobuf/gogoproto/gogo.proto";
```

## Plugin

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
