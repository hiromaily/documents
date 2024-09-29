# JSDoc

## 書き方

- function

```js
/**
 * Helloを付与する関数
 * @param {string} message メッセージ
 * @return {string} 加工された文字列
 */
function sayHello(message) {
  return `Hello ${message}`;
}
s;
```

- deprecated

```js
/**
 * @deprecated
 */
```

- see

```js
/**
 * @see https://ics.media/entry/6789/
 */
```

## JSDoc のメリット

- コードヒント/コード補完の表示
- API リファレンスの生成

## References

- [jsdoc.app](https://jsdoc.app/)
- [jsdoc: getting started](https://jsdoc.app/about-getting-started.html)
- [JSDoc リファレンス](https://www.typescriptlang.org/ja/docs/handbook/jsdoc-supported-types.html)
