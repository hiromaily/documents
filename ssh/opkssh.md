# opkssh (OpenPubkey SSH)

**[opkssh](https://github.com/openpubkey/opkssh)**は、`OpenID Connectを使用してSSHアクセス管理を可能にするツール`。これにより、長期的なSSHキーの代わりに、`alice@example.com`のようなアイデンティティを使用してSSHアクセスを管理できる。`opkssh`はSSHを置き換えるものではなく、PKトークンを含むSSH公開鍵を生成し、sshdを設定してSSH公開鍵内のPKトークンを検証する。
opksshは、OpenID Connectを利用してSSHアクセスを簡素化し、セキュリティを向上させるための強力なツール。特に、短期間のSSHキーを使用することで、ユーザーは頻繁に認証を行う必要があるが、これによりセキュリティが強化される。

## 主な機能

- **OpenID Connectとの統合**: Google、Microsoft/Azure、GitLabのOpenIDプロバイダーと互換性がある。
- **簡単なログイン**: `opkssh login`コマンドを実行することで、ブラウザを介してOpenIDプロバイダーに認証し、SSHキーを生成する。
- **SSHキーの有効期限**: デフォルトでは、生成されたSSHキーは24時間後に期限切れになる。

## インストール方法

### Homebrewを使用したインストール（macOS）

```bash
brew tap openpubkey/opkssh
brew install opkssh
```

### 手動インストール（Windows、Linux、macOS）

- **macOS**:

   ```bash
   curl -L https://github.com/openpubkey/opkssh/releases/latest/download/opkssh-osx-amd64 -o opkssh
   ```

- **Linux**:

   ```bash
   curl -L https://github.com/openpubkey/opkssh/releases/latest/download/opkssh-linux-amd64 -o opkssh
   ```

## SSHの使用方法

1. opksshをインストール後、次のコマンドを実行する。

   ```bash
   opkssh login
   ```

2. ブラウザが開き、OpenIDプロバイダーに認証する。
3. SSHを通常通り使用する。

   ```bash
   ssh user@example.com
   ```

## サーバーの設定

Linuxサーバーでopksshを使用するには、次のコマンドを実行する（root権限が必要）:

```bash
wget -qO- https://github.com/openpubkey/opkssh/releases/latest/download/opkssh-linux-amd64 | sudo tee /usr/local/bin/opkssh
```

## サポートされているOS

| クライアント/サーバー | サポート | テスト済み | テストバージョン   |
| --------------------- | -------- | ---------- | ------------------ |
| Linux                 | ✅        | ✅          | Ubuntu 24.04.1 LTS |
| macOS                 | ✅        | ✅          | macOS 15.3.2       |
| Windows 11            | ✅        | ✅          | Windows 11         |

## 設定ファイル

- **/etc/opk/providers**: 許可されたOpenIDプロバイダーのリストを含む。
- **/etc/opk/auth_id**: グローバルな認証アイデンティティファイル。

## References

- [Open-sourcing OpenPubkey SSH (OPKSSH): integrating single sign-on with SSH](https://blog.cloudflare.com/open-sourcing-openpubkey-ssh-opkssh-integrating-single-sign-on-with-ssh/)
