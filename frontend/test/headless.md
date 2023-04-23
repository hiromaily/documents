# Headless Testing

CLIを使ってユーザーのアクションfunctions(click, hoverなど)を実行することで行うE2Eテストは、`Headless Testing`と呼ばれ、大きなメリットはE2Eの実行時間の削減にある。

## Frameworks with Headless Browser
### Puppeteer
Puppeteer is a `Node.js` library that provides a high-level API for controlling `headless Chrome` or `Chromium browsers`. With Puppeteer, you can automate user actions like clicking, typing, scrolling, and navigating. You can also take screenshots, generate PDFs, and interact with web sockets.

### Playwright
Playwright is a `Node.js` library that provides a multi-browser automation API for `Chromium`, `Firefox`, and `WebKit browsers`. Like Puppeteer, Playwright allows you to automate user actions, take screenshots, and generate PDFs. Playwright also supports a wide range of mobile devices, including iPhones, iPads, and Android devices.

### Cypress
Cypress is a `JavaScript-based` end-to-end testing framework that runs in the browser. Cypress allows you to write tests in a familiar way using Mocha and Chai, and provides a powerful API for simulating user actions, making assertions, and interacting with the DOM. Cypress also has built-in time-travel debugging and a dashboard for recording test results.

## Frameworks with Remote Driver
これはRemote環境のリアルなブラウザを使ってTestを実行するアプローチ


### Selenium WebDriver
Selenium WebDriver is a popular `E2E testing tool` that allows you to automate browser actions across multiple browsers, including Chrome, Firefox, Safari, and Edge. Selenium WebDriver provides a powerful API for simulating user actions and interacting with the DOM. You can also use Selenium Grid to run tests in parallel across multiple remote machines.

### BrowserStack
BrowserStack is a `cloud-based testing platform` that allows you to run E2E tests on a wide range of real browsers and mobile devices. With BrowserStack, you can perform automated testing, manual testing, and visual testing, and integrate your tests with your CI/CD pipeline. BrowserStack also provides a free plan for open source projects.

### Sauce Labs
Sauce Labs is another `cloud-based testing platform` that allows you to run E2E tests on real browsers and devices. With Sauce Labs, you can run tests in parallel, perform manual testing, and integrate with your CI/CD pipeline. Sauce Labs also provides a free plan for open source projects.

## Frameworks without Browser
`jsdom` を使った DOM-based E2E testingとなる

### TestCafé
TestCafé is a `Node.js` testing framework that allows you to write E2E tests using JavaScript or TypeScript. TestCafé provides a powerful API for simulating user interactions, making assertions, and working with the DOM. TestCafé can also run tests in multiple browsers, including Chrome, Firefox, and Safari.

### Cypress (DOM Testing)
Cypress also provides a DOM-based testing approach that simulates user interactions at the DOM level, without requiring a browser. With Cypress, you can write tests using JavaScript or TypeScript and use a powerful API for interacting with the DOM. Cypress also provides features like time-travel debugging, automatic retries, and built-in screenshots and videos.

### Jest (jsdom environment)
Jest is a popular JavaScript testing framework that supports the use of jsdom as a test environment. With Jest, you can write E2E tests using JavaScript or TypeScript and simulate user interactions at the DOM level. Jest also provides features like snapshot testing, code coverage reporting, and parallel test execution.
