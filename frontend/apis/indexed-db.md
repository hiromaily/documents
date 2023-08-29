# IndexedDB

- Browser 上で動作する NoSQL の一種
- ファイルや blob を含む大量の構造化データをクライアント側で保存するための低レベル API
- この API はインデックスを使用して、高パフォーマンスなデータの検索を行うことができる
- WebStorage は比較的少量のデータを保存するのに有用だが、構造化された非常に多くのデータを扱うには不十分
- Web Worker 内で IndexedDB API は利用可能
- JavaScript ベースのオブジェクト指向データベース
  - Key でインデックス付けされたオブジェクトを保存および取り出すことができる
- IndexedDB を扱う操作は非同期に実行する
- 注意点として、プライベートブラウジングモードは、大半のデータストレージに対応していない

![IndexedDB space](../../images/indexeddb-image.webp 'IndexedDB space')

## 利用可能な容量について

- Browser の実装に依存する
- Chrome の場合、Disk スペースの 80%まで利用可能
- Firefox の場合、origin 毎に 2GB
- Safari の場合、origin 毎に 1GB

## DB のバージョンについて

## 発生するイベント

### [IDBRequest](https://developer.mozilla.org/en-US/docs/Web/API/IDBRequest) object

- [IDBVersionChangeEvent](https://developer.mozilla.org/ja/docs/Web/API/IDBVersionChangeEvent)
  - `onupgradeneeded` イベントハンドラー関数の結果として、データベースのバージョンが変更されたことを表す
- [IDBOpenDBRequest: upgradeneeded event](https://developer.mozilla.org/en-US/docs/Web/API/IDBOpenDBRequest/upgradeneeded_event)

  - `upgradeneeded`` イベントは、現在のバージョンより高いバージョン番号でデータベースを開こうとしたときに fire される

#### コード例

- `success`: This event is fired when an asynchronous request succeeds.

```js
request.onsuccess = (event) => {
  console.log('Request succeeded', event);
};
```

- error: This event is fired when an asynchronous request encounters an error.

```js
request.onerror = (event) => {
  console.error('Request error', event);
};
```

- `upgradeneeded``: This event is fired when the version of the database is being upgraded (e.g., when creating or modifying object stores).

```js
request.onupgradeneeded = (event) => {
  const db = (event.target as IDBOpenDBRequest).result;
  // Perform database schema changes here
};
```

- `blocked`: This event is fired when a request to open a database is blocked by other open connections.

```js
request.onblocked = (event) => {
  console.log('Request blocked', event);
};
```

### [IDBTransaction](https://developer.mozilla.org/en-US/docs/Web/API/IDBTransaction) object

#### コード例

- `complete``: This event is fired when a transaction is completed

```js
transaction.oncomplete = (event) => {
  console.log('Transaction completed', event);
};
```

- `success`: This event is fired when a transaction successfully completes.

```js
transaction.onsuccess = (event) => {
  console.log('Transaction completed', event);
};
```

- `error`: This event is fired when a transaction encounters an error.

```js
transaction.onerror = (event) => {
  console.error('Transaction error', event);
};
```

### WIP: どの Operation (Add/Update/Delete)によって Event が発生したか？

## Example Code

```ts
class MyIndexedDB {
  private dbName: string = 'MyDatabase';
  private storeName: string = 'MyStore';
  private db: IDBDatabase | null = null;

  constructor() {
    this.initDatabase();
  }

  // Initialize Database
  private async initDatabase() {
    // returns IDBRequest object
    const request = indexedDB.open(this.dbName, 1);

    request.onupgradeneeded = (event) => {
      const db = (event.target as IDBOpenDBRequest).result;
      db.createObjectStore(this.storeName, {
        keyPath: 'id',
        autoIncrement: true,
      });
    };

    request.onsuccess = (event) => {
      this.db = (event.target as IDBOpenDBRequest).result;
    };

    request.onerror = (event) => {
      console.error(
        'Error opening IndexedDB',
        (event.target as IDBOpenDBRequest).error
      );
    };
  }

  // Add item
  public async addItem(item: any) {
    if (!this.db) {
      console.error('Database not initialized.');
      return;
    }

    const transaction = this.db.transaction([this.storeName], 'readwrite');
    const store = transaction.objectStore(this.storeName);

    const request = store.add(item);

    request.onsuccess = () => {
      console.log('Item added to IndexedDB');
    };

    request.onerror = (event) => {
      console.error('Error adding item to IndexedDB', event);
    };
  }

  // Get all items
  public async getAllItems(): Promise<any[]> {
    return new Promise((resolve, reject) => {
      if (!this.db) {
        reject('Database not initialized.');
      }

      const transaction = this.db.transaction([this.storeName], 'readonly');
      const store = transaction.objectStore(this.storeName);

      const request = store.getAll();

      request.onsuccess = () => {
        resolve(request.result);
      };

      request.onerror = (event) => {
        reject('Error getting items from IndexedDB');
      };
    });
  }
}

// Usage
const dbExample = new MyIndexedDB();

dbExample.addItem({ name: 'John Doe', age: 30 });
dbExample.addItem({ name: 'Jane Smith', age: 25 });

dbExample
  .getAllItems()
  .then((items) => {
    console.log('All items:', items);
  })
  .catch((error) => {
    console.error(error);
  });
```

## Library

### [Dexie.js](https://dexie.org/)

- [github](https://github.com/dexie/Dexie.js)
- A Minimalistic Wrapper for IndexedDB
- Star: 9.6k

### [idb](https://github.com/jakearchibald/idb)

- IndexedDB tiny library
- Star: 5.5k

### [localForage](https://github.com/localForage/localForage)

- IndexedDB や WebSQL, Web Storage のためのライブラリ
  - [setDriver()](https://github.com/localForage/localForage/blob/master/docs/api.md#setdriver)により、Storage を変更できる
- 22.7k

### [JsStore](https://jsstore.net/)

- A complete IndexedDB wrapper with SQL like syntax.
- [github](https://github.com/ujjwalguptaofficial/JsStore)
- Star: 774

## References

- [IndexedDB API](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API)
- [IndexedDB key characteristics and basic terminology](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API/Basic_Terminology)
- [CanIUse](https://caniuse.com/?search=indexeddb)
