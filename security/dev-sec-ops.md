# TODO: DevSecOps

DevSecOpsはセキュリティを開発と運用のプロセスに統合するアプローチ

## セキュリティスキャンツール

1. **SonarQube**
   - 静的コード解析ツールで、コードの品質とセキュリティをチェックします。
   - [SonarCloud](https://www.sonarsource.com/products/sonarcloud/)のほうが低機能

2. **Snyk**
   - オープンソースパッケージの脆弱性を発見し、修正するためのツール。
3. **Checkmarx**
   - 静的アプリケーションセキュリティテスト (SAST) ツール。
4. **WhiteSource**
   - オープンソースのセキュリティとライセンスコンプライアンスを管理。

## コンテナセキュリティツール

1. **Aqua Security**
   - コンテナとクラウドネイティブのセキュリティプラットフォーム。
2. **Twistlock (Prisma Cloud by Palo Alto Networks)**
   - コンテナのセキュリティ管理ツール。
3. **Falco**
   - コンテナのランタイムセキュリティ監視ツール。

## インフラストラクチャセキュリティツール

1. **Terraform + Terraform Cloud/Enterprise**
   - インフラストラクチャをコードとして管理し、セキュリティポリシーを適用。
2. **Ansible**
   - 自動化された構成管理ツールで、セキュリティポリシーの一貫性を保つのに役立ちます。

## モニタリングとログ管理

1. **ELK Stack (Elasticsearch, Logstash, Kibana)**
   - ログ収集と分析のためのオープンソースツールセット。
2. **Splunk**
   - データ分析とログ管理のための商用ツール。
3. **Prometheus + Grafana**
   - モニタリングとアラートのためのオープンソースツール。

## クラウドセキュリティツール

1. **AWS Security Hub / Azure Security Center / Google Cloud Security Command Center**
   - 各クラウドプロバイダーが提供するセキュリティ管理ツール。

## 認証とアクセス管理

1. **HashiCorp Vault**
   - シークレット管理のためのツールで、APIキーなどの機密情報を安全に保存します。
2. **Okta / Auth0**
   - SSO（シングルサインオン）や多要素認証（MFA）を提供するID管理サービス。

## スキャニングと脆弱性管理

1. **Nessus**
   - 脆弱性スキャナー。
2. **Qualys**
   - 総合的な脆弱性管理プラットフォーム。
3. **OpenVAS**
   - オープンソースの脆弱性スキャナー。
