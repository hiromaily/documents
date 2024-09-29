# React Essentials

[React Essentials](https://nextjs.org/docs/getting-started/react-essentials)

- Next.js でアプリケーションを構築するには、React の新機能である `Server Components`` を使いこなす必要がある
- `Server Components`と`Client Components`の違い、使うタイミング、おすすめのパターンについて
- `Server Components`と`Client Components`によって Developer は Server と Client にまたがるアプリケーションを構築でき、Client Application のリッチなインタラクティブ性と、従来の Server-Rendering の改善されたパフォーマンスを組み合わせることができる
- React は、アプリケーション全体を Client-side でレンダリングする代わりに（シングルページアプリケーションの場合など）、目的に応じてコンポーネントをレンダリングする場所を柔軟に選択できる

## [Server Components](https://nextjs.org/docs/getting-started/react-essentials#server-components)

- Server Component モジュールグラフのコンポーネントは、サーバー上でのみレンダリングされることが保証されている

### Next.js における Server Components のメリット

Next.js における Server Components は、パフォーマンスの向上、バンドルサイズの削減、効果的なサーバーサイドリソースの活用など、開発者に多くの利点をもたらす

#### サーバーインフラストラクチャの活用

- データのフェッチをサーバーに近づけることができる。
- また、以前はクライアントの JavaScript バンドルサイズに影響を及ぼしていた大きな依存関係をサーバー側に保持することも可能。これにより、パフォーマンスが向上する

#### 初期ページの高速化

- 初期ページの読み込みが高速化される
- 初期の HTML がサーバー上でレンダリングされ、ブラウザで逐次的に展開されることで、クライアント側の JavaScript バンドルサイズが削減され、パフォーマンスが向上する

#### キャッシュ可能で予測可能なクライアント側ランタイム

- 基本的なクライアント側ランタイムはキャッシュ可能でサイズも予測可能となる
- アプリケーションの成長とともにサイズが増えることはない
- 追加の JavaScript は、クライアント側のインタラクティビティが使用される場合にのみ追加される

#### 移行と採用

- Server Components への移行を容易にするため、App Router 内のすべてのコンポーネントはデフォルトで `Server Components` となっている
- これには特殊ファイルや共有コンポーネントも含まれる
- そのため、追加の作業なしで自動的に `Server Components` を採用し、良好なパフォーマンスを実現できる
- また、`'use client'` ディレクティブを使用して必要に応じて Client Components を選択的に使用することもできる

## [Client Components](https://nextjs.org/docs/getting-started/react-essentials#client-components)

- Client Components を使うと、アプリケーションにクライアントサイドの`インタラクティブ機能`を追加できる
- `Client Components` モジュール グラフのコンポーネントは、主にクライアントでレンダリングされるが、Next.js を使用すると、サーバーで事前にレンダリングし、クライアントで展開することもできる
- Client Components は、Pages Router のコンポーネントと同じようなものだと考えることができる。

### `use client` ディレクティブ

- Server と Client Components のモジュール・グラフの境界を宣言するための規約で、ファイルに`use client`が定義されると、そのファイルに import された子コンポーネントを含む他のすべてのモジュールは、`クライアントバンドルに含まれる` とみなされる。例えば、以下の処理を Server Component に含めるとエラーになる
  - `onClick` event handler
  - `useState` import
- 注意すべきは、`Server Components`がデフォルトであるため、適宜必要に応じて`use client`を追加する必要があるということ
- インポートする前にファイルの先頭で定義しなければならない
- `use client` は、すべてのファイルで定義する必要はない。Client モジュールの境界は、インポートされたすべてのモジュールが Client Components とみなされるために、`エントリーポイント` で一度だけ定義する必要がある

## Server Components と Client Components の使い分け

- ページを小さなコンポーネントに分割してみると、大半のコンポーネントは`非インタラクティブ`で、Server Components としてサーバー上でレンダリングできることに気づくはず
- 小さなインタラクティブな UI には、Client Components を使用する (これは、Next.js のサーバーファーストのアプローチに沿ったもの)

![components comparison](../../../../images/nextjs-components.png 'components comparison')

## [パターン](https://nextjs.org/docs/getting-started/react-essentials#patterns): 重要

### [1. Client Components を起点となる Component(layout.tsx)から離れた先端に移動する](https://nextjs.org/docs/getting-started/react-essentials#moving-client-components-to-the-leaves)

- アプリケーションのパフォーマンスを向上させるには、Client Components を可能な限りコンポーネント・ツリーのリーフに移動させる

### [2. Client と Server Components を構成する](https://nextjs.org/docs/getting-started/react-essentials#composing-client-and-server-components)

- Server Components と Client Components は、同じコンポーネントツリーで組み合わせることができる

### [3. Client Components の中に Server Components を入れ子にする](https://nextjs.org/docs/getting-started/react-essentials#nesting-server-components-inside-client-components)

- Server Components を Client Components にインポートする場合、追加の Server ラウンドトリップが必要になるため、制限がある

#### 3.1 サポートされていないパターン: Client Components への Server Components のインポート

- erver Components を Client Components にインポートすることはできない

#### 3.2 推奨パターン: Server Components を`prop`として Client Components に渡す

```tsx
'use client';

import { useState } from 'react';

export default function ExampleClientComponent({
  children,
}: {
  children: React.ReactNode;
}) {
  const [count, setCount] = useState(0);

  return (
    <>
      <button onClick={() => setCount(count + 1)}>{count}</button>

      {children}
    </>
  );
}
```

```tsx
// This pattern works:
// You can pass a Server Component as a child or prop of a
// Client Component.
import ExampleClientComponent from './example-client-component';
import ExampleServerComponent from './example-server-component';

// Pages in Next.js are Server Components by default
export default function Page() {
  return (
    <ExampleClientComponent>
      <ExampleServerComponent />
    </ExampleClientComponent>
  );
}
```

### [4. Server から Client Components への`props`を渡す（シリアライズ）](https://nextjs.org/docs/getting-started/react-essentials#nesting-server-components-inside-client-components)

- Server から Client Components に渡される prop は、シリアライズ可能である必要がある
- つまり、function や日付などの値を直接 Client Components に渡すことはできない

### [5. Client Components から Server 専用コードを排除する（Poisoning）](https://nextjs.org/docs/getting-started/react-essentials#keeping-server-only-code-out-of-client-components-poisoning)

### [6. Server 専用 パッケージ](https://nextjs.org/docs/getting-started/react-essentials#the-server-only-package)

- サーバー専用パッケージを使用することで、他の開発者が誤ってこれらのモジュールを Client Components にインポートした場合に、ビルド時にエラーを表示することができる

### [7. Data Fetching](https://nextjs.org/docs/getting-started/react-essentials#data-fetching)

Client Component でデータをフェッチすることも可能だが、Client でデータをフェッチする特別な理由がない限り、Server Components でデータをフェッチすることが推奨されている

### [8. Third-party パッケージ](https://nextjs.org/docs/getting-started/react-essentials#third-party-packages)

- `useState`、`useEffect`、`createContext`のような Client 専用の機能を使用するコンポーネントに`use client`ディレクティブを追加
- これらのような Client 専用機能を Server Components 内で直接しようとするとエラーが発生する。この問題を解決するには、Client 専用の機能に依存するサードパーティのコンポーネントを、独自の Client Components でラップする

```tsx
'use client';

import { Carousel } from 'acme-carousel';

export default Carousel;
```

- サードパーティのコンポーネントは、Client Components 内で使用する可能性が高いため、ほとんどのコンポーネントをラップする必要はないはず

## [Context](https://nextjs.org/docs/getting-started/react-essentials#context)

- Next.js 13 では、Context は Client Components 内で完全にサポートされているが、Server Components 内で直接作成したり Consume したりすることはできない。これは、Server Components には React のステートがなく（インタラクティブではないため）、Context は主に、React のステートが更新された後にツリーの奥深くにあるインタラクティブなコンポーネントを再レンダリングするために使用されるため。

### Client Components で Context を使用する

- Context Provider は、現在のテーマなど、グローバルな関心事を共有するために、アプリケーションのルート付近にレンダリングされるのが一般的。Server Components では Context がサポートされていないため、アプリケーションのルートで Context を作成しようとするとエラーになる

```tsx
import { createContext } from 'react';

//  createContext is not supported in Server Components
export const ThemeContext = createContext({});

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        <ThemeContext.Provider value="dark">{children}</ThemeContext.Provider>
      </body>
    </html>
  );
}
```

- これを解決するには、Context を作成し、その Provider を Client Components の中にレンダリングする

```tsx
'use client';

