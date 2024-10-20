# Clientコード

- [パスワードによる認証](https://supabase.com/docs/guides/auth/passwords)
- [パスワードなしEmailログイン](https://supabase.com/docs/guides/auth/auth-email-passwordless)
- [電話によるログイン](https://supabase.com/docs/guides/auth/phone-login)
- [Socialログイン(OAuth)](https://supabase.com/docs/guides/auth/social-login)
- [Reactを使った例](https://supabase.com/docs/guides/auth/quickstarts/react)

## 手順

1. Supabaseにアクセスして、アカウントを作成
2. `supabase-js`をプロジェクトにinstall

    ```sh
    npm install @supabase/supabase-js
    ```

3. clientコードを作成

    ```js
    import { createClient } from '@supabase/supabase-js'

    // use supabase
    const supabaseUrl = process.env.SUPABASE_URL;
    const supabaseKey = process.env.SUPABASE_KEY
    const supabase = createClient(supabaseUrl, supabaseKey)

    // sign in
    const res = await supabase.auth.signInWithPassword({
      email,
      password,
    });
    if (res.error) return null;

    return { email };
    ```
