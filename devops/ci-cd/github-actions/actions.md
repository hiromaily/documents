# Actions

特定のタスクを実行するために再利用可能なスクリプトや Configuration のセット。これを使用することで、複雑なタスクを簡単にワークフローに組み込むことができる。

## Actions の種類

Actions には大きく分けて以下の 2 つのタイプがある

1. **JavaScript Actions**:

   - JavaScript または TypeScript で書かれた Actions。ロジックが含まれ、高度な操作を行うことが可能。

2. **Docker Actions**:
   - Docker コンテナ内で実行される Actions。特定の環境を必要とする操作を行う際に便利。

## 基本的な Actions

1. **actions/checkout**:

   - リポジトリのコードをチェックアウトするための Actions。ほぼすべてのワークフローで使用される。

   ```yaml
   steps:
     - name: Check out code
       uses: actions/checkout@v4
   ```

2. **actions/cache**:

   - 依存関係をキャッシュしてビルド時間を短縮するための Actions。以下は`Go`の例

   ```yaml
    steps:
    - name: Cache Go modules
        uses: actions/cache@v4
        with:
        path: ~/go/pkg/mod
        key: ${{ runner.os }}-go-${{ hashFiles('**/go.sum') }}
        restore-keys: |
            ${{ runner.os }}-go-
   ```

3. **github/super-linter**:

   - GitHub が提供する包括的な Linter の Actions。あらゆる言語や設定ファイルに使えるため、常にこちらを指定しておいてもよい
   - 利用できる例
     - Golang
     - Rust
     - Typescript
     - Javascript
     - Shell
     - SQL
     - Protobuf
     - YAML
     - JSON
     - Dockerfile
     - .env
     - Github Actions
     - Markdown
     - OpenAPI

   ```yaml
   steps:
     - name: Lint code base
       uses: github/super-linter@v3
       env:
         VALIDATE_GO: true
   ```

4. **[actions/github-script](https://github.com/actions/github-script)**:

   - GitHub APIを使ったscriptを記述できる
   - これにより、結果をPRにコメントするといったことが可能

## プログラム言語別 Actions

### Golang で使われる Actions

1. **actions/setup-go**:

   - `Golang` 環境をセットアップするための Actions。

   ```yaml
   steps:
     - name: Set up Golang
       uses: actions/setup-go@v5
       with:
         node-version: "1.23"
   ```

2. **actions/golangci-lint-action**:

   - `golangci-lint`を使ってコードをリントするための Actions。
   -

   ```yaml
   steps:
     - name: Run golangci-lint
       uses: golangci/golangci-lint-action@v6
   ```

### Node.js で使われる Actions

1. **actions/setup-node**:

   - `Node.js` 環境をセットアップするための Actions。

   ```yaml
   steps:
     - name: Set up Node.js
       uses: actions/setup-node@v4
       with:
         node-version: "20"
   ```

### Python で使われる Actions

1. **actions/setup-python**:

   - `Python` 環境をセットアップするための Actions。

   ```yaml
   steps:
     - name: Set up Python
       uses: actions/setup-python@v5
       with:
         python-version: "3.12"
   ```

## Docker で使われる Actions

1. **docker/build-push-action**:

   - Docker イメージをビルドしてプッシュするための Actions。

   ```yaml
   steps:
     - name: Build and push Docker image
       uses: docker/build-push-action@v6
       with:
         context: .
         push: true
         tags: user/app:latest
   ```

   ```yaml
   - name: Build and push Docker image
     uses: docker/build-push-action@v6
     with:
       build-args: |
         DOTENV_PRIVATE_KEY=${{ env.DOTENV_PRIVATE_KEY }}
         COMMIT_ID=${GITHUB_SHA::7}
         ENV_FILE=${{ env.ENV_FILE }}
       file: ./app/Dockerfile
       context: ./myapp
       push: true
       tags: ${{ env.AWS_ACCOUNT_ID }}.dkr.ecr.ap-northeast-1.amazonaws.com/${{ env.ECR_REPOSITORY_NAME }}:${{ env.ECR_IMAGE_TAG }}
       # NOTE: Lambdaがマルチプラットフォームイメージをサポートしていないため、単一のplatformを指定し、provenanceを無効にする
       platforms: linux/arm64
       provenance: false
       cache-from: type=local,src=/tmp/.buildx-cache
       cache-to: type=local,dest=/tmp/.buildx-cache-new,mode=max
   ```

## AWS で使われる Actions

1. **aws-actions/configure-aws-credentials**:

   - AWS CLI の認証情報を設定するための Actions。

   ```yaml
   steps:
     - name: Configure AWS credentials
       uses: aws-actions/configure-aws-credentials@v1
       with:
         aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
         aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
         aws-region: us-west-2
   ```

## Actions を探す方法

GitHub Marketplace にはさまざまな Actions が登録されている。

1. [GitHub Marketplace](https://github.com/marketplace/actions)にアクセス。
2. 「Actions」カテゴリを選択。
3. 検索バーやカテゴリフィルタを使用して、目的に合った Actions を探す。

## References

- [GitHub Marketplace](https://github.com/marketplace/actions)
