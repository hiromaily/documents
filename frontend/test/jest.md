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

## 並列処理
- Jestではデフォルトでテストを実行するとファイルは`並列実行`、ファイル内のテストケースは`逐次実行`される
- 並行処理の上限数は、自動的に実行環境（マシン）のコア数が設定される
- ファイルも含めて全て逐次実行したい場合は、`jest --runInBand` のように実行する 

## Expect Mather メソッド
- toBe(value) ... プリミティブ値を比較する
- toEqual(value) ... オブジェクトや配列を比較する
- not `expect(a).not.toBe(b)`
  - 同じ値ではないことを期待
- toBeNull() `expect(a).not.toBeNull()`
  - null値であることを期待
- toBeUndefined() `expect(a).toBeUndefined()`
  - `undefined`になることを期待
- toBeDefined() `expect().not.toBeDefined()`
  - `undefined`にならないことを期待
- toBeTruthy() `expect(true).toBeTruthy()`
  - `true`になることを期待
- toBeFalsy() `expect(false).toBeFalsy()`
  - `false`になることを期待
- toBeGreaterThan(number) `expect(a).toBeGreaterThan(b)`
  - numberより大きくなることを期待
- toBeGreaterThanOrEqual(number) `expect(a).toBeGreaterThanOrEqual(b)`
  - number以上になることを期待
- toBeLessThan(number) `expect(a).toBeLessThan(b)`
  - numberより小さくなることを期待
- toBeLessThanOrEqual(number) `expect(a).toBeLessThanOrEqual(b)`
  - number以下になることを期待
- toMatch() `expect('Exxxxxpect').toMatch(/xxxx/)`
  - 文字列に対して正規表現でマッチすることを期待
- toContain(item) `expect(arrayData).toContain('item')`
  - 配列やオブジェクトの中にitemが含まれていることを期待
- toThrow() `expect(() => targetFunction()).toThrow()`
  - 例外が発生することを期待
