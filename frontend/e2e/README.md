# Frontend End to End Test

初期導入時はノーコードから初めて、Playwright に移行していく流れがいいように思える。

## [Cypress](https://www.cypress.io/)

- E2E テストフレームワークで、Javascript で Test を書くことができ、無料で利用できる。
- 記述に慣れるまでは実装に時間がかかるのがデメリット。
- [github](https://github.com/cypress-io/cypress)
  - 45.6k

## [Playwright](https://playwright.dev/)

- Microsoft から relesae されている E2E テストフレームワーク(Node.js のライブラリ)
- [github](https://github.com/microsoft/playwright)
  - 58.3k

## [Autify](https://autify.com/)

- ノーコードで使用できるテスト自動化プラットフォーム
  - シナリオのレコーディングを行うことで Test を作成する
- 作成した自動化のシナリオは、テンプレート化することが可能
- 日本語対応可能

### Metamask といった Extension の機能の確認も可能か？

- メールで確認中

### References

- [Autify University: 学ぶための Docs](https://help.autify.com/docs/ja/autify-university)
- [なぜ Selenium を選ばなかったのか～ Autify と MagicPod を選びました～](https://blog.studysapuri.jp/entry/e2e-test-automation-adr)
- [Autify について調べたことのまとめ](https://zenn.dev/d0ne1s/articles/2637d20f5133e6)

### 料金

- 問い合わせが必要だが、年間 100 万ほどかかりそう？

## [mabl](https://www.mabl.com/)

- ブラウザの操作内容を記録することにより、自動テストを作成できるクラウド型のソリューション
- モバイルアプリの Test はできない

## [MagicPod](https://magicpod.com/)

- モバイルアプリテスト、ブラウザテストの両方に対応した AI テスト自動化クラウドサービス

## [Katalon](https://katalon.com/)

- 設定したテスト項目を自動で実行するシステム
- 昔からあるため、Update はあるものの、古い印象がある

## Blockchain project で Metamask などの Wallet を使う場合、どう対応するか？

- [synpress](https://github.com/Synthetixio/synpress)
