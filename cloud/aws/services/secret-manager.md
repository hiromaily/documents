# AWS Secrets Manager

特に認証情報やAPIキー、パスワードなどの機密データを管理するためのサービスだ。このサービスを使うことで、機密データを安全に保存、取得、ローテーションすることができる。

## 主な機能

1. **Secretsの保存**:
   - パスワード、データベースの認証情報、APIキーなどの機密データを安全に保存する。
   - 保存されたセcretsは暗号化され、AWS Key Management Service (KMS)を使って管理される。

2. **Secretsのローテーション**:
   - 定期的なセcretsの自動ローテーションを設定できる。これにより、セキュリティリスクを減少させる。
   - サポートされているAWSサービス（例えばRDS）の場合、Secrets Managerが自動的にデータベースのパスワードを更新し、アプリケーションとの連携を維持してくれる。

3. **Secretsの取得**：
   - 開発者はAPIやAWS CLIを使って簡単にセcretsを取得できる。
   - AWS SDKを使えば、コード内でセcretsを読み込み、必要な場所で利用できる。

4. **アクセス管理**：
   - セcretsへのアクセスはIAMポリシーを使って制御する。
   - 詳細なアクセスルールを設定することで、特定のユーザーやサービスに対するアクセス制御が可能。

## 使用シナリオ

- **データベース接続**：
  アプリケーションがデータベースに接続するための認証情報をSecrets Managerに保存し、必要な時に取得する。
  
- **サードパーティAPIの連携**：
  APIキーやアクセストークンなどを安全に管理し、アプリケーションがそれらにアクセスしてAPIとの連携を実現する。

## メリット

- **セキュリティ強化**：
  機密データをコード内やバージョン管理システムに直接書かない。
  
- **運用の簡素化**：
  セcretsのローテーションや管理を自動化することで、運用負荷を減少させる。

- **統合**：
  AWSの他のサービスとシームレスに統合できる。特にLambdaやRDSとの連携が簡単に行える。

## 始め方

1. **Secretsの取得の作成**：
   AWSマネジメントコンソールからSecrets Managerを選択し、新しいシークレットを作成する。

2. **Secretsの取得の使用**：
   作成したシークレットを使用するためのアクセス権をIAMポリシーで設定し、必要に応じてAPIやAWS SDKを使ってシークレットを取得する。

3. **Secretsの取得のローテーション**：
   必要に応じて、自動ローテーションを設定する。利用可能なテンプレートやカスタムスクリプトを使って、自動ローテーションを実装する。

これで、AWS Secrets Managerの概要についての説明は終わりだ。詳細な実装はAWSの公式ドキュメントを参照するといい。

## AWSでDockerコンテナに秘密情報を含む環境変数を安全にデプロイする方法

### 1. AWS Secrets Managerの使用

1. **秘密情報を登録する**:
   - AWS管理コンソールでSecrets Managerを開き、必要な秘密情報を登録。

2. **IAMロールの設定**:
   - 定義したIAMロールにSecrets Managerからシークレットを読み取るための`secretsmanager:GetSecretValue`権限を付与。

3. **シークレットをGolangコードで取得**:
   - 依存関係を設定するために、go.modファイルに以下を追加。

```go
module module-name

go 1.23

require (
    github.com/aws/aws-sdk-go-v2 v1.10.0
    github.com/aws/aws-sdk-go-v2/config v1.10.0
    github.com/aws/aws-sdk-go-v2/service/secretsmanager v1.10.0
)
```

- GolangでSecrets Managerからシークレットを取得し、環境変数に設定する。

```go
package main

import (
    "context"
    "log"
    "os"

    "github.com/aws/aws-sdk-go-v2/aws"
    "github.com/aws/aws-sdk-go-v2/config"
    "github.com/aws/aws-sdk-go-v2/service/secretsmanager"
)

func getSecret(secretName string) (string, error) {
    cfg, err := config.LoadDefaultConfig(context.TODO())
    if err != nil {
        return "", err
    }

    svc := secretsmanager.NewFromConfig(cfg)
    input := &secretsmanager.GetSecretValueInput{
        SecretId: aws.String(secretName),
    }

    result, err := svc.GetSecretValue(context.TODO(), input)
    if err != nil {
        return "", err
    }

    return *result.SecretString, nil
}

func main() {
    secretName := "my_secret"
    
    secretValue, err := getSecret(secretName)
    if err != nil {
        log.Fatalf("Unable to retrieve secret: %v", err)
    }
}
```

### 2. AWS Systems Manager Parameter Storeの使用

1. **パラメータを登録する**:
   - AWS管理コンソールでParameter Storeを開き、必要なパラメータを登録。

2. **IAMロールの設定**:
   - 定義したIAMロールにParameter Storeからパラメータを読み取るための`ssm:GetParameter`権限を付与。

3. **パラメータをGolangコードで取得**:
   - 依存関係は上記のSecrests Managerと同様に設定。

   - GolangでParameter Storeからパラメータを取得し、環境変数に設定する。

```go
package main

import (
    "context"
    "log"
    "os"
    "github.com/aws/aws-sdk-go-v2/aws"
    "github.com/aws/aws-sdk-go-v2/config"
    "github.com/aws/aws-sdk-go-v2/service/ssm"
)

func getParameter(parameterName string) (string, error) {
    cfg, err := config.LoadDefaultConfig(context.TODO())
    if err != nil {
        return "", err
    }

    svc := ssm.NewFromConfig(cfg)
    input := &ssm.GetParameterInput{
        Name:           aws.String(parameterName),
        WithDecryption: aws.Bool(true),
    }

    result, err := svc.GetParameter(context.TODO(), input)
    if err != nil {
        return "", err
    }

    return *result.Parameter.Value, nil
}

func main() {
    parameterName := "my_parameter"
    parameterValue, err := getParameter(parameterName)
    if err != nil {
        log.Fatalf("Unable to retrieve parameter: %v", err)
    }

    os.Setenv("MY_PARAMETER", parameterValue)

    // 以下のコードで環境変数 MY_PARAMETER を使用
    log.Println("Parameter value set to environment variable MY_PARAMETER")
}
```
