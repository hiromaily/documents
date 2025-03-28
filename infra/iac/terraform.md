# Terraform

Terraform は、インフラ自動化を高度に実現するための強力なツールであり、マルチクラウド環境やハイブリッドなインフラストラクチャの管理において非常に有用。プロジェクトの規模に関わらず、一貫した、効率的なインフラ管理を実現できるため、現代のインフラ管理において広く採用されている。

## 主要な特長

1. **宣言的な構成**:

   - Terraform の構成ファイルは宣言的（declarative）であり、何を達成したいかを記述します。ユーザーは「どうやって」ではなく、「何を」達成するかに集中できる。

2. **インフラストラクチャのプロビジョニング**:

   - 多様なクラウドプロバイダー（AWS、Azure、Google Cloud など）、オンプレミス環境、および PaaS/SaaS サービスを管理できる。

3. **PlanとApply**:

   - `terraform plan`を使用して何が変更されるかを事前に確認でき、`terraform apply`で実際の変更を適用する。

4. **リソースの管理**:

   - 既存のリソースの観察、変更、新規作成、削除を自動的に処理する。

5. **モジュラー構造**:
   - Terraform はモジュール化されており、再利用可能な構成を作成し、異なるプロジェクトでも使い回せる。

## 基本的なコンセプト

1. **HCL (HashiCorp Configuration Language)**:

   - Terraform は HCL という独自の構成言語を使用してインフラの構成を記述する。HCL は人間にとって読みやすく、また機械が簡単に解析しやすい仕様。

2. **プロバイダー**:

   - プロバイダーは特定のインフラストラクチャー（クラウドサービスや SaaS サービスなど）と連携するためのプラグイン。例えば、AWS プロバイダー、Azure プロバイダーなどがある。

3. **リソース**:

   - リソースは実際に管理するインフラのエンティティ。たとえば、AWS の EC2 インスタンス、Google Cloud の Storage Bucket などがリソースとして扱われる。

4. **ステートファイル**:

   - Terraform はインフラの状態をステートファイルとして保存し、実際の環境と定義された構成の差異を管理する。ステートファイルは S3 などのリモートストレージにも保存可能で、チームで共有できる。

5. **モジュール**:
   - モジュールは自己完結型の再利用可能な構成パーツ。一度作成したモジュールは別の Terraform プロジェクトでも再利用できる。

## AWS での簡単な EC2 インスタンスの作成例

```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

output "instance_id" {
  value = aws_instance.example.id
}
```

この構成ファイルでは、`aws`プロバイダーを使用し、特定の AMI をベースにした`t2.micro`タイプの EC2 インスタンスを作成する。そして、作成されたインスタンスの ID を出力する。

## References

- [Terragrunt](https://terragrunt.gruntwork.io/)
  - Terragrunt is a flexible orchestration tool that allows Infrastructure as Code to scale.
- [Google CloudのTerraform職人が失職する機能が出てしまった](https://zenn.dev/nnaka2992/articles/intro_to_application_design_center)
  - Google Cloudの`Application Design Center`という、構成図を書けばTerraformを書いて、デプロイまで行う機能
