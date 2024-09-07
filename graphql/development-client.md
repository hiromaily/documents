# GraphQL Client

## Library

- [Apollo Client](https://www.apollographql.com/docs/)
- [Apollo Client for React](https://www.apollographql.com/docs/react/)
- [graphql-js](https://github.com/graphql/graphql-js)
- [Prisma with GraphQL](https://www.prisma.io/docs/orm/overview/prisma-in-your-stack/graphql)
- [Relay](https://relay.dev/)
- [svelte-apollo](https://github.com/timhall/svelte-apollo)

## [Apollo Client](https://www.apollographql.com/docs/)を使ったFrontend側の開発例

1. **Apollo Clientの設定**: Apollo Clientを設定し、Reactアプリケーション全体をApolloProviderでラップ。
2. **クエリを作成・実行**: GraphQLクエリを定義し、useQueryフックを使ってデータを取得。
3. **ミューテーションを作成・実行**: GraphQLミューテーションを定義し、useMutationフックを使ってデータを操作。

### 1. Apollo Clientと関連するパッケージをインストール

```sh
npm install @apollo/client graphql
```

### 2. Apollo Clientの設定

`src`ディレクトリに`apolloClient.ts`というファイルを作成し、Apollo Clientの設定を行う。

```ts
// src/apolloClient.ts
import { ApolloClient, InMemoryCache } from '@apollo/client';

const client = new ApolloClient({
  uri: 'http://localhost:4000/graphql', // GraphQLサーバーのエンドポイントを指定
  cache: new InMemoryCache()
});

export default client;
```

### 3. ApolloProviderでラップ

`src/index.tsx`ファイルを編集して、ApolloProviderでアプリ全体をラップする。

```ts
// src/index.tsx
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import { ApolloProvider } from '@apollo/client';
import client from './apolloClient'; // 先ほど作成したApollo Client設定ファイルをインポート

ReactDOM.render(
  <ApolloProvider client={client}>
    <React.StrictMode>
      <App />
    </React.StrictMode>
  </ApolloProvider>,
  document.getElementById('root')
);
```

### 4. クエリを作成

フロントエンドで使用するGraphQLクエリを定義する。例えば、ユーザーリストを取得するクエリを作成する。

```ts
// src/queries.ts
import { gql } from '@apollo/client';

export const GET_USERS = gql`
  query GetUsers {
    users {
      id
      name
      email
    }
  }
`;
```

### 5. クエリを使ってデータを取得

クエリを実行してデータを取得するコンポーネントを作成する。Reactのフックを使用してシンプルに実装する。TypeScriptの型も追加する。

```ts
// src/App.tsx
import React from 'react';
import { useQuery } from '@apollo/client';
import { GET_USERS } from './queries';

interface User {
  id: string;
  name: string;
  email: string;
}

const App: React.FC = () => {
  const { loading, error, data } = useQuery<{ users: User[] }>(GET_USERS);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;

  return (
    <div>
      <h1>Users</h1>
      <ul>
        {data?.users.map(user => (
          <li key={user.id}>
            {user.name} - {user.email}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default App;
```

### 6. ミューテーションを使ってデータを操作

例えば、ユーザーを追加するためのミューテーションを定義し、それを呼び出すコンポーネントを作成する。

#### ミューテーションの定義

```ts
// src/mutations.ts
import { gql } from '@apollo/client';

export const ADD_USER = gql`
  mutation AddUser($name: String!, $email: String!, $age: Int) {
    addUser(name: $name, email: $email, age: $age) {
      id
      name
      email
      age
    }
  }
`;
```

#### ミューテーションを使用するコンポーネント

```ts
// src/AddUserForm.tsx
import React, { useState } from 'react';
import { useMutation } from '@apollo/client';
import { ADD_USER } from './mutations';
import { GET_USERS } from './queries';

const AddUserForm: React.FC = () => {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [age, setAge] = useState<number | ''>('');
  const [addUser] = useMutation(ADD_USER, {
    refetchQueries: [{ query: GET_USERS }],
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    addUser({ variables: { name, email, age: parseInt(age as string) }});
    setName('');
    setEmail('');
    setAge('');
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        placeholder="Name"
        value={name}
        onChange={e => setName(e.target.value)}
      />
      <input
        type="email"
        placeholder="Email"
        value={email}
        onChange={e => setEmail(e.target.value)}
      />
      <input
        type="number"
        placeholder="Age"
        value={age}
        onChange={e => setAge(e.target.value)}
      />
      <button type="submit">Add User</button>
    </form>
  );
};

export default AddUserForm;
```

このフォームコンポーネントをメインの `App` コンポーネントに追加する。

```ts
// src/App.tsx
import React from 'react';
import { useQuery } from '@apollo/client';
import { GET_USERS } from './queries';
import AddUserForm from './AddUserForm';

interface User {
  id: string;
  name: string;
  email: string;
}

const App: React.FC = () => {
  const { loading, error, data } = useQuery<{ users: User[] }>(GET_USERS);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;

  return (
    <div>
      <h1>Users</h1>
      <ul>
        {data?.users.map(user => (
          <li key={user.id}>
            {user.name} - {user.email}
          </li>
        ))}
      </ul>
      <AddUserForm />
    </div>
  );
};

export default App;
```
