# grpc-web

browser のための、gRPC の Javascript 実装で、特別な proxy を経由して gRPC service に接続する。
gRPC-web は[Envoy](https://www.envoyproxy.io/)を使っている。

## References

- [grpc/grpc-web](https://github.com/grpc/grpc-web)
- [Docs](https://grpc.io/docs/platforms/web/)

## [Envoy](https://www.envoyproxy.io/)

分散アーキテクチャーのための、Open-Source の cloud-native の high パフォーマンスの edge/proxy サービスで、拡張性が高く以下の機能を持つ

- Load balancing
- Traffic management
- Observability and Security

## 構成例: [参考](https://grpc.io/docs/platforms/web/quickstart/)

[compose file](https://github.com/grpc/grpc-web/blob/b1297e616ae7a20c4ffa227cb5d7eee1d911cfbf/docker-compose.yml)は以下の container によって構成されている

- [prereqs](https://github.com/grpc/grpc-web/blob/b1297e616ae7a20c4ffa227cb5d7eee1d911cfbf/net/grpc/gateway/docker/prereqs/Dockerfile)
- [node-server](https://github.com/grpc/grpc-web/blob/b1297e616ae7a20c4ffa227cb5d7eee1d911cfbf/net/grpc/gateway/docker/node_server/Dockerfile)
  - gRPC Server
- [envoy](https://github.com/grpc/grpc-web/blob/b1297e616ae7a20c4ffa227cb5d7eee1d911cfbf/net/grpc/gateway/docker/envoy/Dockerfile)
  - Envoy proxy で、browser の gRPC-Web リクエストを gRPC サーバーにフォワードする
- [commonjs-client](https://github.com/grpc/grpc-web/blob/b1297e616ae7a20c4ffa227cb5d7eee1d911cfbf/net/grpc/gateway/docker/commonjs_client/Dockerfile)
  - python の SimpleHTTPServer が立ち上がる
  - ここで host される[HTML](https://github.com/grpc/grpc-web/blob/b1297e616ae7a20c4ffa227cb5d7eee1d911cfbf/net/grpc/gateway/examples/echo/commonjs-example/echotest.html)
  - gRPC-web リクエストを Envoy Proxy に送信する

## 開発手順

1. proto にてサービスを定義する
2. proto compiler にて client code を生成する
3. gRPC-Web API を使用して Client のコードを作成する
4. Envoy Proxy の設定
