# grpc-gateway で RESTful API を実装する

- [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway)
- [Docs](https://grpc-ecosystem.github.io/grpc-gateway/)

```proto
import "google/api/annotations.proto";
service Query {
  rpc TxState(QueryTxStateRequest) returns (QueryTxStateResponse) {
    option (google.api.http).get = "/v1/tx/state";
  }
}
```
