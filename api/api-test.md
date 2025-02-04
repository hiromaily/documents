# API Test

[Test: 内部Docs](../test/README.md)

## 種類

- 機能テスト
  - Positive/Negative Testing
- Integration テスト
  - Reliability Testing
  - Integration Testing
- パフォーマンステスト
  - Soak Testing
  - Load Testing
  - Peak Testing
  - Scalability Testing
  - Spike Testing
  - Stress Testing
- セキュリティーテスト
  - Authentication Testing
  - Fuzz Testing
  - Penetration Testing

## API Tools for CI

- [API testing tool について調べてみる](https://zenn.dev/katzumi/scraps/4fe5976c0753d5)

## 個人的なニーズは以下

- OpenAPI と連携している Test ツールがあるが、そもそも OpenAPI のデザインが想定と違っているケースも存在するため、Test シナリオは必ずしも OpenAPI に準拠しなくてもよい
- Open source で、簡単に Install できるもの。Node, Python, Java 製は避けたい

### Tools

- [Hurl](https://hurl.dev/)
  - [Github](https://github.com/Orange-OpenSource/hurl)
  - Star: 12.5k
  - Rust
  - Docs も充実していて本命感がある
- [keploy](https://github.com/keploy/keploy)
  - Testing for Developers. Toolkit that creates test-cases and data mocks from API calls, DB queries, etc.
  - Star: 1.1k
  - Golang
  - 頻繁に更新されている
- [SuperTest](https://github.com/ladjs/supertest)
  - Super-agent driven library for testing node.js HTTP servers
  - Star: 13.8k
  - Javascript
- [ATAC](https://github.com/Julien-cpsn/ATAC)
  - シンプルなPostmanのようなHTTP Client
  - Star: 2.4k
  - Rust
- [httpie](https://github.com/httpie/cli)
  - HTTP client
- [asciinema](https://github.com/asciinema/asciinema)
  - Terminal上で利用するセッションレコーダー

### 有償??

- [Postman + Newman](https://learning.postman.com/docs/running-collections/using-newman-cli/command-line-integration-with-newman/)
  - [Postman と Newman を組み合わせて、CI/CD に組み込む REST API の自動テストを作ろう！](https://qiita.com/developer-kikikaikai/items/74cedc67643ca93d2e0b)
  - [Postman Newman とは、その使い方を解説](https://apidog.com/jp/blog/how-to-use-postman-newman/)
- [Katalon](https://katalon.com/)
- [TestGrid](https://www.testgrid.io/)