import { createContext } from 'react';

export const ThemeContext = createContext({});

export default function ThemeProvider({ children }) {
  return <ThemeContext.Provider value="dark">{children}</ThemeContext.Provider>;
}
```

- Server Components は、Client Components としてマークされているので、プロバイダを直接レンダリングできるようになる

```tsx
import ThemeProvider from './theme-provider';

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html>
      <body>
        <ThemeProvider>{children}</ThemeProvider>
      </body>
    </html>
  );
}
```

- Provider が Root にレンダリングされると、App 全体の他のすべての Client Components がこの Context を利用できるようになる

### Server Components でのサードパーティ Context Provider のレンダリング

- `use client` を持たないサードパーティ Provider をレンダリングしようとすると、エラーが発生する

```tsx
import { ThemeProvider } from 'acme-theme';

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {/*  Error: `createContext` can't be used in Server Components */}
        <ThemeProvider>{children}</ThemeProvider>
      </body>
    </html>
  );
}
```

- これを解決するには、サードパーティ Provider を独自の Client Components でラップする

```tsx
'use client';

import { ThemeProvider } from 'acme-theme';
import { AuthProvider } from 'acme-auth';

export function Providers({ children }) {
  return (
    <ThemeProvider>
      <AuthProvider>{children}</AuthProvider>
    </ThemeProvider>
  );
}
```

- これで、root の layout 内で`<Providers />`を直接インポートしてレンダリングできる

```tsx
import { Providers } from './providers';

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
```

- サードパーティライブラリがその Client コードに`use client` を追加したら、ラッパーとなる Client Component を削除できるようになる

### Server Components 間のデータ共有

- Server Components はインタラクティブではないので、React のステートから読み込むことはない
- 代わりに、複数の Server Components がアクセスする必要がある共通のデータには、ネイティブの JavaScript パターンを使用できる
  - この JavaScript パターンは`Global・シングルトン`と呼ばれる
- 例えば、モジュールを使用して、複数のコンポーネント間でデータベース接続を共有することができる

```ts
export const db = new DatabaseConnection();
```

```tsx
import { db } from '@utils/database';

export async function UsersLayout() {
  let users = await db.query();
  // ...
}
```

### Server Components 間で Fetch リクエストを共有する

- データを消費するコンポーネントと一緒にデータフェッチをコロケーションする(同一場所に設置する)ことが推奨されている
- Fetch リクエストは Server Components で自動的に推定されるので、各 Root セグメントは重複リクエストを気にすることなく、必要なデータを正確にリクエストできる。
- Next.js は Fetch Cache から同じ値を読み込む
- [参考: Automatic fetch() Request Deduping](https://nextjs.org/docs/app/building-your-application/data-fetching#automatic-fetch-request-deduping)
