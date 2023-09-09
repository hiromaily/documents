# useContext

- `Context`の`Provider`から値を参照するための Hook
- つまり、`Context`と併用するための Hook

## Example

```tsx
import React, { useContext } from "react";

type User = {
  id: number;
  name: string;
};

// ユーザーデータを保持するContextを作成する
const UserContext = React.createContext<User | null>(null);

const GrandChild = () => {
  // useContextにContextを渡すことで、Contextから値を取得する
  const user = useContext(UserContext);

  return user !== null ? <p>Hello, {user.name}</p> : null;
};

const Child = () => {
  const now = new Date();

  return (
    <div>
      <p>Current: {now.toLocaleString()}</p>
      <GrandChild />
    </div>
  );
};

const Parent = () => {
  const user: User = {
    id: 1,
    name: "Alice",
  };
  return (
    // Contextに値を渡す
    <UserContext.Provider value={user}>
      <Child />
    </UserContext.Provider>
  );
};

export default Parent;
```
