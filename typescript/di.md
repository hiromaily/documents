# Dependency Injection (DI)

## React内におけるパターン
### `Props`を使う
  - これは環境に合わせて、異なる`TodoService`を挿入することを想定している
```tsx
import React, { useState, useEffect } from 'react';

function TodoList({ todoService }) {
  const [todos, setTodos] = useState([]);

  useEffect(() => {
    async function fetchTodos() {
      try {
        const todos = await todoService.getTodos(); // Call injected TodoService to get todos
        setTodos(todos);
      } catch (error) {
        console.error(error);
      }
    }
    fetchTodos();
  }, [todoService]);

  return (
    <ul>
      {todos.map(todo => (
        <li key={todo.id}>{todo.title}</li>
      ))}
    </ul>
  );
}

export default TodoList;
```

```tsx
import React from 'react';
import TodoService from './TodoService';
import TodoList from './TodoList';

function App() {
  return <TodoList todoService={TodoService} />;
}

export default App;
```

### `Context API`を使う
```tsx
import React, { useState, useEffect, useContext } from 'react';
import TodoContext from './TodoContext';

function TodoList() {
  const [todos, setTodos] = useState([]);
  const todoService = useContext(TodoContext); // Retrieve TodoService from TodoContext
  useEffect(() => {
    async function fetchTodos() {
      try {
        const todos = await todoService.getTodos(); // Call TodoService from TodoContext to get todos
        setTodos(todos);
      } catch (error) {
        console.error(error);
      }
    }
    fetchTodos();
  }, [todoService]);  return (
    <ul>
      {todos.map(todo => (
        <li key={todo.id}>{todo.title}</li>
      ))}
    </ul>
  );
}
export default TodoList;
```

```tsx
import React from 'react';
import TodoContext from './TodoContext';
import TodoService from './TodoService';
import TodoList from './TodoList';

function App() {
  return (
    <TodoContext.Provider value={TodoService}>
      <TodoList />
    </TodoContext.Provider>
  );
}

export default App;
```


- Reactの場合、Propsを使うパターンより、`Context API`を使ってDIを利用するのがよさそう
- DIによりサービスを初期化するタイミングは、App functionが定義してある、`_app.tsx`などがよさそう
