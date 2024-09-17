# Auth.js

NextAuth.js は、`Next.js`アプリケーションにおいて認証機能を簡単に追加できる強力なライブラリ

## 主な特徴

- **OAuth サポート**: Google, Facebook, GitHub など、多くの OAuth プロバイダーをサポート。
- **Email 認証**: 特定のトークンを含むメールリンクでのサインイン。
- **セッション管理**: サーバーサイド/クライアントサイドのセッション管理。
- **カスタマイズ性**: 認証ロジックやユーザー情報の管理を自由にカスタマイズ可能。

## 認証ルートの設定

NextAuth.js は`/api/auth/[...nextauth]`ルートで動作する。このため、`pages/api/auth/[...nextauth].js`ファイルを作成し、基本的な設定を記述する。

```javascript
// pages/api/auth/[...nextauth].js
import NextAuth from "next-auth";
import Providers from "next-auth/providers";

export default NextAuth({
  providers: [
    Providers.Google({
      clientId: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    }),
    // 他のプロバイダーもここに追加できる
  ],
  // 必要に応じて他のオプションを追加
});
```

## 環境変数の設定

`.env.local`ファイルに OAuth プロバイダーのクライアント ID とクライアントシークレットを設定する。

```sh
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret
```

## サインインとサインアウト

NextAuth.js は用意されたフロントエンドのフックを通じて簡単にサインインとサインアウトを実装できる。

```js
// pages/index.js
import { signIn, signOut, useSession } from "next-auth/client";

export default function Home() {
  const [session, loading] = useSession();

  return (
    <div>
      {!session && (
        <>
          <button onClick={() => signIn()}>Sign in</button>
        </>
      )}
      {session && (
        <>
          <p>Signed in as {session.user.email}</p>
          <button onClick={() => signOut()}>Sign out</button>
        </>
      )}
    </div>
  );
}
```

## セッション情報の取得

セッション情報は`useSession`フックを使って簡単に取得できる。このフックはクライアントサイドでセッションの状態を監視する。

```js
import { useSession } from "next-auth/client";

const MyComponent = () => {
  const [session, loading] = useSession();

  if (loading) return <p>Loading...</p>;

  if (!session) {
    return <p>You are not signed in</p>;
  }

  return <p>Welcome, {session.user.name}</p>;
};
```

## セッションのカスタマイズ

セッションや JWT の情報をカスタマイズしたい場合も、オプションを使って設定できる。

```js
// pages/api/auth/[...nextauth].js
import NextAuth from "next-auth";
import Providers from "next-auth/providers";

export default NextAuth({
  providers: [
    Providers.Google({
      clientId: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    }),
  ],
  callbacks: {
    // セッションが生成される前にコールされる関数
    async session(session, user) {
      session.userId = user.id;
      return session;
    },
    // JWTトークンが生成される前にコールされる関数
    async jwt(token, user) {
      if (user) {
        token.id = user.id;
      }
      return token;
    },
  },
});
```

## References

- [Auth.js](https://authjs.dev/)
