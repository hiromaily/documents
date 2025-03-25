# Open Source E2E テスト Framework

## [Cypress](https://www.cypress.io/)

- E2E テストフレームワークで、Javascript で Test を書くことができ、無料で利用できる。
- 記述に慣れるまでは実装に時間がかかるのがデメリット。
- [github](https://github.com/cypress-io/cypress)
  - 45.6k

## [Playwright](https://playwright.dev/)

- Microsoft から relesae されている E2E テストフレームワーク(Node.js のライブラリ)
- [github](https://github.com/microsoft/playwright)
  - 58.3k
- [mcp-playwright](https://github.com/executeautomation/mcp-playwright)
  - AIによるTestが可能となるか？

### Blockchain project で Metamask などの Wallet を使う場合、どう対応するか？

- [Synpress](https://github.com/Synthetixio/synpress)
  - [Test e2e login to dApp with Metamask with Synpress](https://medium.com/coinmonks/test-e2e-login-to-dapp-with-metamask-with-synpress-5248dd1f17c1)
  - Cypress もしくは、Playwright 上で動く

### Cypress から Playwright へのリプレイスした例

- [Zenn の E2E テスト基盤をリプレイスしました（開発体験向上、CI 時間の短縮、Playwright 移行）](https://zenn.dev/team_zenn/articles/zenn-e2e-replace-to-playwright)
  - 手元で特定のテストケースをデバッグすることが容易になった
  - CI の実行時間が早くなった (並列数によるもの)
- [Cypress から Playwright に移行しました](https://developers.prtimes.jp/2023/04/10/migrate-from-cypress-to-playwright/)

## [shortest](https://github.com/anti-work/shortest)

Shortestは生成AIとE2EテストフレームワークのPlaywrightを組み合わせ、自然言語でE2Eテストを実施できるフレームワーク
