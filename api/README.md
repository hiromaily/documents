# API

## 参考
- [REST API設計のパターンと原則](https://note.com/skijima/n/n8c3b18f93c80)
- [API Testing Tools & Approaches to know in 2022](https://aglowiditsolutions.com/blog/api-testing-tools/)

## 設計ガイドライン
- [Microsoft REST API Guidelines](https://github.com/microsoft/api-guidelines)
- [Google API design guide](https://cloud.google.com/apis/design)
- [Salesforce APIs](https://developer.salesforce.com/docs/apis)


## Rest APIのTestについて
### 種類
- 機能テスト
  - Positive/Negative Testing
- Integrationテスト
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
- [API testing toolについて調べてみる](https://zenn.dev/katzumi/scraps/4fe5976c0753d5)

### 個人的なニーズは以下
- OpenAPIと連携しているTestツールがあるが、そもそもOpenAPIのデザインが想定と違っているケースも存在するため、Testシナリオは必ずしもOpenAPIに準拠しなくてもよい
- Open sourceで、簡単にInstallできるもの。Node, Python, Java製は避けたい
- ぶっちゃけ、httpie,jqを使ってShell ScriptでTest書くのが最強な気がする。
  - [Httpie Command-line API testing tricks](https://httpie.io/blog/cli-api-tricks)

### Tools
- [zoncoen/scenarigo](https://github.com/zoncoen/scenarigo)
  - Star: 177
  - Golang
  - 頻繁に更新されている
  - YAMLにシナリオを書いて実行できる
  - メルカリでも利用しているらしい
  - [scenarigoでE2Eを実装](https://www.wheatandcat.me/entry/2021/10/31/121549)
- [k1LoW/runn](https://github.com/k1LoW/runn)
  - Star: 89
  - Golang
  - 頻繁に更新されている
  - YAMLにシナリオを書いて実行できる
- [keploy](https://github.com/keploy/keploy)
  - Testing for Developers. Toolkit that creates test-cases and data mocks from API calls, DB queries, etc.
  - Star: 1.1k
  - Golang
  - 頻繁に更新されている
- [taverntesting/tavern](https://github.com/taverntesting/tavern)
  - A command-line tool and Python library and Pytest plugin for automated testing of RESTful APIs, with a simple, concise and flexible YAML-based syntax
  - Star: 898
  - Python
  - 頻繁に更新されている
  - YAMLにシナリオを書いて実行できる
- [restcli/restcli](https://github.com/restcli/restcli)
  - Star: 249
  - Kotlin
  - 2021/12でReleaseが止まっている
  - JetBrain依存か？

### Not Free??
- [Postman + Newman](https://learning.postman.com/docs/running-collections/using-newman-cli/command-line-integration-with-newman/)
  - [PostmanとNewmanを組み合わせて、CI/CDに組み込むREST APIの自動テストを作ろう！](https://qiita.com/developer-kikikaikai/items/74cedc67643ca93d2e0b)
- [Katalon](https://katalon.com/)
- [TestGrid](https://www.testgrid.io/)