# Frontend End to End Test

大きく、Open SourceによるTestフレームワークとAIを活用したSaasに分かれる

## 自動ブラウザテスト技術

### WebDriver型(Selenium, WebDriverIOなど)

- WebDriver型は、`Selenium`がその代表例
- WebDriverはWebブラウザを外部から制御するための標準インターフェースを目指してたもの
- Seleniumが独自に実装したWebDriverの他に、各ベンダが各ブラウザに対応したそれぞれのWebDriverが存在している。

- Seleniumの独自実装が元となって2018年にはW3C勧告として標準化された
- `W3CのWebDriver`はChrome Driver, geckodriverといった具体的な実装ではなく、ブラウザを自動化するための`API`と`プロトコル`を規定したもの

#### WebDriver型のメリット

- クロスブラウザ対応が容易な点

#### WebDriver型のデメリット

- 仕組み上動作に信頼性がない
- websocketを使った実装に比べて低速

#### WebDriver型のツールの動作

1. Driverに対してクライアントから自動化コマンドを送る
2. Driverが実際のブラウザ操作に変換し、ブラウザを自動操作

### Native型(Cypress, TestCafe)

- `Cypress`などのNative型は、WebDriverを使用せずに`JavaScript API`を直接利用
- テストランナー自体が実際のブラウザ内で動作しており`iframe`を通じてロードしたテスト対象のアプリケーションを直接操作することでUIのテストを行う

### CDP型(Puppeteer, PlayWright)

- `Puppeteer`や最近人気の`Playwright`がこの方式
- 開発者ツール用に作られている`Chrome DevTools Protocol`(CDP) を利用している

- WebDriver型と似ていてクライアントからのリクエストをCDPコマンドに変換してブラウザを操作
- クライアント、サーバー間はwebsocketで通信により高速で動作
- コマンドを送信すると同時にサーバーからのイベント/メッセージをリアルタイムでリッスンできる
- CDPは低レベルなAPIにもアクセスできるため、consoleのキャプチャやDOMの監視、ネットワークのinterceptなど低レベルな制御が可能

#### CDP型のデメリット

- Chromium baseのブラウザでしか動作しない
- Puppeteerは試験的にFirefoxに対応しているが、完全な互換性はない
- PlaywrightもFirefoxやsafariが動かせますが、FireFox、Safariの特定のバージョンに何かしらのパッチを当てて動かしている

### [Web Driver BiDi](https://w3c.github.io/webdriver-bidi/)

`BiDirectional WebDriver Protocol`の意味

- W3Cの`Browser Testing and Tools Working Group`にで`WebDriver BiDi`の策定が進んでいる
- WebDriver型とCDP型のいいとこどりを目指しているプロトコル
  - クロスブラウザ対応
  - W3C準拠
  - 高速
  - 低レベルな操作にも対応
  - `local end`(クライアント) と `remote end`(ユーザーエージェント) 間の双方向の通信プロトコルの定義
  - session管理
  - local-remote間のコマンド、イベント、エラー定義など

#### ツールの対応状況

- PuppeteerやwebdriverIOといったツール側での試験的にサポートも始まっている
- SeleniumなどのWebDriver型、Puppeteer、PlaywrightのようなCDP型のツールは今後このプロトコルの実装も進んでいくはず

## References

- [次世代のブラウザテスト自動化プロトコルWeb Driver BiDi](https://zenn.dev/togami2864/articles/65af759b4a34f6)
- [Browser Automation Tools Protocols - WebDriver vs CDP](https://www.neovasolutions.com/2022/05/19/browser-automation-tools-protocols-webdriver-vs-cdp/)
