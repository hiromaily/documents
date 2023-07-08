# Jest

## Jest with Typescript

```
npm install --save-dev jest @types/jest ts-jest
npm install --save-dev jest-environment-jsdom
npm install --save-dev eslint-plugin-jest eslint-plugin-jest-dom
```

## 設定 jest.config.js

[Configuring Jest](https://jestjs.io/docs/configuration)

### [testEnvironment](https://jestjs.io/docs/configuration#testenvironment-string)

- テストが実行されるテスト環境を指定するために使用される
- テスト環境は、テストが実行されるランタイム環境を決定し、テストに必要な API や Global Object を提供する
- 設定の種類
  - node
    - default 設定になる。この環境は、ブラウザ固有の API を使用しないで Node.js 環境でテストを実行する。DOM や他のブラウザ関連の機能に依存しないコードのテストに便利。
  - jsdom
    - これはシミュレートされたブラウザ環境を提供し、DOM といったブラウザの API と対話するテストを実行することができる。
  - jest-environment-jsdom
    - これは`jsdom`環境に似ているが、より制御とカスタマイズのオプションが提供される。仮想 DOM のカスタマイズや特定の API の動作の変更など、さまざまな機能を設定することができる。
  - jest-environment-node
    - これは`node`環境に似ているが、Jest 固有の機能も提供される。Node.js 固有の API や Jest が提供する機能を使用するコードのテストに便利。
- ファイルの先頭に`@jest-environment docblock` を追加することで、そのファイル内のすべてのテストで使用する別の環境を指定することができる

```js
/**
 * @jest-environment jsdom
 */

test('use jsdom in this test file', () => {
  const element = document.createElement('div');
  expect(element).not.toBeNull();
});
```

## メソッド

- toBe(value) ... プリミティブ値を比較する
- toEqual(value) ... オブジェクトや配列を比較する
