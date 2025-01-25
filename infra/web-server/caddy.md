# Caddy

**Caddy**は、SSL/TLS の自動管理機能を持つモダンなオープンソースの Web Server。
Caddy は、その簡単な設定と自動 HTTPS 機能により、ウェブサーバーの設定や運用を非常に簡単にする。高性能で拡張性があり、多くのプロジェクトで利用価値がある。

## 特徴

1. **自動 HTTPS**:

   - Caddy の最も注目すべき特徴の一つは、`HTTPSを自動で設定し管理できること`。Caddy は自動で`Let's Encrypt`や ZeroSSL などの ACME 互換の CA から SSL 証明書を取得し、リニューアルも自動で行う。

2. **シンプルな設定**:

   - Caddy の設定は非常にシンプルで、`Caddyfile`という構成ファイルを使用して設定を行う。わかりやすい形式で記述できるため、設定が容易。

3. **パフォーマンス**:

   - Go 言語で書かれている Caddy は、高速で効率的なパフォーマンスを提供する。並列処理や非同期処理に最適化されている。

4. **プラグインと拡張性**:

   - 初期設定の機能だけでなく、Caddy は多くのプラグインをサポートしており、機能の拡張が容易。これにより、プロキシ、ロードバランシング、静的ファイルの提供、認証など多岐にわたる機能を追加できる。

5. **セキュアなデフォルト**:
   - セキュリティを重視し、セキュアなデフォルト設定を採用している。これにより、設定ミスによるセキュリティリスクを低減できる。

## 基本的な使用例

以下は、Caddyfile の簡単な例。これにより、特定のドメイン名に対して HTTPS を有効にし、静的ファイルを提供するように設定する

```txt
example.com {
    root * /var/www/html
    file_server
}
```

この設定では、`example.com`というドメインで Caddy が自動的に`Let's Encrypt`から証明書を取得し、指定されたディレクトリの静的ファイルを提供する。

## インストール

```bash
# Install script provided by Caddy
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
```

## References

- [github](https://github.com/caddyserver/caddy)
- [Docs](https://caddyserver.com/docs/)
