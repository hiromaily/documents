# Session Manager

[AWS Systems Manager] > [Node Tools] > [Session Manager]

AWS Systems Manager の一部である AWS Systems Manager Session Manager（以下、Session Manager）は、Amazon EC2 インスタンスやオンプレミスのサーバーに対し、安全かつ迅速なシェルアクセスを提供するマネージドサービス。Session Manager は、システム管理者やデベロッパーがサーバーを管理・操作するためのツールとして、特にセキュリティと利便性を重視して設計されている。

## 主な機能と特徴

1. **エージェントベースのアプローチ**:

   - AWS Systems Manager エージェント（SSM Agent）がインスタンスにインストールされている必要がある。このエージェントは、AWS からのセッションリクエストを受け取ってセッションを確立する。

2. **セキュアなアクセス**:

   - セッションは AWS IAM（Identity and Access Management）で認証・認可され、ログは CloudTrail に記録される。これにより、アクセスの監査とトレーサビリティが実現する。
   - セッションは TLS（Transport Layer Security）で暗号化され、安全な通信を確保する。

3. **インバウンドポート不要**:

   - セッションの開始にはインスタンスに対するインバウンドポートの開放が不要で、パブリック IP アドレスを持たないインスタンスにもアクセスが可能。これにより、セキュリティリスクを大幅に軽減できる。

4. **統合されたログと監査**:

   - すべてのセッションアクティビティは AWS CloudTrail や Amazon S3、Amazon CloudWatch Logs などに記録し、監査やレビューを容易にする。

5. **複数のアクセス方法**:
   - AWS Management Console、AWS CLI、AWS SDK などからシームレスにセッションを開始できる。
   - シェルアクセス（Bash、PowerShell）だけでなく、RDP セッション（Windows GUI アクセス）もサポートされている。

## 利便性

1. **使いやすいアクセス管理**:

   - AWS IAM ロールやポリシーを利用して、どのユーザーがどのインスタンスにアクセスできるかを細かく制御可能。

2. **操作の一貫性**:

   - 統一されたインターフェースで、複数の異なるインスタンスに対して一貫した操作が行える。

3. **簡素化された接続手順**:

   - インターネット経由のリモートアクセス設定や VPN トンネルの構成が不要で、アクセスを迅速にセットアップできる。

4. **セッションの監査と記録**:
   - セッション中のユーザーアクティビティをリアルタイムでモニタリングし、重要なコマンドやアクションを後で確認できる。

## Session Manager 使用方法

### Session Manager 事前準備

1. **SSM エージェントのインストール**:

   - AWS 公式のドキュメントに従い、ターゲットの EC2 インスタンスに SSM エージェントをインストールする
     - 多くの AWS 提供の AMI には SSM エージェントがプリインストールされている。

2. **IAM ロールとポリシーの設定**:
   - 予め必要な権限を持つ IAM ロールを作成し、EC2 インスタンスにアタッチする。通常は`AmazonSSMManagedInstanceCore`ポリシーを適用することで基本的な機能が利用可能。

### コンソールからの利用

1. **AWS Management Console ログイン**:
   - AWS Management Console にログインする。
2. **Systems Manager Dashboard への移動**:

   - ナビゲーションペインで「Systems Manager」を選択。

3. **Session Manager の開始**:
   - `Session Manager`を選択し、「セッションの開始」ボタンをクリック。
   - インスタンス ID を選択し、セッションタイプ（シェルや RDP）を選択してセッションを開始する。

### AWS CLI からの利用

1. **セッションの開始**:

```bash
aws ssm start-session --target <instance-id>
```

### プログラムからの利用（Python SDK の例）

```python
import boto3

ssm = boto3.client('ssm')

response = ssm.start_session(
    Target='instance-id'
)
```

## セキュリティとコンプライアンス

1. **アクセス制御**:

   - IAM ポリシーを利用して、誰がどのインスタンスにアクセスできるかを厳密に管理する。

2. **監査ログ**:

   - すべてのセッションとそのアクティビティは CloudTrail や CloudWatch Logs に記録され、後でレビューや監査に利用可能。

3. **ペイロードの暗号化**:
   - すべてのセッションデータは TLS で暗号化され、安全な通信が保証される。
