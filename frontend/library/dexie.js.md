# Dexie.js

IndexedDB のための Wrapper

## [Table.add()](<https://dexie.org/docs/Table/Table.add()>)と[Table.put()](<https://dexie.org/docs/Table/Table.put()>)の違い

- 既に該当 key が存在している状態で同一 key で add()を実行するとエラーが発生する
- 既に該当 key が存在している状態で同一 key で put()を実行すると、新しい value で該当 key の value が置き換えられる

## 複数の条件文

```js
return db.store1
  .where('clientStatus')
  .equals(1)
  .and((record) => record.isDeleted === false)
  .toArray();
```

## [liveQuery()](<https://dexie.org/docs/liveQuery()>)と[useLiveQuery()](<https://dexie.org/docs/dexie-react-hooks/useLiveQuery()>)

- Dexie に問い合わせる Promise を返す関数を`Observable`に変えることができ、監視することが可能
- React の場合は Component 内で、[useLiveQuery()](<https://dexie.org/docs/dexie-react-hooks/useLiveQuery()>)を使う場合ができる
- Dexie のバージョンが`3.2`以上であれば、[Dexie.Observable](https://dexie.org/docs/Observable/Dexie.Observable)は不要

### 挙動

- 該当の Store の値が変更され、指定したクエリーの結果が変更されるたびに、クエリーの Callback が再実行され、observable は新しい結果を出力する
- クエリされるすべてのインデックスは、クエリされる指定された範囲で追跡される
  - これにより、追加されたオブジェクトがその範囲に収まるかどうか、また、インデックスされたプロパティの更新によってそのオブジェクトが含まれるかどうかを検出することができる
- 書き込みトランザクションが正常にコミットされるたびに、変更された部分（キーと範囲）は、範囲ツリー構造を使用して、アクティブな LiveQuery と照合される
  - 追加
  - 更新
  - 削除

### この機能の制約

- Dexie 以外の非同期 API を直接呼び出さないこと

### 記述例

```ts
import { db } from './db';

// Case 1 > ageが50-75までの間のレコードに変化があった場合、通知される
const txHistoriesObservable = liveQuery(() =>
  db.txHistories.where('age').between(50, 75).toArray()
);

// Case 2 > 以下条件に合致するレコードに変化があった場合、通知される
// - この条件のInsertが走っても検知されるはず
const txHistoriesObservable = liveQuery(() =>
  db.txHistories
    .where("clientStatus")
    .equals(TxClientStatusType.PENDING)
    .and((record) => record.isTimeout === false)
    .toArray();
);

// Subscribe
// おそらく、Observerのselectの結果が返ってくる
const subscription = friendsObservable.subscribe({
  next: (result) => console.log('Got result:', JSON.stringify(result)),
  error: (error) => console.error(error),
});

// Unsubscribe
subscription.unsubscribe();
```

### React による Example

```tsx
import * as React from 'react';
import { useLiveQuery } from 'dexie-react-hooks';
import { TodoList } from '../models/TodoList';
import { db } from '../models/db';
import { TodoItemView } from './TodoItemView';
import { AddTodoItem } from './AddTodoItem';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTrashAlt } from '@fortawesome/free-solid-svg-icons';

interface Props {
  todoList: TodoList;
}

export function TodoListView({ todoList }: Props) {
  const items = useLiveQuery(
    () => db.todoItems.where({ todoListId: todoList.id }).toArray(),
    [todoList.id]
  );

  if (!items) return null;

  return (
    <div className="box">
      <div className="grid-row">
        <h2>{todoList.title}</h2>
        <div className="todo-list-trash">
          <a onClick={() => db.deleteList(todoList.id)} title="Delete list">
            <FontAwesomeIcon icon={faTrashAlt} />
          </a>
        </div>
      </div>
      <div>
        {items.map((item) => (
          <TodoItemView key={item.id} item={item} />
        ))}
      </div>
      <div>
        <AddTodoItem todoList={todoList} />
      </div>
    </div>
  );
}
```

## References

- [Official](https://dexie.org/)
- [github](https://github.com/dexie/Dexie.js)
