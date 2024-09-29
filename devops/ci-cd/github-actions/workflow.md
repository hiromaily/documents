# Github Actions Workflow

## Goによるアプリケーションの例

`.github/workflows/go-ci.yml`の例

```yaml
name: Go CI

on:
  push:
    branches:
      - main

jobs:
  lint:
    runs-on: ubuntu-latest

    steps:
    - name: Check out code
      uses: actions/checkout@v4

    - name: Set up Go
      uses: actions/setup-go@v5
      with:
        go-version: '1.23'

    - name: Cache Go modules
      uses: actions/cache@v4
      with:
        path: ~/go/pkg/mod
        key: ${{ runner.os }}-go-${{ hashFiles('**/go.sum') }}
        restore-keys: |
          ${{ runner.os }}-go-

    - name: Install dependencies
      run: go mod download

    - name: Run golangci-lint
      uses: golangci/golangci-lint-action@v6

  build:
    runs-on: ubuntu-latest
    needs: lint

    steps:
    - name: Check out code
      uses: actions/checkout@v4

    - name: Set up Go
      uses: actions/setup-go@v5
      with:
        go-version: '1.23'

    - name: Cache Go modules
      uses: actions/cache@v4
      with:
        path: ~/go/pkg/mod
        key: ${{ runner.os }}-go-${{ hashFiles('**/go.sum') }}
        restore-keys: |
          ${{ runner.os }}-go-

    - name: Install dependencies
      run: go mod download

    - name: Build the Go app
      run: go build -v ./...

    - name: Build Docker image
      run: |
        docker build -t myapp:latest .

    - name: Log in to Docker Hub
      env:
        DOCKER_USERNAME: ${{ secrets.DOCKER_USERNAME }}
        DOCKER_PASSWORD: ${{ secrets.DOCKER_PASSWORD }}
      run: echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin

    - name: Push Docker image to Docker Hub
      run: docker push myapp:latest

  deploy:
    runs-on: ubuntu-latest
    needs: build

    steps:
    - name: Check out code
      uses: actions/checkout@v4

    - name: Deploy to production
      env:
        SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
      run: |
        echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add - > /dev/null
        ssh -o StrictHostKeyChecking=no user@your-server 'docker pull myapp:latest && docker run -d myapp:latest'
```
