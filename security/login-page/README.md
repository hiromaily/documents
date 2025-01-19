# ログインページ

## セキュリティ

ログイン画面を作成する際にセキュリティ対策を十分に行うことは非常に重要。以下に気をつけるべき主要なポイントを挙げる。

1. **HTTPS の使用**:

   - HTTPS を使用して通信を暗号化し、通信中のデータが盗聴されるのを防ぐ。

2. **強力なパスワードポリシー**:

   - ユーザーに対して強力なパスワードを設定させるようにする。パスワードは十分な長さがあり、数字、特殊文字、大文字、小文字を含むことが推奨される。

3. **アカウントロックアウト**:

   - 一定回数のログイン試行が失敗した場合、アカウントを一時的にロックアウトする機能を実装し、ブルートフォース攻撃を防ぐ。

4. **CAPTCHA の導入**:

   - ログインフォームに CAPTCHA を追加し、自動化されたログイン攻撃を防ぐ。

5. **セッション管理**:

   - セキュアで完全なセッション管理を行い、セッションハイジャックを防ぐ。セッション ID はランダムで予測不可能なものを使用し、セッションタイムアウトを設定する。

6. **クロスサイトスクリプティング（XSS）対策**:

   - 入力データを適切にエスケープして、悪意のあるスクリプトの実行を防ぐ。

7. **SQL インジェクション対策**:

   - プリペアドステートメントやパラメータ化クエリを使用して、SQL インジェクション攻撃を防ぐ。

8. **二要素認証（2FA）の実装**:

   - ユーザーに対して、パスワードに加えてもう一つの確認手段（例：SMS コードや認証アプリ）を要求することで、追加のセキュリティ層を提供する。

9. **エラーメッセージの管理**:

   - ログイン失敗時のエラーメッセージには、何が間違っているのか特定されにくいようにし、攻撃者に情報を与えないようにする。

10. **セキュリティヘッダーの使用**:

    - X-Content-Type-Options, X-Frame-Options, Content-Security-Policy などのセキュリティヘッダーを設定して、各種攻撃を防ぐ。

11. **定期的なセキュリティ診断とテスト**:

    - 定期的にペネトレーションテストやセキュリティ診断を行い、新たな脆弱性を発見し対策を講じる。

12. **autocomplete 属性を off にする**:
    - デフォルトでは ON となるため、`<form autocomplete="off">`を設定
    - しかし、Password Manager と連携させるためには`on`にする必要がある

## Google Chrome でパスワードマネージャ（Chrome Password Manager）にログイン情報を保存し、連携させる

1. **HTML 構造の適切な使用**:
   - フォームの構造は標準的な形で書くことが重要。
   - `name` 属性を適切に設定することで、Chrome がフィールドを認識しやすくなる。

   ```html
   <form action="/login" method="POST">
     <label for="username">Username:</label>
     <input type="text" id="username" name="username" required />
     <label for="password">Password:</label>
     <input type="password" id="password" name="password" required />
     <button type="submit">Login</button>
   </form>
   ```

2. **適切な`type="password"`**:
   - パスワードフィールドとして `input` 要素の `type` を `password` に設定する。これにより、ブラウザはパスワードとして認識する。

3. **自動補完属性（autocomplete）の設定**:
   - ブラウザは `autocomplete` 属性を使用してフィールドを適切に補完する。特にログイン情報に対しては、`username` と `current-password` を使用する。

   ```html
   <form action="/login" method="POST" autocomplete="on">
     <label for="username">Username:</label>
     <input
       type="text"
       id="username"
       name="username"
       autocomplete="username"
       required
     />
     <label for="password">Password:</label>
     <input
       type="password"
       id="password"
       name="password"
       autocomplete="current-password"
       required
     />
     <button type="submit">Login</button>
   </form>
   ```

### ユーザーエクスペリエンスの考慮

ユーザーが Chrome のパスワードマネージャでログイン情報を保存したり、自動入力させやすくするための追加の考慮事項

1. **セキュリティメッセージの最小化**:

   - ブラウザがセキュリティ上安全と判断した場合のみ、パスワードを保存するプロンプトが表示される。これには、サイトが HTTPS を使用していることが必要。

2. **モーダルやダイアログを避ける**:

   - 一部のモーダルや動的に生成されたログインフォーム要素は、ブラウザによって認識されない可能性がある。通常の HTML フォームを使用することが好ましい。

3. **パスワード保存のプロンプト**:
   - ユーザーがログインするたびに、Google Chrome はログイン情報を保存するかどうかを尋ねる。このプロンプトが表示されるようにするため、ページ遷移やリダイレクトがスムーズに行われるよう設計することが重要。
