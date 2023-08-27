# Web Storage

ブラウザーがキーと値のペアを保存できる仕組み

## SessionStorage

1. ページのセッション中 (ページの再読み込みや復元を含む、ブラウザーを開いている間) に使用可能な、オリジンごとに区切られた保存領域を管理
2. セッションデータのみを保存。つまり、データはブラウザー（またはタブ）が閉じられるまで有効
3. データがサーバーに転送されることはない
4. system memory によって制約を受ける

## LocalStorage

1. SessionStorage の`1`と同様
2. ブラウザーを閉じたり再び開いたりしてもデータは保持される
3. 有効期限なしでデータを保存し、JavaScript によるクリア、もしくは、ブラウザーキャッシュ/ローカルに保存したデータのクリアによってのみクリアされる
4. ストレージの上限が Cookie よりも大きく、最大 `5MB`

## 利用方法

- これらの仕組みは `Window.sessionStorage` および `Window.localStorage` プロパティ を通して使用できる
- いずれかのプロパティを使用すると `Storage オブジェクト`のインスタンスを生成して、データアイテムの保存、取り出し、削除ができる
- 同じオリジンに対して sessionStorage と localStorage は、別の Storage オブジェクトを使用する

```js
// set
localStorage.setItem("name", "Chris");

// get
let myName = localStorage.getItem("name");
console.log(myName);
// >> Chris

// remove
localStorage.removeItem("name");
```

## StorageEvent

- 保存領域が変更されたときにドキュメントの Window オブジェクトで発生する

## 保存可能なデータ

- Strings
- Numbers
- Booleans
- JSON objects (since they are essentially strings)
- Other serializable data formats

### Example of serializable data formats

- Store data

```js
const dataObject = {
  name: "John",
  age: 30,
  hobbies: ["reading", "swimming", "cooking"],
};

// Serialize the object to JSON
const serializedData = JSON.stringify(dataObject);

// Store the serialized data in localStorage
localStorage.setItem("dataKey", serializedData);
```

- Retrieve data

```js
// Retrieve the serialized data from localStorage
const storedData = localStorage.getItem("dataKey");

if (storedData) {
  // Deserialize the data from JSON
  const deserializedData = JSON.parse(storedData);

  // Now you can use the deserialized data as needed
  console.log(deserializedData.name);
  console.log(deserializedData.age);
  console.log(deserializedData.hobbies);
}
```

## 保存する item に期限を設ける場合

- store

```js
const dataObject = {
  name: "John",
  age: 30,
  hobbies: ["reading", "swimming", "cooking"],
  // Set expiration time, e.g., 1 hour from now
  expiration: Date.now() + 3600 * 1000, // 1 hour in milliseconds
};

// Serialize the object to JSON
const serializedData = JSON.stringify(dataObject);

// Store the serialized data in localStorage
localStorage.setItem("dataKey", serializedData);
```

- retrieve

```js
// Retrieve the serialized data from localStorage
const storedData = localStorage.getItem("dataKey");

if (storedData) {
  const parsedData = JSON.parse(storedData);

  // Check if the data has expired
  if (parsedData.expiration && Date.now() > parsedData.expiration) {
    // Data has expired, remove it from storage
    localStorage.removeItem("dataKey");
  } else {
    // Data is still valid, use it
    console.log(parsedData.name);
    console.log(parsedData.age);
    console.log(parsedData.hobbies);
  }
}
```

## Third party libraries

- [store.js](https://github.com/jaywcjlove/store.js)
  - v2.0.5 is released May 2023
  - Star: 409
- [store.js](https://github.com/marcuswestin/store.js)
  - This is not updated since 2017
  - Star: 13.9K

## References

- [Web Storage API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Storage_API)
- [HTML5 Storage](https://www.gwtproject.org/doc/latest/DevGuideHtml5Storage.html)
- [Client-side storage](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Client-side_web_APIs/Client-side_storage)
