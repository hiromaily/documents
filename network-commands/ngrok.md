# ngrok

ngrok は、ローカル環境で動作しているウェブサーバーや API サーバーに対して、インターネットからアクセス可能な公開 URL を提供するトンネリングサービス。

## 特徴

1. **簡単なセットアップ**

   - ngrok をダウンロードし、コマンドを一つ実行するだけでローカルサーバーに対するトンネルが作成できる。

2. **動的な URL**

   - 基本的にはランダムな URL が生成されるが、認証されたユーザーにはカスタムサブドメインを使用するオプションもある。

3. **セキュリティ**

   - HTTPS 対応の URL を生成でき、セキュアなアクセスが可能。
   - ベーシック認証などのセキュリティ機能も提供されている。

4. **ダッシュボード**

   - Web Interfaceでトンネルのステータスやログをリアルタイムに確認できる。

5. **プロトコルサポート**
   - HTTP/HTTPS だけでなく、TCP トンネルのサポートもある。

### 主な用途

1. **アプリケーション開発**

   - ローカルで開発中のアプリケーションをチームメンバーやクライアントと手軽に共有できる。

2. **API 開発とデバッグ**

   - API のエンドポイントをインターネットからアクセス可能にして、テストやデバッグを行う際に非常に便利。

3. **Webhook テスト**

   - 各種サービス（例：GitHub、Stripe 等）が提供する Webhook をローカル開発環境で受け取り、動作をテストすることができる。

4. **リモートアクセス**
   - ローカルネットワークに閉じたサーバーやデータベースにアクセスするための手段としても利用可能。

## プラン

ngrok は無料プランと有料プランがあり、用途に応じて選択が可能。

- **無料プラン**: 基本的な機能が利用できるが、トンネルのセッションは一時的で、滞在時間やカスタムサブドメインの使用に制約がある。
- **有料プラン**: 無制限のトンネルセッション、カスタムサブドメイン、追加の認証オプションなど、より高度な機能が利用可能。
