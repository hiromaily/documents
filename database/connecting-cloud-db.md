# Cloud 上の DB への接続

## AWS

### 前提条件

1. AWS EC2 インスタンスを踏み台サーバーとして設定していること。
2. SSH キーやアクセス権限があること。
3. AWS Database（例：RDS インスタンス）が設定されていること。

### 手順

#### 方法1: 踏み台サーバーへの接続

まず、踏み台サーバーに接続する。AWS System Manager の Session Manager を使用して接続することができる。  
[内部Docs: AWS Session Manager](../cloud/aws/services/management-console/session-manager.md)

1. **AWS Management Console**にログインする。
2. **AWS Systems Manager**を開く。
3. **Session Manager**に移動する。
4. **Start session**ボタンをクリックして、新しいセッションを開始する。

#### 方法2: ローカルマシンから踏み台サーバーに SSH アクセスを設定

通常、踏み台サーバーを経由してデータベースへアクセスするには SSH トンネルを設定する。

**Linux/Unix の場合**

   1. ターミナルを開きます。
   2. 以下のコマンドを実行してSSHトンネルを設定します：

      ```sh
      aws configure --profile my-profile
      # ssh -L <ローカルポート>:<データベースエンドポイント>:<データベースポート> -i <パス/to/your/key.pem> <ユーザー>@<踏み台サーバーのパブリックIP>
      ssh -L 13306:db-endpoint.com:3306 -i /path/to/your/key.pem ec2-user@踏み台サーバーのIP
      # LocalからDBに接続
      mysql -h localhost -p 13306 -U mydbuser -d mydatabase

#### 方法3: AWS Systems Manager (SSM)を使う方法

`aws ssm start-session`コマンドは、AWS Systems Manager (SSM)を使用して、指定したEC2インスタンスへのセッションを開始する。具体的には、リモートホストへのポートフォワーディングセッションを作成するために使用される。

```sh
aws ssm start-session \
  --target ec2-instance-id \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters host='my-cluster.cluster-xxxxxxx.ap-northeast-1.rds.amazonaws.com',portNumber='3306',localPortNumber='13306' --region ap-northeast-1
```

- aws ssm start-session: AWS SSMセッションマネージャーを使用して、新しいセッションを開始
- --target: セッションを開始するターゲットのEC2インスタンスIDを指定
- --document-name: AWS-StartPortForwardingSessionToRemoteHost:
   使用するドキュメント名を指定する。この例の場合、`AWS-StartPortForwardingSessionToRemoteHost`というドキュメントを使用する。このドキュメントはポートフォワーディングを実行するための事前定義された設定を含んでいる。
- --parameters: ポートフォワーディングに必要なパラメータを指定する

### 接続後、IDE の設定

最後に、ローカルの IDE ツールを設定する。例えば、MySQL Workbench や DBeaver などのツールを使用しているとする。

1. IDE ツールを開きます。
2. 新しい接続を追加し、以下の情報を入力します：
   - **ホスト名**：`localhost`
   - **ポート**：`3306`（または SSH トンネルで指定したローカルポート）
   - **ユーザー名**：データベースのユーザー名
   - **パスワード**：データベースのパスワード
3. 接続をテストし、成功するか確認します。

## GCP

接続例

```sh
# GCPアカウントにブラウザ経由で認証
gcloud auth login
# gcloud CLIの現在のプロジェクトを設定
gcloud config set project project-name
gcloud compute ssh vpc-bastion --project=project-name --zone=asia-northeast1-a -- -N -L 15432:10.7.0.2:5432
```

- gcloud compute ssh vpc-bastion:
  - gcloud compute sshは、GCP上の特定のコンピュートインスタンスにSSH接続を確立するためのコマンド
- `-- -N -L 15432:10.7.0.2:5432:`
  - SSHクライアントに直接渡されるコマンド
  - `-N`: SSH接続を確立するが、リモートコマンドは実行しないオプション
  - `-L 15432:10.7.0.2:5432`: ローカルポートフォワーディングを設定するためのオプション
    - 15432はローカルマシン上のポート番号
    - 10.7.0.2はデータベースインスタンスのプライベートIPアドレス
    - 5432はリモートデータベースのポート番号
